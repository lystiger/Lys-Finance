import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/app_clock.dart';
import '../../../settings/domain/entities/account.dart';
import '../../../settings/domain/repositories/account_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_history_event.dart';
import '../../domain/repositories/vault_history_repository.dart';
import '../../domain/repositories/vault_repository.dart';

/// Milestone thresholds checked after every contribution, expressed as a
/// fraction of the vault's goal amount. 1.0 (goal completion) is handled
/// separately since it uses a different event type and drives the
/// completion celebration.
const List<double> vaultMilestoneThresholds = <double>[0.25, 0.5, 0.75];

final class ContributionService {
  const ContributionService({
    required this.transactions,
    required this.vaults,
    required this.accounts,
    required this.history,
    required this.uuid,
    required this.clock,
  });

  final TransactionRepository transactions;
  final VaultRepository vaults;
  final AccountRepository accounts;
  final VaultHistoryRepository history;
  final UuidGenerator uuid;
  final AppClock clock;

  Future<AppResult<Transaction>> contribute({
    required String vaultId,
    required String accountId,
    required Money amount,
    String? note,
    DateTime? occurredAt,
  }) async {
    final AppResult<Vault> vaultResult = await vaults.getById(
      vaultId,
      includeArchived: true,
    );
    if (vaultResult case AppError<Vault>(:final error)) {
      return AppError<Transaction>(error);
    }
    final Vault vault = (vaultResult as AppSuccess<Vault>).value;
    if (vault.isArchived) {
      return const AppError<Transaction>(ArchivedVaultFailure());
    }
    if (amount.currency != vault.currency) {
      return const AppError<Transaction>(CurrencyVaultMismatchFailure());
    }
    final AppResult<Account> accountResult = await accounts.getById(
      accountId,
      includeDeleted: true,
    );
    if (accountResult case AppError<Account>()) {
      return const AppError<Transaction>(MissingAccountFailure());
    }
    final Account account = (accountResult as AppSuccess<Account>).value;
    if (account.isDeleted) {
      return const AppError<Transaction>(ArchivedAccountFailure());
    }
    if (account.currencyCode != amount.currency.code) {
      return const AppError<Transaction>(CurrencyAccountMismatchFailure());
    }
    final DateTime now = clock.now().toUtc();
    final AppResult<Transaction> transaction = Transaction.create(
      id: uuid.v4(),
      type: TransactionType.contribution,
      amount: amount,
      accountId: accountId,
      vaultId: vaultId,
      incClass: null,
      note: note,
      occurredAt: occurredAt ?? now,
      createdAt: now,
      updatedAt: now,
      version: 1,
    );
    if (transaction case AppError<Transaction>()) return transaction;
    final AppResult<Transaction> created = await transactions.create(
      (transaction as AppSuccess<Transaction>).value,
    );
    if (created case AppSuccess<Transaction>()) {
      await _checkMilestones(vault);
    }
    return created;
  }

  Future<void> _checkMilestones(Vault vault) async {
    final Money? goalAmount = vault.goalAmount;
    if (goalAmount == null || goalAmount.minorUnits == 0) return;
    final AppResult<Money> balanceResult = await vaults.getBalance(vault.id);
    if (balanceResult case AppError<Money>()) return;
    final Money balance = (balanceResult as AppSuccess<Money>).value;
    final double ratio = balance.minorUnits / goalAmount.minorUnits;
    final DateTime now = clock.now().toUtc();
    for (final double threshold in vaultMilestoneThresholds) {
      if (ratio < threshold) continue;
      final String payload = (threshold * 100).round().toString();
      final bool already = await history.hasEvent(
        vault.id,
        VaultHistoryEventType.milestoneReached,
        payload: payload,
      );
      if (!already) {
        await history.append(
          VaultHistoryEvent(
            id: uuid.v4(),
            vaultId: vault.id,
            eventType: VaultHistoryEventType.milestoneReached,
            payload: payload,
            occurredAt: now,
            createdAt: now,
          ),
        );
      }
    }
    if (ratio >= 1.0) {
      final bool already = await history.hasEvent(
        vault.id,
        VaultHistoryEventType.goalCompleted,
      );
      if (!already) {
        await history.append(
          VaultHistoryEvent(
            id: uuid.v4(),
            vaultId: vault.id,
            eventType: VaultHistoryEventType.goalCompleted,
            occurredAt: now,
            createdAt: now,
          ),
        );
      }
    }
  }
}

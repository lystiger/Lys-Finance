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

final class WithdrawalService {
  const WithdrawalService({
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

  Future<AppResult<Transaction>> withdraw({
    required String vaultId,
    required String accountId,
    required Money amount,
    String? reason,
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
    if (vault.withdrawalPolicy == VaultWithdrawalPolicy.locked &&
        (reason == null || reason.trim().isEmpty)) {
      return const AppError<Transaction>(WithdrawalReasonRequiredFailure());
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
    final AppResult<Money> balanceResult = await vaults.getBalance(vaultId);
    if (balanceResult case AppError<Money>(:final error)) {
      return AppError<Transaction>(error);
    }
    final Money balance = (balanceResult as AppSuccess<Money>).value;
    if (amount.minorUnits > balance.minorUnits) {
      return const AppError<Transaction>(InsufficientVaultBalanceFailure());
    }
    final DateTime now = clock.now().toUtc();
    final AppResult<Transaction> transaction = Transaction.create(
      id: uuid.v4(),
      type: TransactionType.withdrawal,
      amount: amount,
      accountId: accountId,
      vaultId: vaultId,
      incClass: null,
      note: reason,
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
      await _checkGoalReopened(vault, balance.minorUnits - amount.minorUnits);
    }
    return created;
  }

  Future<void> _checkGoalReopened(Vault vault, int newBalanceMinorUnits) async {
    final Money? goalAmount = vault.goalAmount;
    if (goalAmount == null || newBalanceMinorUnits >= goalAmount.minorUnits) {
      return;
    }
    final AppResult<List<VaultHistoryEvent>> eventsResult = await history
        .queryForVault(vault.id);
    if (eventsResult case AppError<List<VaultHistoryEvent>>()) return;
    final List<VaultHistoryEvent> events =
        (eventsResult as AppSuccess<List<VaultHistoryEvent>>).value
            .where(
              (event) =>
                  event.eventType == VaultHistoryEventType.goalCompleted ||
                  event.eventType == VaultHistoryEventType.goalReopened,
            )
            .toList(growable: false)
          ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt));
    if (events.isEmpty) return;
    final bool currentlyCompleted =
        events.last.eventType == VaultHistoryEventType.goalCompleted;
    if (!currentlyCompleted) return;
    final DateTime now = clock.now().toUtc();
    await history.append(
      VaultHistoryEvent(
        id: uuid.v4(),
        vaultId: vault.id,
        eventType: VaultHistoryEventType.goalReopened,
        occurredAt: now,
        createdAt: now,
      ),
    );
  }
}

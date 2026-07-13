import '../../../../core/domain/app_result.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/app_clock.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_goal_snapshot.dart';
import '../../domain/entities/vault_transfer.dart';
import '../../domain/repositories/vault_repository.dart';
import '../../domain/repositories/vault_transfer_repository.dart';
import 'projection_service.dart';

/// Presentation-facing façade: combines vault/activity reads with
/// [ProjectionService]'s pure math into one ready-to-render snapshot, so
/// providers call one method instead of composing three repositories and a
/// pure-math service themselves.
final class GoalService {
  const GoalService({
    required this.vaults,
    required this.transactions,
    required this.transfers,
    required this.projection,
    required this.clock,
  });

  final VaultRepository vaults;
  final TransactionRepository transactions;
  final VaultTransferRepository transfers;
  final ProjectionService projection;
  final AppClock clock;

  Future<AppResult<VaultGoalSnapshot>> snapshotFor(String vaultId) async {
    final AppResult<Vault> vaultResult = await vaults.getById(
      vaultId,
      includeArchived: true,
    );
    if (vaultResult case AppError<Vault>(:final error)) {
      return AppError<VaultGoalSnapshot>(error);
    }
    final Vault vault = (vaultResult as AppSuccess<Vault>).value;
    final AppResult<Money> balanceResult = await vaults.getBalance(vaultId);
    if (balanceResult case AppError<Money>(:final error)) {
      return AppError<VaultGoalSnapshot>(error);
    }
    final Money balance = (balanceResult as AppSuccess<Money>).value;
    return AppSuccess<VaultGoalSnapshot>(await _snapshot(vault, balance));
  }

  /// Recomputes the snapshot every time the vault's derived balance changes
  /// — the common trigger for contribute/withdraw/transfer — without a
  /// dependency on a reactive-streams package.
  Stream<VaultGoalSnapshot> watchSnapshotFor(String vaultId) =>
      vaults.watchBalance(vaultId).asyncMap((balance) async {
        final AppResult<Vault> vaultResult = await vaults.getById(
          vaultId,
          includeArchived: true,
        );
        final Vault vault = vaultResult.fold(
          success: (value) => value,
          failure: (failure) => throw failure,
        );
        return _snapshot(vault, balance);
      });

  Future<VaultGoalSnapshot> _snapshot(Vault vault, Money balance) async {
    final DateTime now = clock.now().toUtc();
    final int windowDays = projection.windowDaysFor(
      vaultCreatedAt: vault.createdAt,
      now: now,
    );
    final Money netActivity = await _netActivityInWindow(
      vault.id,
      vault.currency,
      now,
      windowDays,
    );
    return projection.compute(
      vault: vault,
      currentBalance: balance,
      now: now,
      netActivityInWindow: netActivity,
      windowDays: windowDays,
    );
  }

  Future<Money> _netActivityInWindow(
    String vaultId,
    Currency currency,
    DateTime now,
    int windowDays,
  ) async {
    if (windowDays <= 0) return Money.zero(currency);
    final DateTime windowStart = now.subtract(Duration(days: windowDays));
    final AppResult<List<Transaction>> activityResult = await transactions
        .queryVaultActivity(vaultId);
    final List<Transaction> activity = activityResult.fold(
      success: (value) => value,
      failure: (_) => const <Transaction>[],
    );
    final AppResult<List<VaultTransfer>> transfersResult = await transfers
        .queryForVault(vaultId);
    final List<VaultTransfer> vaultTransfers = transfersResult.fold(
      success: (value) => value,
      failure: (_) => const <VaultTransfer>[],
    );
    int total = 0;
    for (final Transaction transaction in activity) {
      if (transaction.occurredAt.isBefore(windowStart)) continue;
      if (transaction.type == TransactionType.contribution) {
        total += transaction.amount.minorUnits;
      } else if (transaction.type == TransactionType.withdrawal) {
        total -= transaction.amount.minorUnits;
      }
    }
    for (final VaultTransfer transfer in vaultTransfers) {
      if (transfer.occurredAt.isBefore(windowStart)) continue;
      if (transfer.destinationVaultId == vaultId) {
        total += transfer.amount.minorUnits;
      } else if (transfer.sourceVaultId == vaultId) {
        total -= transfer.amount.minorUnits;
      }
    }
    return Money.fromMinorUnits(
      minorUnits: total,
      currency: currency,
    ).fold(success: (value) => value, failure: (_) => Money.zero(currency));
  }
}

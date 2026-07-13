import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/money/money.dart';
import '../../../../core/providers/foundation_providers.dart';
import '../../../settings/application/providers/settings_providers.dart';
import '../../../transactions/application/providers/transaction_providers.dart';
import '../../data/repositories/drift_vault_history_repository.dart';
import '../../data/repositories/drift_vault_repository.dart';
import '../../data/repositories/drift_vault_transfer_repository.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_goal_snapshot.dart';
import '../../domain/entities/vault_history_entry.dart';
import '../../domain/entities/vault_transfer.dart';
import '../../domain/repositories/vault_history_repository.dart';
import '../../domain/repositories/vault_repository.dart';
import '../../domain/repositories/vault_transfer_repository.dart';
import '../services/contribution_service.dart';
import '../services/goal_service.dart';
import '../services/history_service.dart';
import '../services/projection_service.dart';
import '../services/transfer_service.dart';
import '../services/vault_service.dart';
import '../services/withdrawal_service.dart';

part 'vault_providers.g.dart';

@Riverpod(keepAlive: true)
VaultRepository vaultRepository(Ref ref) =>
    DriftVaultRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
VaultTransferRepository vaultTransferRepository(Ref ref) =>
    DriftVaultTransferRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
VaultHistoryRepository vaultHistoryRepository(Ref ref) =>
    DriftVaultHistoryRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ProjectionService projectionService(Ref ref) => const ProjectionService();

@Riverpod(keepAlive: true)
VaultService vaultService(Ref ref) => VaultService(
  vaults: ref.watch(vaultRepositoryProvider),
  history: ref.watch(vaultHistoryRepositoryProvider),
  uuid: ref.watch(uuidGeneratorProvider),
  clock: ref.watch(appClockProvider),
);

@Riverpod(keepAlive: true)
ContributionService contributionService(Ref ref) => ContributionService(
  transactions: ref.watch(transactionRepositoryProvider),
  vaults: ref.watch(vaultRepositoryProvider),
  accounts: ref.watch(accountRepositoryProvider),
  history: ref.watch(vaultHistoryRepositoryProvider),
  uuid: ref.watch(uuidGeneratorProvider),
  clock: ref.watch(appClockProvider),
);

@Riverpod(keepAlive: true)
WithdrawalService withdrawalService(Ref ref) => WithdrawalService(
  transactions: ref.watch(transactionRepositoryProvider),
  vaults: ref.watch(vaultRepositoryProvider),
  accounts: ref.watch(accountRepositoryProvider),
  history: ref.watch(vaultHistoryRepositoryProvider),
  uuid: ref.watch(uuidGeneratorProvider),
  clock: ref.watch(appClockProvider),
);

@Riverpod(keepAlive: true)
TransferService transferService(Ref ref) => TransferService(
  transfers: ref.watch(vaultTransferRepositoryProvider),
  vaults: ref.watch(vaultRepositoryProvider),
  uuid: ref.watch(uuidGeneratorProvider),
  clock: ref.watch(appClockProvider),
);

@Riverpod(keepAlive: true)
GoalService goalService(Ref ref) => GoalService(
  vaults: ref.watch(vaultRepositoryProvider),
  transactions: ref.watch(transactionRepositoryProvider),
  transfers: ref.watch(vaultTransferRepositoryProvider),
  projection: ref.watch(projectionServiceProvider),
  clock: ref.watch(appClockProvider),
);

@Riverpod(keepAlive: true)
HistoryService historyService(Ref ref) => HistoryService(
  transactions: ref.watch(transactionRepositoryProvider),
  transfers: ref.watch(vaultTransferRepositoryProvider),
  history: ref.watch(vaultHistoryRepositoryProvider),
);

@riverpod
Stream<List<Vault>> activeVaults(Ref ref) =>
    ref.watch(vaultRepositoryProvider).watchActive();

@riverpod
Stream<Vault?> vaultDetail(Ref ref, String vaultId) =>
    ref.watch(vaultRepositoryProvider).watchById(vaultId);

@riverpod
Stream<Money> vaultBalance(Ref ref, String vaultId) =>
    ref.watch(vaultRepositoryProvider).watchBalance(vaultId);

@riverpod
Stream<VaultGoalSnapshot> vaultGoalSnapshot(Ref ref, String vaultId) =>
    ref.watch(goalServiceProvider).watchSnapshotFor(vaultId);

@riverpod
Stream<List<VaultHistoryEntry>> vaultHistoryTimeline(Ref ref, String vaultId) =>
    ref.watch(historyServiceProvider).watchTimelineFor(vaultId);

@riverpod
Stream<List<VaultTransfer>> vaultTransfers(Ref ref, String vaultId) =>
    ref.watch(vaultTransferRepositoryProvider).watchForVault(vaultId);

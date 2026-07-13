import 'dart:async';

import '../../../../core/domain/app_result.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/vault_history_entry.dart';
import '../../domain/entities/vault_history_event.dart';
import '../../domain/entities/vault_transfer.dart';
import '../../domain/repositories/vault_history_repository.dart';
import '../../domain/repositories/vault_transfer_repository.dart';

/// Merges contribution/withdrawal transactions, vault-to-vault transfers,
/// and lifecycle events into one chronologically sorted timeline. Each
/// source keeps its own facts (Decision 3 in the Sprint 03 spec) — this
/// service only merges the already-fetched reads, it never persists.
final class HistoryService {
  const HistoryService({
    required this.transactions,
    required this.transfers,
    required this.history,
  });

  final TransactionRepository transactions;
  final VaultTransferRepository transfers;
  final VaultHistoryRepository history;

  Future<AppResult<List<VaultHistoryEntry>>> timelineFor(String vaultId) async {
    final AppResult<List<Transaction>> activityResult = await transactions
        .queryVaultActivity(vaultId);
    if (activityResult case AppError<List<Transaction>>(:final error)) {
      return AppError<List<VaultHistoryEntry>>(error);
    }
    final AppResult<List<VaultTransfer>> transfersResult = await transfers
        .queryForVault(vaultId);
    if (transfersResult case AppError<List<VaultTransfer>>(:final error)) {
      return AppError<List<VaultHistoryEntry>>(error);
    }
    final AppResult<List<VaultHistoryEvent>> eventsResult = await history
        .queryForVault(vaultId);
    if (eventsResult case AppError<List<VaultHistoryEvent>>(:final error)) {
      return AppError<List<VaultHistoryEntry>>(error);
    }
    return AppSuccess<List<VaultHistoryEntry>>(
      _merge(
        vaultId,
        (activityResult as AppSuccess<List<Transaction>>).value,
        (transfersResult as AppSuccess<List<VaultTransfer>>).value,
        (eventsResult as AppSuccess<List<VaultHistoryEvent>>).value,
      ),
    );
  }

  Stream<List<VaultHistoryEntry>> watchTimelineFor(String vaultId) {
    List<Transaction>? activity;
    List<VaultTransfer>? transferRows;
    List<VaultHistoryEvent>? events;
    StreamSubscription<List<Transaction>>? activitySub;
    StreamSubscription<List<VaultTransfer>>? transferSub;
    StreamSubscription<List<VaultHistoryEvent>>? eventSub;
    late final StreamController<List<VaultHistoryEntry>> controller;

    void emit() {
      if (activity == null || transferRows == null || events == null) return;
      controller.add(_merge(vaultId, activity!, transferRows!, events!));
    }

    controller = StreamController<List<VaultHistoryEntry>>(
      onListen: () {
        activitySub = transactions.watchVaultActivity(vaultId).listen((value) {
          activity = value;
          emit();
        });
        transferSub = transfers.watchForVault(vaultId).listen((value) {
          transferRows = value;
          emit();
        });
        eventSub = history.watchForVault(vaultId).listen((value) {
          events = value;
          emit();
        });
      },
      onCancel: () async {
        await activitySub?.cancel();
        await transferSub?.cancel();
        await eventSub?.cancel();
      },
    );
    return controller.stream;
  }

  List<VaultHistoryEntry> _merge(
    String vaultId,
    List<Transaction> activity,
    List<VaultTransfer> transferRows,
    List<VaultHistoryEvent> events,
  ) {
    final List<VaultHistoryEntry> entries = <VaultHistoryEntry>[
      ...activity.map(VaultActivityEntry.new),
      ...transferRows.map(
        (transfer) => VaultTransferEntry(
          transfer,
          direction: transfer.destinationVaultId == vaultId
              ? VaultTransferDirection.incoming
              : VaultTransferDirection.outgoing,
        ),
      ),
      ...events.map(VaultLifecycleEntry.new),
    ];
    entries.sort((a, b) {
      final int byOccurred = b.occurredAt.compareTo(a.occurredAt);
      if (byOccurred != 0) return byOccurred;
      final int byCreated = b.createdAt.compareTo(a.createdAt);
      if (byCreated != 0) return byCreated;
      return b.sortId.compareTo(a.sortId);
    });
    return List<VaultHistoryEntry>.unmodifiable(entries);
  }
}

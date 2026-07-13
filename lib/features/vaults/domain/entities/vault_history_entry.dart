import '../../../transactions/domain/entities/transaction.dart';
import 'vault_history_event.dart';
import 'vault_transfer.dart';

enum VaultTransferDirection { incoming, outgoing }

sealed class VaultHistoryEntry {
  const VaultHistoryEntry();

  DateTime get occurredAt;
  DateTime get createdAt;
  String get sortId;
}

final class VaultActivityEntry extends VaultHistoryEntry {
  const VaultActivityEntry(this.transaction);

  final Transaction transaction;

  @override
  DateTime get occurredAt => transaction.occurredAt;

  @override
  DateTime get createdAt => transaction.createdAt;

  @override
  String get sortId => transaction.id;
}

final class VaultTransferEntry extends VaultHistoryEntry {
  const VaultTransferEntry(this.transfer, {required this.direction});

  final VaultTransfer transfer;
  final VaultTransferDirection direction;

  @override
  DateTime get occurredAt => transfer.occurredAt;

  @override
  DateTime get createdAt => transfer.createdAt;

  @override
  String get sortId => transfer.id;
}

final class VaultLifecycleEntry extends VaultHistoryEntry {
  const VaultLifecycleEntry(this.event);

  final VaultHistoryEvent event;

  @override
  DateTime get occurredAt => event.occurredAt;

  @override
  DateTime get createdAt => event.createdAt;

  @override
  String get sortId => event.id;
}

enum VaultHistoryEventType {
  created,
  edited,
  archived,
  restored,
  milestoneReached,
  goalCompleted,
  goalReopened,
}

final class VaultHistoryEvent {
  const VaultHistoryEvent({
    required this.id,
    required this.vaultId,
    required this.eventType,
    required this.occurredAt,
    required this.createdAt,
    this.payload,
  });

  final String id;
  final String vaultId;
  final VaultHistoryEventType eventType;
  final String? payload;
  final DateTime occurredAt;
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      other is VaultHistoryEvent &&
      id == other.id &&
      vaultId == other.vaultId &&
      eventType == other.eventType &&
      payload == other.payload &&
      occurredAt == other.occurredAt &&
      createdAt == other.createdAt;

  @override
  int get hashCode =>
      Object.hash(id, vaultId, eventType, payload, occurredAt, createdAt);
}

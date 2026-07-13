import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/vault_history_event.dart';
import '../../domain/repositories/vault_history_repository.dart';
import '../dao/vault_history_dao.dart';

final class DriftVaultHistoryRepository implements VaultHistoryRepository {
  DriftVaultHistoryRepository(this.database) : dao = VaultHistoryDao(database);

  final AppDatabase database;
  final VaultHistoryDao dao;

  @override
  Future<AppResult<void>> append(VaultHistoryEvent event) async {
    try {
      await dao.insert(_companion(event));
      return const AppSuccess<void>(null);
    } on Object catch (error) {
      return AppError<void>(StorageFailure(cause: error));
    }
  }

  @override
  Future<bool> hasEvent(
    String vaultId,
    VaultHistoryEventType eventType, {
    String? payload,
  }) async => await dao.findEvent(vaultId, eventType.name, payload) != null;

  @override
  Stream<List<VaultHistoryEvent>> watchForVault(String vaultId) => dao
      .watchForVault(vaultId)
      .map((rows) => List<VaultHistoryEvent>.unmodifiable(rows.map(_fromRow)));

  @override
  Future<AppResult<List<VaultHistoryEvent>>> queryForVault(
    String vaultId,
  ) async {
    try {
      final List<VaultHistoryRow> rows = await dao.queryForVault(vaultId);
      return AppSuccess<List<VaultHistoryEvent>>(
        List<VaultHistoryEvent>.unmodifiable(rows.map(_fromRow)),
      );
    } on Object catch (error) {
      return AppError<List<VaultHistoryEvent>>(StorageFailure(cause: error));
    }
  }

  VaultHistoryCompanion _companion(VaultHistoryEvent event) =>
      VaultHistoryCompanion(
        id: Value<String>(event.id),
        vaultId: Value<String>(event.vaultId),
        eventType: Value<String>(event.eventType.name),
        payload: Value<String?>(event.payload),
        occurredAt: Value<int>(event.occurredAt.toUtc().microsecondsSinceEpoch),
        createdAt: Value<int>(event.createdAt.toUtc().microsecondsSinceEpoch),
      );

  VaultHistoryEvent _fromRow(VaultHistoryRow row) => VaultHistoryEvent(
    id: row.id,
    vaultId: row.vaultId,
    eventType: VaultHistoryEventType.values.byName(row.eventType),
    payload: row.payload,
    occurredAt: DateTime.fromMicrosecondsSinceEpoch(
      row.occurredAt,
      isUtc: true,
    ),
    createdAt: DateTime.fromMicrosecondsSinceEpoch(row.createdAt, isUtc: true),
  );
}

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

final class VaultHistoryDao {
  const VaultHistoryDao(this.database);

  final AppDatabase database;

  Future<void> insert(VaultHistoryCompanion companion) =>
      database.into(database.vaultHistory).insert(companion);

  Future<VaultHistoryRow?> findEvent(
    String vaultId,
    String eventType,
    String? payload,
  ) {
    final SimpleSelectStatement<$VaultHistoryTable, VaultHistoryRow> query =
        database.select(database.vaultHistory)..where(
          ($VaultHistoryTable table) =>
              table.vaultId.equals(vaultId) & table.eventType.equals(eventType),
        );
    if (payload != null) {
      query.where(($VaultHistoryTable table) => table.payload.equals(payload));
    }
    query.limit(1);
    return query.getSingleOrNull();
  }

  Stream<List<VaultHistoryRow>> watchForVault(String vaultId) {
    final SimpleSelectStatement<$VaultHistoryTable, VaultHistoryRow> query =
        database.select(database.vaultHistory)
          ..where(($VaultHistoryTable table) => table.vaultId.equals(vaultId))
          ..orderBy(<OrderingTerm Function($VaultHistoryTable)>[
            ($VaultHistoryTable table) => OrderingTerm.desc(table.occurredAt),
            ($VaultHistoryTable table) => OrderingTerm.desc(table.createdAt),
          ]);
    return query.watch();
  }

  Future<List<VaultHistoryRow>> queryForVault(String vaultId) {
    final SimpleSelectStatement<$VaultHistoryTable, VaultHistoryRow> query =
        database.select(database.vaultHistory)
          ..where(($VaultHistoryTable table) => table.vaultId.equals(vaultId))
          ..orderBy(<OrderingTerm Function($VaultHistoryTable)>[
            ($VaultHistoryTable table) => OrderingTerm.desc(table.occurredAt),
            ($VaultHistoryTable table) => OrderingTerm.desc(table.createdAt),
          ]);
    return query.get();
  }
}

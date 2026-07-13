import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

final class VaultDao {
  const VaultDao(this.database);

  final AppDatabase database;

  Future<void> insert(VaultsCompanion companion) =>
      database.into(database.vaults).insert(companion);

  Future<int> updateVersioned(
    VaultsCompanion companion,
    String id,
    int expectedVersion,
  ) =>
      (database.update(database.vaults)..where(
            ($VaultsTable table) =>
                table.id.equals(id) &
                table.version.equals(expectedVersion) &
                table.deletedAt.isNull(),
          ))
          .write(companion);

  Future<int> archive(String id, int expectedVersion, int timestamp) =>
      (database.update(database.vaults)..where(
            ($VaultsTable table) =>
                table.id.equals(id) &
                table.version.equals(expectedVersion) &
                table.deletedAt.isNull(),
          ))
          .write(
            VaultsCompanion(
              deletedAt: Value<int?>(timestamp),
              updatedAt: Value<int>(timestamp),
              version: Value<int>(expectedVersion + 1),
            ),
          );

  Future<int> restore(String id, int expectedVersion, int timestamp) =>
      (database.update(database.vaults)..where(
            ($VaultsTable table) =>
                table.id.equals(id) &
                table.version.equals(expectedVersion) &
                table.deletedAt.isNotNull(),
          ))
          .write(
            VaultsCompanion(
              deletedAt: const Value<int?>(null),
              updatedAt: Value<int>(timestamp),
              version: Value<int>(expectedVersion + 1),
            ),
          );

  Future<VaultRow?> getById(String id, {required bool includeArchived}) {
    final SimpleSelectStatement<$VaultsTable, VaultRow> query = database.select(
      database.vaults,
    )..where(($VaultsTable table) => table.id.equals(id));
    if (!includeArchived) {
      query.where(($VaultsTable table) => table.deletedAt.isNull());
    }
    return query.getSingleOrNull();
  }

  Stream<VaultRow?> watchById(String id, {required bool includeArchived}) {
    final SimpleSelectStatement<$VaultsTable, VaultRow> query = database.select(
      database.vaults,
    )..where(($VaultsTable table) => table.id.equals(id));
    if (!includeArchived) {
      query.where(($VaultsTable table) => table.deletedAt.isNull());
    }
    return query.watchSingleOrNull();
  }

  Stream<List<VaultRow>> watchActive() {
    final SimpleSelectStatement<$VaultsTable, VaultRow> query =
        database.select(database.vaults)
          ..where(($VaultsTable table) => table.deletedAt.isNull())
          ..orderBy(<OrderingTerm Function($VaultsTable)>[
            ($VaultsTable table) => OrderingTerm.desc(table.priority),
            ($VaultsTable table) => OrderingTerm.asc(table.sortOrder),
          ]);
    return query.watch();
  }

  Future<int> signedVaultTotal(String vaultId) async {
    final QueryRow row = await database
        .customSelect(
          'SELECT COALESCE(SUM(CASE '
          "WHEN type = 'contribution' THEN amount_minor "
          "WHEN type = 'withdrawal' THEN -amount_minor "
          'ELSE 0 END), 0) AS activity_total, '
          'COALESCE((SELECT SUM(amount_minor) FROM vault_transfers '
          'WHERE destination_vault_id = ?), 0) AS incoming_total, '
          'COALESCE((SELECT SUM(amount_minor) FROM vault_transfers '
          'WHERE source_vault_id = ?), 0) AS outgoing_total '
          'FROM transactions WHERE vault_id = ? AND deleted_at IS NULL',
          variables: <Variable<Object>>[
            Variable<String>(vaultId),
            Variable<String>(vaultId),
            Variable<String>(vaultId),
          ],
          readsFrom: <ResultSetImplementation<Table, Object?>>{
            database.transactions,
            database.vaultTransfers,
          },
        )
        .getSingle();
    return row.read<int>('activity_total') +
        row.read<int>('incoming_total') -
        row.read<int>('outgoing_total');
  }

  Stream<int> watchSignedVaultTotal(String vaultId) => database
      .customSelect(
        'SELECT COALESCE(SUM(CASE '
        "WHEN type = 'contribution' THEN amount_minor "
        "WHEN type = 'withdrawal' THEN -amount_minor "
        'ELSE 0 END), 0) AS activity_total, '
        'COALESCE((SELECT SUM(amount_minor) FROM vault_transfers '
        'WHERE destination_vault_id = ?), 0) AS incoming_total, '
        'COALESCE((SELECT SUM(amount_minor) FROM vault_transfers '
        'WHERE source_vault_id = ?), 0) AS outgoing_total '
        'FROM transactions WHERE vault_id = ? AND deleted_at IS NULL',
        variables: <Variable<Object>>[
          Variable<String>(vaultId),
          Variable<String>(vaultId),
          Variable<String>(vaultId),
        ],
        readsFrom: <ResultSetImplementation<Table, Object?>>{
          database.transactions,
          database.vaultTransfers,
        },
      )
      .watch()
      .map(
        (List<QueryRow> rows) =>
            rows.first.read<int>('activity_total') +
            rows.first.read<int>('incoming_total') -
            rows.first.read<int>('outgoing_total'),
      );

  Future<bool> hasActivity(String vaultId) async {
    final bool hasTransaction =
        await (database.select(database.transactions)
              ..where(
                ($TransactionsTable table) => table.vaultId.equals(vaultId),
              )
              ..limit(1))
            .getSingleOrNull() !=
        null;
    if (hasTransaction) return true;
    final bool hasTransfer =
        await (database.select(database.vaultTransfers)
              ..where(
                ($VaultTransfersTable table) =>
                    table.sourceVaultId.equals(vaultId) |
                    table.destinationVaultId.equals(vaultId),
              )
              ..limit(1))
            .getSingleOrNull() !=
        null;
    return hasTransfer;
  }
}

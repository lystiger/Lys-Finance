import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

final class VaultTransferDao {
  const VaultTransferDao(this.database);

  final AppDatabase database;

  Future<void> insert(VaultTransfersCompanion companion) =>
      database.into(database.vaultTransfers).insert(companion);

  Stream<List<VaultTransferRow>> watchForVault(String vaultId) {
    final SimpleSelectStatement<$VaultTransfersTable, VaultTransferRow> query =
        database.select(database.vaultTransfers)
          ..where(
            ($VaultTransfersTable table) =>
                table.sourceVaultId.equals(vaultId) |
                table.destinationVaultId.equals(vaultId),
          )
          ..orderBy(<OrderingTerm Function($VaultTransfersTable)>[
            ($VaultTransfersTable table) => OrderingTerm.desc(table.occurredAt),
            ($VaultTransfersTable table) => OrderingTerm.desc(table.createdAt),
          ]);
    return query.watch();
  }

  Future<List<VaultTransferRow>> queryForVault(String vaultId) {
    final SimpleSelectStatement<$VaultTransfersTable, VaultTransferRow> query =
        database.select(database.vaultTransfers)
          ..where(
            ($VaultTransfersTable table) =>
                table.sourceVaultId.equals(vaultId) |
                table.destinationVaultId.equals(vaultId),
          )
          ..orderBy(<OrderingTerm Function($VaultTransfersTable)>[
            ($VaultTransfersTable table) => OrderingTerm.desc(table.occurredAt),
            ($VaultTransfersTable table) => OrderingTerm.desc(table.createdAt),
          ]);
    return query.get();
  }
}

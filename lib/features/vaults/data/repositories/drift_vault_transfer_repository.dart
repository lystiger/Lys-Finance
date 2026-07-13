import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/vault_transfer.dart';
import '../../domain/repositories/vault_transfer_repository.dart';
import '../dao/vault_dao.dart';
import '../dao/vault_transfer_dao.dart';

final class DriftVaultTransferRepository implements VaultTransferRepository {
  DriftVaultTransferRepository(this.database)
    : dao = VaultTransferDao(database),
      vaultDao = VaultDao(database);

  final AppDatabase database;
  final VaultTransferDao dao;
  final VaultDao vaultDao;

  @override
  Future<AppResult<VaultTransfer>> create(VaultTransfer transfer) async {
    try {
      return await database.transaction<AppResult<VaultTransfer>>(() async {
        final VaultRow? source = await vaultDao.getById(
          transfer.sourceVaultId,
          includeArchived: false,
        );
        final VaultRow? destination = await vaultDao.getById(
          transfer.destinationVaultId,
          includeArchived: false,
        );
        if (source == null || destination == null) {
          return const AppError<VaultTransfer>(MissingVaultFailure());
        }
        if (source.currencyCode != transfer.amount.currency.code ||
            destination.currencyCode != transfer.amount.currency.code) {
          return const AppError<VaultTransfer>(VaultCurrencyMismatchFailure());
        }
        final int sourceTotal = await vaultDao.signedVaultTotal(
          transfer.sourceVaultId,
        );
        if (transfer.amount.minorUnits > sourceTotal) {
          return const AppError<VaultTransfer>(
            InsufficientVaultBalanceFailure(),
          );
        }
        await dao.insert(_companion(transfer));
        return AppSuccess<VaultTransfer>(transfer);
      });
    } on Object catch (error) {
      return AppError<VaultTransfer>(StorageFailure(cause: error));
    }
  }

  @override
  Stream<List<VaultTransfer>> watchForVault(String vaultId) => dao
      .watchForVault(vaultId)
      .map((rows) => List<VaultTransfer>.unmodifiable(rows.map(_fromRow)));

  @override
  Future<AppResult<List<VaultTransfer>>> queryForVault(String vaultId) async {
    try {
      final List<VaultTransferRow> rows = await dao.queryForVault(vaultId);
      return AppSuccess<List<VaultTransfer>>(
        List<VaultTransfer>.unmodifiable(rows.map(_fromRow)),
      );
    } on Object catch (error) {
      return AppError<List<VaultTransfer>>(StorageFailure(cause: error));
    }
  }

  VaultTransfersCompanion _companion(
    VaultTransfer transfer,
  ) => VaultTransfersCompanion(
    id: Value<String>(transfer.id),
    sourceVaultId: Value<String>(transfer.sourceVaultId),
    destinationVaultId: Value<String>(transfer.destinationVaultId),
    currencyCode: Value<String>(transfer.amount.currency.code),
    amountMinor: Value<int>(transfer.amount.minorUnits),
    note: Value<String?>(transfer.note),
    occurredAt: Value<int>(transfer.occurredAt.toUtc().microsecondsSinceEpoch),
    createdAt: Value<int>(transfer.createdAt.toUtc().microsecondsSinceEpoch),
  );

  VaultTransfer _fromRow(VaultTransferRow row) {
    final Currency currency = Currency.supported.firstWhere(
      (value) => value.code == row.currencyCode,
      orElse: () => throw StateError('Unsupported stored currency.'),
    );
    final Money amount = Money.fromMinorUnits(
      minorUnits: row.amountMinor,
      currency: currency,
    ).fold(success: (value) => value, failure: (failure) => throw failure);
    return VaultTransfer.create(
      id: row.id,
      sourceVaultId: row.sourceVaultId,
      destinationVaultId: row.destinationVaultId,
      amount: amount,
      note: row.note,
      occurredAt: DateTime.fromMicrosecondsSinceEpoch(
        row.occurredAt,
        isUtc: true,
      ),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
        row.createdAt,
        isUtc: true,
      ),
    ).fold(success: (value) => value, failure: (failure) => throw failure);
  }
}

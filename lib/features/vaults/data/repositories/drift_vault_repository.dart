import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../domain/entities/vault.dart';
import '../../domain/repositories/vault_repository.dart';
import '../dao/vault_dao.dart';

final class DriftVaultRepository implements VaultRepository {
  DriftVaultRepository(this.database) : dao = VaultDao(database);

  final AppDatabase database;
  final VaultDao dao;

  @override
  Stream<List<Vault>> watchActive() => dao.watchActive().map(
    (rows) => List<Vault>.unmodifiable(rows.map(_fromRow)),
  );

  @override
  Future<AppResult<Vault>> getById(
    String id, {
    bool includeArchived = false,
  }) async {
    try {
      final VaultRow? row = await dao.getById(
        id,
        includeArchived: includeArchived,
      );
      return row == null
          ? const AppError<Vault>(MissingVaultFailure())
          : AppSuccess<Vault>(_fromRow(row));
    } on Object catch (error) {
      return AppError<Vault>(StorageFailure(cause: error));
    }
  }

  @override
  Stream<Vault?> watchById(String id, {bool includeArchived = true}) => dao
      .watchById(id, includeArchived: includeArchived)
      .map((row) => row == null ? null : _fromRow(row));

  @override
  Future<AppResult<Vault>> create(Vault vault) async {
    try {
      await dao.insert(_companion(vault));
      return AppSuccess<Vault>(vault);
    } on SqliteException catch (error) {
      return AppError<Vault>(StorageFailure(cause: error));
    } on Object catch (error) {
      return AppError<Vault>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Vault>> update(
    Vault vault, {
    required int expectedVersion,
  }) async {
    final Vault updated = vault.copyWith(version: expectedVersion + 1);
    try {
      final int count = await dao.updateVersioned(
        _companion(updated),
        vault.id,
        expectedVersion,
      );
      return count == 0
          ? const AppError<Vault>(VersionConflictFailure())
          : AppSuccess<Vault>(updated);
    } on Object catch (error) {
      return AppError<Vault>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<void>> archive(
    String id, {
    required int expectedVersion,
    required DateTime archivedAt,
  }) async {
    try {
      final int count = await dao.archive(
        id,
        expectedVersion,
        archivedAt.toUtc().microsecondsSinceEpoch,
      );
      return count == 0
          ? const AppError<void>(VersionConflictFailure())
          : const AppSuccess<void>(null);
    } on Object catch (error) {
      return AppError<void>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<void>> restore(
    String id, {
    required int expectedVersion,
    required DateTime restoredAt,
  }) async {
    try {
      final int count = await dao.restore(
        id,
        expectedVersion,
        restoredAt.toUtc().microsecondsSinceEpoch,
      );
      return count == 0
          ? const AppError<void>(VersionConflictFailure())
          : const AppSuccess<void>(null);
    } on Object catch (error) {
      return AppError<void>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Money>> getBalance(String vaultId) async {
    try {
      final VaultRow? row = await dao.getById(vaultId, includeArchived: true);
      if (row == null) return const AppError<Money>(MissingVaultFailure());
      final Currency currency = _currencyForCode(row.currencyCode);
      final int total = await dao.signedVaultTotal(vaultId);
      return Money.fromMinorUnits(minorUnits: total, currency: currency);
    } on Object catch (error) {
      return AppError<Money>(StorageFailure(cause: error));
    }
  }

  @override
  Stream<Money> watchBalance(String vaultId) async* {
    final VaultRow? row = await dao.getById(vaultId, includeArchived: true);
    if (row == null) throw const MissingVaultFailure();
    final Currency currency = _currencyForCode(row.currencyCode);
    yield* dao.watchSignedVaultTotal(vaultId).map((total) {
      return Money.fromMinorUnits(
        minorUnits: total,
        currency: currency,
      ).fold(success: (value) => value, failure: (failure) => throw failure);
    });
  }

  @override
  Future<bool> hasActivity(String vaultId) => dao.hasActivity(vaultId);

  Currency _currencyForCode(String code) => Currency.supported.firstWhere(
    (value) => value.code == code,
    orElse: () => throw StateError('Unsupported stored currency.'),
  );

  VaultsCompanion _companion(Vault vault) => VaultsCompanion(
    id: Value<String>(vault.id),
    name: Value<String?>(vault.name),
    localizationKey: Value<String?>(vault.localizationKey),
    description: Value<String?>(vault.description),
    iconKey: Value<String>(vault.iconKey),
    colorToken: Value<String>(vault.colorToken),
    currencyCode: Value<String>(vault.currency.code),
    goalAmountMinor: Value<int?>(vault.goalAmount?.minorUnits),
    targetDate: Value<int?>(vault.targetDate?.toUtc().microsecondsSinceEpoch),
    priority: Value<int>(vault.priority),
    sortOrder: Value<int>(vault.sortOrder),
    withdrawalPolicy: Value<String>(vault.withdrawalPolicy.name),
    isSystem: Value<bool>(vault.isSystem),
    autoContributionEnabled: Value<bool>(vault.autoContributionEnabled),
    autoContributionKind: Value<String?>(vault.autoContributionKind?.name),
    autoContributionValue: Value<int?>(vault.autoContributionValue),
    createdAt: Value<int>(vault.createdAt.toUtc().microsecondsSinceEpoch),
    updatedAt: Value<int>(vault.updatedAt.toUtc().microsecondsSinceEpoch),
    deletedAt: Value<int?>(vault.deletedAt?.toUtc().microsecondsSinceEpoch),
    version: Value<int>(vault.version),
  );

  Vault _fromRow(VaultRow row) {
    final Currency currency = _currencyForCode(row.currencyCode);
    return Vault.create(
      id: row.id,
      name: row.name,
      localizationKey: row.localizationKey,
      description: row.description,
      iconKey: row.iconKey,
      colorToken: row.colorToken,
      currency: currency,
      goalAmount: row.goalAmountMinor == null
          ? null
          : Money.fromMinorUnits(
              minorUnits: row.goalAmountMinor!,
              currency: currency,
            ).fold(
              success: (value) => value,
              failure: (failure) => throw failure,
            ),
      targetDate: row.targetDate == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(row.targetDate!, isUtc: true),
      priority: row.priority,
      sortOrder: row.sortOrder,
      withdrawalPolicy: VaultWithdrawalPolicy.values.byName(
        row.withdrawalPolicy,
      ),
      isSystem: row.isSystem,
      autoContributionEnabled: row.autoContributionEnabled,
      autoContributionKind: row.autoContributionKind == null
          ? null
          : VaultAutoContributionKind.values.byName(row.autoContributionKind!),
      autoContributionValue: row.autoContributionValue,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
        row.createdAt,
        isUtc: true,
      ),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(
        row.updatedAt,
        isUtc: true,
      ),
      deletedAt: row.deletedAt == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(row.deletedAt!, isUtc: true),
      version: row.version,
    ).fold(success: (value) => value, failure: (failure) => throw failure);
  }
}

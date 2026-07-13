import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/validation/validation.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';

final class DriftAccountRepository implements AccountRepository {
  const DriftAccountRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Account>> watchActive() {
    final SimpleSelectStatement<$AccountsTable, AccountRow> query =
        _database.select(_database.accounts)
          ..where(($AccountsTable table) => table.deletedAt.isNull())
          ..orderBy(<OrderingTerm Function($AccountsTable)>[
            ($AccountsTable table) => OrderingTerm.asc(table.sortOrder),
            ($AccountsTable table) => OrderingTerm.asc(table.normalizedName),
          ]);
    return query.watch().map(
      (List<AccountRow> rows) =>
          List<Account>.unmodifiable(rows.map(_accountFromRow)),
    );
  }

  @override
  Future<AppResult<Account>> getById(
    String id, {
    bool includeDeleted = false,
  }) async {
    try {
      final SimpleSelectStatement<$AccountsTable, AccountRow> query =
          _database.select(_database.accounts)
            ..where(($AccountsTable table) => table.id.equals(id));
      if (!includeDeleted) {
        query.where(($AccountsTable table) => table.deletedAt.isNull());
      }
      final AccountRow? row = await query.getSingleOrNull();
      return row == null
          ? const AppError<Account>(NotFoundFailure())
          : AppSuccess<Account>(_accountFromRow(row));
    } on Object catch (error) {
      return AppError<Account>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Account>> create(Account account) async {
    try {
      await _database.into(_database.accounts).insert(_companion(account));
      return AppSuccess<Account>(account);
    } on SqliteException catch (error) {
      return error.message.contains('UNIQUE')
          ? const AppError<Account>(DuplicateFailure())
          : AppError<Account>(StorageFailure(cause: error));
    } on Object catch (error) {
      return AppError<Account>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Account>> update(
    Account account, {
    required int expectedVersion,
  }) async {
    try {
      final Account updated = account.copyWith(version: expectedVersion + 1);
      final int count =
          await (_database.update(_database.accounts)..where(
                ($AccountsTable table) =>
                    table.id.equals(account.id) &
                    table.version.equals(expectedVersion) &
                    table.deletedAt.isNull(),
              ))
              .write(_companion(updated));
      return count == 0
          ? const AppError<Account>(VersionConflictFailure())
          : AppSuccess<Account>(updated);
    } on SqliteException catch (error) {
      return error.message.contains('UNIQUE')
          ? const AppError<Account>(DuplicateFailure())
          : AppError<Account>(StorageFailure(cause: error));
    } on Object catch (error) {
      return AppError<Account>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<void>> softDelete(
    String id, {
    required int expectedVersion,
    required DateTime deletedAt,
  }) async {
    try {
      final int count =
          await (_database.update(_database.accounts)..where(
                ($AccountsTable table) =>
                    table.id.equals(id) &
                    table.version.equals(expectedVersion) &
                    table.deletedAt.isNull(),
              ))
              .write(
                AccountsCompanion(
                  deletedAt: Value<int>(
                    deletedAt.toUtc().microsecondsSinceEpoch,
                  ),
                  updatedAt: Value<int>(
                    deletedAt.toUtc().microsecondsSinceEpoch,
                  ),
                  version: Value<int>(expectedVersion + 1),
                ),
              );
      return count == 0
          ? const AppError<void>(VersionConflictFailure())
          : const AppSuccess<void>(null);
    } on Object catch (error) {
      return AppError<void>(StorageFailure(cause: error));
    }
  }

  @override
  Future<bool> activeNameExists(String name, {String? excludingId}) async {
    final String key = ValidationService.duplicateKey(name);
    final SimpleSelectStatement<$AccountsTable, AccountRow> query =
        _database.select(_database.accounts)..where(
          ($AccountsTable table) =>
              table.normalizedName.equals(key) & table.deletedAt.isNull(),
        );
    if (excludingId != null) {
      query.where(($AccountsTable table) => table.id.equals(excludingId).not());
    }
    return await query.getSingleOrNull() != null;
  }

  AccountsCompanion _companion(Account account) {
    return AccountsCompanion(
      id: Value<String>(account.id),
      name: Value<String?>(account.name),
      normalizedName: Value<String?>(
        account.name == null
            ? null
            : ValidationService.duplicateKey(account.name!),
      ),
      localizationKey: Value<String?>(account.localizationKey),
      type: Value<String>(_accountTypeToStorage(account.type)),
      currencyCode: Value<String>(account.currencyCode),
      openingBalanceMinor: Value<int>(account.openingBalance.minorUnits),
      iconKey: Value<String>(account.iconKey),
      colorToken: Value<String>(account.colorToken),
      sortOrder: Value<int>(account.sortOrder),
      createdAt: Value<int>(account.createdAt.toUtc().microsecondsSinceEpoch),
      updatedAt: Value<int>(account.updatedAt.toUtc().microsecondsSinceEpoch),
      deletedAt: Value<int?>(account.deletedAt?.toUtc().microsecondsSinceEpoch),
      version: Value<int>(account.version),
    );
  }

  Account _accountFromRow(AccountRow row) {
    final Currency currency = Currency.supported.firstWhere(
      (Currency value) => value.code == row.currencyCode,
      orElse: () => throw StateError('Unsupported stored currency.'),
    );
    final Money money =
        Money.fromMinorUnits(
          minorUnits: row.openingBalanceMinor,
          currency: currency,
        ).fold(
          success: (Money value) => value,
          failure: (AppFailure failure) => throw StateError(failure.code),
        );
    return Account(
      id: row.id,
      name: row.name,
      localizationKey: row.localizationKey,
      type: _accountTypeFromStorage(row.type),
      openingBalance: money,
      iconKey: row.iconKey,
      colorToken: row.colorToken,
      sortOrder: row.sortOrder,
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
    );
  }
}

String _accountTypeToStorage(AccountType type) => switch (type) {
  AccountType.cash => 'cash',
  AccountType.bank => 'bank',
  AccountType.eWallet => 'e_wallet',
};

AccountType _accountTypeFromStorage(String value) => switch (value) {
  'cash' => AccountType.cash,
  'bank' => AccountType.bank,
  'e_wallet' => AccountType.eWallet,
  _ => throw StateError('Unsupported stored account type.'),
};

import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../settings/domain/entities/category.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../dao/transaction_dao.dart';

final class DriftTransactionRepository implements TransactionRepository {
  DriftTransactionRepository(this.database) : dao = TransactionDao(database);
  final AppDatabase database;
  final TransactionDao dao;

  @override
  Future<AppResult<Transaction>> create(Transaction transaction) async {
    final AppFailure? referenceFailure = await _validateReferences(transaction);
    if (referenceFailure != null) {
      return AppError<Transaction>(referenceFailure);
    }
    try {
      await dao.insert(_companion(transaction));
      return AppSuccess<Transaction>(transaction);
    } on SqliteException catch (error) {
      return AppError<Transaction>(StorageFailure(cause: error));
    } on Object catch (error) {
      return AppError<Transaction>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Transaction?>> getById(
    String id, {
    bool includeDeleted = false,
  }) async {
    try {
      final TransactionRow? row = await dao.getById(
        id,
        includeDeleted: includeDeleted,
      );
      return AppSuccess<Transaction?>(row == null ? null : _fromRow(row));
    } on Object catch (error) {
      return AppError<Transaction?>(StorageFailure(cause: error));
    }
  }

  @override
  Stream<Transaction?> watchById(String id, {bool includeDeleted = false}) =>
      dao
          .watchById(id, includeDeleted: includeDeleted)
          .map((row) => row == null ? null : _fromRow(row));

  @override
  Future<AppResult<Transaction>> update(
    Transaction transaction, {
    required int expectedVersion,
  }) async {
    final AppFailure? referenceFailure = await _validateReferences(transaction);
    if (referenceFailure != null) {
      return AppError<Transaction>(referenceFailure);
    }
    final Transaction updated = transaction.copyWith(
      version: expectedVersion + 1,
    );
    try {
      final int count = await dao.updateVersioned(
        _companion(updated),
        transaction.id,
        expectedVersion,
      );
      return count == 0
          ? const AppError<Transaction>(VersionConflictFailure())
          : AppSuccess<Transaction>(updated);
    } on Object catch (error) {
      return AppError<Transaction>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<void>> softDelete(
    String id, {
    required int expectedVersion,
    required DateTime deletedAt,
  }) async {
    try {
      final int count = await dao.softDelete(
        id,
        expectedVersion,
        deletedAt.toUtc().microsecondsSinceEpoch,
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
  Future<AppResult<LedgerPage>> queryLedger(
    TransactionFilter filter, {
    TransactionCursor? cursor,
    int limit = 50,
  }) async {
    try {
      return AppSuccess<LedgerPage>(
        _page(
          await dao.queryLedger(filter, cursor: cursor, limit: limit),
          limit,
        ),
      );
    } on Object catch (error) {
      return AppError<LedgerPage>(StorageFailure(cause: error));
    }
  }

  @override
  Stream<LedgerPage> watchLedger(
    TransactionFilter filter, {
    TransactionCursor? cursor,
    int limit = 50,
  }) => dao
      .watchLedger(filter, cursor: cursor, limit: limit)
      .map((rows) => _page(rows, limit));

  @override
  Future<AppResult<int>> count(TransactionFilter filter) async {
    try {
      return AppSuccess<int>(await dao.count(filter));
    } on Object catch (error) {
      return AppError<int>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Money>> getAccountBalance(String accountId) async {
    try {
      final AccountRow? account = await (database.select(
        database.accounts,
      )..where((table) => table.id.equals(accountId))).getSingleOrNull();
      if (account == null) {
        return const AppError<Money>(MissingAccountFailure());
      }
      final Currency currency = Currency.supported.firstWhere(
        (value) => value.code == account.currencyCode,
      );
      final Money opening = Money.fromMinorUnits(
        minorUnits: account.openingBalanceMinor,
        currency: currency,
      ).fold(success: (value) => value, failure: (failure) => throw failure);
      final Money transactions = Money.fromMinorUnits(
        minorUnits: await dao.signedTransactionTotal(accountId),
        currency: currency,
      ).fold(success: (value) => value, failure: (failure) => throw failure);
      return opening.add(transactions);
    } on Object catch (error) {
      return AppError<Money>(StorageFailure(cause: error));
    }
  }

  @override
  Stream<Money> watchAccountBalance(String accountId) async* {
    final AccountRow? account = await (database.select(
      database.accounts,
    )..where((table) => table.id.equals(accountId))).getSingleOrNull();
    if (account == null) throw const MissingAccountFailure();
    final Currency currency = Currency.supported.firstWhere(
      (value) => value.code == account.currencyCode,
    );
    yield* dao.watchSignedTransactionTotal(accountId).map((total) {
      final Money opening = Money.fromMinorUnits(
        minorUnits: account.openingBalanceMinor,
        currency: currency,
      ).fold(success: (value) => value, failure: (failure) => throw failure);
      final Money transactions = Money.fromMinorUnits(
        minorUnits: total,
        currency: currency,
      ).fold(success: (value) => value, failure: (failure) => throw failure);
      return opening
          .add(transactions)
          .fold(success: (value) => value, failure: (failure) => throw failure);
    });
  }

  @override
  Future<AppResult<List<Transaction>>> queryVaultActivity(
    String vaultId,
  ) async {
    try {
      final List<TransactionRow> rows = await dao.queryVaultActivity(vaultId);
      return AppSuccess<List<Transaction>>(
        List<Transaction>.unmodifiable(rows.map(_fromRow)),
      );
    } on Object catch (error) {
      return AppError<List<Transaction>>(StorageFailure(cause: error));
    }
  }

  @override
  Stream<List<Transaction>> watchVaultActivity(String vaultId) => dao
      .watchVaultActivity(vaultId)
      .map((rows) => List<Transaction>.unmodifiable(rows.map(_fromRow)));

  LedgerPage _page(List<TransactionRow> rows, int limit) {
    final List<Transaction> items = List<Transaction>.unmodifiable(
      rows.map(_fromRow),
    );
    final Transaction? last = items.length == limit ? items.last : null;
    return LedgerPage(
      items: items,
      nextCursor: last == null
          ? null
          : TransactionCursor(
              occurredAt: last.occurredAt,
              createdAt: last.createdAt,
              id: last.id,
            ),
    );
  }

  Future<AppFailure?> _validateReferences(Transaction transaction) async {
    final AccountRow? account =
        await (database.select(database.accounts)
              ..where((table) => table.id.equals(transaction.accountId)))
            .getSingleOrNull();
    if (account == null) return const MissingAccountFailure();
    if (account.deletedAt != null) return const ArchivedAccountFailure();
    if (account.currencyCode != transaction.amount.currency.code) {
      return const CurrencyAccountMismatchFailure();
    }
    if (transaction.isVaultActivity) {
      final VaultRow? vault =
          await (database.select(database.vaults)
                ..where((table) => table.id.equals(transaction.vaultId!)))
              .getSingleOrNull();
      if (vault == null) return const MissingVaultFailure();
      if (vault.deletedAt != null) return const ArchivedVaultFailure();
      if (vault.currencyCode != transaction.amount.currency.code) {
        return const CurrencyVaultMismatchFailure();
      }
      return null;
    }
    final CategoryRow? category =
        await (database.select(database.categories)
              ..where((table) => table.id.equals(transaction.categoryId!)))
            .getSingleOrNull();
    if (category == null || category.deletedAt != null) {
      return const MissingCategoryFailure();
    }
    final String requiredType = transaction.type == TransactionType.expense
        ? CategoryType.expense.name
        : CategoryType.income.name;
    if (category.type != requiredType) {
      return const CategoryKindMismatchFailure();
    }
    return null;
  }

  TransactionsCompanion _companion(
    Transaction transaction,
  ) => TransactionsCompanion(
    id: Value<String>(transaction.id),
    type: Value<String>(transaction.type.name),
    accountId: Value<String>(transaction.accountId),
    categoryId: Value<String?>(transaction.categoryId),
    vaultId: Value<String?>(transaction.vaultId),
    incClass: Value<String?>(transaction.incClass?.name),
    currencyCode: Value<String>(transaction.amount.currency.code),
    amountMinor: Value<int>(transaction.amount.minorUnits),
    note: Value<String?>(transaction.note),
    occurredAt: Value<int>(
      transaction.occurredAt.toUtc().microsecondsSinceEpoch,
    ),
    createdAt: Value<int>(transaction.createdAt.toUtc().microsecondsSinceEpoch),
    updatedAt: Value<int>(transaction.updatedAt.toUtc().microsecondsSinceEpoch),
    deletedAt: Value<int?>(
      transaction.deletedAt?.toUtc().microsecondsSinceEpoch,
    ),
    version: Value<int>(transaction.version),
  );

  Transaction _fromRow(TransactionRow row) {
    final Currency currency = Currency.supported.firstWhere(
      (value) => value.code == row.currencyCode,
    );
    final Money amount = Money.fromMinorUnits(
      minorUnits: row.amountMinor,
      currency: currency,
    ).fold(success: (value) => value, failure: (failure) => throw failure);
    return Transaction.create(
      id: row.id,
      type: TransactionType.values.byName(row.type),
      amount: amount,
      accountId: row.accountId,
      categoryId: row.categoryId,
      vaultId: row.vaultId,
      incClass: row.incClass == null
          ? null
          : IncClass.values.byName(row.incClass!),
      note: row.note,
      occurredAt: DateTime.fromMicrosecondsSinceEpoch(
        row.occurredAt,
        isUtc: true,
      ),
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

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/transaction_filter.dart';

final class TransactionDao {
  const TransactionDao(this.database);

  final AppDatabase database;

  Future<void> insert(TransactionsCompanion companion) => database.transaction(
    () => database.into(database.transactions).insert(companion),
  );

  Future<int> updateVersioned(
    TransactionsCompanion companion,
    String id,
    int expectedVersion,
  ) => database.transaction(
    () =>
        (database.update(database.transactions)..where(
              ($TransactionsTable table) =>
                  table.id.equals(id) &
                  table.version.equals(expectedVersion) &
                  table.deletedAt.isNull(),
            ))
            .write(companion),
  );

  Future<int> softDelete(String id, int expectedVersion, int timestamp) =>
      database.transaction(
        () =>
            (database.update(database.transactions)..where(
                  ($TransactionsTable table) =>
                      table.id.equals(id) &
                      table.version.equals(expectedVersion) &
                      table.deletedAt.isNull(),
                ))
                .write(
                  TransactionsCompanion(
                    deletedAt: Value<int>(timestamp),
                    updatedAt: Value<int>(timestamp),
                    version: Value<int>(expectedVersion + 1),
                  ),
                ),
      );

  Future<int> restore(String id, int expectedVersion, int timestamp) =>
      database.transaction(
        () =>
            (database.update(database.transactions)..where(
                  ($TransactionsTable table) =>
                      table.id.equals(id) &
                      table.version.equals(expectedVersion) &
                      table.deletedAt.isNotNull(),
                ))
                .write(
                  TransactionsCompanion(
                    deletedAt: const Value<int?>(null),
                    updatedAt: Value<int>(timestamp),
                    version: Value<int>(expectedVersion + 1),
                  ),
                ),
      );

  Future<TransactionRow?> getById(String id, {required bool includeDeleted}) {
    final SimpleSelectStatement<$TransactionsTable, TransactionRow> query =
        database.select(database.transactions)
          ..where(($TransactionsTable table) => table.id.equals(id));
    if (!includeDeleted) {
      query.where(($TransactionsTable table) => table.deletedAt.isNull());
    }
    return query.getSingleOrNull();
  }

  Stream<TransactionRow?> watchById(String id, {required bool includeDeleted}) {
    final SimpleSelectStatement<$TransactionsTable, TransactionRow> query =
        database.select(database.transactions)
          ..where(($TransactionsTable table) => table.id.equals(id));
    if (!includeDeleted) {
      query.where(($TransactionsTable table) => table.deletedAt.isNull());
    }
    return query.watchSingleOrNull();
  }

  JoinedSelectStatement<HasResultSet, dynamic> _ledgerQuery(
    TransactionFilter filter, {
    TransactionCursor? cursor,
    int? limit,
    bool countOnly = false,
  }) {
    final $TransactionsTable transactions = database.transactions;
    final $CategoriesTable categories = database.categories;
    final JoinedSelectStatement<HasResultSet, dynamic> query = database
        .select(transactions)
        .join(<Join>[
          leftOuterJoin(
            categories,
            categories.id.equalsExp(transactions.categoryId),
          ),
        ]);
    Expression<bool> predicate = filter.onlyDeleted
        ? transactions.deletedAt.isNotNull()
        : filter.includeDeleted
        ? const Constant<bool>(true)
        : transactions.deletedAt.isNull();
    if (filter.start != null) {
      predicate &= transactions.occurredAt.isBiggerOrEqualValue(
        filter.start!.toUtc().microsecondsSinceEpoch,
      );
    }
    if (filter.end != null) {
      predicate &= transactions.occurredAt.isSmallerOrEqualValue(
        filter.end!.toUtc().microsecondsSinceEpoch,
      );
    }
    if (filter.type != null) {
      predicate &= transactions.type.equals(filter.type!.name);
    }
    if (filter.accountIds.isNotEmpty) {
      predicate &= transactions.accountId.isIn(filter.accountIds);
    }
    if (filter.categoryIds.isNotEmpty) {
      predicate &= transactions.categoryId.isIn(filter.categoryIds);
    }
    if (filter.incClasses.isNotEmpty) {
      predicate &= transactions.incClass.isIn(
        filter.incClasses.map((value) => value.name),
      );
    }
    if (filter.currencyCode != null) {
      predicate &= transactions.currencyCode.equals(filter.currencyCode!);
    }
    if (filter.minAmountMinor != null) {
      predicate &= transactions.amountMinor.isBiggerOrEqualValue(
        filter.minAmountMinor!,
      );
    }
    if (filter.maxAmountMinor != null) {
      predicate &= transactions.amountMinor.isSmallerOrEqualValue(
        filter.maxAmountMinor!,
      );
    }
    final String search = filter.searchText?.trim().toLowerCase() ?? '';
    if (search.isNotEmpty) {
      final String pattern =
          '%${search.replaceAll('%', r'\%').replaceAll('_', r'\_')}%';
      predicate &=
          transactions.note.lower().like(pattern) |
          categories.name.lower().like(pattern) |
          categories.localizationKey.lower().like(pattern);
    }
    if (cursor != null) {
      final int occurred = cursor.occurredAt.toUtc().microsecondsSinceEpoch;
      final int created = cursor.createdAt.toUtc().microsecondsSinceEpoch;
      predicate &=
          transactions.occurredAt.isSmallerThanValue(occurred) |
          (transactions.occurredAt.equals(occurred) &
              transactions.createdAt.isSmallerThanValue(created)) |
          (transactions.occurredAt.equals(occurred) &
              transactions.createdAt.equals(created) &
              transactions.id.isSmallerThanValue(cursor.id));
    }
    query.where(predicate);
    if (!countOnly) {
      query.orderBy(<OrderingTerm>[
        OrderingTerm.desc(transactions.occurredAt),
        OrderingTerm.desc(transactions.createdAt),
        OrderingTerm.desc(transactions.id),
      ]);
      if (limit != null) query.limit(limit);
    }
    return query;
  }

  Future<List<TransactionRow>> queryLedger(
    TransactionFilter filter, {
    TransactionCursor? cursor,
    required int limit,
  }) async => (await _ledgerQuery(filter, cursor: cursor, limit: limit).get())
      .map((row) => row.readTable(database.transactions))
      .toList(growable: false);

  Stream<List<TransactionRow>> watchLedger(
    TransactionFilter filter, {
    TransactionCursor? cursor,
    required int limit,
  }) => _ledgerQuery(filter, cursor: cursor, limit: limit).watch().map(
    (rows) => rows
        .map((row) => row.readTable(database.transactions))
        .toList(growable: false),
  );

  Future<int> count(TransactionFilter filter) async {
    final JoinedSelectStatement<HasResultSet, dynamic> filtered = _ledgerQuery(
      filter,
    );
    final List<TypedResult> rows = await filtered.get();
    // Drift cannot project a count from a joined statement after its predicate
    // is composed. This remains an application-only affordance; paged ledger
    // reads and balance calculations stay in SQL.
    return rows.length;
  }

  Future<int> signedTransactionTotal(String accountId) async {
    final row = await database
        .customSelect(
          "SELECT COALESCE(SUM(CASE WHEN type = 'income' THEN amount_minor WHEN type = 'expense' THEN -amount_minor ELSE 0 END), 0) AS total FROM transactions WHERE account_id = ? AND deleted_at IS NULL",
          variables: <Variable<Object>>[Variable<String>(accountId)],
          readsFrom: <ResultSetImplementation<Table, Object?>>{
            database.transactions,
          },
        )
        .getSingle();
    return row.read<int>('total');
  }

  Stream<int> watchSignedTransactionTotal(String accountId) => database
      .customSelect(
        "SELECT COALESCE(SUM(CASE WHEN type = 'income' THEN amount_minor WHEN type = 'expense' THEN -amount_minor ELSE 0 END), 0) AS total FROM transactions WHERE account_id = ? AND deleted_at IS NULL",
        variables: <Variable<Object>>[Variable<String>(accountId)],
        readsFrom: <ResultSetImplementation<Table, Object?>>{
          database.transactions,
        },
      )
      .watchSingle()
      .map((row) => row.read<int>('total'));
}

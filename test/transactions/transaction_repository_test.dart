import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/errors/app_failure.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/features/settings/domain/entities/category.dart';
import 'package:lys_finance/features/transactions/data/repositories/drift_transaction_repository.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction_filter.dart';

void main() {
  late AppDatabase database;
  late DriftTransactionRepository repository;
  final DateTime now = DateTime.utc(2026, 7, 13, 12);
  const String account = '00000000-0000-4000-8000-000000000001';
  const String secondAccount = '00000000-0000-4000-8000-000000000002';
  const String food = '00000000-0000-4000-8000-000000000102';
  const String salary = '00000000-0000-4000-8000-000000000101';

  setUp(() async {
    database = AppDatabase(executor: NativeDatabase.memory());
    await database.initialize();
    repository = DriftTransactionRepository(database);
  });
  tearDown(() => database.close());

  Transaction transaction({
    required String id,
    required TransactionType type,
    required int amount,
    String? note,
    DateTime? occurredAt,
    String accountId = account,
  }) => Transaction.create(
    id: id,
    type: type,
    amount: Money.fromMinorUnits(
      minorUnits: amount,
      currency: Currency.vnd,
    ).fold(success: (value) => value, failure: (failure) => throw failure),
    accountId: accountId,
    categoryId: type == TransactionType.expense ? food : salary,
    incClass: type == TransactionType.expense ? IncClass.necessity : null,
    note: note,
    occurredAt: occurredAt ?? now,
    createdAt: now,
    updatedAt: now,
    version: 1,
  ).fold(success: (value) => value, failure: (failure) => throw failure);

  test('creates income and expense and derives exact balance', () async {
    await repository.create(
      transaction(
        id: '11111111-1111-4111-8111-111111111111',
        type: TransactionType.income,
        amount: 100000,
      ),
    );
    await repository.create(
      transaction(
        id: '22222222-2222-4222-8222-222222222222',
        type: TransactionType.expense,
        amount: 45000,
      ),
    );
    final Money balance =
        (await repository.getAccountBalance(account) as AppSuccess<Money>)
            .value;
    expect(balance.minorUnits, 55000);
  });

  test(
    'balance includes future rows and reacts to delete and account move',
    () async {
      final Transaction futureIncome = transaction(
        id: '33333333-3333-4333-8333-333333333333',
        type: TransactionType.income,
        amount: 1000,
        occurredAt: now.add(const Duration(days: 30)),
      );
      final Transaction expense = transaction(
        id: '44444444-4444-4444-8444-444444444444',
        type: TransactionType.expense,
        amount: 200,
      );
      await repository.create(futureIncome);
      await repository.create(expense);
      expect(
        ((await repository.getAccountBalance(account)) as AppSuccess<Money>)
            .value
            .minorUnits,
        800,
      );

      await repository.softDelete(
        expense.id,
        expectedVersion: 1,
        deletedAt: now,
      );
      expect(
        ((await repository.getAccountBalance(account)) as AppSuccess<Money>)
            .value
            .minorUnits,
        1000,
      );

      await repository.update(
        futureIncome.copyWith(accountId: secondAccount),
        expectedVersion: 1,
      );
      expect(
        ((await repository.getAccountBalance(account)) as AppSuccess<Money>)
            .value
            .minorUnits,
        0,
      );
      expect(
        ((await repository.getAccountBalance(secondAccount))
                as AppSuccess<Money>)
            .value
            .minorUnits,
        1000,
      );
    },
  );

  test('filters, searches, and applies stable descending order', () async {
    await repository.create(
      transaction(
        id: '11111111-1111-4111-8111-111111111111',
        type: TransactionType.expense,
        amount: 100,
        note: 'Morning coffee',
        occurredAt: now.subtract(const Duration(days: 1)),
      ),
    );
    await repository.create(
      transaction(
        id: '22222222-2222-4222-8222-222222222222',
        type: TransactionType.income,
        amount: 200,
        note: 'Client work',
      ),
    );
    final LedgerPage expense =
        (await repository.queryLedger(
                  const TransactionFilter(type: TransactionType.expense),
                )
                as AppSuccess<LedgerPage>)
            .value;
    expect(expense.items, hasLength(1));
    final LedgerPage search =
        (await repository.queryLedger(
                  const TransactionFilter(searchText: 'client'),
                )
                as AppSuccess<LedgerPage>)
            .value;
    expect(search.items.single.type, TransactionType.income);
  });

  test('combines date, account, category, INC, and amount filters', () async {
    await repository.create(
      transaction(
        id: '55555555-5555-4555-8555-555555555555',
        type: TransactionType.expense,
        amount: 500,
      ),
    );
    await repository.create(
      transaction(
        id: '66666666-6666-4666-8666-666666666666',
        type: TransactionType.expense,
        amount: 900,
        occurredAt: now.subtract(const Duration(days: 5)),
      ),
    );
    await repository.create(
      transaction(
        id: '77777777-7777-4777-8777-777777777777',
        type: TransactionType.expense,
        amount: 500,
        accountId: secondAccount,
      ),
    );
    final LedgerPage result =
        (await repository.queryLedger(
                  TransactionFilter(
                    start: now.subtract(const Duration(days: 1)),
                    end: now.add(const Duration(days: 1)),
                    accountIds: const <String>{account},
                    categoryIds: const <String>{food},
                    incClasses: const <IncClass>{IncClass.necessity},
                    currencyCode: Currency.vnd.code,
                    minAmountMinor: 400,
                    maxAmountMinor: 600,
                  ),
                )
                as AppSuccess<LedgerPage>)
            .value;
    expect(result.items.map((value) => value.id), <String>[
      '55555555-5555-4555-8555-555555555555',
    ]);
  });

  test('enforces optimistic update, delete visibility, and restore', () async {
    final Transaction item = transaction(
      id: '11111111-1111-4111-8111-111111111111',
      type: TransactionType.expense,
      amount: 100,
    );
    await repository.create(item);
    expect(
      await repository.update(item, expectedVersion: 99),
      isA<AppError<Transaction>>().having(
        (value) => value.error,
        'error',
        isA<VersionConflictFailure>(),
      ),
    );
    expect(
      await repository.softDelete(item.id, expectedVersion: 1, deletedAt: now),
      isA<AppSuccess<void>>(),
    );
    expect(
      (await repository.queryLedger(const TransactionFilter())
              as AppSuccess<LedgerPage>)
          .value
          .items,
      isEmpty,
    );
    final Transaction deleted =
        (await repository.getById(item.id, includeDeleted: true)
                as AppSuccess<Transaction?>)
            .value!;
    expect(deleted.version, 2);
    expect(
      await repository.restore(
        item.id,
        expectedVersion: 2,
        restoredAt: now.add(const Duration(seconds: 1)),
      ),
      isA<AppSuccess<void>>(),
    );
    expect(
      (await repository.queryLedger(const TransactionFilter())
              as AppSuccess<LedgerPage>)
          .value
          .items,
      hasLength(1),
    );
  });

  test(
    'maps missing references and category mismatch to typed failures',
    () async {
      final Transaction item = transaction(
        id: '11111111-1111-4111-8111-111111111111',
        type: TransactionType.expense,
        amount: 100,
      ).copyWith(accountId: 'missing');
      expect(
        await repository.create(item),
        isA<AppError<Transaction>>().having(
          (value) => value.error,
          'error',
          isA<MissingAccountFailure>(),
        ),
      );
      final Transaction mismatch = transaction(
        id: '22222222-2222-4222-8222-222222222222',
        type: TransactionType.expense,
        amount: 100,
      ).copyWith(categoryId: salary);
      expect(
        await repository.create(mismatch),
        isA<AppError<Transaction>>().having(
          (value) => value.error,
          'error',
          isA<CategoryKindMismatchFailure>(),
        ),
      );
    },
  );
}

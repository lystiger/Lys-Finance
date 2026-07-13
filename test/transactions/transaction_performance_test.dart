import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/features/settings/domain/entities/category.dart';
import 'package:lys_finance/features/transactions/data/repositories/drift_transaction_repository.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction_filter.dart';

void main() {
  test('10,000-row ledger operations stay within Sprint 02 budgets', () async {
    final AppDatabase database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);
    await database.initialize();
    const String account = '00000000-0000-4000-8000-000000000001';
    const String food = '00000000-0000-4000-8000-000000000102';
    const String salary = '00000000-0000-4000-8000-000000000101';
    final int now = DateTime.utc(2026, 7, 13, 12).microsecondsSinceEpoch;

    await database.transaction(() async {
      await database.batch((batch) {
        for (int index = 0; index < 10000; index += 1) {
          final bool income = index.isEven;
          batch.insert(
            database.transactions,
            TransactionsCompanion.insert(
              id: '10000000-0000-4000-8000-${index.toString().padLeft(12, '0')}',
              type: income
                  ? TransactionType.income.name
                  : TransactionType.expense.name,
              accountId: account,
              categoryId: income ? salary : food,
              incClass: Value<String?>(income ? null : IncClass.necessity.name),
              currencyCode: Currency.vnd.code,
              amountMinor: index + 1,
              note: Value<String?>(index == 6789 ? 'performance needle' : null),
              occurredAt: now - index,
              createdAt: now - index,
              updatedAt: now - index,
              version: 1,
            ),
          );
        }
      });
    });

    final DriftTransactionRepository repository = DriftTransactionRepository(
      database,
    );
    final Stopwatch ledgerWatch = Stopwatch()..start();
    final LedgerPage ledger =
        (await repository.queryLedger(const TransactionFilter())
                as AppSuccess<LedgerPage>)
            .value;
    ledgerWatch.stop();

    final Stopwatch searchWatch = Stopwatch()..start();
    final LedgerPage search =
        (await repository.queryLedger(
                  const TransactionFilter(searchText: 'needle'),
                )
                as AppSuccess<LedgerPage>)
            .value;
    searchWatch.stop();

    final Stopwatch balanceWatch = Stopwatch()..start();
    final Money balance =
        (await repository.getAccountBalance(account) as AppSuccess<Money>)
            .value;
    balanceWatch.stop();

    final Transaction extra = Transaction.create(
      id: '20000000-0000-4000-8000-000000000001',
      type: TransactionType.expense,
      amount: Money.fromMinorUnits(
        minorUnits: 100,
        currency: Currency.vnd,
      ).fold(success: (value) => value, failure: (failure) => throw failure),
      accountId: account,
      categoryId: food,
      incClass: IncClass.necessity,
      occurredAt: DateTime.utc(2026, 7, 13, 13),
      createdAt: DateTime.utc(2026, 7, 13, 13),
      updatedAt: DateTime.utc(2026, 7, 13, 13),
      version: 1,
    ).fold(success: (value) => value, failure: (failure) => throw failure);
    final Stopwatch saveWatch = Stopwatch()..start();
    await repository.create(extra);
    saveWatch.stop();

    debugPrint(
      'Sprint 02 performance (10,000 rows): '
      'ledger=${ledgerWatch.elapsedMilliseconds}ms, '
      'search=${searchWatch.elapsedMilliseconds}ms, '
      'balance=${balanceWatch.elapsedMilliseconds}ms, '
      'save=${saveWatch.elapsedMilliseconds}ms',
    );
    expect(ledger.items, hasLength(50));
    expect(ledger.nextCursor, isNotNull);
    expect(search.items.single.note, 'performance needle');
    expect(balance.currency, Currency.vnd);
    expect(ledgerWatch.elapsedMilliseconds, lessThan(300));
    expect(searchWatch.elapsedMilliseconds, lessThan(400));
    expect(balanceWatch.elapsedMilliseconds, lessThan(100));
    expect(saveWatch.elapsedMilliseconds, lessThan(300));
  });
}

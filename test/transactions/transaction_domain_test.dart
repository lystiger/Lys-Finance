import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/features/settings/domain/entities/category.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction.dart';

void main() {
  final DateTime now = DateTime.utc(2026, 7, 13);
  final Money amount =
      Money.fromMinorUnits(minorUnits: 45000, currency: Currency.vnd).fold(
        success: (value) => value,
        failure: (failure) => throw TestFailure(failure.code),
      );

  AppResult<Transaction> create({
    TransactionType type = TransactionType.expense,
    Money? value,
    IncClass? incClass = IncClass.necessity,
    String? note,
  }) => Transaction.create(
    id: '11111111-1111-4111-8111-111111111111',
    type: type,
    amount: value ?? amount,
    accountId: 'account',
    categoryId: 'category',
    incClass: incClass,
    note: note,
    occurredAt: now,
    createdAt: now,
    updatedAt: now,
    version: 1,
  );

  test('creates valid expense and normalizes note', () {
    final Transaction transaction =
        (create(note: '  lunch  ') as AppSuccess<Transaction>).value;
    expect(transaction.note, 'lunch');
    expect(transaction.incClass, IncClass.necessity);
  });

  test('requires positive amount and valid expense classification', () {
    expect(
      create(value: Money.zero(Currency.vnd)),
      isA<AppError<Transaction>>(),
    );
    expect(create(incClass: null), isA<AppError<Transaction>>());
  });

  test('income cannot carry INC and reserved types cannot be created', () {
    expect(create(type: TransactionType.income), isA<AppError<Transaction>>());
    expect(
      create(type: TransactionType.income, incClass: null),
      isA<AppSuccess<Transaction>>(),
    );
    expect(
      create(type: TransactionType.transfer, incClass: null),
      isA<AppError<Transaction>>(),
    );
  });

  test('rejects invalid IDs, audit state, and overlong notes', () {
    expect(
      Transaction.create(
        id: 'bad',
        type: TransactionType.expense,
        amount: amount,
        accountId: 'a',
        categoryId: 'c',
        incClass: IncClass.investment,
        occurredAt: now,
        createdAt: now,
        updatedAt: now,
        version: 1,
      ),
      isA<AppError<Transaction>>(),
    );
    expect(
      create(note: List<String>.filled(2001, 'a').join()),
      isA<AppError<Transaction>>(),
    );
  });
}

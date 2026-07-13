import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/formatting_service.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/core/money/money_service.dart';

void main() {
  const MoneyService service = MoneyService();
  const FormattingService formatting = FormattingService();

  test('parses exact VND and localized USD without floating point', () {
    expect(
      _value(
        service.parse('125.000', currency: Currency.vnd, locale: 'vi'),
      ).minorUnits,
      125000,
    );
    expect(
      _value(
        service.parse('1.234,50', currency: Currency.usd, locale: 'vi'),
      ).minorUnits,
      123450,
    );
    expect(
      _value(
        service.parse('1,234.50', currency: Currency.usd, locale: 'en'),
      ).minorUnits,
      123450,
    );
  });

  test('rejects excess precision and out-of-range input as typed failures', () {
    expect(
      service.parse('1.2', currency: Currency.vnd, locale: 'en'),
      isA<AppError<Money>>(),
    );
    expect(
      service.parse(
        '999999999999999999999999',
        currency: Currency.usd,
        locale: 'en',
      ),
      isA<AppError<Money>>(),
    );
  });

  test('checks overflow, mismatch, comparison, negation, and allocation', () {
    final Money maximum = _value(
      Money.fromMinorUnits(minorUnits: maxInt64, currency: Currency.vnd),
    );
    final Money one = _value(
      Money.fromMinorUnits(minorUnits: 1, currency: Currency.vnd),
    );
    final Money dollar = _value(
      Money.fromMinorUnits(minorUnits: 1, currency: Currency.usd),
    );
    expect(maximum.add(one), isA<AppError<Money>>());
    expect(one.add(dollar), isA<AppError<Money>>());
    expect(one.compare(dollar), isA<AppError<int>>());
    expect(
      _value(one.allocate(<int>[1, 1, 1])).map((part) => part.minorUnits),
      <int>[1, 0, 0],
    );
    final Money minimum = _value(
      Money.fromMinorUnits(minorUnits: minInt64, currency: Currency.vnd),
    );
    expect(minimum.negate(), isA<AppError<Money>>());
    expect(minimum.absolute(), isA<AppError<Money>>());
  });

  test('formats VND and USD in English and Vietnamese', () {
    final Money vnd = _value(
      Money.fromMinorUnits(minorUnits: 125000, currency: Currency.vnd),
    );
    final Money usd = _value(
      Money.fromMinorUnits(minorUnits: 1234, currency: Currency.usd),
    );
    expect(formatting.money(vnd, locale: 'en'), '₫125,000');
    expect(formatting.money(vnd, locale: 'vi'), '125.000 ₫');
    expect(formatting.money(usd, locale: 'en'), r'$12.34');
    expect(formatting.money(usd, locale: 'vi'), r'12,34 US$');
  });
}

T _value<T>(AppResult<T> result) => switch (result) {
  AppSuccess<T>(value: final T value) => value,
  AppError<T>(error: final error) => throw TestFailure(error.code),
};

import '../domain/app_result.dart';
import '../errors/app_failure.dart';
import 'currency.dart';

const int minInt64 = -9223372036854775808;
const int maxInt64 = 9223372036854775807;

final class Money {
  const Money._(this.minorUnits, this.currency);

  final int minorUnits;
  final Currency currency;

  static AppResult<Money> fromMinorUnits({
    required int minorUnits,
    required Currency currency,
  }) {
    if (!_inRange(minorUnits)) {
      return AppError<Money>(_overflowFailure);
    }
    return AppSuccess<Money>(Money._(minorUnits, currency));
  }

  static Money zero(Currency currency) => Money._(0, currency);

  AppResult<Money> add(Money other) {
    final AppFailure? mismatch = _currencyMismatch(other);
    if (mismatch != null) {
      return AppError<Money>(mismatch);
    }
    if ((other.minorUnits > 0 && minorUnits > maxInt64 - other.minorUnits) ||
        (other.minorUnits < 0 && minorUnits < minInt64 - other.minorUnits)) {
      return AppError<Money>(_overflowFailure);
    }
    return AppSuccess<Money>(Money._(minorUnits + other.minorUnits, currency));
  }

  AppResult<Money> subtract(Money other) {
    final AppFailure? mismatch = _currencyMismatch(other);
    if (mismatch != null) {
      return AppError<Money>(mismatch);
    }
    if ((other.minorUnits < 0 && minorUnits > maxInt64 + other.minorUnits) ||
        (other.minorUnits > 0 && minorUnits < minInt64 + other.minorUnits)) {
      return AppError<Money>(_overflowFailure);
    }
    return AppSuccess<Money>(Money._(minorUnits - other.minorUnits, currency));
  }

  AppResult<List<Money>> allocate(List<int> ratios) {
    if (ratios.isEmpty || ratios.any((int ratio) => ratio <= 0)) {
      return const AppError<List<Money>>(
        DomainFailure(
          'Allocation ratios must be positive.',
          code: 'invalid_allocation',
        ),
      );
    }
    final BigInt total = ratios.fold<BigInt>(
      BigInt.zero,
      (BigInt sum, int ratio) => sum + BigInt.from(ratio),
    );
    final List<int> shares = ratios
        .map(
          (int ratio) =>
              (BigInt.from(minorUnits) * BigInt.from(ratio) ~/ total).toInt(),
        )
        .toList(growable: false);
    int remainder =
        minorUnits - shares.fold(0, (int sum, int value) => sum + value);
    final int direction = remainder.sign;
    int index = 0;
    while (remainder != 0) {
      shares[index] += direction;
      remainder -= direction;
      index = (index + 1) % shares.length;
    }
    return AppSuccess<List<Money>>(
      List<Money>.unmodifiable(
        shares.map((int value) => Money._(value, currency)),
      ),
    );
  }

  AppResult<Money> absolute() {
    if (minorUnits == minInt64) {
      return AppError<Money>(_overflowFailure);
    }
    return AppSuccess<Money>(Money._(minorUnits.abs(), currency));
  }

  AppResult<Money> negate() {
    if (minorUnits == minInt64) {
      return AppError<Money>(_overflowFailure);
    }
    return AppSuccess<Money>(Money._(-minorUnits, currency));
  }

  AppResult<int> compare(Money other) {
    final AppFailure? mismatch = _currencyMismatch(other);
    if (mismatch != null) {
      return AppError<int>(mismatch);
    }
    return AppSuccess<int>(minorUnits.compareTo(other.minorUnits));
  }

  AppFailure? _currencyMismatch(Money other) {
    return currency == other.currency
        ? null
        : const DomainFailure(
            'Money values must use the same currency.',
            code: 'currency_mismatch',
          );
  }

  static bool _inRange(int value) => value >= minInt64 && value <= maxInt64;

  static const DomainFailure _overflowFailure = DomainFailure(
    'The amount is outside the supported range.',
    code: 'money_overflow',
  );

  @override
  bool operator ==(Object other) =>
      other is Money &&
      minorUnits == other.minorUnits &&
      currency == other.currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);
}

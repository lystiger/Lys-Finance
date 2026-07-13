import '../domain/app_result.dart';
import '../errors/app_failure.dart';
import 'currency.dart';
import 'money.dart';

final class MoneyService {
  const MoneyService();

  AppResult<Money> parse(
    String input, {
    required Currency currency,
    required String locale,
  }) {
    String value = input.trim();
    if (value.isEmpty) {
      return const AppError<Money>(
        ValidationFailure('Enter an amount.', code: 'required'),
      );
    }
    final bool negative = value.startsWith('-');
    if (negative) {
      value = value.substring(1);
    }
    final bool vietnamese = locale.toLowerCase().startsWith('vi');
    final String decimalSeparator = vietnamese ? ',' : '.';
    final String groupingSeparator = vietnamese ? '.' : ',';
    if (!RegExp(r'^[0-9.,]+$').hasMatch(value)) {
      return const AppError<Money>(
        ValidationFailure('Enter a valid amount.', code: 'invalid_format'),
      );
    }
    final List<String> parts = value.split(decimalSeparator);
    if (parts.length > 2) {
      return const AppError<Money>(
        ValidationFailure('Enter a valid amount.', code: 'invalid_format'),
      );
    }
    final String wholeText = parts.first.replaceAll(groupingSeparator, '');
    final String fractionText = parts.length == 2 ? parts.last : '';
    if (wholeText.isEmpty ||
        !RegExp(r'^\d+$').hasMatch(wholeText) ||
        (fractionText.isNotEmpty && !RegExp(r'^\d+$').hasMatch(fractionText))) {
      return const AppError<Money>(
        ValidationFailure('Enter a valid amount.', code: 'invalid_format'),
      );
    }
    if (fractionText.length > currency.minorUnitDigits) {
      return const AppError<Money>(
        ValidationFailure(
          'The amount has too many decimal places.',
          code: 'excessive_precision',
        ),
      );
    }
    final int scale = _pow10(currency.minorUnitDigits);
    final int? whole = int.tryParse(wholeText);
    if (whole == null || whole > maxInt64 ~/ scale) {
      return const AppError<Money>(
        ValidationFailure(
          'The amount is outside the supported range.',
          code: 'out_of_range',
        ),
      );
    }
    final String paddedFraction = fractionText.padRight(
      currency.minorUnitDigits,
      '0',
    );
    final int fraction = paddedFraction.isEmpty ? 0 : int.parse(paddedFraction);
    int minorUnits = whole * scale + fraction;
    if (negative) {
      minorUnits = -minorUnits;
    }
    return Money.fromMinorUnits(minorUnits: minorUnits, currency: currency);
  }

  AppResult<Money> requirePositive(Money money) {
    return money.minorUnits > 0
        ? AppSuccess<Money>(money)
        : const AppError<Money>(
            ValidationFailure(
              'The amount must be greater than zero.',
              code: 'positive_required',
            ),
          );
  }
}

int _pow10(int exponent) {
  int value = 1;
  for (int index = 0; index < exponent; index += 1) {
    value *= 10;
  }
  return value;
}

import 'currency.dart';
import 'money.dart';

final class FormattingService {
  const FormattingService();

  String money(Money money, {required String locale}) {
    final bool vietnamese = locale.toLowerCase().startsWith('vi');
    final String groupingSeparator = vietnamese ? '.' : ',';
    final String decimalSeparator = vietnamese ? ',' : '.';
    final int scale = _pow10(money.currency.minorUnitDigits);
    final bool negative = money.minorUnits < 0;
    final int absolute = money.minorUnits.abs();
    final int whole = absolute ~/ scale;
    final int fraction = absolute % scale;
    final String grouped = _group(whole.toString(), groupingSeparator);
    final String decimals = money.currency.minorUnitDigits == 0
        ? ''
        : '$decimalSeparator${fraction.toString().padLeft(money.currency.minorUnitDigits, '0')}';
    final String number = '${negative ? '-' : ''}$grouped$decimals';
    if (vietnamese) {
      final String symbol = money.currency == Currency.usd
          ? 'US\$'
          : money.currency.symbol;
      return '$number $symbol';
    }
    return '${money.currency.symbol}$number';
  }

  String _group(String digits, String separator) {
    final StringBuffer output = StringBuffer();
    for (int index = 0; index < digits.length; index += 1) {
      if (index > 0 && (digits.length - index) % 3 == 0) {
        output.write(separator);
      }
      output.write(digits[index]);
    }
    return output.toString();
  }
}

int _pow10(int exponent) {
  int value = 1;
  for (int index = 0; index < exponent; index += 1) {
    value *= 10;
  }
  return value;
}

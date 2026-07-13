import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/localization/formatters.dart';

void main() {
  test('VND formatter uses no fractional digits', () {
    final String formatted = AppFormatters.currency(1234567);

    expect(formatted, contains('1.234.567'));
    expect(formatted, contains('₫'));
  });
}

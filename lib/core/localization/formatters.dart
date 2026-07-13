import 'package:intl/intl.dart';

abstract final class AppFormatters {
  static String date(DateTime value, {required String locale}) {
    return DateFormat.yMMMMd(locale).format(value);
  }

  static String currency(
    num value, {
    String locale = 'vi_VN',
    String currencyCode = 'VND',
  }) {
    return NumberFormat.currency(
      locale: locale,
      name: currencyCode,
      symbol: currencyCode == 'VND' ? '₫' : currencyCode,
      decimalDigits: currencyCode == 'VND' ? 0 : 2,
    ).format(value);
  }
}

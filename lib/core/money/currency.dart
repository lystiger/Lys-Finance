import '../domain/app_result.dart';
import '../errors/app_failure.dart';

final class Currency {
  const Currency._({
    required this.code,
    required this.numericCode,
    required this.minorUnitDigits,
    required this.symbol,
    required this.englishName,
  });

  final String code;
  final int numericCode;
  final int minorUnitDigits;
  final String symbol;
  final String englishName;

  static const Currency vnd = Currency._(
    code: 'VND',
    numericCode: 704,
    minorUnitDigits: 0,
    symbol: '₫',
    englishName: 'Vietnamese đồng',
  );

  static const Currency usd = Currency._(
    code: 'USD',
    numericCode: 840,
    minorUnitDigits: 2,
    symbol: r'$',
    englishName: 'US dollar',
  );

  static const List<Currency> supported = <Currency>[vnd, usd];

  static AppResult<Currency> fromCode(String code) {
    final String normalized = code.trim().toUpperCase();
    for (final Currency currency in supported) {
      if (currency.code == normalized) {
        return AppSuccess<Currency>(currency);
      }
    }
    return AppError<Currency>(
      const DomainFailure(
        'That currency is not supported.',
        code: 'unsupported_currency',
      ),
    );
  }

  @override
  bool operator ==(Object other) => other is Currency && code == other.code;

  @override
  int get hashCode => code.hashCode;
}

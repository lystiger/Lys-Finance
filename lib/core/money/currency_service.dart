import '../domain/app_result.dart';
import 'currency.dart';

final class CurrencyService {
  const CurrencyService();

  List<Currency> get supported => Currency.supported;

  AppResult<Currency> resolve(String code) => Currency.fromCode(code);
}

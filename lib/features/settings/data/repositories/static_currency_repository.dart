import '../../../../core/domain/app_result.dart';
import '../../../../core/money/currency.dart';
import '../../domain/repositories/currency_repository.dart';

final class StaticCurrencyRepository implements CurrencyRepository {
  const StaticCurrencyRepository();

  @override
  List<Currency> get supported => Currency.supported;

  @override
  AppResult<Currency> getByCode(String code) => Currency.fromCode(code);
}

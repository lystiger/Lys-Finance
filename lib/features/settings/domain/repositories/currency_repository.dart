import '../../../../core/domain/app_result.dart';
import '../../../../core/money/currency.dart';

abstract interface class CurrencyRepository {
  List<Currency> get supported;
  AppResult<Currency> getByCode(String code);
}

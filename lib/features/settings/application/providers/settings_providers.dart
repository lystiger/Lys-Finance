import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/money/currency_service.dart';
import '../../../../core/money/formatting_service.dart';
import '../../../../core/money/money_service.dart';
import '../../../../core/providers/foundation_providers.dart';
import '../../../../core/validation/validation.dart';
import '../../data/repositories/drift_account_repository.dart';
import '../../data/repositories/drift_category_repository.dart';
import '../../data/repositories/drift_settings_repository.dart';
import '../../data/repositories/static_currency_repository.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../services/account_service.dart';
import '../services/category_service.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
ValidationService validationService(Ref ref) => const ValidationService();

@Riverpod(keepAlive: true)
MoneyService moneyService(Ref ref) => const MoneyService();

@Riverpod(keepAlive: true)
FormattingService formattingService(Ref ref) => const FormattingService();

@Riverpod(keepAlive: true)
CurrencyService currencyService(Ref ref) => const CurrencyService();

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) =>
    DriftAccountRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) =>
    DriftCategoryRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    DriftSettingsRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
CurrencyRepository currencyRepository(Ref ref) =>
    const StaticCurrencyRepository();

@Riverpod(keepAlive: true)
AccountService accountService(Ref ref) => AccountService(
  repository: ref.watch(accountRepositoryProvider),
  validation: ref.watch(validationServiceProvider),
  uuid: ref.watch(uuidGeneratorProvider),
  clock: ref.watch(appClockProvider),
);

@Riverpod(keepAlive: true)
CategoryService categoryService(Ref ref) => CategoryService(
  repository: ref.watch(categoryRepositoryProvider),
  validation: ref.watch(validationServiceProvider),
  uuid: ref.watch(uuidGeneratorProvider),
  clock: ref.watch(appClockProvider),
);

@riverpod
Stream<List<Account>> activeAccounts(Ref ref) =>
    ref.watch(accountRepositoryProvider).watchActive();

@riverpod
Stream<List<Category>> activeCategories(
  Ref ref, {
  CategoryType? type,
  IncClass? incClass,
}) => ref
    .watch(categoryRepositoryProvider)
    .watchActive(type: type, incClass: incClass);

@riverpod
Stream<AppSettings> appSettingsStream(Ref ref) =>
    ref.watch(settingsRepositoryProvider).watch();

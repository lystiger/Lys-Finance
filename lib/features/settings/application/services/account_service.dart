import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/app_clock.dart';
import '../../../../core/validation/validation.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';

final class AccountService {
  const AccountService({
    required this.repository,
    required this.validation,
    required this.uuid,
    required this.clock,
  });

  static const Set<String> iconKeys = <String>{
    'wallet',
    'account_balance',
    'account_balance_wallet',
  };
  static const Set<String> colorTokens = <String>{
    'category1',
    'category2',
    'category3',
    'category4',
    'category5',
    'category6',
    'category7',
    'category8',
  };

  final AccountRepository repository;
  final ValidationService validation;
  final UuidGenerator uuid;
  final AppClock clock;

  Future<AppResult<Account>> create({
    required String name,
    required AccountType type,
    required Currency currency,
    required int openingBalanceMinor,
    required String iconKey,
    required String colorToken,
    required int sortOrder,
  }) async {
    final ValidationResult<String> validName = validation.validateName(name);
    if (!validName.isValid) {
      return AppError<Account>(_validationFailure(validName.errors.first));
    }
    if (!iconKeys.contains(iconKey) || !colorTokens.contains(colorToken)) {
      return const AppError<Account>(
        ValidationFailure(
          'Choose a valid icon and color.',
          code: 'invalid_key',
        ),
      );
    }
    if (sortOrder < 0) {
      return const AppError<Account>(
        ValidationFailure(
          'Sort order cannot be negative.',
          code: 'out_of_range',
        ),
      );
    }
    if (await repository.activeNameExists(validName.value!)) {
      return const AppError<Account>(DuplicateFailure());
    }
    final AppResult<Money> moneyResult = Money.fromMinorUnits(
      minorUnits: openingBalanceMinor,
      currency: currency,
    );
    if (moneyResult is AppError<Money>) {
      return AppError<Account>(moneyResult.error);
    }
    final DateTime now = clock.now().toUtc();
    final Account account = Account(
      id: uuid.v4(),
      name: validName.value!,
      type: type,
      openingBalance: (moneyResult as AppSuccess<Money>).value,
      iconKey: iconKey,
      colorToken: colorToken,
      sortOrder: sortOrder,
      createdAt: now,
      updatedAt: now,
      version: 1,
    );
    return repository.create(account);
  }
}

ValidationFailure _validationFailure(ValidationCode code) {
  return ValidationFailure('Check this value and try again.', code: code.name);
}

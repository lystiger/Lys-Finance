import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/time/app_clock.dart';
import '../../../../core/validation/validation.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

final class CategoryService {
  const CategoryService({
    required this.repository,
    required this.validation,
    required this.uuid,
    required this.clock,
  });

  static const Set<String> iconKeys = <String>{
    'payments',
    'restaurant',
    'directions_bus',
    'shopping_bag',
    'smart_toy',
    'health_and_safety',
    'school',
    'trending_up',
    'more_horiz',
  };

  final CategoryRepository repository;
  final ValidationService validation;
  final UuidGenerator uuid;
  final AppClock clock;

  Future<AppResult<Category>> create({
    required String name,
    required CategoryType type,
    required IncClass? incClass,
    required String iconKey,
    required String colorToken,
    required int sortOrder,
  }) async {
    final ValidationResult<String> validName = validation.validateName(name);
    if (!validName.isValid) {
      return AppError<Category>(_validationFailure(validName.errors.first));
    }
    if ((type == CategoryType.expense && incClass == null) ||
        (type == CategoryType.income && incClass != null)) {
      return const AppError<Category>(
        ValidationFailure(
          'Choose a valid classification.',
          code: 'invalid_inc_class',
        ),
      );
    }
    if (!iconKeys.contains(iconKey) ||
        !RegExp(r'^(category[1-8]|income|investment)$').hasMatch(colorToken)) {
      return const AppError<Category>(
        ValidationFailure(
          'Choose a valid icon and color.',
          code: 'invalid_key',
        ),
      );
    }
    if (sortOrder < 0) {
      return const AppError<Category>(
        ValidationFailure(
          'Sort order cannot be negative.',
          code: 'out_of_range',
        ),
      );
    }
    if (await repository.activeNameExists(validName.value!, type)) {
      return const AppError<Category>(DuplicateFailure());
    }
    final DateTime now = clock.now().toUtc();
    return repository.create(
      Category(
        id: uuid.v4(),
        name: validName.value!,
        type: type,
        incClass: incClass,
        iconKey: iconKey,
        colorToken: colorToken,
        sortOrder: sortOrder,
        isSystem: false,
        createdAt: now,
        updatedAt: now,
        version: 1,
      ),
    );
  }
}

ValidationFailure _validationFailure(ValidationCode code) {
  return ValidationFailure('Check this value and try again.', code: code.name);
}

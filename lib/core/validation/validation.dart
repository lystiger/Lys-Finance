import 'package:characters/characters.dart';

enum ValidationCode {
  required,
  invalidFormat,
  unsupportedCurrency,
  excessivePrecision,
  outOfRange,
  invalidCharacter,
  tooLong,
  duplicate,
  invalidIncClass,
  versionConflict,
  unavailableStorage,
}

final class ValidationResult<T> {
  const ValidationResult.valid(this.value) : errors = const <ValidationCode>[];

  const ValidationResult.invalid(this.errors) : value = null;

  final T? value;
  final List<ValidationCode> errors;

  bool get isValid => errors.isEmpty;
}

final class ValidationService {
  const ValidationService();

  ValidationResult<String> validateName(String? input, {int maxLength = 80}) {
    final String source = input ?? '';
    if (RegExp(r'[\u0000-\u001F\u007F-\u009F\u2028\u2029]').hasMatch(source)) {
      return const ValidationResult<String>.invalid(<ValidationCode>[
        ValidationCode.invalidCharacter,
      ]);
    }
    final String normalized = normalizeName(source);
    if (normalized.isEmpty) {
      return const ValidationResult<String>.invalid(<ValidationCode>[
        ValidationCode.required,
      ]);
    }
    if (normalized.characters.length > maxLength) {
      return const ValidationResult<String>.invalid(<ValidationCode>[
        ValidationCode.tooLong,
      ]);
    }
    return ValidationResult<String>.valid(normalized);
  }

  ValidationResult<String> validateCurrencyCode(String? input) {
    final String normalized = (input ?? '').trim().toUpperCase();
    if (!RegExp(r'^[A-Z]{3}$').hasMatch(normalized)) {
      return const ValidationResult<String>.invalid(<ValidationCode>[
        ValidationCode.invalidFormat,
      ]);
    }
    return ValidationResult<String>.valid(normalized);
  }

  static String normalizeName(String value) =>
      value.trim().replaceAll(RegExp(r'\s+'), ' ');

  static String duplicateKey(String value) =>
      normalizeName(value).toLowerCase();
}

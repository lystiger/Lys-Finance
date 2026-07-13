import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/validation/validation.dart';

void main() {
  const ValidationService validation = ValidationService();

  test('normalizes whitespace and accepts Vietnamese and emoji graphemes', () {
    final ValidationResult<String> result = validation.validateName(
      '  Ví   🐷  ',
    );
    expect(result.isValid, isTrue);
    expect(result.value, 'Ví 🐷');
  });

  test('rejects control characters and counts grapheme clusters', () {
    expect(
      validation.validateName('bad\nname').errors,
      contains(ValidationCode.invalidCharacter),
    );
    expect(
      validation.validateName('👨‍👩‍👧‍👦👨‍👩‍👧‍👦', maxLength: 1).errors,
      contains(ValidationCode.tooLong),
    );
  });

  test('normalizes currency syntax and duplicate keys', () {
    expect(validation.validateCurrencyCode(' usd ').value, 'USD');
    expect(
      validation.validateCurrencyCode('US1').errors,
      contains(ValidationCode.invalidFormat),
    );
    expect(ValidationService.duplicateKey('  CASH   Wallet '), 'cash wallet');
  });
}

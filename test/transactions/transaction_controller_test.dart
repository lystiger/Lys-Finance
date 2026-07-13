import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/identifiers/uuid_generator.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/providers/foundation_providers.dart';
import 'package:lys_finance/core/time/app_clock.dart';
import 'package:lys_finance/features/settings/domain/entities/category.dart';
import 'package:lys_finance/features/transactions/application/providers/transaction_providers.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction_draft.dart';

void main() {
  test(
    'Quick Add preserves its draft after failure and succeeds on retry',
    () async {
      final AppDatabase database = AppDatabase(
        executor: NativeDatabase.memory(),
      );
      await database.initialize();
      final DateTime now = DateTime.utc(2026, 7, 13, 12);
      final ProviderContainer container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          appClockProvider.overrideWithValue(FixedAppClock(now)),
          uuidGeneratorProvider.overrideWithValue(const _FixedUuid()),
        ],
      );
      addTearDown(() async {
        container.dispose();
        await database.close();
      });
      final QuickAddController controller = container.read(
        quickAddControllerProvider.notifier,
      );

      final AppResult<Transaction> invalid = await controller.submit();
      expect(invalid, isA<AppError<Transaction>>());
      expect(
        container.read(quickAddControllerProvider).failureCode,
        'invalid_amount',
      );

      controller.setAccount(
        '00000000-0000-4000-8000-000000000001',
        Currency.vnd,
        locale: 'en',
      );
      controller.setCategory(
        Category(
          id: '00000000-0000-4000-8000-000000000102',
          localizationKey: 'category.food',
          type: CategoryType.expense,
          incClass: IncClass.necessity,
          iconKey: 'food',
          colorToken: 'expense',
          sortOrder: 20,
          isSystem: true,
          createdAt: now,
          updatedAt: now,
          version: 1,
        ),
      );
      for (final String digit in '45000'.split('')) {
        controller.append(digit, Currency.vnd, locale: 'en');
      }
      controller.setNote('Lunch');
      final TransactionDraft beforeRetry = container.read(
        quickAddControllerProvider,
      );
      expect(beforeRetry.rawAmountText, '45000');
      expect(beforeRetry.note, 'Lunch');

      final AppResult<Transaction> saved = await controller.submit();
      expect(saved, isA<AppSuccess<Transaction>>());
      expect(
        container.read(quickAddControllerProvider).submission,
        SubmissionStatus.success,
      );
    },
  );

  test('changing type clears incompatible category and INC selections', () {
    final ProviderContainer container = ProviderContainer(
      overrides: [
        appClockProvider.overrideWithValue(
          FixedAppClock(DateTime.utc(2026, 7, 13)),
        ),
      ],
    );
    addTearDown(container.dispose);
    final QuickAddController controller = container.read(
      quickAddControllerProvider.notifier,
    );
    controller.setType(TransactionType.income);
    final TransactionDraft draft = container.read(quickAddControllerProvider);
    expect(draft.type, TransactionType.income);
    expect(draft.categoryId, isNull);
    expect(draft.incClass, isNull);
  });
}

final class _FixedUuid implements UuidGenerator {
  const _FixedUuid();

  @override
  String v4() => '30000000-0000-4000-8000-000000000001';
}

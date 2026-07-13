import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/errors/app_failure.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/features/settings/data/repositories/drift_account_repository.dart';
import 'package:lys_finance/features/settings/data/repositories/drift_settings_repository.dart';
import 'package:lys_finance/features/settings/domain/entities/account.dart';
import 'package:lys_finance/features/settings/domain/entities/app_settings.dart';

void main() {
  late AppDatabase database;
  late DriftAccountRepository accounts;

  setUp(() async {
    database = AppDatabase(executor: NativeDatabase.memory());
    await database.initialize();
    accounts = DriftAccountRepository(database);
  });
  tearDown(() => database.close());

  test(
    'account repository creates, streams, conflicts, and soft deletes',
    () async {
      final DateTime now = DateTime.utc(2026, 7, 13);
      final Account account = Account(
        id: 'test-account',
        name: 'Travel Cash',
        type: AccountType.cash,
        openingBalance: Money.zero(Currency.vnd),
        iconKey: 'wallet',
        colorToken: 'category1',
        sortOrder: 20,
        createdAt: now,
        updatedAt: now,
        version: 1,
      );
      expect(await accounts.create(account), isA<AppSuccess<Account>>());
      expect(await accounts.activeNameExists(' travel   CASH '), isTrue);
      expect(
        await accounts.update(account, expectedVersion: 99),
        isA<AppError<Account>>().having(
          (value) => value.error,
          'error',
          isA<VersionConflictFailure>(),
        ),
      );
      expect(
        await accounts.softDelete(
          account.id,
          expectedVersion: 1,
          deletedAt: now.add(const Duration(minutes: 1)),
        ),
        isA<AppSuccess<void>>(),
      );
      expect(await accounts.activeNameExists(account.name!), isFalse);
      expect(
        (await accounts.getById(account.id, includeDeleted: true)),
        isA<AppSuccess<Account>>(),
      );
    },
  );

  test(
    'settings repository updates with optimistic version protection',
    () async {
      final DriftSettingsRepository settings = DriftSettingsRepository(
        database,
      );
      final AppSettings current =
          (await settings.get() as AppSuccess<AppSettings>).value;
      final AppSettings changed = current.copyWith(
        baseCurrencyCode: 'USD',
        updatedAt: current.updatedAt.add(const Duration(seconds: 1)),
      );
      final AppResult<AppSettings> updated = await settings.update(
        changed,
        expectedVersion: 1,
      );
      expect(updated, isA<AppSuccess<AppSettings>>());
      expect(
        await settings.update(changed, expectedVersion: 1),
        isA<AppError<AppSettings>>(),
      );
    },
  );
}

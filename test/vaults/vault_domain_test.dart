import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault_transfer.dart';

void main() {
  final DateTime now = DateTime.utc(2026, 7, 13);
  final Money goal =
      Money.fromMinorUnits(minorUnits: 5000000, currency: Currency.vnd).fold(
        success: (value) => value,
        failure: (failure) => throw TestFailure(failure.code),
      );

  AppResult<Vault> create({
    String? name = 'Japan Fund',
    String? localizationKey,
    Money? goalAmount,
    int priority = 0,
    int sortOrder = 0,
    bool autoContributionEnabled = false,
    VaultAutoContributionKind? autoContributionKind,
    int? autoContributionValue,
  }) => Vault.create(
    id: '11111111-1111-4111-8111-111111111111',
    iconKey: 'flag',
    colorToken: 'primary',
    currency: Currency.vnd,
    withdrawalPolicy: VaultWithdrawalPolicy.soft,
    priority: priority,
    sortOrder: sortOrder,
    name: name,
    localizationKey: localizationKey,
    goalAmount: goalAmount,
    autoContributionEnabled: autoContributionEnabled,
    autoContributionKind: autoContributionKind,
    autoContributionValue: autoContributionValue,
    createdAt: now,
    updatedAt: now,
    version: 1,
  );

  group('Vault.create', () {
    test('creates a valid vault with only a name and no goal', () {
      final Vault vault = (create() as AppSuccess<Vault>).value;
      expect(vault.name, 'Japan Fund');
      expect(vault.goalAmount, isNull);
      expect(vault.isArchived, isFalse);
    });

    test('requires exactly one of name or localizationKey', () {
      expect(create(name: null), isA<AppError<Vault>>());
      expect(
        create(name: 'Both', localizationKey: 'vault.emergencyFund'),
        isA<AppError<Vault>>(),
      );
      expect(
        create(name: null, localizationKey: 'vault.emergencyFund'),
        isA<AppSuccess<Vault>>(),
      );
    });

    test('rejects a non-positive goal amount', () {
      expect(
        create(goalAmount: Money.zero(Currency.vnd)),
        isA<AppError<Vault>>(),
      );
    });

    test('rejects a goal amount in a different currency', () {
      final Money usdGoal = Money.fromMinorUnits(
        minorUnits: 1000,
        currency: Currency.usd,
      ).fold(success: (value) => value, failure: (failure) => throw failure);
      expect(create(goalAmount: usdGoal), isA<AppError<Vault>>());
      expect(create(goalAmount: goal), isA<AppSuccess<Vault>>());
    });

    test('rejects negative priority or sort order', () {
      expect(create(priority: -1), isA<AppError<Vault>>());
      expect(create(sortOrder: -1), isA<AppError<Vault>>());
    });

    test(
      'auto-contribution kind and value must both be present or both absent',
      () {
        expect(create(autoContributionEnabled: true), isA<AppError<Vault>>());
        expect(
          create(
            autoContributionEnabled: true,
            autoContributionKind: VaultAutoContributionKind.fixed,
          ),
          isA<AppError<Vault>>(),
        );
        expect(
          create(
            autoContributionEnabled: true,
            autoContributionKind: VaultAutoContributionKind.fixed,
            autoContributionValue: 100000,
          ),
          isA<AppSuccess<Vault>>(),
        );
        expect(
          create(
            autoContributionEnabled: false,
            autoContributionKind: VaultAutoContributionKind.fixed,
            autoContributionValue: 100000,
          ),
          isA<AppError<Vault>>(),
        );
      },
    );
  });

  group('VaultTransfer.create', () {
    final Money amount = Money.fromMinorUnits(
      minorUnits: 200000,
      currency: Currency.vnd,
    ).fold(success: (value) => value, failure: (failure) => throw failure);

    test('creates a valid transfer between two different vaults', () {
      final AppResult<VaultTransfer> result = VaultTransfer.create(
        id: '22222222-2222-4222-8222-222222222222',
        sourceVaultId: 'vault-a',
        destinationVaultId: 'vault-b',
        amount: amount,
        occurredAt: now,
        createdAt: now,
      );
      expect(result, isA<AppSuccess<VaultTransfer>>());
    });

    test('rejects a transfer to the same vault', () {
      final AppResult<VaultTransfer> result = VaultTransfer.create(
        id: '22222222-2222-4222-8222-222222222222',
        sourceVaultId: 'vault-a',
        destinationVaultId: 'vault-a',
        amount: amount,
        occurredAt: now,
        createdAt: now,
      );
      expect(result, isA<AppError<VaultTransfer>>());
    });

    test('rejects a non-positive amount', () {
      final AppResult<VaultTransfer> result = VaultTransfer.create(
        id: '22222222-2222-4222-8222-222222222222',
        sourceVaultId: 'vault-a',
        destinationVaultId: 'vault-b',
        amount: Money.zero(Currency.vnd),
        occurredAt: now,
        createdAt: now,
      );
      expect(result, isA<AppError<VaultTransfer>>());
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/features/vaults/application/services/projection_service.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault_goal_snapshot.dart';

void main() {
  const ProjectionService projection = ProjectionService();
  final DateTime now = DateTime.utc(2026, 7, 13);

  Money vnd(int minorUnits) => Money.fromMinorUnits(
    minorUnits: minorUnits,
    currency: Currency.vnd,
  ).fold(success: (value) => value, failure: (failure) => throw failure);

  Vault vault({Money? goalAmount, DateTime? targetDate, DateTime? createdAt}) =>
      (Vault.create(
                id: '11111111-1111-4111-8111-111111111111',
                name: 'Test Vault',
                iconKey: 'flag',
                colorToken: 'primary',
                currency: Currency.vnd,
                withdrawalPolicy: VaultWithdrawalPolicy.soft,
                priority: 0,
                sortOrder: 0,
                goalAmount: goalAmount,
                targetDate: targetDate,
                createdAt: createdAt ?? now.subtract(const Duration(days: 60)),
                updatedAt: now,
                version: 1,
              )
              as AppSuccess<Vault>)
          .value;

  test('windowDaysFor caps at 90 days and floors at 0', () {
    expect(
      projection.windowDaysFor(
        vaultCreatedAt: now.subtract(const Duration(days: 10)),
        now: now,
      ),
      10,
    );
    expect(
      projection.windowDaysFor(
        vaultCreatedAt: now.subtract(const Duration(days: 400)),
        now: now,
      ),
      90,
    );
    expect(projection.windowDaysFor(vaultCreatedAt: now, now: now), 0);
  });

  test('an open-ended vault (no goal) has no remaining amount or ETA', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(),
      currentBalance: vnd(1000000),
      now: now,
      netActivityInWindow: vnd(500000),
      windowDays: 30,
    );
    expect(snapshot.remainingAmount, isNull);
    expect(snapshot.completionRatio, isNull);
    expect(snapshot.estimatedCompletion, isNull);
    expect(snapshot.health, GoalHealth.noTarget);
  });

  test('a vault younger than 7 days has no pace data', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(goalAmount: vnd(5000000)),
      currentBalance: vnd(1000000),
      now: now,
      netActivityInWindow: vnd(500000),
      windowDays: 3,
    );
    expect(snapshot.monthlyAverageContribution, isNull);
    expect(snapshot.estimatedCompletion, isNull);
    expect(snapshot.health, GoalHealth.noData);
  });

  test('zero net activity in the window has no pace data', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(goalAmount: vnd(5000000)),
      currentBalance: vnd(1000000),
      now: now,
      netActivityInWindow: vnd(0),
      windowDays: 30,
    );
    expect(snapshot.monthlyAverageContribution, isNull);
    expect(snapshot.health, GoalHealth.noData);
  });

  test('completed vault reports completed regardless of pace', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(goalAmount: vnd(1000000)),
      currentBalance: vnd(1200000),
      now: now,
      netActivityInWindow: vnd(0),
      windowDays: 30,
    );
    expect(snapshot.health, GoalHealth.completed);
    expect(snapshot.remainingAmount, vnd(0));
    expect(snapshot.completionRatio, closeTo(1.2, 0.001));
  });

  test('positive pace with no deadline is on track', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(goalAmount: vnd(5000000)),
      currentBalance: vnd(1000000),
      now: now,
      netActivityInWindow: vnd(1000000),
      windowDays: 30,
    );
    expect(snapshot.monthlyAverageContribution, isNotNull);
    expect(snapshot.estimatedCompletion, isNotNull);
    expect(snapshot.health, GoalHealth.onTrack);
  });

  test('positive pace but ETA after the deadline is behind', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(
        goalAmount: vnd(50000000),
        targetDate: now.add(const Duration(days: 30)),
      ),
      currentBalance: vnd(1000000),
      now: now,
      netActivityInWindow: vnd(500000),
      windowDays: 30,
    );
    expect(snapshot.health, GoalHealth.behind);
  });

  test('positive pace with ETA before the deadline is on track', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(
        goalAmount: vnd(2000000),
        targetDate: now.add(const Duration(days: 365)),
      ),
      currentBalance: vnd(1000000),
      now: now,
      netActivityInWindow: vnd(1000000),
      windowDays: 30,
    );
    expect(snapshot.health, GoalHealth.onTrack);
  });

  test('negative pace near an imminent deadline is at risk', () {
    final VaultGoalSnapshot snapshot = projection.compute(
      vault: vault(
        goalAmount: vnd(5000000),
        targetDate: now.add(const Duration(days: 10)),
      ),
      currentBalance: vnd(1000000),
      now: now,
      netActivityInWindow: vnd(-200000),
      windowDays: 30,
    );
    expect(snapshot.monthlyAverageContribution!.minorUnits, lessThan(0));
    expect(snapshot.estimatedCompletion, isNull);
    expect(snapshot.health, GoalHealth.atRisk);
  });

  test(
    'negative pace with a distant or absent deadline is behind, not at risk',
    () {
      final VaultGoalSnapshot snapshot = projection.compute(
        vault: vault(goalAmount: vnd(5000000)),
        currentBalance: vnd(1000000),
        now: now,
        netActivityInWindow: vnd(-200000),
        windowDays: 30,
      );
      expect(snapshot.health, GoalHealth.behind);
    },
  );
}

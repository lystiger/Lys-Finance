import '../../../../core/money/money.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_goal_snapshot.dart';

/// Pure goal-tracking math. No persistence, no side effects — every input is
/// supplied by the caller (GoalService), so this is fully unit-testable
/// without a database.
final class ProjectionService {
  const ProjectionService();

  static const int _minWindowDaysForData = 7;
  static const int _maxWindowDays = 90;
  static const int _atRiskDeadlineWindowDays = 30;

  int windowDaysFor({required DateTime vaultCreatedAt, required DateTime now}) {
    final int daysSinceCreation = now.difference(vaultCreatedAt).inDays;
    if (daysSinceCreation <= 0) return 0;
    return daysSinceCreation < _maxWindowDays
        ? daysSinceCreation
        : _maxWindowDays;
  }

  VaultGoalSnapshot compute({
    required Vault vault,
    required Money currentBalance,
    required DateTime now,
    required Money netActivityInWindow,
    required int windowDays,
  }) {
    final Money? goalAmount = vault.goalAmount;
    final Money? remainingAmount = goalAmount == null
        ? null
        : (currentBalance.minorUnits >= goalAmount.minorUnits
              ? Money.zero(goalAmount.currency)
              : Money.fromMinorUnits(
                  minorUnits: goalAmount.minorUnits - currentBalance.minorUnits,
                  currency: goalAmount.currency,
                ).fold(success: (value) => value, failure: (_) => null));
    final double? completionRatio =
        goalAmount == null || goalAmount.minorUnits == 0
        ? null
        : currentBalance.minorUnits / goalAmount.minorUnits;

    final bool hasEnoughDataForPace =
        windowDays >= _minWindowDaysForData &&
        netActivityInWindow.minorUnits != 0;
    final double? monthlyAverageValue = hasEnoughDataForPace
        ? netActivityInWindow.minorUnits / (windowDays / 30.0)
        : null;
    final Money? monthlyAverageContribution = monthlyAverageValue == null
        ? null
        : Money.fromMinorUnits(
            minorUnits: monthlyAverageValue.round(),
            currency: currentBalance.currency,
          ).fold(success: (value) => value, failure: (_) => null);

    final bool completed =
        goalAmount != null &&
        currentBalance.minorUnits >= goalAmount.minorUnits;

    DateTime? estimatedCompletion;
    if (!completed &&
        goalAmount != null &&
        monthlyAverageValue != null &&
        monthlyAverageValue > 0 &&
        remainingAmount != null) {
      final double monthsRemaining =
          remainingAmount.minorUnits / monthlyAverageValue;
      final int monthsToAdd = monthsRemaining.ceil().clamp(0, 1200);
      final int targetMonthIndex = now.month + monthsToAdd;
      final int targetYear = now.year + (targetMonthIndex - 1) ~/ 12;
      final int normalizedMonth = ((targetMonthIndex - 1) % 12) + 1;
      // Day 0 of the month after the target month is the last day of the
      // target month — an intentionally month-granular ("sometime in
      // March"), slightly conservative estimate rather than a false-precise
      // day count.
      estimatedCompletion = DateTime.utc(targetYear, normalizedMonth + 1, 0);
    }

    final GoalHealth health = _health(
      completed: completed,
      goalAmount: goalAmount,
      monthlyAverageValue: monthlyAverageValue,
      estimatedCompletion: estimatedCompletion,
      targetDate: vault.targetDate,
      now: now,
    );

    return VaultGoalSnapshot(
      vault: vault,
      currentBalance: currentBalance,
      remainingAmount: remainingAmount,
      completionRatio: completionRatio,
      monthlyAverageContribution: monthlyAverageContribution,
      estimatedCompletion: estimatedCompletion,
      health: health,
    );
  }

  GoalHealth _health({
    required bool completed,
    required Money? goalAmount,
    required double? monthlyAverageValue,
    required DateTime? estimatedCompletion,
    required DateTime? targetDate,
    required DateTime now,
  }) {
    if (completed) return GoalHealth.completed;
    if (goalAmount == null) return GoalHealth.noTarget;
    if (monthlyAverageValue == null) return GoalHealth.noData;
    if (monthlyAverageValue <= 0) {
      final bool deadlineImminent =
          targetDate != null &&
          targetDate.difference(now).inDays <= _atRiskDeadlineWindowDays;
      return deadlineImminent ? GoalHealth.atRisk : GoalHealth.behind;
    }
    if (targetDate == null) return GoalHealth.onTrack;
    if (estimatedCompletion == null) return GoalHealth.noData;
    return estimatedCompletion.isAfter(targetDate)
        ? GoalHealth.behind
        : GoalHealth.onTrack;
  }
}

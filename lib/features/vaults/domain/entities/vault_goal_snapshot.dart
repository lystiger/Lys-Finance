import '../../../../core/money/money.dart';
import 'vault.dart';

enum GoalHealth { completed, noTarget, noData, onTrack, behind, atRisk }

final class VaultGoalSnapshot {
  const VaultGoalSnapshot({
    required this.vault,
    required this.currentBalance,
    required this.health,
    this.remainingAmount,
    this.completionRatio,
    this.monthlyAverageContribution,
    this.estimatedCompletion,
  });

  final Vault vault;
  final Money currentBalance;
  final Money? remainingAmount;
  final double? completionRatio;
  final Money? monthlyAverageContribution;
  final DateTime? estimatedCompletion;
  final GoalHealth health;
}

import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../domain/entities/vault_goal_snapshot.dart';
import '../vault_l10n.dart';

class GoalBadge extends StatelessWidget {
  const GoalBadge({required this.health, super.key});
  final GoalHealth health;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final (IconData icon, Color? color) = switch (health) {
      GoalHealth.completed => (Icons.check_circle, Colors.green),
      GoalHealth.onTrack => (Icons.trending_up, Colors.green),
      GoalHealth.behind => (Icons.schedule, Colors.amber.shade800),
      GoalHealth.atRisk => (Icons.warning_amber, Colors.amber.shade800),
      GoalHealth.noTarget => (Icons.flag_outlined, null),
      GoalHealth.noData => (Icons.hourglass_empty, null),
    };
    return Semantics(
      label: goalHealthLabel(l10n, health),
      child: Chip(
        avatar: Icon(icon, size: 16, color: color),
        label: Text(goalHealthLabel(l10n, health)),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

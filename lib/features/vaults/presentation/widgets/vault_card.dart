import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../settings/application/providers/settings_providers.dart';
import '../../application/providers/vault_providers.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_goal_snapshot.dart';
import '../vault_icons.dart';
import '../vault_l10n.dart';
import 'goal_badge.dart';

class VaultCard extends ConsumerWidget {
  const VaultCard({required this.vault, super.key});
  final Vault vault;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<VaultGoalSnapshot> snapshot = ref.watch(
      vaultGoalSnapshotProvider(vault.id),
    );
    final Color accent = vaultColorFor(vault.colorToken);
    return Card(
      child: InkWell(
        onTap: () => context.push(AppRoutes.vault(vault.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: accent.withValues(alpha: 0.15),
                    child: Icon(vaultIconFor(vault.iconKey), color: accent),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      vaultLabel(l10n, vault),
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  snapshot.maybeWhen(
                    data: (value) => GoalBadge(health: value.health),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              snapshot.when(
                data: (value) => _VaultCardProgress(snapshot: value),
                loading: () => const LinearProgressIndicator(),
                error: (error, stackTrace) => Text(l10n.databaseReadError),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VaultCardProgress extends ConsumerWidget {
  const _VaultCardProgress({required this.snapshot});
  final VaultGoalSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    final String balance = ref
        .read(formattingServiceProvider)
        .money(snapshot.currentBalance, locale: locale);
    final double? ratio = snapshot.completionRatio;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (ratio != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: ratio.clamp(0, 1)),
          ),
        const SizedBox(height: 8),
        Text(balance, style: Theme.of(context).textTheme.titleSmall),
        if (snapshot.remainingAmount != null)
          Text(
            '${l10n.remainingAmount}: ${ref.read(formattingServiceProvider).money(snapshot.remainingAmount!, locale: locale)}',
            style: Theme.of(context).textTheme.bodySmall,
          )
        else if (snapshot.vault.goalAmount == null)
          Text(l10n.noGoalSet, style: Theme.of(context).textTheme.bodySmall),
        if (snapshot.estimatedCompletion != null)
          Text(
            '${l10n.estimatedCompletion}: ${MaterialLocalizations.of(context).formatShortDate(snapshot.estimatedCompletion!.toLocal())}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

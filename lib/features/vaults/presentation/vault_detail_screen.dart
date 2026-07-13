import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_states.dart';
import '../../../shared/widgets/app_surfaces.dart';
import '../../settings/application/providers/settings_providers.dart';
import '../../transactions/domain/entities/transaction.dart';
import '../application/providers/vault_providers.dart';
import '../domain/entities/vault.dart';
import '../domain/entities/vault_goal_snapshot.dart';
import '../domain/entities/vault_history_entry.dart';
import 'vault_form_sheet.dart';
import 'vault_icons.dart';
import 'vault_l10n.dart';
import 'widgets/contribution_dialog.dart';
import 'widgets/goal_badge.dart';
import 'widgets/transfer_dialog.dart';
import 'widgets/withdrawal_dialog.dart';

class VaultDetailScreen extends ConsumerWidget {
  const VaultDetailScreen({required this.vaultId, super.key});
  final String vaultId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<Vault?> detail = ref.watch(vaultDetailProvider(vaultId));
    return Scaffold(
      appBar: AppBar(
        title: detail.value == null
            ? Text(l10n.vaults)
            : Text(vaultLabel(l10n, detail.value!)),
        actions: <Widget>[
          if (detail.value != null && !detail.value!.isArchived)
            IconButton(
              tooltip: l10n.edit,
              icon: const Icon(Icons.edit_outlined),
              onPressed: () =>
                  showVaultFormSheet(context, existing: detail.value),
            ),
        ],
      ),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: l10n.unableToLoad,
          message: l10n.databaseReadError,
        ),
        data: (vault) {
          if (vault == null) {
            return EmptyState(
              icon: Icons.savings_outlined,
              title: l10n.emptyVaultsTitle,
              message: l10n.emptyVaultsMessage,
            );
          }
          return _VaultDetailBody(vault: vault);
        },
      ),
    );
  }
}

class _VaultDetailBody extends ConsumerWidget {
  const _VaultDetailBody({required this.vault});
  final Vault vault;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    final AsyncValue<VaultGoalSnapshot> snapshot = ref.watch(
      vaultGoalSnapshotProvider(vault.id),
    );
    final AsyncValue<List<VaultHistoryEntry>> timeline = ref.watch(
      vaultHistoryTimelineProvider(vault.id),
    );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 28,
              backgroundColor: vaultColorFor(
                vault.colorToken,
              ).withValues(alpha: 0.15),
              child: Icon(
                vaultIconFor(vault.iconKey),
                color: vaultColorFor(vault.colorToken),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: snapshot.maybeWhen(
                data: (value) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ref
                          .read(formattingServiceProvider)
                          .money(value.currentBalance, locale: locale),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    GoalBadge(health: value.health),
                  ],
                ),
                orElse: () => const LinearProgressIndicator(),
              ),
            ),
          ],
        ),
        if (vault.isArchived)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Chip(label: Text(l10n.archiveVault)),
          ),
        const SizedBox(height: 24),
        snapshot.maybeWhen(
          data: (value) => _GoalSummary(snapshot: value),
          orElse: () => const SizedBox.shrink(),
        ),
        const SizedBox(height: 24),
        if (!vault.isArchived)
          Row(
            children: <Widget>[
              Expanded(
                child: SecondaryButton(
                  label: l10n.contribute,
                  onPressed: () => showContributionDialog(context, vault),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SecondaryButton(
                  label: l10n.withdraw,
                  onPressed: () => showWithdrawalDialog(context, vault),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SecondaryButton(
                  label: l10n.transfer,
                  onPressed: () => showTransferDialog(context, vault),
                ),
              ),
            ],
          ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () async {
            final bool? confirmed = vault.isArchived
                ? true
                : await showConfirmationDialog(
                    context,
                    title: l10n.archiveVaultTitle,
                    body: l10n.archiveVaultMessage,
                    cancelLabel: l10n.cancel,
                    confirmLabel: l10n.archiveVault,
                    destructive: true,
                  );
            if (confirmed != true) return;
            if (vault.isArchived) {
              await ref.read(vaultServiceProvider).restore(vault);
            } else {
              await ref.read(vaultServiceProvider).archive(vault);
            }
          },
          child: Text(vault.isArchived ? l10n.restoreVault : l10n.archiveVault),
        ),
        const SizedBox(height: 16),
        SectionHeader(title: l10n.vaultHistory),
        const SizedBox(height: 8),
        timeline.when(
          data: (entries) => entries.isEmpty
              ? EmptyState(
                  icon: Icons.history,
                  title: l10n.emptyVaultHistoryTitle,
                  message: l10n.emptyVaultHistoryMessage,
                )
              : Column(
                  children: entries
                      .map(
                        (entry) =>
                            _HistoryTile(entry: entry, vaultId: vault.id),
                      )
                      .toList(growable: false),
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(l10n.databaseReadError),
        ),
      ],
    );
  }
}

class _GoalSummary extends ConsumerWidget {
  const _GoalSummary({required this.snapshot});
  final VaultGoalSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    final double? ratio = snapshot.completionRatio;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (ratio != null) ...<Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio.clamp(0, 1),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (snapshot.vault.goalAmount != null)
            _row(
              context,
              l10n.goalAmount,
              ref
                  .read(formattingServiceProvider)
                  .money(snapshot.vault.goalAmount!, locale: locale),
            )
          else
            _row(context, l10n.goalAmount, l10n.noGoalSet),
          if (snapshot.remainingAmount != null)
            _row(
              context,
              l10n.remainingAmount,
              ref
                  .read(formattingServiceProvider)
                  .money(snapshot.remainingAmount!, locale: locale),
            ),
          _row(
            context,
            l10n.monthlyAverage,
            snapshot.monthlyAverageContribution == null
                ? l10n.notEnoughData
                : ref
                      .read(formattingServiceProvider)
                      .money(
                        snapshot.monthlyAverageContribution!,
                        locale: locale,
                      ),
          ),
          _row(
            context,
            l10n.estimatedCompletion,
            snapshot.estimatedCompletion == null
                ? l10n.notEnoughData
                : MaterialLocalizations.of(
                    context,
                  ).formatShortDate(snapshot.estimatedCompletion!.toLocal()),
          ),
          if (snapshot.vault.targetDate != null)
            _row(
              context,
              l10n.targetDate,
              MaterialLocalizations.of(
                context,
              ).formatShortDate(snapshot.vault.targetDate!.toLocal()),
            ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}

class _HistoryTile extends ConsumerWidget {
  const _HistoryTile({required this.entry, required this.vaultId});
  final VaultHistoryEntry entry;
  final String vaultId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    return switch (entry) {
      VaultActivityEntry(:final transaction) => ListTile(
        leading: Icon(
          transaction.type == TransactionType.contribution
              ? Icons.add_circle_outline
              : Icons.remove_circle_outline,
        ),
        title: Text(
          transaction.type == TransactionType.contribution
              ? l10n.historyContribution
              : l10n.historyWithdrawal,
        ),
        subtitle: transaction.note == null ? null : Text(transaction.note!),
        trailing: Text(
          ref
              .read(formattingServiceProvider)
              .money(transaction.amount, locale: locale),
        ),
      ),
      VaultTransferEntry(:final transfer, :final direction) => ListTile(
        leading: Icon(
          direction == VaultTransferDirection.incoming
              ? Icons.call_received
              : Icons.call_made,
        ),
        title: Text(vaultTransferDirectionLabel(l10n, direction)),
        subtitle: transfer.note == null ? null : Text(transfer.note!),
        trailing: Text(
          ref
              .read(formattingServiceProvider)
              .money(transfer.amount, locale: locale),
        ),
      ),
      VaultLifecycleEntry(:final event) => ListTile(
        leading: const Icon(Icons.flag_outlined),
        title: Text(
          vaultHistoryEventLabel(l10n, event.eventType, payload: event.payload),
        ),
      ),
    };
  }
}

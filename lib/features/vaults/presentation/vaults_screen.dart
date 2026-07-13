import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../shared/widgets/app_states.dart';
import '../application/providers/vault_providers.dart';
import '../domain/entities/vault.dart';
import 'vault_form_sheet.dart';
import 'widgets/vault_card.dart';

class VaultsScreen extends ConsumerWidget {
  const VaultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Vault>> vaults = ref.watch(activeVaultsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.vaults),
        actions: <Widget>[
          IconButton(
            key: const Key('new-vault-action'),
            tooltip: l10n.newVault,
            onPressed: () => showVaultFormSheet(
              context,
              nextSortOrder: vaults.value?.length ?? 0,
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: vaults.when(
        data: (items) => items.isEmpty
            ? EmptyState(
                icon: Icons.savings_outlined,
                title: l10n.emptyVaultsTitle,
                message: l10n.emptyVaultsMessage,
                actionLabel: l10n.createVault,
                onAction: () => showVaultFormSheet(context, nextSortOrder: 0),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: VaultCard(vault: items[index]),
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ErrorState(
          title: l10n.unableToLoad,
          message: l10n.databaseReadError,
        ),
      ),
    );
  }
}

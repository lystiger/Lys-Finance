import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/money/money.dart';
import '../../settings/application/providers/settings_providers.dart';
import '../../settings/domain/entities/account.dart';
import '../../transactions/application/providers/transaction_providers.dart';
import '../../transactions/presentation/transaction_l10n.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Account>> accounts = ref.watch(
      activeAccountsProvider,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
        actions: <Widget>[
          IconButton(
            key: const Key('settings-action'),
            tooltip: l10n.settings,
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: Text(l10n.transactions),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.ledger),
          ),
          const Divider(),
          Text(l10n.accounts, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...accounts.when(
            data: (items) =>
                items.map((account) => _AccountBalanceTile(account: account)),
            loading: () => <Widget>[const LinearProgressIndicator()],
            error: (error, stackTrace) => <Widget>[
              Text(l10n.databaseReadError),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccountBalanceTile extends ConsumerWidget {
  const _AccountBalanceTile({required this.account});
  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<Money> balance = ref.watch(
      accountBalanceProvider(account.id),
    );
    return Card(
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet_outlined),
        title: Text(accountLabel(l10n, account)),
        trailing: balance.when(
          data: (money) => Text(
            ref
                .read(formattingServiceProvider)
                .money(
                  money,
                  locale: Localizations.localeOf(context).languageCode,
                ),
          ),
          loading: () => const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (error, stackTrace) => const Icon(Icons.error_outline),
        ),
      ),
    );
  }
}

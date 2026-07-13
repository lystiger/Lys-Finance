import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/localization/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: <Widget>[
          _entry(
            context,
            Icons.account_balance_wallet_outlined,
            l10n.accounts,
            AppRoutes.settingsAccounts,
          ),
          _entry(
            context,
            Icons.category_outlined,
            l10n.categories,
            AppRoutes.settingsCategories,
          ),
          _entry(
            context,
            Icons.currency_exchange,
            l10n.currencies,
            AppRoutes.settingsCurrencies,
          ),
          _entry(
            context,
            Icons.palette_outlined,
            l10n.appearance,
            AppRoutes.settingsAppearance,
          ),
          _entry(
            context,
            Icons.notifications_outlined,
            l10n.notifications,
            AppRoutes.settingsNotifications,
          ),
          _entry(
            context,
            Icons.ios_share_outlined,
            l10n.backupExport,
            AppRoutes.settingsBackup,
          ),
        ],
      ),
    );
  }

  Widget _entry(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(l10n.foundationEntryDescription),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(route),
    );
  }
}

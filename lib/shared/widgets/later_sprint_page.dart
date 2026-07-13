import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router/app_routes.dart';
import '../../core/localization/l10n/app_localizations.dart';
import '../../core/theme/app_tokens.dart';

class LaterSprintPage extends StatelessWidget {
  const LaterSprintPage({
    required this.title,
    required this.icon,
    this.showSettings = false,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool showSettings;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          if (showSettings)
            IconButton(
              key: const Key('settings-action'),
              tooltip: l10n.settings,
              onPressed: () => context.push(AppRoutes.settings),
              icon: const Icon(Icons.settings_outlined),
            ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 48),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.foundationReady,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.comingLater, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

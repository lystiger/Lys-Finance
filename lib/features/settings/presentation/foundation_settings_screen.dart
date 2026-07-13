import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../shared/widgets/app_states.dart';

class FoundationSettingsScreen extends StatelessWidget {
  const FoundationSettingsScreen({
    required this.title,
    required this.icon,
    super.key,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: EmptyState(
        icon: icon,
        title: l10n.foundationRouteTitle,
        message: l10n.foundationRouteMessage,
      ),
    );
  }
}

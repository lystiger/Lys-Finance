import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../shared/widgets/later_sprint_page.dart';

class VaultsScreen extends StatelessWidget {
  const VaultsScreen({super.key});

  @override
  Widget build(BuildContext context) => LaterSprintPage(
    title: AppLocalizations.of(context).vaults,
    icon: Icons.savings_outlined,
  );
}

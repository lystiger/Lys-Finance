import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../shared/widgets/later_sprint_page.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) => LaterSprintPage(
    title: AppLocalizations.of(context).insights,
    icon: Icons.insights_outlined,
  );
}

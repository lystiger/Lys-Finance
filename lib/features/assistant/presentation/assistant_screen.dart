import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../shared/widgets/later_sprint_page.dart';

class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});

  @override
  Widget build(BuildContext context) => LaterSprintPage(
    title: AppLocalizations.of(context).assistant,
    icon: Icons.auto_awesome_outlined,
  );
}

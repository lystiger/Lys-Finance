import 'package:flutter/material.dart';

import '../../../core/localization/l10n/app_localizations.dart';
import '../../../shared/widgets/later_sprint_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => LaterSprintPage(
    title: AppLocalizations.of(context).home,
    icon: Icons.home_outlined,
    showSettings: true,
  );
}

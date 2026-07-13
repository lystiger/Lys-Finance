// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Lys Finance';

  @override
  String get home => 'Home';

  @override
  String get vaults => 'Vaults';

  @override
  String get insights => 'Insights';

  @override
  String get assistant => 'Assistant';

  @override
  String get settings => 'Settings';

  @override
  String get quickAdd => 'Quick Add';

  @override
  String get comingLater => 'This feature belongs to a later sprint.';

  @override
  String get foundationReady => 'The foundation is ready.';

  @override
  String get close => 'Close';
}

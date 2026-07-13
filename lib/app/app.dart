import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class LysFinanceApp extends StatelessWidget {
  const LysFinanceApp({this.router, super.key});

  final GoRouter? router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router ?? appRouter,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: _resolveLocale,
    );
  }

  Locale _resolveLocale(Locale? deviceLocale, Iterable<Locale> supported) {
    if (deviceLocale == null) {
      return const Locale('en');
    }
    return supported.firstWhere(
      (Locale locale) => locale.languageCode == deviceLocale.languageCode,
      orElse: () => const Locale('en'),
    );
  }
}

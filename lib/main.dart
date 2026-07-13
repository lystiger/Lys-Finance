import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/logging/app_logger.dart';

Future<void> main() async {
  final logger = LoggerAppLogger();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      configureGlobalErrorHandling(logger);
      runApp(
        ProviderScope(
          observers: <ProviderObserver>[AppProviderObserver(logger)],
          child: const LysFinanceApp(),
        ),
      );
    },
    (Object error, StackTrace stackTrace) {
      logger.error(
        'uncaught_async_error',
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}

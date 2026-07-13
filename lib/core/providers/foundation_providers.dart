import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../database/app_database.dart';
import '../identifiers/uuid_generator.dart';
import '../logging/app_logger.dart';
import '../notifications/app_notifications.dart';
import '../storage/secure_storage.dart';
import '../time/app_clock.dart';

part 'foundation_providers.g.dart';

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => const AppConfig();

@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) => LoggerAppLogger();

@Riverpod(keepAlive: true)
AppClock appClock(Ref ref) => const SystemAppClock();

@Riverpod(keepAlive: true)
UuidGenerator uuidGenerator(Ref ref) => RandomUuidGenerator();

@Riverpod(keepAlive: true)
SecureStorage secureStorage(Ref ref) => PlatformSecureStorage();

@Riverpod(keepAlive: true)
AppNotifications appNotifications(Ref ref) => LocalAppNotifications();

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final AppDatabase database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}

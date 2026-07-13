import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract interface class AppNotifications {
  Future<void> initialize();
}

final class LocalAppNotifications implements AppNotifications {
  LocalAppNotifications({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<void> initialize() async {
    const InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(settings: settings);
  }
}

final class NoopAppNotifications implements AppNotifications {
  const NoopAppNotifications();

  @override
  Future<void> initialize() async {}
}

import 'package:logger/logger.dart';

abstract interface class AppLogger {
  void debug(String event);
  void info(String event);
  void warning(String event);
  void error(String event, {Object? error, StackTrace? stackTrace});
}

final class LoggerAppLogger implements AppLogger {
  LoggerAppLogger({Logger? logger})
    : _logger =
          logger ??
          Logger(printer: SimplePrinter(colors: false, printTime: true));

  final Logger _logger;

  @override
  void debug(String event) => _logger.d(_sanitize(event));

  @override
  void info(String event) => _logger.i(_sanitize(event));

  @override
  void warning(String event) => _logger.w(_sanitize(event));

  @override
  void error(String event, {Object? error, StackTrace? stackTrace}) {
    _logger.e(
      _sanitize(event),
      error: error?.runtimeType.toString(),
      stackTrace: stackTrace,
    );
  }

  String _sanitize(String event) {
    return event
        .replaceAll(
          RegExp(
            r'(token|secret|password|amount)=[^\s]+',
            caseSensitive: false,
          ),
          r'$1=[redacted]',
        )
        .replaceAll(RegExp(r'\b\d{4,}\b'), '[number]');
  }
}

final class NoopAppLogger implements AppLogger {
  const NoopAppLogger();

  @override
  void debug(String event) {}

  @override
  void error(String event, {Object? error, StackTrace? stackTrace}) {}

  @override
  void info(String event) {}

  @override
  void warning(String event) {}
}

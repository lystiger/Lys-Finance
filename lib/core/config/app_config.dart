import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

enum AppEnvironment { development, production }

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default(AppEnvironment.development) AppEnvironment environment,
    @Default('VND') String defaultCurrency,
    @Default(false) bool enableDiagnostics,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, Object?> json) =>
      _$AppConfigFromJson(json);
}

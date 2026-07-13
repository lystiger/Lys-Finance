// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  environment:
      $enumDecodeNullable(_$AppEnvironmentEnumMap, json['environment']) ??
      AppEnvironment.development,
  defaultCurrency: json['defaultCurrency'] as String? ?? 'VND',
  enableDiagnostics: json['enableDiagnostics'] as bool? ?? false,
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'environment': _$AppEnvironmentEnumMap[instance.environment]!,
      'defaultCurrency': instance.defaultCurrency,
      'enableDiagnostics': instance.enableDiagnostics,
    };

const _$AppEnvironmentEnumMap = {
  AppEnvironment.development: 'development',
  AppEnvironment.production: 'production',
};

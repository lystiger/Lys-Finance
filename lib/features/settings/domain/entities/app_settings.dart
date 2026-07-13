enum AppThemeMode { system, light, dark }

final class AppSettings {
  const AppSettings({
    required this.baseCurrencyCode,
    required this.themeMode,
    required this.reducedMotion,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.locale,
  });

  static const String singletonId = 'app';

  final String baseCurrencyCode;
  final String? locale;
  final AppThemeMode themeMode;
  final bool reducedMotion;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  AppSettings copyWith({
    String? baseCurrencyCode,
    String? locale,
    bool clearLocale = false,
    AppThemeMode? themeMode,
    bool? reducedMotion,
    DateTime? updatedAt,
    int? version,
  }) {
    return AppSettings(
      baseCurrencyCode: baseCurrencyCode ?? this.baseCurrencyCode,
      locale: clearLocale ? null : locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      baseCurrencyCode == other.baseCurrencyCode &&
      locale == other.locale &&
      themeMode == other.themeMode &&
      reducedMotion == other.reducedMotion &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt &&
      version == other.version;

  @override
  int get hashCode => Object.hash(
    baseCurrencyCode,
    locale,
    themeMode,
    reducedMotion,
    createdAt,
    updatedAt,
    version,
  );
}

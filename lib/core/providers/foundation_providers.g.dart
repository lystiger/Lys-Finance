// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foundation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appConfig)
final appConfigProvider = AppConfigProvider._();

final class AppConfigProvider
    extends $FunctionalProvider<AppConfig, AppConfig, AppConfig>
    with $Provider<AppConfig> {
  AppConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigHash();

  @$internal
  @override
  $ProviderElement<AppConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppConfig create(Ref ref) {
    return appConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfig>(value),
    );
  }
}

String _$appConfigHash() => r'c018d55044c07de33e1763c45125c0e682b53da7';

@ProviderFor(appLogger)
final appLoggerProvider = AppLoggerProvider._();

final class AppLoggerProvider
    extends $FunctionalProvider<AppLogger, AppLogger, AppLogger>
    with $Provider<AppLogger> {
  AppLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLoggerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLoggerHash();

  @$internal
  @override
  $ProviderElement<AppLogger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLogger create(Ref ref) {
    return appLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLogger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLogger>(value),
    );
  }
}

String _$appLoggerHash() => r'9db30e47da9552118e14307b5ef7a2ceb3548497';

@ProviderFor(appClock)
final appClockProvider = AppClockProvider._();

final class AppClockProvider
    extends $FunctionalProvider<AppClock, AppClock, AppClock>
    with $Provider<AppClock> {
  AppClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appClockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appClockHash();

  @$internal
  @override
  $ProviderElement<AppClock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppClock create(Ref ref) {
    return appClock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppClock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppClock>(value),
    );
  }
}

String _$appClockHash() => r'e1fb0e382f31b2588127780c0985e470e145cba3';

@ProviderFor(uuidGenerator)
final uuidGeneratorProvider = UuidGeneratorProvider._();

final class UuidGeneratorProvider
    extends $FunctionalProvider<UuidGenerator, UuidGenerator, UuidGenerator>
    with $Provider<UuidGenerator> {
  UuidGeneratorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uuidGeneratorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uuidGeneratorHash();

  @$internal
  @override
  $ProviderElement<UuidGenerator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UuidGenerator create(Ref ref) {
    return uuidGenerator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UuidGenerator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UuidGenerator>(value),
    );
  }
}

String _$uuidGeneratorHash() => r'4191111521de157e83d015082700e4bbfb504d81';

@ProviderFor(secureStorage)
final secureStorageProvider = SecureStorageProvider._();

final class SecureStorageProvider
    extends $FunctionalProvider<SecureStorage, SecureStorage, SecureStorage>
    with $Provider<SecureStorage> {
  SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $ProviderElement<SecureStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SecureStorage create(Ref ref) {
    return secureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureStorage>(value),
    );
  }
}

String _$secureStorageHash() => r'd19bceb5551bee07e3bd664bacafc943ad35aa93';

@ProviderFor(appNotifications)
final appNotificationsProvider = AppNotificationsProvider._();

final class AppNotificationsProvider
    extends
        $FunctionalProvider<
          AppNotifications,
          AppNotifications,
          AppNotifications
        >
    with $Provider<AppNotifications> {
  AppNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appNotificationsHash();

  @$internal
  @override
  $ProviderElement<AppNotifications> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppNotifications create(Ref ref) {
    return appNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppNotifications value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppNotifications>(value),
    );
  }
}

String _$appNotificationsHash() => r'7a7d96910276e0844dcfba288014519b71253c3c';

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'79fbc893ebdcc6adbd4c31ca4e8922a8f9832d4d';

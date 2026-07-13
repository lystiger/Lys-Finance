import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

final class DriftSettingsRepository implements SettingsRepository {
  const DriftSettingsRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<AppSettings> watch() {
    final SimpleSelectStatement<$AppSettingsEntriesTable, AppSettingRow> query =
        _database.select(_database.appSettingsEntries)..where(
          ($AppSettingsEntriesTable table) =>
              table.id.equals(AppSettings.singletonId),
        );
    return query.watchSingle().map(_settingsFromRow);
  }

  @override
  Future<AppResult<AppSettings>> get() async {
    try {
      final AppSettingRow? row =
          await (_database.select(_database.appSettingsEntries)..where(
                ($AppSettingsEntriesTable table) =>
                    table.id.equals(AppSettings.singletonId),
              ))
              .getSingleOrNull();
      return row == null
          ? const AppError<AppSettings>(NotFoundFailure())
          : AppSuccess<AppSettings>(_settingsFromRow(row));
    } on Object catch (error) {
      return AppError<AppSettings>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<AppSettings>> update(
    AppSettings settings, {
    required int expectedVersion,
  }) async {
    try {
      final AppSettings updated = settings.copyWith(
        version: expectedVersion + 1,
      );
      final int count =
          await (_database.update(_database.appSettingsEntries)..where(
                ($AppSettingsEntriesTable table) =>
                    table.id.equals(AppSettings.singletonId) &
                    table.version.equals(expectedVersion),
              ))
              .write(_companion(updated));
      return count == 0
          ? const AppError<AppSettings>(VersionConflictFailure())
          : AppSuccess<AppSettings>(updated);
    } on Object catch (error) {
      return AppError<AppSettings>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<AppSettings>> repairDefaults(DateTime now) async {
    final AppResult<AppSettings> current = await get();
    if (current is AppSuccess<AppSettings>) {
      return current;
    }
    if (current case AppError<AppSettings>(
      error: final AppFailure error,
    ) when error is! NotFoundFailure) {
      return AppError<AppSettings>(error);
    }
    final int timestamp = now.toUtc().microsecondsSinceEpoch;
    final AppSettings defaults = AppSettings(
      baseCurrencyCode: 'VND',
      themeMode: AppThemeMode.system,
      reducedMotion: false,
      createdAt: now.toUtc(),
      updatedAt: now.toUtc(),
      version: 1,
    );
    try {
      await _database
          .into(_database.appSettingsEntries)
          .insert(
            AppSettingsEntriesCompanion.insert(
              id: AppSettings.singletonId,
              baseCurrencyCode: 'VND',
              locale: const Value<String?>(null),
              themeMode: 'system',
              reducedMotion: false,
              createdAt: timestamp,
              updatedAt: timestamp,
              version: 1,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      return AppSuccess<AppSettings>(defaults);
    } on Object catch (error) {
      return AppError<AppSettings>(StorageFailure(cause: error));
    }
  }

  AppSettingsEntriesCompanion _companion(AppSettings settings) {
    return AppSettingsEntriesCompanion(
      id: const Value<String>(AppSettings.singletonId),
      baseCurrencyCode: Value<String>(settings.baseCurrencyCode),
      locale: Value<String?>(settings.locale),
      themeMode: Value<String>(settings.themeMode.name),
      reducedMotion: Value<bool>(settings.reducedMotion),
      createdAt: Value<int>(settings.createdAt.toUtc().microsecondsSinceEpoch),
      updatedAt: Value<int>(settings.updatedAt.toUtc().microsecondsSinceEpoch),
      version: Value<int>(settings.version),
    );
  }

  AppSettings _settingsFromRow(AppSettingRow row) {
    return AppSettings(
      baseCurrencyCode: row.baseCurrencyCode,
      locale: row.locale,
      themeMode: AppThemeMode.values.byName(row.themeMode),
      reducedMotion: row.reducedMotion,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
        row.createdAt,
        isUtc: true,
      ),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(
        row.updatedAt,
        isUtc: true,
      ),
      version: row.version,
    );
  }
}

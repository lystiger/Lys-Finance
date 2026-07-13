import '../../../../core/domain/app_result.dart';
import '../entities/app_settings.dart';

abstract interface class SettingsRepository {
  Stream<AppSettings> watch();
  Future<AppResult<AppSettings>> get();
  Future<AppResult<AppSettings>> update(
    AppSettings settings, {
    required int expectedVersion,
  });
  Future<AppResult<AppSettings>> repairDefaults(DateTime now);
}

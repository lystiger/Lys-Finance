import '../../../../core/domain/app_result.dart';
import '../entities/account.dart';

abstract interface class AccountRepository {
  Stream<List<Account>> watchActive();
  Future<AppResult<Account>> getById(String id, {bool includeDeleted = false});
  Future<AppResult<Account>> create(Account account);
  Future<AppResult<Account>> update(
    Account account, {
    required int expectedVersion,
  });
  Future<AppResult<void>> softDelete(
    String id, {
    required int expectedVersion,
    required DateTime deletedAt,
  });
  Future<bool> activeNameExists(String name, {String? excludingId});
}

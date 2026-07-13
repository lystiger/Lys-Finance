import '../../../../core/domain/app_result.dart';
import '../../../../core/money/money.dart';
import '../entities/vault.dart';

abstract interface class VaultRepository {
  Stream<List<Vault>> watchActive();
  Future<AppResult<Vault>> getById(String id, {bool includeArchived = false});
  Stream<Vault?> watchById(String id, {bool includeArchived = true});
  Future<AppResult<Vault>> create(Vault vault);
  Future<AppResult<Vault>> update(Vault vault, {required int expectedVersion});
  Future<AppResult<void>> archive(
    String id, {
    required int expectedVersion,
    required DateTime archivedAt,
  });
  Future<AppResult<void>> restore(
    String id, {
    required int expectedVersion,
    required DateTime restoredAt,
  });
  Future<AppResult<Money>> getBalance(String vaultId);
  Stream<Money> watchBalance(String vaultId);
  Future<bool> hasActivity(String vaultId);
}

import '../../../../core/domain/app_result.dart';
import '../entities/vault_history_event.dart';

abstract interface class VaultHistoryRepository {
  Future<AppResult<void>> append(VaultHistoryEvent event);
  Future<bool> hasEvent(
    String vaultId,
    VaultHistoryEventType eventType, {
    String? payload,
  });
  Stream<List<VaultHistoryEvent>> watchForVault(String vaultId);
  Future<AppResult<List<VaultHistoryEvent>>> queryForVault(String vaultId);
}

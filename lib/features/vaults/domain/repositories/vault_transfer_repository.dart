import '../../../../core/domain/app_result.dart';
import '../entities/vault_transfer.dart';

abstract interface class VaultTransferRepository {
  Future<AppResult<VaultTransfer>> create(VaultTransfer transfer);
  Stream<List<VaultTransfer>> watchForVault(String vaultId);
  Future<AppResult<List<VaultTransfer>>> queryForVault(String vaultId);
}

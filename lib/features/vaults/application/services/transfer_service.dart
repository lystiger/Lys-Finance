import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/app_clock.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_transfer.dart';
import '../../domain/repositories/vault_repository.dart';
import '../../domain/repositories/vault_transfer_repository.dart';

final class TransferService {
  const TransferService({
    required this.transfers,
    required this.vaults,
    required this.uuid,
    required this.clock,
  });

  final VaultTransferRepository transfers;
  final VaultRepository vaults;
  final UuidGenerator uuid;
  final AppClock clock;

  Future<AppResult<VaultTransfer>> transfer({
    required String sourceVaultId,
    required String destinationVaultId,
    required Money amount,
    String? reason,
    DateTime? occurredAt,
  }) async {
    if (sourceVaultId == destinationVaultId) {
      return const AppError<VaultTransfer>(SameVaultTransferFailure());
    }
    final AppResult<Vault> sourceResult = await vaults.getById(
      sourceVaultId,
      includeArchived: true,
    );
    if (sourceResult case AppError<Vault>(:final error)) {
      return AppError<VaultTransfer>(error);
    }
    final Vault source = (sourceResult as AppSuccess<Vault>).value;
    if (source.isArchived) {
      return const AppError<VaultTransfer>(ArchivedVaultFailure());
    }
    if (source.withdrawalPolicy == VaultWithdrawalPolicy.locked &&
        (reason == null || reason.trim().isEmpty)) {
      return const AppError<VaultTransfer>(WithdrawalReasonRequiredFailure());
    }
    final AppResult<Vault> destinationResult = await vaults.getById(
      destinationVaultId,
      includeArchived: true,
    );
    if (destinationResult case AppError<Vault>(:final error)) {
      return AppError<VaultTransfer>(error);
    }
    final Vault destination = (destinationResult as AppSuccess<Vault>).value;
    if (destination.isArchived) {
      return const AppError<VaultTransfer>(ArchivedVaultFailure());
    }
    if (source.currency != destination.currency ||
        amount.currency != source.currency) {
      return const AppError<VaultTransfer>(VaultCurrencyMismatchFailure());
    }
    final DateTime now = clock.now().toUtc();
    final AppResult<VaultTransfer> transfer = VaultTransfer.create(
      id: uuid.v4(),
      sourceVaultId: sourceVaultId,
      destinationVaultId: destinationVaultId,
      amount: amount,
      note: reason,
      occurredAt: occurredAt ?? now,
      createdAt: now,
    );
    if (transfer case AppError<VaultTransfer>()) return transfer;
    return transfers.create((transfer as AppSuccess<VaultTransfer>).value);
  }
}

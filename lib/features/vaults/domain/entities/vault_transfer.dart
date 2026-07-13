import 'package:characters/characters.dart';

import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/money/money.dart';

final class VaultTransfer {
  const VaultTransfer._({
    required this.id,
    required this.sourceVaultId,
    required this.destinationVaultId,
    required this.amount,
    required this.occurredAt,
    required this.createdAt,
    this.note,
  });

  final String id;
  final String sourceVaultId;
  final String destinationVaultId;
  final Money amount;
  final String? note;
  final DateTime occurredAt;
  final DateTime createdAt;

  static AppResult<VaultTransfer> create({
    required String id,
    required String sourceVaultId,
    required String destinationVaultId,
    required Money amount,
    required DateTime occurredAt,
    required DateTime createdAt,
    String? note,
  }) {
    if (!RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
    ).hasMatch(id)) {
      return const AppError<VaultTransfer>(
        ValidationFailure('Invalid transfer identity.', code: 'invalid_id'),
      );
    }
    if (sourceVaultId == destinationVaultId) {
      return const AppError<VaultTransfer>(SameVaultTransferFailure());
    }
    if (amount.minorUnits <= 0) {
      return const AppError<VaultTransfer>(
        ValidationFailure(
          'Enter an amount greater than zero.',
          code: 'invalid_amount',
        ),
      );
    }
    final String? normalizedNote = _normalizeNote(note);
    if (normalizedNote != null && normalizedNote.characters.length > 500) {
      return const AppError<VaultTransfer>(
        ValidationFailure('The note is too long.', code: 'too_long'),
      );
    }
    return AppSuccess<VaultTransfer>(
      VaultTransfer._(
        id: id,
        sourceVaultId: sourceVaultId,
        destinationVaultId: destinationVaultId,
        amount: amount,
        note: normalizedNote,
        occurredAt: occurredAt.toUtc(),
        createdAt: createdAt.toUtc(),
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is VaultTransfer &&
      id == other.id &&
      sourceVaultId == other.sourceVaultId &&
      destinationVaultId == other.destinationVaultId &&
      amount == other.amount &&
      note == other.note &&
      occurredAt == other.occurredAt &&
      createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(
    id,
    sourceVaultId,
    destinationVaultId,
    amount,
    note,
    occurredAt,
    createdAt,
  );
}

String? _normalizeNote(String? value) {
  final String normalized = value?.trim() ?? '';
  return normalized.isEmpty ? null : normalized;
}

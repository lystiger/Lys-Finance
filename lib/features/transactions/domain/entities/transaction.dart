import 'package:characters/characters.dart';

import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/money/money.dart';
import '../../../settings/domain/entities/category.dart';

enum TransactionType { expense, income, transfer, contribution, withdrawal }

final class Transaction {
  const Transaction._({
    required this.id,
    required this.type,
    required this.amount,
    required this.accountId,
    required this.categoryId,
    required this.incClass,
    required this.note,
    required this.occurredAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.version,
  });

  final String id;
  final TransactionType type;
  final Money amount;
  final String accountId;
  final String categoryId;
  final IncClass? incClass;
  final String? note;
  final DateTime occurredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;

  bool get isDeleted => deletedAt != null;
  bool get isExpense => type == TransactionType.expense;

  static AppResult<Transaction> create({
    required String id,
    required TransactionType type,
    required Money amount,
    required String accountId,
    required String categoryId,
    required IncClass? incClass,
    required DateTime occurredAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int version,
    String? note,
    DateTime? deletedAt,
  }) {
    if (!RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
    ).hasMatch(id)) {
      return const AppError<Transaction>(
        ValidationFailure('Invalid transaction identity.', code: 'invalid_id'),
      );
    }
    if (type != TransactionType.expense && type != TransactionType.income) {
      return const AppError<Transaction>(
        ValidationFailure(
          'Unsupported transaction type.',
          code: 'invalid_transaction_type',
        ),
      );
    }
    if (amount.minorUnits <= 0) {
      return const AppError<Transaction>(
        ValidationFailure(
          'Enter an amount greater than zero.',
          code: 'invalid_amount',
        ),
      );
    }
    if (accountId.isEmpty || categoryId.isEmpty) {
      return const AppError<Transaction>(
        ValidationFailure('Choose an account and category.', code: 'required'),
      );
    }
    if ((type == TransactionType.expense && incClass == null) ||
        (type == TransactionType.income && incClass != null)) {
      return const AppError<Transaction>(
        ValidationFailure('Invalid classification.', code: 'invalid_inc_class'),
      );
    }
    final String? normalizedNote = _normalizeNote(note);
    if (normalizedNote != null && normalizedNote.characters.length > 2000) {
      return const AppError<Transaction>(
        ValidationFailure('The note is too long.', code: 'too_long'),
      );
    }
    final DateTime created = createdAt.toUtc();
    final DateTime updated = updatedAt.toUtc();
    if (updated.isBefore(created) || version < 1) {
      return const AppError<Transaction>(
        ValidationFailure('Invalid audit state.', code: 'invalid_audit_state'),
      );
    }
    return AppSuccess<Transaction>(
      Transaction._(
        id: id,
        type: type,
        amount: amount,
        accountId: accountId,
        categoryId: categoryId,
        incClass: incClass,
        note: normalizedNote,
        occurredAt: occurredAt.toUtc(),
        createdAt: created,
        updatedAt: updated,
        deletedAt: deletedAt?.toUtc(),
        version: version,
      ),
    );
  }

  Transaction copyWith({
    Money? amount,
    String? accountId,
    String? categoryId,
    IncClass? incClass,
    bool clearIncClass = false,
    String? note,
    bool clearNote = false,
    DateTime? occurredAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
    int? version,
  }) => Transaction._(
    id: id,
    type: type,
    amount: amount ?? this.amount,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId ?? this.categoryId,
    incClass: clearIncClass ? null : incClass ?? this.incClass,
    note: clearNote ? null : note ?? this.note,
    occurredAt: (occurredAt ?? this.occurredAt).toUtc(),
    createdAt: createdAt,
    updatedAt: (updatedAt ?? this.updatedAt).toUtc(),
    deletedAt: clearDeletedAt ? null : deletedAt ?? this.deletedAt,
    version: version ?? this.version,
  );

  @override
  bool operator ==(Object other) =>
      other is Transaction &&
      id == other.id &&
      type == other.type &&
      amount == other.amount &&
      accountId == other.accountId &&
      categoryId == other.categoryId &&
      incClass == other.incClass &&
      note == other.note &&
      occurredAt == other.occurredAt &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt &&
      deletedAt == other.deletedAt &&
      version == other.version;

  @override
  int get hashCode => Object.hash(
    id,
    type,
    amount,
    accountId,
    categoryId,
    incClass,
    note,
    occurredAt,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  );
}

String? _normalizeNote(String? value) {
  final String normalized = value?.trim() ?? '';
  return normalized.isEmpty ? null : normalized;
}

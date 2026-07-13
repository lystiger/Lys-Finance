import '../../../../core/money/money.dart';
import '../../../settings/domain/entities/category.dart';
import 'transaction.dart';

enum SubmissionStatus { idle, validating, submitting, success, failure }

final class TransactionDraft {
  const TransactionDraft({
    required this.type,
    required this.rawAmountText,
    required this.occurredAt,
    this.parsedAmount,
    this.accountId,
    this.categoryId,
    this.incClass,
    this.note = '',
    this.isDirty = false,
    this.submission = SubmissionStatus.idle,
    this.failureCode,
    this.expectedVersion,
  });

  factory TransactionDraft.initial(DateTime now) => TransactionDraft(
    type: TransactionType.expense,
    rawAmountText: '',
    occurredAt: now.toUtc(),
  );

  final TransactionType type;
  final String rawAmountText;
  final Money? parsedAmount;
  final String? accountId;
  final String? categoryId;
  final IncClass? incClass;
  final String note;
  final DateTime occurredAt;
  final bool isDirty;
  final SubmissionStatus submission;
  final String? failureCode;
  final int? expectedVersion;

  TransactionDraft copyWith({
    TransactionType? type,
    String? rawAmountText,
    Money? parsedAmount,
    bool clearParsedAmount = false,
    String? accountId,
    bool clearAccountId = false,
    String? categoryId,
    bool clearCategoryId = false,
    IncClass? incClass,
    bool clearIncClass = false,
    String? note,
    DateTime? occurredAt,
    bool? isDirty,
    SubmissionStatus? submission,
    String? failureCode,
    bool clearFailure = false,
    int? expectedVersion,
  }) => TransactionDraft(
    type: type ?? this.type,
    rawAmountText: rawAmountText ?? this.rawAmountText,
    parsedAmount: clearParsedAmount ? null : parsedAmount ?? this.parsedAmount,
    accountId: clearAccountId ? null : accountId ?? this.accountId,
    categoryId: clearCategoryId ? null : categoryId ?? this.categoryId,
    incClass: clearIncClass ? null : incClass ?? this.incClass,
    note: note ?? this.note,
    occurredAt: occurredAt ?? this.occurredAt,
    isDirty: isDirty ?? true,
    submission: submission ?? this.submission,
    failureCode: clearFailure ? null : failureCode ?? this.failureCode,
    expectedVersion: expectedVersion ?? this.expectedVersion,
  );
}

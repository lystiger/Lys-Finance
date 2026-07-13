import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/time/app_clock.dart';
import '../../../settings/domain/entities/account.dart';
import '../../../settings/domain/entities/category.dart';
import '../../../settings/domain/repositories/account_repository.dart';
import '../../../settings/domain/repositories/category_repository.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_draft.dart';
import '../../domain/repositories/transaction_repository.dart';

final class TransactionService {
  const TransactionService({
    required this.transactions,
    required this.accounts,
    required this.categories,
    required this.uuid,
    required this.clock,
  });

  final TransactionRepository transactions;
  final AccountRepository accounts;
  final CategoryRepository categories;
  final UuidGenerator uuid;
  final AppClock clock;

  Future<AppResult<Transaction>> create(TransactionDraft draft) async {
    final AppResult<_ValidatedReferences> validation = await _validate(draft);
    if (validation case AppError<_ValidatedReferences>(:final error)) {
      return AppError<Transaction>(error);
    }
    final _ValidatedReferences references =
        (validation as AppSuccess<_ValidatedReferences>).value;
    final DateTime now = clock.now().toUtc();
    final AppResult<Transaction> transaction = Transaction.create(
      id: uuid.v4(),
      type: draft.type,
      amount: draft.parsedAmount!,
      accountId: references.account.id,
      categoryId: references.category.id,
      incClass: draft.type == TransactionType.expense
          ? draft.incClass ?? references.category.incClass
          : null,
      note: draft.note,
      occurredAt: draft.occurredAt,
      createdAt: now,
      updatedAt: now,
      version: 1,
    );
    return transaction.fold(
      success: transactions.create,
      failure: (failure) async => AppError<Transaction>(failure),
    );
  }

  Future<AppResult<Transaction>> update(
    Transaction original,
    TransactionDraft draft,
  ) async {
    if (original.isDeleted) {
      return const AppError<Transaction>(NotFoundFailure());
    }
    if (draft.type != original.type) {
      return const AppError<Transaction>(
        ValidationFailure(
          'Transaction type cannot be changed.',
          code: 'immutable_transaction_type',
        ),
      );
    }
    final AppResult<_ValidatedReferences> validation = await _validate(draft);
    if (validation case AppError<_ValidatedReferences>(:final error)) {
      return AppError<Transaction>(error);
    }
    final _ValidatedReferences references =
        (validation as AppSuccess<_ValidatedReferences>).value;
    final Transaction changed = original.copyWith(
      amount: draft.parsedAmount,
      accountId: references.account.id,
      categoryId: references.category.id,
      incClass: draft.type == TransactionType.expense
          ? draft.incClass ?? references.category.incClass
          : null,
      clearIncClass: draft.type == TransactionType.income,
      note: draft.note,
      clearNote: draft.note.trim().isEmpty,
      occurredAt: draft.occurredAt,
      updatedAt: clock.now().toUtc(),
    );
    if (_sameEditableFields(original, changed)) {
      return AppSuccess<Transaction>(original);
    }
    return transactions.update(changed, expectedVersion: original.version);
  }

  Future<AppResult<void>> delete(Transaction transaction) =>
      transactions.softDelete(
        transaction.id,
        expectedVersion: transaction.version,
        deletedAt: clock.now().toUtc(),
      );

  Future<AppResult<void>> restore(Transaction transaction) =>
      transactions.restore(
        transaction.id,
        expectedVersion: transaction.version,
        restoredAt: clock.now().toUtc(),
      );

  Future<AppResult<_ValidatedReferences>> _validate(
    TransactionDraft draft,
  ) async {
    if (draft.parsedAmount == null || draft.parsedAmount!.minorUnits <= 0) {
      return const AppError<_ValidatedReferences>(InvalidAmountFailure());
    }
    if (draft.accountId == null) {
      return const AppError<_ValidatedReferences>(MissingAccountFailure());
    }
    final AppResult<Account> accountResult = await accounts.getById(
      draft.accountId!,
      includeDeleted: true,
    );
    if (accountResult case AppError<Account>()) {
      return const AppError<_ValidatedReferences>(MissingAccountFailure());
    }
    final Account account = (accountResult as AppSuccess<Account>).value;
    if (account.isDeleted) {
      return const AppError<_ValidatedReferences>(ArchivedAccountFailure());
    }
    if (account.currencyCode != draft.parsedAmount!.currency.code) {
      return const AppError<_ValidatedReferences>(
        CurrencyAccountMismatchFailure(),
      );
    }
    if (draft.categoryId == null) {
      return const AppError<_ValidatedReferences>(MissingCategoryFailure());
    }
    final AppResult<Category> categoryResult = await categories.getById(
      draft.categoryId!,
      includeDeleted: true,
    );
    if (categoryResult case AppError<Category>()) {
      return const AppError<_ValidatedReferences>(MissingCategoryFailure());
    }
    final Category category = (categoryResult as AppSuccess<Category>).value;
    if (category.isDeleted) {
      return const AppError<_ValidatedReferences>(MissingCategoryFailure());
    }
    final CategoryType required = draft.type == TransactionType.expense
        ? CategoryType.expense
        : CategoryType.income;
    if (category.type != required) {
      return const AppError<_ValidatedReferences>(
        CategoryKindMismatchFailure(),
      );
    }
    if (draft.type == TransactionType.expense &&
        (draft.incClass ?? category.incClass) == null) {
      return const AppError<_ValidatedReferences>(
        ValidationFailure(
          'Choose a classification.',
          code: 'invalid_inc_class',
        ),
      );
    }
    return AppSuccess<_ValidatedReferences>(
      _ValidatedReferences(account, category),
    );
  }
}

final class _ValidatedReferences {
  const _ValidatedReferences(this.account, this.category);
  final Account account;
  final Category category;
}

bool _sameEditableFields(Transaction left, Transaction right) =>
    left.amount == right.amount &&
    left.accountId == right.accountId &&
    left.categoryId == right.categoryId &&
    left.incClass == right.incClass &&
    left.note == right.note &&
    left.occurredAt == right.occurredAt;

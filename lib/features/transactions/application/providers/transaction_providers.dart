import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/app_result.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/providers/foundation_providers.dart';
import '../../../settings/application/providers/settings_providers.dart';
import '../../../settings/domain/entities/category.dart';
import '../../data/repositories/drift_transaction_repository.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_draft.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../services/transaction_service.dart';

part 'transaction_providers.g.dart';

@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(Ref ref) =>
    DriftTransactionRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
TransactionService transactionService(Ref ref) => TransactionService(
  transactions: ref.watch(transactionRepositoryProvider),
  accounts: ref.watch(accountRepositoryProvider),
  categories: ref.watch(categoryRepositoryProvider),
  uuid: ref.watch(uuidGeneratorProvider),
  clock: ref.watch(appClockProvider),
);

@Riverpod(keepAlive: true)
class LedgerFilterController extends _$LedgerFilterController {
  @override
  TransactionFilter build() => const TransactionFilter();

  void setSearch(String value) => state = state.copyWith(searchText: value);

  void setType(TransactionType? value) =>
      state = state.copyWith(type: value, clearType: value == null);

  void showDeleted(bool value) =>
      state = state.copyWith(includeDeleted: value, onlyDeleted: value);

  void apply(TransactionFilter value) => state = value.copyWith(
    searchText: state.searchText,
    includeDeleted: state.includeDeleted,
    onlyDeleted: state.onlyDeleted,
  );

  void clear() => state = const TransactionFilter();
}

@riverpod
Stream<LedgerPage> ledgerStream(Ref ref) {
  final TransactionFilter filter = ref.watch(ledgerFilterControllerProvider);
  return ref.watch(transactionRepositoryProvider).watchLedger(filter);
}

@riverpod
Stream<Transaction?> transactionDetail(
  Ref ref,
  String id, {
  bool includeDeleted = true,
}) => ref
    .watch(transactionRepositoryProvider)
    .watchById(id, includeDeleted: includeDeleted);

@riverpod
Stream<Money> accountBalance(Ref ref, String accountId) =>
    ref.watch(transactionRepositoryProvider).watchAccountBalance(accountId);

@riverpod
class QuickAddController extends _$QuickAddController {
  @override
  TransactionDraft build() =>
      TransactionDraft.initial(ref.watch(appClockProvider).now());

  void setType(TransactionType type) {
    state = state.copyWith(
      type: type,
      clearCategoryId: true,
      clearIncClass: true,
      clearFailure: true,
    );
  }

  void setAccount(String id, Currency currency, {required String locale}) {
    state = state.copyWith(accountId: id, clearFailure: true);
    _parse(currency, locale);
  }

  void setCategory(Category category) => state = state.copyWith(
    categoryId: category.id,
    incClass: category.incClass,
    clearIncClass: category.type == CategoryType.income,
    clearFailure: true,
  );

  void setIncClass(IncClass value) =>
      state = state.copyWith(incClass: value, clearFailure: true);

  void append(String digit, Currency currency, {required String locale}) {
    String next = '${state.rawAmountText}$digit';
    if (next.startsWith('00')) next = next.substring(1);
    state = state.copyWith(rawAmountText: next, clearFailure: true);
    _parse(currency, locale);
  }

  void backspace(Currency currency, {required String locale}) {
    final String raw = state.rawAmountText;
    state = state.copyWith(
      rawAmountText: raw.isEmpty ? '' : raw.substring(0, raw.length - 1),
      clearFailure: true,
    );
    _parse(currency, locale);
  }

  void setNote(String value) => state = state.copyWith(note: value);

  void setOccurredAt(DateTime value) =>
      state = state.copyWith(occurredAt: value.toUtc());

  void _parse(Currency currency, String locale) {
    final AppResult<Money> result = ref
        .read(moneyServiceProvider)
        .parse(state.rawAmountText, currency: currency, locale: locale);
    state = switch (result) {
      AppSuccess<Money>(:final value) => state.copyWith(parsedAmount: value),
      AppError<Money>() => state.copyWith(clearParsedAmount: true),
    };
  }

  Future<AppResult<Transaction>> submit() async {
    state = state.copyWith(
      submission: SubmissionStatus.submitting,
      clearFailure: true,
    );
    final AppResult<Transaction> result = await ref
        .read(transactionServiceProvider)
        .create(state);
    state = switch (result) {
      AppSuccess<Transaction>() => state.copyWith(
        submission: SubmissionStatus.success,
      ),
      AppError<Transaction>(:final error) => state.copyWith(
        submission: SubmissionStatus.failure,
        failureCode: error.code,
      ),
    };
    return result;
  }
}

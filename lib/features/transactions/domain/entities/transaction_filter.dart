import '../../../settings/domain/entities/category.dart';
import 'transaction.dart';

final class TransactionCursor {
  const TransactionCursor({
    required this.occurredAt,
    required this.createdAt,
    required this.id,
  });
  final DateTime occurredAt;
  final DateTime createdAt;
  final String id;
}

final class TransactionFilter {
  const TransactionFilter({
    this.start,
    this.end,
    this.type,
    this.accountIds = const <String>{},
    this.categoryIds = const <String>{},
    this.incClasses = const <IncClass>{},
    this.currencyCode,
    this.minAmountMinor,
    this.maxAmountMinor,
    this.searchText,
    this.includeDeleted = false,
    this.onlyDeleted = false,
  });

  final DateTime? start;
  final DateTime? end;
  final TransactionType? type;
  final Set<String> accountIds;
  final Set<String> categoryIds;
  final Set<IncClass> incClasses;
  final String? currencyCode;
  final int? minAmountMinor;
  final int? maxAmountMinor;
  final String? searchText;
  final bool includeDeleted;
  final bool onlyDeleted;

  TransactionFilter copyWith({
    DateTime? start,
    bool clearStart = false,
    DateTime? end,
    bool clearEnd = false,
    TransactionType? type,
    bool clearType = false,
    Set<String>? accountIds,
    Set<String>? categoryIds,
    Set<IncClass>? incClasses,
    String? currencyCode,
    bool clearCurrencyCode = false,
    int? minAmountMinor,
    bool clearMinAmount = false,
    int? maxAmountMinor,
    bool clearMaxAmount = false,
    String? searchText,
    bool? includeDeleted,
    bool? onlyDeleted,
  }) => TransactionFilter(
    start: clearStart ? null : start ?? this.start,
    end: clearEnd ? null : end ?? this.end,
    type: clearType ? null : type ?? this.type,
    accountIds: accountIds ?? this.accountIds,
    categoryIds: categoryIds ?? this.categoryIds,
    incClasses: incClasses ?? this.incClasses,
    currencyCode: clearCurrencyCode ? null : currencyCode ?? this.currencyCode,
    minAmountMinor: clearMinAmount
        ? null
        : minAmountMinor ?? this.minAmountMinor,
    maxAmountMinor: clearMaxAmount
        ? null
        : maxAmountMinor ?? this.maxAmountMinor,
    searchText: searchText ?? this.searchText,
    includeDeleted: includeDeleted ?? this.includeDeleted,
    onlyDeleted: onlyDeleted ?? this.onlyDeleted,
  );
}

final class LedgerPage {
  const LedgerPage({required this.items, required this.nextCursor});
  final List<Transaction> items;
  final TransactionCursor? nextCursor;
}

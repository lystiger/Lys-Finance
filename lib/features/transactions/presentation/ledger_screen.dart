import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/domain/app_result.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/formatting_service.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_states.dart';
import '../../settings/application/providers/settings_providers.dart';
import '../../settings/domain/entities/account.dart';
import '../../settings/domain/entities/category.dart';
import '../application/providers/transaction_providers.dart';
import '../domain/entities/transaction.dart';
import '../domain/entities/transaction_filter.dart';
import 'transaction_l10n.dart';

class LedgerScreen extends ConsumerStatefulWidget {
  const LedgerScreen({this.deletedOnly = false, super.key});
  final bool deletedOnly;

  @override
  ConsumerState<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends ConsumerState<LedgerScreen> {
  final TextEditingController _search = TextEditingController();
  Timer? _debounce;
  TransactionFilter? _loadedFilter;
  final List<Transaction> _additional = <Transaction>[];
  TransactionCursor? _nextCursor;
  bool _pageInitialized = false;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    if (widget.deletedOnly) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) =>
            ref.read(ledgerFilterControllerProvider.notifier).showDeleted(true),
      );
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    if (widget.deletedOnly) {
      ref.read(ledgerFilterControllerProvider.notifier).clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<LedgerPage> ledger = ref.watch(ledgerStreamProvider);
    final List<Account> accounts =
        ref.watch(activeAccountsProvider).value ?? <Account>[];
    final List<Category> categories =
        ref.watch(activeCategoriesProvider()).value ?? <Category>[];
    final TransactionFilter filter = ref.watch(ledgerFilterControllerProvider);
    if (!identical(_loadedFilter, filter)) {
      _loadedFilter = filter;
      _additional.clear();
      _nextCursor = null;
      _pageInitialized = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.deletedOnly ? l10n.recentlyDeleted : l10n.transactions,
        ),
        actions: widget.deletedOnly
            ? null
            : <Widget>[
                IconButton(
                  tooltip: l10n.filters,
                  onPressed: () =>
                      _showFilters(context, ref, filter, accounts, categories),
                  icon: const Icon(Icons.filter_list),
                ),
                IconButton(
                  tooltip: l10n.recentlyDeleted,
                  onPressed: () => context.push(AppRoutes.recentlyDeleted),
                  icon: const Icon(Icons.history),
                ),
              ],
      ),
      floatingActionButton: widget.deletedOnly
          ? null
          : FloatingActionButton(
              key: const Key('ledger-add'),
              tooltip: l10n.addTransaction,
              onPressed: () => context.push(AppRoutes.quickAdd),
              child: const Icon(Icons.add),
            ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SearchBar(
              controller: _search,
              hintText: l10n.search,
              leading: const Icon(Icons.search),
              onChanged: (value) {
                _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 250), () {
                  ref
                      .read(ledgerFilterControllerProvider.notifier)
                      .setSearch(value);
                });
              },
            ),
          ),
          if (!widget.deletedOnly)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SegmentedButton<TransactionType?>(
                segments: <ButtonSegment<TransactionType?>>[
                  ButtonSegment<TransactionType?>(
                    value: null,
                    label: Text(l10n.all),
                  ),
                  ButtonSegment<TransactionType?>(
                    value: TransactionType.expense,
                    label: Text(l10n.expense),
                  ),
                  ButtonSegment<TransactionType?>(
                    value: TransactionType.income,
                    label: Text(l10n.income),
                  ),
                ],
                selected: <TransactionType?>{filter.type},
                onSelectionChanged: (value) => ref
                    .read(ledgerFilterControllerProvider.notifier)
                    .setType(value.single),
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: ledger.when(
              loading: () => LoadingCard(label: l10n.loadingTransactions),
              error: (error, stackTrace) => ErrorState(
                title: l10n.unableToLoad,
                message: l10n.databaseReadError,
                retryLabel: l10n.filters,
                onRetry: () => ref.invalidate(ledgerStreamProvider),
              ),
              data: (page) {
                if (!_pageInitialized) {
                  _nextCursor = page.nextCursor;
                  _pageInitialized = true;
                }
                final Map<String, Transaction> unique = <String, Transaction>{
                  for (final item in page.items) item.id: item,
                  for (final item in _additional) item.id: item,
                };
                final List<Transaction> items = unique.values.toList(
                  growable: false,
                );
                if (items.isEmpty) {
                  return EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: l10n.emptyLedgerTitle,
                    message: l10n.emptyLedgerMessage,
                    actionLabel: widget.deletedOnly
                        ? null
                        : l10n.addTransaction,
                    onAction: widget.deletedOnly
                        ? null
                        : () => context.push(AppRoutes.quickAdd),
                  );
                }
                return _GroupedLedger(
                  items: items,
                  accounts: accounts,
                  categories: categories,
                  hasMore: _nextCursor != null,
                  loadingMore: _loadingMore,
                  onLoadMore: () => _loadMore(filter),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showFilters(
    BuildContext context,
    WidgetRef ref,
    TransactionFilter initial,
    List<Account> accounts,
    List<Category> categories,
  ) async {
    final TransactionFilter? selected =
        await showModalBottomSheet<TransactionFilter>(
          context: context,
          isScrollControlled: true,
          builder: (context) => _LedgerFilterSheet(
            initial: initial,
            accounts: accounts,
            categories: categories,
          ),
        );
    if (selected != null) {
      ref.read(ledgerFilterControllerProvider.notifier).apply(selected);
    }
  }

  Future<void> _loadMore(TransactionFilter filter) async {
    final TransactionCursor? cursor = _nextCursor;
    if (cursor == null || _loadingMore) return;
    setState(() => _loadingMore = true);
    final AppResult<LedgerPage> result = await ref
        .read(transactionRepositoryProvider)
        .queryLedger(filter, cursor: cursor);
    if (!mounted) return;
    setState(() {
      _loadingMore = false;
      if (result case AppSuccess<LedgerPage>(:final value)) {
        _additional.addAll(value.items);
        _nextCursor = value.nextCursor;
      }
    });
  }
}

class _GroupedLedger extends StatelessWidget {
  const _GroupedLedger({
    required this.items,
    required this.accounts,
    required this.categories,
    required this.hasMore,
    required this.loadingMore,
    required this.onLoadMore,
  });
  final List<Transaction> items;
  final List<Account> accounts;
  final List<Category> categories;
  final bool hasMore;
  final bool loadingMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<Transaction>> groups =
        <DateTime, List<Transaction>>{};
    for (final Transaction item in items) {
      final DateTime local = item.occurredAt.toLocal();
      groups
          .putIfAbsent(
            DateTime(local.year, local.month, local.day),
            () => <Transaction>[],
          )
          .add(item);
    }
    return ListView(
      children: <Widget>[
        ...groups.entries.expand((entry) {
          return <Widget>[
            _DayHeader(day: entry.key, transactions: entry.value),
            ...entry.value.map(
              (item) => _TransactionTile(
                transaction: item,
                account: accounts
                    .where((value) => value.id == item.accountId)
                    .firstOrNull,
                category: categories
                    .where((value) => value.id == item.categoryId)
                    .firstOrNull,
              ),
            ),
          ];
        }),
        if (hasMore)
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton.tonal(
              onPressed: loadingMore ? null : onLoadMore,
              child: loadingMore
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppLocalizations.of(context).loadMore),
            ),
          ),
      ],
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.day, required this.transactions});
  final DateTime day;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final String locale = Localizations.localeOf(context).languageCode;
    final Map<Currency, ({int income, int expense})> totals =
        <Currency, ({int income, int expense})>{};
    for (final Transaction transaction in transactions) {
      final ({int income, int expense}) current =
          totals[transaction.amount.currency] ?? (income: 0, expense: 0);
      totals[transaction.amount.currency] =
          transaction.type == TransactionType.income
          ? (
              income: current.income + transaction.amount.minorUnits,
              expense: current.expense,
            )
          : (
              income: current.income,
              expense: current.expense + transaction.amount.minorUnits,
            );
    }
    const FormattingService formatter = FormattingService();
    final String summary = totals.entries
        .map((entry) {
          final Money income =
              Money.fromMinorUnits(
                minorUnits: entry.value.income,
                currency: entry.key,
              ).fold(
                success: (value) => value,
                failure: (failure) => Money.zero(entry.key),
              );
          final Money expense =
              Money.fromMinorUnits(
                minorUnits: entry.value.expense,
                currency: entry.key,
              ).fold(
                success: (value) => value,
                failure: (failure) => Money.zero(entry.key),
              );
          return '+${formatter.money(income, locale: locale)} / '
              '-${formatter.money(expense, locale: locale)}';
        })
        .join('  ');
    return ListTile(
      title: Text(
        MaterialLocalizations.of(context).formatMediumDate(day),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(summary),
    );
  }
}

class _TransactionTile extends ConsumerWidget {
  const _TransactionTile({
    required this.transaction,
    required this.account,
    required this.category,
  });
  final Transaction transaction;
  final Account? account;
  final Category? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppSemanticColors colors = Theme.of(
      context,
    ).extension<AppSemanticColors>()!;
    final bool income = transaction.type == TransactionType.income;
    final String categoryText = category == null
        ? l10n.category
        : categoryLabel(l10n, category!);
    final String accountText = account == null
        ? l10n.account
        : accountLabel(l10n, account!);
    final String amount =
        '${income ? '+' : '-'}${ref.watch(formattingServiceProvider).money(transaction.amount, locale: Localizations.localeOf(context).languageCode)}';
    return Semantics(
      label: '${income ? l10n.income : l10n.expense}, $categoryText, $amount',
      child: ListTile(
        leading: CircleAvatar(child: Icon(income ? Icons.add : Icons.remove)),
        title: Text(categoryText),
        subtitle: Text(
          transaction.incClass == null
              ? accountText
              : '$accountText · ${incLabel(l10n, transaction.incClass!)}',
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            color: income ? colors.income : colors.expense,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () => context.push(AppRoutes.transaction(transaction.id)),
      ),
    );
  }
}

class _LedgerFilterSheet extends StatefulWidget {
  const _LedgerFilterSheet({
    required this.initial,
    required this.accounts,
    required this.categories,
  });
  final TransactionFilter initial;
  final List<Account> accounts;
  final List<Category> categories;

  @override
  State<_LedgerFilterSheet> createState() => _LedgerFilterSheetState();
}

class _LedgerFilterSheetState extends State<_LedgerFilterSheet> {
  late final Set<String> _accounts = <String>{...widget.initial.accountIds};
  late final Set<String> _categories = <String>{...widget.initial.categoryIds};
  late final Set<IncClass> _incClasses = <IncClass>{
    ...widget.initial.incClasses,
  };
  late DateTime? _start = widget.initial.start;
  late DateTime? _end = widget.initial.end;
  late final TextEditingController _minimum = TextEditingController(
    text: widget.initial.minAmountMinor?.toString() ?? '',
  );
  late final TextEditingController _maximum = TextEditingController(
    text: widget.initial.maxAmountMinor?.toString() ?? '',
  );

  @override
  void dispose() {
    _minimum.dispose();
    _maximum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                l10n.filters,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.date_range),
                label: Text(
                  _start == null
                      ? l10n.date
                      : '${MaterialLocalizations.of(context).formatShortDate(_start!.toLocal())} – '
                            '${MaterialLocalizations.of(context).formatShortDate(_end!.toLocal())}',
                ),
                onPressed: _pickDates,
              ),
              _FilterHeading(l10n.accounts),
              Wrap(
                spacing: 8,
                children: widget.accounts
                    .map(
                      (account) => FilterChip(
                        label: Text(accountLabel(l10n, account)),
                        selected: _accounts.contains(account.id),
                        onSelected: (selected) => setState(
                          () => selected
                              ? _accounts.add(account.id)
                              : _accounts.remove(account.id),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              _FilterHeading(l10n.categories),
              Wrap(
                spacing: 8,
                children: widget.categories
                    .map(
                      (category) => FilterChip(
                        label: Text(categoryLabel(l10n, category)),
                        selected: _categories.contains(category.id),
                        onSelected: (selected) => setState(
                          () => selected
                              ? _categories.add(category.id)
                              : _categories.remove(category.id),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              _FilterHeading(l10n.incomeSource),
              Wrap(
                spacing: 8,
                children: IncClass.values
                    .map(
                      (value) => FilterChip(
                        label: Text(incLabel(l10n, value)),
                        selected: _incClasses.contains(value),
                        onSelected: (selected) => setState(
                          () => selected
                              ? _incClasses.add(value)
                              : _incClasses.remove(value),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _minimum,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '${l10n.amount} ≥',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _maximum,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '${l10n.amount} ≤',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pop(context, const TransactionFilter()),
                      child: Text(l10n.clearFilters),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context, _filter()),
                      child: Text(l10n.save),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDates() async {
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: _start == null
          ? null
          : DateTimeRange(start: _start!.toLocal(), end: _end!.toLocal()),
    );
    if (range == null) return;
    setState(() {
      _start = DateTime(
        range.start.year,
        range.start.month,
        range.start.day,
      ).toUtc();
      _end = DateTime(
        range.end.year,
        range.end.month,
        range.end.day,
        23,
        59,
        59,
        999,
        999,
      ).toUtc();
    });
  }

  TransactionFilter _filter() => widget.initial.copyWith(
    start: _start,
    clearStart: _start == null,
    end: _end,
    clearEnd: _end == null,
    accountIds: Set<String>.unmodifiable(_accounts),
    categoryIds: Set<String>.unmodifiable(_categories),
    incClasses: Set<IncClass>.unmodifiable(_incClasses),
    minAmountMinor: int.tryParse(_minimum.text),
    clearMinAmount: _minimum.text.isEmpty,
    maxAmountMinor: int.tryParse(_maximum.text),
    clearMaxAmount: _maximum.text.isEmpty,
  );
}

class _FilterHeading extends StatelessWidget {
  const _FilterHeading(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 4),
    child: Text(label, style: Theme.of(context).textTheme.titleMedium),
  );
}

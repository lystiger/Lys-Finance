import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../core/domain/app_result.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/money/money.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_states.dart';
import '../../../shared/widgets/app_surfaces.dart';
import '../../settings/application/providers/settings_providers.dart';
import '../../settings/domain/entities/account.dart';
import '../../settings/domain/entities/category.dart';
import '../application/providers/transaction_providers.dart';
import '../domain/entities/transaction.dart';
import '../domain/entities/transaction_draft.dart';
import 'transaction_l10n.dart';

class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({required this.transactionId, super.key});
  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<Transaction?> detail = ref.watch(
      transactionDetailProvider(transactionId),
    );
    final List<Account> accounts =
        ref.watch(activeAccountsProvider).value ?? <Account>[];
    final List<Category> categories =
        ref.watch(activeCategoriesProvider()).value ?? <Category>[];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.transactionDetails)),
      body: detail.when(
        loading: () => LoadingCard(label: l10n.loadingTransactions),
        error: (error, stackTrace) => ErrorState(
          title: l10n.unableToLoad,
          message: l10n.databaseReadError,
        ),
        data: (transaction) {
          if (transaction == null) {
            return EmptyState(
              icon: Icons.receipt_long_outlined,
              title: l10n.emptyLedgerTitle,
              message: l10n.emptyLedgerMessage,
            );
          }
          final Account? account = accounts
              .where((value) => value.id == transaction.accountId)
              .firstOrNull;
          final Category? category = categories
              .where((value) => value.id == transaction.categoryId)
              .firstOrNull;
          final String formattedAmount = ref
              .watch(formattingServiceProvider)
              .money(
                transaction.amount,
                locale: Localizations.localeOf(context).languageCode,
              );
          final String signedAmount =
              '${transaction.type == TransactionType.expense ? '-' : '+'}$formattedAmount';
          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Semantics(
                label:
                    '${transaction.type == TransactionType.expense ? l10n.expense : l10n.income} $formattedAmount',
                child: Text(
                  signedAmount,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: 24),
              AppCard(
                child: Column(
                  children: <Widget>[
                    _DetailRow(
                      label: l10n.account,
                      value: account == null
                          ? l10n.account
                          : accountLabel(l10n, account),
                    ),
                    _DetailRow(
                      label: l10n.category,
                      value: category == null
                          ? l10n.category
                          : categoryLabel(l10n, category),
                    ),
                    if (transaction.incClass != null)
                      _DetailRow(
                        label: l10n.filters,
                        value: incLabel(l10n, transaction.incClass!),
                      ),
                    _DetailRow(
                      label: l10n.date,
                      value: MaterialLocalizations.of(
                        context,
                      ).formatFullDate(transaction.occurredAt.toLocal()),
                    ),
                    if (transaction.note != null)
                      _DetailRow(label: l10n.note, value: transaction.note!),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (transaction.isDeleted)
                PrimaryButton(
                  label: l10n.restore,
                  onPressed: () async {
                    final AppResult<void> result = await ref
                        .read(transactionServiceProvider)
                        .restore(transaction);
                    if (context.mounted && result is AppSuccess<void>) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.transactionRestored)),
                      );
                    }
                  },
                )
              else ...<Widget>[
                PrimaryButton(
                  label: l10n.edit,
                  onPressed: () =>
                      context.push(AppRoutes.editTransaction(transaction.id)),
                ),
                const SizedBox(height: 8),
                SecondaryButton(
                  label: l10n.delete,
                  onPressed: () async {
                    final bool confirmed =
                        await showConfirmationDialog(
                          context,
                          title: l10n.deleteTransactionTitle,
                          body: l10n.deleteTransactionMessage,
                          cancelLabel: l10n.cancel,
                          confirmLabel: l10n.delete,
                          destructive: true,
                        ) ??
                        false;
                    if (!confirmed) return;
                    final AppResult<void> result = await ref
                        .read(transactionServiceProvider)
                        .delete(transaction);
                    if (!context.mounted || result is! AppSuccess<void>) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 6),
                        content: Text(l10n.transactionDeleted),
                        action: SnackBarAction(
                          label: l10n.undo,
                          onPressed: () => ref
                              .read(transactionRepositoryProvider)
                              .restore(
                                transaction.id,
                                expectedVersion: transaction.version + 1,
                                restoredAt: DateTime.now().toUtc(),
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) =>
      ListTile(title: Text(label), subtitle: Text(value));
}

class EditTransactionScreen extends ConsumerWidget {
  const EditTransactionScreen({required this.transactionId, super.key});
  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<Transaction?> detail = ref.watch(
      transactionDetailProvider(transactionId),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.edit)),
      body: detail.when(
        loading: () => LoadingCard(label: l10n.loadingTransactions),
        error: (error, stackTrace) => ErrorState(
          title: l10n.unableToLoad,
          message: l10n.databaseReadError,
        ),
        data: (transaction) => transaction == null
            ? EmptyState(
                icon: Icons.receipt_long_outlined,
                title: l10n.emptyLedgerTitle,
                message: l10n.emptyLedgerMessage,
              )
            : _EditForm(transaction: transaction),
      ),
    );
  }
}

class _EditForm extends ConsumerStatefulWidget {
  const _EditForm({required this.transaction});
  final Transaction transaction;

  @override
  ConsumerState<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<_EditForm> {
  late final TextEditingController _amount;
  late final TextEditingController _note;
  late String _accountId;
  late String _categoryId;
  late IncClass? _incClass;
  late DateTime _occurredAt;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController(
      text: _editableAmount(widget.transaction.amount),
    );
    _note = TextEditingController(text: widget.transaction.note);
    _accountId = widget.transaction.accountId;
    _categoryId = widget.transaction.categoryId!;
    _incClass = widget.transaction.incClass;
    _occurredAt = widget.transaction.occurredAt;
  }

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<Account> accounts =
        ref.watch(activeAccountsProvider).value ?? <Account>[];
    final List<Category> categories =
        (ref.watch(activeCategoriesProvider()).value ?? <Category>[])
            .where(
              (value) =>
                  value.type ==
                  (widget.transaction.type == TransactionType.expense
                      ? CategoryType.expense
                      : CategoryType.income),
            )
            .toList(growable: false);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: l10n.amount),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _accountId,
          decoration: InputDecoration(labelText: l10n.account),
          items: accounts
              .map(
                (value) => DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(accountLabel(l10n, value)),
                ),
              )
              .toList(growable: false),
          onChanged: (value) =>
              setState(() => _accountId = value ?? _accountId),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _categoryId,
          decoration: InputDecoration(labelText: l10n.category),
          items: categories
              .map(
                (value) => DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(categoryLabel(l10n, value)),
                ),
              )
              .toList(growable: false),
          onChanged: (value) {
            final Category? category = categories
                .where((item) => item.id == value)
                .firstOrNull;
            if (category != null) {
              setState(() {
                _categoryId = category.id;
                _incClass = category.incClass;
              });
            }
          },
        ),
        if (widget.transaction.type == TransactionType.expense) ...<Widget>[
          const SizedBox(height: 12),
          SegmentedButton<IncClass>(
            segments: IncClass.values
                .map(
                  (value) => ButtonSegment<IncClass>(
                    value: value,
                    label: Text(incLabel(l10n, value)),
                  ),
                )
                .toList(growable: false),
            selected: <IncClass>{?_incClass},
            onSelectionChanged: (value) =>
                setState(() => _incClass = value.single),
          ),
        ],
        const SizedBox(height: 12),
        TextField(
          controller: _note,
          maxLength: 2000,
          decoration: InputDecoration(labelText: l10n.optionalNote),
        ),
        PrimaryButton(
          label: l10n.save,
          loading: _saving,
          onPressed: () async {
            final Account? account = accounts
                .where((value) => value.id == _accountId)
                .firstOrNull;
            if (account == null) return;
            final AppResult<Money> parsed = ref
                .read(moneyServiceProvider)
                .parse(
                  _amount.text,
                  currency: account.openingBalance.currency,
                  locale: Localizations.localeOf(context).languageCode,
                );
            final TransactionDraft draft = TransactionDraft(
              type: widget.transaction.type,
              rawAmountText: _amount.text,
              parsedAmount: parsed is AppSuccess<Money> ? parsed.value : null,
              accountId: _accountId,
              categoryId: _categoryId,
              incClass: _incClass,
              note: _note.text,
              occurredAt: _occurredAt,
              expectedVersion: widget.transaction.version,
            );
            setState(() => _saving = true);
            final AppResult<Transaction> result = await ref
                .read(transactionServiceProvider)
                .update(widget.transaction, draft);
            if (mounted) setState(() => _saving = false);
            if (context.mounted && result is AppSuccess<Transaction>) {
              context.pop();
            }
            if (context.mounted && result is AppError<Transaction>) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(transactionError(l10n, result.error.code)),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

String _editableAmount(Money money) {
  if (money.currency.minorUnitDigits == 0) return money.minorUnits.toString();
  final bool negative = money.minorUnits < 0;
  final int absolute = money.minorUnits.abs();
  final int scale = money.currency.minorUnitDigits == 2 ? 100 : 1000;
  return '${negative ? '-' : ''}${absolute ~/ scale}.${(absolute % scale).toString().padLeft(money.currency.minorUnitDigits, '0')}';
}

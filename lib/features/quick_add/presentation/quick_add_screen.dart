import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/app_result.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../features/settings/application/providers/settings_providers.dart';
import '../../../features/settings/domain/entities/account.dart';
import '../../../features/settings/domain/entities/category.dart';
import '../../../features/transactions/application/providers/transaction_providers.dart';
import '../../../features/transactions/domain/entities/transaction.dart';
import '../../../features/transactions/domain/entities/transaction_draft.dart';
import '../../../features/transactions/presentation/transaction_l10n.dart';
import '../../../shared/widgets/app_buttons.dart';

class QuickAddScreen extends ConsumerWidget {
  const QuickAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    final TransactionDraft draft = ref.watch(quickAddControllerProvider);
    final List<Account> accounts =
        ref.watch(activeAccountsProvider).value ?? <Account>[];
    final List<Category> allCategories =
        ref.watch(activeCategoriesProvider()).value ?? <Category>[];
    final CategoryType categoryType = draft.type == TransactionType.expense
        ? CategoryType.expense
        : CategoryType.income;
    final List<Category> categories = allCategories
        .where((value) => value.type == categoryType)
        .toList(growable: false);
    final Account? selectedAccount = accounts
        .where((value) => value.id == draft.accountId)
        .firstOrNull;
    final Currency currency =
        selectedAccount?.openingBalance.currency ?? Currency.vnd;

    if (draft.accountId == null && accounts.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref
            .read(quickAddControllerProvider.notifier)
            .setAccount(
              accounts.first.id,
              accounts.first.openingBalance.currency,
              locale: locale,
            ),
      );
    }
    if (draft.categoryId == null && categories.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref
            .read(quickAddControllerProvider.notifier)
            .setCategory(categories.first),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.quickAdd),
        leading: IconButton(
          tooltip: l10n.close,
          onPressed: context.pop,
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            SegmentedButton<TransactionType>(
              segments: <ButtonSegment<TransactionType>>[
                ButtonSegment<TransactionType>(
                  value: TransactionType.expense,
                  label: Text(l10n.expense),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                ButtonSegment<TransactionType>(
                  value: TransactionType.income,
                  label: Text(l10n.income),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
              selected: <TransactionType>{draft.type},
              onSelectionChanged: (value) => ref
                  .read(quickAddControllerProvider.notifier)
                  .setType(value.single),
            ),
            const SizedBox(height: 24),
            Semantics(
              label: l10n.amount,
              value: draft.parsedAmount == null
                  ? draft.rawAmountText
                  : '${draft.parsedAmount!.minorUnits} ${currency.code}',
              child: Text(
                draft.rawAmountText.isEmpty
                    ? '0 ${currency.symbol}'
                    : '${draft.rawAmountText} ${currency.symbol}',
                key: const Key('quick-add-amount'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 16),
            _NumberPad(currency: currency, locale: locale),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: const Key('quick-add-account'),
              initialValue: selectedAccount?.id,
              decoration: InputDecoration(labelText: l10n.account),
              items: accounts
                  .map(
                    (account) => DropdownMenuItem<String>(
                      value: account.id,
                      child: Text(accountLabel(l10n, account)),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (id) {
                final Account? account = accounts
                    .where((value) => value.id == id)
                    .firstOrNull;
                if (account != null) {
                  ref
                      .read(quickAddControllerProvider.notifier)
                      .setAccount(
                        account.id,
                        account.openingBalance.currency,
                        locale: locale,
                      );
                }
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: const Key('quick-add-category'),
              initialValue:
                  categories.any((value) => value.id == draft.categoryId)
                  ? draft.categoryId
                  : null,
              decoration: InputDecoration(
                labelText: draft.type == TransactionType.income
                    ? l10n.incomeSource
                    : l10n.category,
              ),
              items: categories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(categoryLabel(l10n, category)),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (id) {
                final Category? category = categories
                    .where((value) => value.id == id)
                    .firstOrNull;
                if (category != null) {
                  ref
                      .read(quickAddControllerProvider.notifier)
                      .setCategory(category);
                }
              },
            ),
            if (draft.type == TransactionType.expense) ...<Widget>[
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
                selected: draft.incClass == null
                    ? <IncClass>{}
                    : <IncClass>{draft.incClass!},
                emptySelectionAllowed: true,
                onSelectionChanged: (value) {
                  if (value.isNotEmpty) {
                    ref
                        .read(quickAddControllerProvider.notifier)
                        .setIncClass(value.single);
                  }
                },
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              key: const Key('quick-add-note'),
              maxLength: 2000,
              decoration: InputDecoration(labelText: l10n.optionalNote),
              onChanged: ref.read(quickAddControllerProvider.notifier).setNote,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_outlined),
              title: Text(l10n.date),
              subtitle: Text(
                MaterialLocalizations.of(
                  context,
                ).formatFullDate(draft.occurredAt.toLocal()),
              ),
              onTap: () async {
                final DateTime? value = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: draft.occurredAt.toLocal(),
                );
                if (value != null) {
                  ref
                      .read(quickAddControllerProvider.notifier)
                      .setOccurredAt(value);
                }
              },
            ),
            if (draft.failureCode != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  transactionError(l10n, draft.failureCode),
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            PrimaryButton(
              label: l10n.save,
              loading: draft.submission == SubmissionStatus.submitting,
              onPressed: () async {
                final AppResult<Transaction> result = await ref
                    .read(quickAddControllerProvider.notifier)
                    .submit();
                if (context.mounted && result is AppSuccess<Transaction>) {
                  context.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberPad extends ConsumerWidget {
  const _NumberPad({required this.currency, required this.locale});
  final Currency currency;
  final String locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> keys = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      currency.minorUnitDigits > 0 && locale.startsWith('vi')
          ? ','
          : currency.minorUnitDigits > 0
          ? '.'
          : '00',
      '0',
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: <Widget>[
        ...keys.map(
          (value) => Semantics(
            button: true,
            label: value,
            child: TextButton(
              onPressed: () => ref
                  .read(quickAddControllerProvider.notifier)
                  .append(value, currency, locale: locale),
              child: Text(value, style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ),
        IconButton(
          tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
          onPressed: () => ref
              .read(quickAddControllerProvider.notifier)
              .backspace(currency, locale: locale),
          icon: const Icon(Icons.backspace_outlined),
        ),
      ],
    );
  }
}

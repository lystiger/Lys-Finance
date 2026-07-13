import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/app_result.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/money/money.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_inputs.dart';
import '../../../../shared/widgets/app_surfaces.dart';
import '../../../settings/application/providers/settings_providers.dart';
import '../../../settings/domain/entities/account.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/presentation/transaction_l10n.dart';
import '../../application/providers/vault_providers.dart';
import '../../domain/entities/vault.dart';
import '../vault_l10n.dart';

Future<void> showWithdrawalDialog(BuildContext context, Vault vault) =>
    showAppBottomSheet<void>(context, child: _WithdrawalSheet(vault: vault));

class _WithdrawalSheet extends ConsumerStatefulWidget {
  const _WithdrawalSheet({required this.vault});
  final Vault vault;

  @override
  ConsumerState<_WithdrawalSheet> createState() => _WithdrawalSheetState();
}

class _WithdrawalSheetState extends ConsumerState<_WithdrawalSheet> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _reason = TextEditingController();
  String? _accountId;
  bool _saving = false;
  String? _errorCode;

  bool get _locked =>
      widget.vault.withdrawalPolicy == VaultWithdrawalPolicy.locked;

  @override
  void dispose() {
    _amount.dispose();
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    final List<Account> accounts =
        (ref.watch(activeAccountsProvider).value ?? <Account>[])
            .where(
              (account) => account.currencyCode == widget.vault.currency.code,
            )
            .toList(growable: false);
    _accountId ??= accounts.firstOrNull?.id;
    final bool canSubmit =
        _accountId != null && (!_locked || _reason.text.trim().isNotEmpty);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            l10n.withdrawFromVault,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          MoneyInput(
            controller: _amount,
            currency: widget.vault.currency,
            semanticLabel: l10n.amount,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: const Key('withdrawal-account'),
            initialValue: _accountId,
            decoration: InputDecoration(labelText: l10n.account),
            items: accounts
                .map(
                  (account) => DropdownMenuItem<String>(
                    value: account.id,
                    child: Text(accountLabel(l10n, account)),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) => setState(() => _accountId = value),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('withdrawal-reason'),
            controller: _reason,
            decoration: InputDecoration(
              labelText: _locked ? l10n.reasonRequired : l10n.optionalReason,
            ),
            onChanged: (_) => setState(() {}),
          ),
          if (_errorCode != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                vaultError(l10n, _errorCode),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: l10n.save,
            loading: _saving,
            onPressed: canSubmit ? () => _submit(locale) : null,
          ),
        ],
      ),
    );
  }

  Future<void> _submit(String locale) async {
    setState(() {
      _saving = true;
      _errorCode = null;
    });
    final AppResult<Money> parsed = ref
        .read(moneyServiceProvider)
        .parse(_amount.text, currency: widget.vault.currency, locale: locale);
    if (parsed case AppError<Money>(:final error)) {
      setState(() {
        _saving = false;
        _errorCode = error.code;
      });
      return;
    }
    final AppResult<Transaction> result = await ref
        .read(withdrawalServiceProvider)
        .withdraw(
          vaultId: widget.vault.id,
          accountId: _accountId!,
          amount: (parsed as AppSuccess<Money>).value,
          reason: _reason.text,
        );
    if (!mounted) return;
    switch (result) {
      case AppSuccess<Transaction>():
        Navigator.of(context).pop();
      case AppError<Transaction>(:final error):
        setState(() {
          _saving = false;
          _errorCode = error.code;
        });
    }
  }
}

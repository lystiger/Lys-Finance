import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/app_result.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/money/money.dart';
import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_inputs.dart';
import '../../../../shared/widgets/app_surfaces.dart';
import '../../../settings/application/providers/settings_providers.dart';
import '../../application/providers/vault_providers.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_transfer.dart';
import '../vault_l10n.dart';

Future<void> showTransferDialog(BuildContext context, Vault vault) =>
    showAppBottomSheet<void>(context, child: _TransferSheet(vault: vault));

class _TransferSheet extends ConsumerStatefulWidget {
  const _TransferSheet({required this.vault});
  final Vault vault;

  @override
  ConsumerState<_TransferSheet> createState() => _TransferSheetState();
}

class _TransferSheetState extends ConsumerState<_TransferSheet> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _reason = TextEditingController();
  String? _destinationVaultId;
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
    final List<Vault> destinations =
        (ref.watch(activeVaultsProvider).value ?? <Vault>[])
            .where(
              (candidate) =>
                  candidate.id != widget.vault.id &&
                  candidate.currency == widget.vault.currency,
            )
            .toList(growable: false);
    final bool canSubmit =
        _destinationVaultId != null &&
        (!_locked || _reason.text.trim().isNotEmpty);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            l10n.transferBetweenVaults,
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
            key: const Key('transfer-destination'),
            initialValue: _destinationVaultId,
            decoration: InputDecoration(labelText: l10n.destinationVault),
            items: destinations
                .map(
                  (candidate) => DropdownMenuItem<String>(
                    value: candidate.id,
                    child: Text(vaultLabel(l10n, candidate)),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) => setState(() => _destinationVaultId = value),
          ),
          const SizedBox(height: 12),
          TextField(
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
    final AppResult<VaultTransfer> result = await ref
        .read(transferServiceProvider)
        .transfer(
          sourceVaultId: widget.vault.id,
          destinationVaultId: _destinationVaultId!,
          amount: (parsed as AppSuccess<Money>).value,
          reason: _reason.text,
        );
    if (!mounted) return;
    switch (result) {
      case AppSuccess<VaultTransfer>():
        Navigator.of(context).pop();
      case AppError<VaultTransfer>(:final error):
        setState(() {
          _saving = false;
          _errorCode = error.code;
        });
    }
  }
}

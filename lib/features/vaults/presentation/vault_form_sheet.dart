import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/app_result.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money.dart';
import '../../../features/settings/application/providers/settings_providers.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/app_inputs.dart';
import '../../../shared/widgets/app_surfaces.dart';
import '../application/providers/vault_providers.dart';
import '../application/services/vault_service.dart';
import '../domain/entities/vault.dart';
import 'vault_icons.dart';
import 'vault_l10n.dart';

Future<void> showVaultFormSheet(
  BuildContext context, {
  Vault? existing,
  int nextSortOrder = 0,
}) => showAppBottomSheet<void>(
  context,
  child: _VaultFormSheet(existing: existing, nextSortOrder: nextSortOrder),
);

class _VaultFormSheet extends ConsumerStatefulWidget {
  const _VaultFormSheet({this.existing, required this.nextSortOrder});
  final Vault? existing;
  final int nextSortOrder;

  @override
  ConsumerState<_VaultFormSheet> createState() => _VaultFormSheetState();
}

class _VaultFormSheetState extends ConsumerState<_VaultFormSheet> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _goalAmount;
  late Currency _currency;
  late String _iconKey;
  late String _colorToken;
  late VaultWithdrawalPolicy _withdrawalPolicy;
  DateTime? _targetDate;
  bool _saving = false;
  String? _errorCode;

  Vault? get _existing => widget.existing;

  @override
  void initState() {
    super.initState();
    final Vault? existing = _existing;
    _name = TextEditingController(text: existing?.name ?? '');
    _description = TextEditingController(text: existing?.description ?? '');
    _goalAmount = TextEditingController(
      text: existing?.goalAmount == null
          ? ''
          : (existing!.goalAmount!.minorUnits /
                    _scale(existing.goalAmount!.currency))
                .toString(),
    );
    _currency = existing?.currency ?? Currency.vnd;
    _iconKey = existing?.iconKey ?? VaultService.iconKeys.first;
    _colorToken = existing?.colorToken ?? VaultService.colorTokens.first;
    _withdrawalPolicy =
        existing?.withdrawalPolicy ?? VaultWithdrawalPolicy.soft;
    _targetDate = existing?.targetDate;
  }

  int _scale(Currency currency) {
    int value = 1;
    for (int index = 0; index < currency.minorUnitDigits; index += 1) {
      value *= 10;
    }
    return value;
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _goalAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String locale = Localizations.localeOf(context).languageCode;
    final bool isEditing = _existing != null;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            isEditing ? l10n.editVault : l10n.newVault,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('vault-form-name'),
            controller: _name,
            decoration: InputDecoration(labelText: l10n.vaultName),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _description,
            decoration: InputDecoration(labelText: l10n.optionalDescription),
          ),
          const SizedBox(height: 12),
          CurrencyInput(
            value: _currency,
            currencies: Currency.supported,
            label: l10n.currencies,
            onChanged: (value) {
              if (value != null) setState(() => _currency = value);
            },
          ),
          const SizedBox(height: 12),
          MoneyInput(
            controller: _goalAmount,
            currency: _currency,
            semanticLabel: l10n.optionalGoalAmount,
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_outlined),
            title: Text(l10n.optionalTargetDate),
            subtitle: _targetDate == null
                ? null
                : Text(
                    MaterialLocalizations.of(
                      context,
                    ).formatFullDate(_targetDate!.toLocal()),
                  ),
            trailing: _targetDate == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _targetDate = null),
                  ),
            onTap: () async {
              final DateTime? value = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3650)),
                initialDate: _targetDate?.toLocal() ?? DateTime.now(),
              );
              if (value != null) setState(() => _targetDate = value);
            },
          ),
          const SizedBox(height: 12),
          Text(
            l10n.withdrawalPolicy,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          SegmentedButton<VaultWithdrawalPolicy>(
            segments: VaultWithdrawalPolicy.values
                .map(
                  (value) => ButtonSegment<VaultWithdrawalPolicy>(
                    value: value,
                    label: Text(withdrawalPolicyLabel(l10n, value)),
                  ),
                )
                .toList(growable: false),
            selected: <VaultWithdrawalPolicy>{_withdrawalPolicy},
            onSelectionChanged: (value) =>
                setState(() => _withdrawalPolicy = value.single),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: const Key('vault-form-icon'),
            initialValue: _iconKey,
            decoration: const InputDecoration(labelText: 'Icon'),
            items: VaultService.iconKeys
                .map(
                  (key) => DropdownMenuItem<String>(
                    value: key,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(vaultIconFor(key)),
                        const SizedBox(width: 8),
                        Text(key),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) {
              if (value != null) setState(() => _iconKey = value);
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: const Key('vault-form-color'),
            initialValue: _colorToken,
            decoration: const InputDecoration(labelText: 'Color'),
            items: VaultService.colorTokens
                .map(
                  (token) => DropdownMenuItem<String>(
                    value: token,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: vaultColorFor(token),
                        ),
                        const SizedBox(width: 8),
                        Text(token),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) {
              if (value != null) setState(() => _colorToken = value);
            },
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
            onPressed: () => _submit(locale),
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
    Money? goalAmount;
    if (_goalAmount.text.trim().isNotEmpty) {
      final AppResult<Money> parsed = ref
          .read(moneyServiceProvider)
          .parse(_goalAmount.text, currency: _currency, locale: locale);
      if (parsed case AppError<Money>(:final error)) {
        setState(() {
          _saving = false;
          _errorCode = error.code;
        });
        return;
      }
      goalAmount = (parsed as AppSuccess<Money>).value;
    }
    final VaultService service = ref.read(vaultServiceProvider);
    final Vault? existing = _existing;
    final AppResult<Vault> result = existing == null
        ? await service.create(
            name: _name.text,
            iconKey: _iconKey,
            colorToken: _colorToken,
            currency: _currency,
            withdrawalPolicy: _withdrawalPolicy,
            sortOrder: widget.nextSortOrder,
            description: _description.text,
            goalAmount: goalAmount,
            targetDate: _targetDate,
          )
        : await service.update(
            original: existing,
            name: _name.text,
            description: _description.text,
            iconKey: _iconKey,
            colorToken: _colorToken,
            currency: _currency,
            goalAmount: goalAmount,
            clearGoalAmount: goalAmount == null,
            targetDate: _targetDate,
            clearTargetDate: _targetDate == null,
            withdrawalPolicy: _withdrawalPolicy,
          );
    if (!mounted) return;
    switch (result) {
      case AppSuccess<Vault>():
        Navigator.of(context).pop();
      case AppError<Vault>(:final error):
        setState(() {
          _saving = false;
          _errorCode = error.code;
        });
    }
  }
}

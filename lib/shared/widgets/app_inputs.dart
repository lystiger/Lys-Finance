import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/money/currency.dart';

class MoneyInput extends StatelessWidget {
  const MoneyInput({
    required this.controller,
    required this.currency,
    required this.semanticLabel,
    this.errorText,
    this.enabled = true,
    super.key,
  });
  final TextEditingController controller;
  final Currency currency;
  final String semanticLabel;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    enabled: enabled,
    keyboardType: TextInputType.numberWithOptions(
      decimal: currency.minorUnitDigits > 0,
    ),
    textInputAction: TextInputAction.next,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\-]')),
    ],
    decoration: InputDecoration(
      labelText: semanticLabel,
      errorText: errorText,
      suffixText: currency.code,
    ),
  );
}

class CurrencyInput extends StatelessWidget {
  const CurrencyInput({
    required this.value,
    required this.currencies,
    required this.label,
    required this.onChanged,
    super.key,
  });
  final Currency value;
  final List<Currency> currencies;
  final String label;
  final ValueChanged<Currency?> onChanged;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<Currency>(
    initialValue: value,
    decoration: InputDecoration(labelText: label),
    items: currencies
        .map(
          (Currency currency) => DropdownMenuItem<Currency>(
            value: currency,
            child: Text('${currency.code} · ${currency.englishName}'),
          ),
        )
        .toList(growable: false),
    onChanged: onChanged,
  );
}

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    required this.controller,
    required this.label,
    required this.onChanged,
    this.restorationId,
    super.key,
  });
  final TextEditingController controller;
  final String label;
  final ValueChanged<String> onChanged;
  final String? restorationId;

  @override
  Widget build(BuildContext context) => SearchBar(
    controller: controller,
    hintText: label,
    onChanged: onChanged,
    trailing: <Widget>[
      if (controller.text.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          onPressed: () {
            controller.clear();
            onChanged('');
          },
          icon: const Icon(Icons.clear),
        ),
    ],
  );
}

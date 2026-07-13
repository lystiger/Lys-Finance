import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/shared/widgets/app_buttons.dart';
import 'package:lys_finance/shared/widgets/app_chips.dart';
import 'package:lys_finance/shared/widgets/app_inputs.dart';
import 'package:lys_finance/shared/widgets/app_states.dart';
import 'package:lys_finance/shared/widgets/app_surfaces.dart';

void main() {
  testWidgets('shared controls remain usable at 200% text scale', (
    WidgetTester tester,
  ) async {
    final TextEditingController amount = TextEditingController();
    final TextEditingController search = TextEditingController(text: 'cash');
    addTearDown(amount.dispose);
    addTearDown(search.dispose);
    int presses = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SectionHeader(
                    title: 'Accounts',
                    description: 'Your money locations',
                  ),
                  MoneyInput(
                    controller: amount,
                    currency: Currency.usd,
                    semanticLabel: 'Amount',
                  ),
                  AppSearchBar(
                    controller: search,
                    label: 'Search',
                    onChanged: (_) {},
                  ),
                  CategoryChip(
                    label: 'Food',
                    icon: Icons.restaurant,
                    color: Colors.orange,
                    selected: true,
                    semanticClass: 'Necessity',
                    onSelected: (_) {},
                  ),
                  AppFilterChip(
                    label: 'Expense',
                    count: 3,
                    selected: true,
                    onSelected: (_) {},
                  ),
                  AppCard(child: const Text('Card content'), onTap: () {}),
                  PrimaryButton(
                    label: 'Continue',
                    onPressed: () => presses += 1,
                  ),
                  SecondaryButton(label: 'Cancel', onPressed: () {}),
                  AppIconButton(
                    icon: Icons.edit,
                    tooltip: 'Edit account',
                    onPressed: () {},
                  ),
                  const EmptyState(
                    icon: Icons.inbox_outlined,
                    title: 'Nothing here',
                    message: 'Add an item later.',
                  ),
                  const LoadingCard(label: 'Loading accounts'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Continue'));
    expect(presses, 1);
    expect(find.byTooltip('Edit account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('loading primary action cannot invoke twice', (
    WidgetTester tester,
  ) async {
    int presses = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: PrimaryButton(
          label: 'Save',
          loading: true,
          onPressed: () => presses += 1,
        ),
      ),
    );
    await tester.tap(find.byType(PrimaryButton));
    expect(presses, 0);
  });
}

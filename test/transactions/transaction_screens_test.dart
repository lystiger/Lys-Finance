import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/app/app.dart';
import 'package:lys_finance/app/router/app_router.dart';
import 'package:lys_finance/features/settings/application/providers/settings_providers.dart';
import 'package:lys_finance/features/settings/domain/entities/account.dart';
import 'package:lys_finance/features/settings/domain/entities/category.dart';
import 'package:lys_finance/features/transactions/application/providers/transaction_providers.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction_filter.dart';

void main() {
  testWidgets('empty ledger is usable in dark mode at 200% text scale', (
    WidgetTester tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final router = createAppRouter(initialLocation: '/ledger');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeAccountsProvider.overrideWith(
            (ref) => Stream.value(const <Account>[]),
          ),
          activeCategoriesProvider().overrideWith(
            (ref) => Stream.value(const <Category>[]),
          ),
          ledgerStreamProvider.overrideWith(
            (ref) =>
                Stream.value(const LedgerPage(items: [], nextCursor: null)),
          ),
        ],
        child: LysFinanceApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Transactions'), findsOneWidget);
    expect(find.text('No transactions yet'), findsOneWidget);
    expect(find.byKey(const Key('ledger-add')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

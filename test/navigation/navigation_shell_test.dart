import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/app/app.dart';
import 'package:lys_finance/app/router/app_router.dart';
import 'package:lys_finance/features/settings/application/providers/settings_providers.dart';
import 'package:lys_finance/features/settings/domain/entities/account.dart';
import 'package:lys_finance/features/settings/domain/entities/category.dart';
import 'package:lys_finance/features/vaults/application/providers/vault_providers.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault.dart';

void main() {
  testWidgets('shell navigates to every Sprint 00 destination', (
    WidgetTester tester,
  ) async {
    final router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeAccountsProvider.overrideWith(
            (ref) => Stream.value(const <Account>[]),
          ),
          activeVaultsProvider.overrideWith(
            (ref) => Stream.value(const <Vault>[]),
          ),
        ],
        child: LysFinanceApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    for (final String destination in <String>[
      'Vaults',
      'Insights',
      'Assistant',
      'Home',
    ]) {
      await tester.tap(find.text(destination).last);
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, destination), findsOneWidget);
    }
  });

  testWidgets('Quick Add and Settings placeholders are reachable', (
    WidgetTester tester,
  ) async {
    final router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeAccountsProvider.overrideWith(
            (ref) => Stream.value(const <Account>[]),
          ),
          activeCategoriesProvider(
            type: null,
          ).overrideWith((ref) => Stream.value(const <Category>[])),
        ],
        child: LysFinanceApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('quick-add-action')));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Quick Add'), findsOneWidget);

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-action')));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);
  });

  testWidgets('Settings exposes every structured foundation route', (
    WidgetTester tester,
  ) async {
    final router = createAppRouter(initialLocation: '/settings');
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(child: LysFinanceApp(router: router)),
    );
    await tester.pumpAndSettle();

    for (final String destination in <String>[
      'Accounts',
      'Categories',
      'Currencies',
      'Appearance',
      'Notifications',
      'Backup & export',
    ]) {
      await tester.tap(find.text(destination));
      await tester.pumpAndSettle();
      expect(find.text('Foundation ready'), findsOneWidget);
      router.pop();
      await tester.pumpAndSettle();
    }
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/app/app.dart';
import 'package:lys_finance/app/router/app_router.dart';
import 'package:lys_finance/app/router/app_routes.dart';
import 'package:lys_finance/features/vaults/application/providers/vault_providers.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault.dart';

void main() {
  testWidgets('empty vaults screen offers a way to create the first vault', (
    WidgetTester tester,
  ) async {
    final router = createAppRouter(initialLocation: AppRoutes.vaults);
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeVaultsProvider.overrideWith(
            (ref) => Stream.value(const <Vault>[]),
          ),
        ],
        child: LysFinanceApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Vaults'), findsOneWidget);
    expect(find.text('No vaults yet'), findsOneWidget);
    expect(find.byKey(const Key('new-vault-action')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('new vault sheet opens with the expected fields', (
    WidgetTester tester,
  ) async {
    final router = createAppRouter(initialLocation: AppRoutes.vaults);
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeVaultsProvider.overrideWith(
            (ref) => Stream.value(const <Vault>[]),
          ),
        ],
        child: LysFinanceApp(router: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('new-vault-action')));
    await tester.pumpAndSettle();

    expect(find.text('New vault'), findsOneWidget);
    expect(find.byKey(const Key('vault-form-name')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

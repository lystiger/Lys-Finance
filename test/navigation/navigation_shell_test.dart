import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/app/app.dart';
import 'package:lys_finance/app/router/app_router.dart';

void main() {
  testWidgets('shell navigates to every Sprint 00 destination', (
    WidgetTester tester,
  ) async {
    final router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(LysFinanceApp(router: router));
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
    await tester.pumpWidget(LysFinanceApp(router: router));
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
}

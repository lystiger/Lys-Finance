import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lys_finance/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('creates, opens, deletes, and restores an expense', (
    WidgetTester tester,
  ) async {
    await app.main();
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.byKey(const Key('quick-add-action')), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('quick-add-action')));
    await tester.pumpAndSettle();
    for (final String digit in <String>['4', '3', '2', '1', '0']) {
      await tester.tap(find.text(digit).first);
      await tester.pump();
    }
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Transactions').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('43,210'), findsWidgets);

    await tester.tap(find.textContaining('43,210').last);
    await tester.pumpAndSettle();
    expect(find.text('Transaction details'), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();
    expect(find.text('Undo'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

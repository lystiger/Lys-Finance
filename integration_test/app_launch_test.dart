import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lys_finance/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('launches the navigation shell', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.byKey(const Key('quick-add-action')), findsOneWidget);
  });
}

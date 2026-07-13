import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/app/app.dart';
import 'package:lys_finance/app/router/app_router.dart';

void main() {
  testWidgets('application starts on the Home destination', (
    WidgetTester tester,
  ) async {
    final router = createAppRouter();
    addTearDown(router.dispose);

    await tester.pumpWidget(LysFinanceApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('The foundation is ready.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

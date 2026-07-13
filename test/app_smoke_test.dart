import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/app/app.dart';
import 'package:lys_finance/app/router/app_router.dart';
import 'package:lys_finance/features/settings/application/providers/settings_providers.dart';
import 'package:lys_finance/features/settings/domain/entities/account.dart';

void main() {
  testWidgets('application starts on the Home destination', (
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
        ],
        child: LysFinanceApp(router: router),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Transactions'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

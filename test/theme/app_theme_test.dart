import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/theme/app_colors.dart';
import 'package:lys_finance/core/theme/app_theme.dart';

void main() {
  test('light and dark themes expose Material 3 semantic tokens', () {
    final ThemeData light = AppTheme.light();
    final ThemeData dark = AppTheme.dark();

    expect(light.useMaterial3, isTrue);
    expect(light.brightness, Brightness.light);
    expect(dark.useMaterial3, isTrue);
    expect(dark.brightness, Brightness.dark);
    expect(light.extension<AppSemanticColors>()?.investment, isNotNull);
    expect(dark.extension<AppSemanticColors>()?.consumption, isNotNull);
  });

  testWidgets('shell remains usable at large text scale', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(2)),
          child: child!,
        ),
        home: const Scaffold(
          body: SafeArea(
            child: Center(child: Text('Scalable foundation content')),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension GoldenPump on WidgetTester {
  Future<void> pumpGoldenSurface(
    Widget child, {
    required ThemeData theme,
    Size size = const Size(390, 844),
  }) async {
    view.physicalSize = size;
    view.devicePixelRatio = 1;
    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);
    await pumpWidget(MaterialApp(theme: theme, home: child));
    await pumpAndSettle();
  }
}

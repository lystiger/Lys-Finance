import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/providers/foundation_providers.dart';
import 'package:lys_finance/core/time/app_clock.dart';

void main() {
  test('foundation dependencies can be overridden in tests', () {
    final DateTime instant = DateTime.utc(2026, 7, 13);
    final ProviderContainer container = ProviderContainer(
      overrides: [appClockProvider.overrideWithValue(FixedAppClock(instant))],
    );
    addTearDown(container.dispose);

    expect(container.read(appClockProvider).now(), instant);
  });
}

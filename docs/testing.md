# Testing

Tests mirror production ownership under `test/`:

- Unit tests cover pure formatting, domain rules, and application behavior.
- Provider tests use `ProviderContainer` overrides; no platform singleton is
  required to test application code.
- Database tests use `NativeDatabase.memory()` and must cover initialization and
  every future migration.
- Sprint 02 repository tests cover exact balance derivation, filtering/search,
  keyset ordering, optimistic conflicts, soft delete, and restore. A generated
  10,000-row database test enforces the documented ledger, search, balance, and
  local-write budgets.

The final Sprint 02 local gate on 2026-07-13 measured 105 ms for the first
ledger page, 38 ms for search, 26 ms for account balance, and 17 ms for a local
save with 10,000 rows present. These figures are test-environment evidence, not
production telemetry.
- Widget tests cover smoke startup, routing, accessibility/text scale, and both
  themes.
- Golden tests use the fixed viewport helper in `test/helpers/golden.dart`.
  Baselines are reviewed UI artifacts, not automatic snapshots.
- Device flows live under `integration_test/` and run separately from unit/widget
  tests when an emulator or physical device is available.

Run locally:

```sh
fvm flutter test
fvm flutter test --coverage
fvm flutter test integration_test -d <device-id>
```

Prefer fakes and provider overrides over mocks. Mock only an external boundary
whose interaction itself matters. Tests should describe behavior and catch a
credible regression; coverage percentage is not a reason to add meaningless
assertions.

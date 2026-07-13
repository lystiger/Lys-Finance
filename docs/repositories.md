# Repository contracts

Domain repository interfaces never expose Drift rows. Drift implementations map
rows explicitly and return `AppResult` values with safe failures for duplicates,
missing records, storage errors, and optimistic-version conflicts.

- `AccountRepository` watches ordered active accounts and supports fetch, create,
  versioned update, duplicate detection, and soft deletion.
- `CategoryRepository` provides the same lifecycle with type/INC filters and
  localized seed metadata.
- `SettingsRepository` owns the singleton preferences record and atomic repair.
- `CurrencyRepository` exposes the immutable VND/USD catalog; it performs no
  network or exchange-rate work.

Application services validate commands and orchestrate repositories. Riverpod
providers compose concrete dependencies and remain replaceable in tests.

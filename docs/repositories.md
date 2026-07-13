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
- `TransactionRepository` provides versioned create/update/delete/restore,
  reactive detail and ledger reads, stable keyset pagination over occurrence,
  creation time, and ID, composable filters/search, and exact derived account
  balances. Deleted rows are excluded by default and remain available through
  the Recently Deleted surface.

- `VaultRepository` mirrors `AccountRepository`: watches the ordered active
  vault list, fetch/create/versioned-update/archive/restore, plus a derived
  `getBalance`/`watchBalance` composed from contribution/withdrawal
  transactions and vault transfers.
- `VaultTransferRepository` creates a transfer atomically (validating both
  vaults' currency and the source balance inside one Drift transaction) and
  reads/streams a vault's transfer history.
- `VaultHistoryRepository` appends lifecycle events idempotently and
  reads/streams them; it never stores contributions, withdrawals, or
  transfers, which already live in `TransactionRepository` and
  `VaultTransferRepository`. No separate `GoalRepository` exists — goal
  fields live on `Vault` itself.

Application services validate commands and orchestrate repositories. Riverpod
providers compose concrete dependencies and remain replaceable in tests.

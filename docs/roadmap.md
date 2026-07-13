# Engineering roadmap

## Sprint 00 — Foundation and bootstrap

Pinned mobile toolchain, Android/iOS targets, Material 3 design system, localized
navigation shell, Riverpod DI, empty Drift schema, infrastructure boundaries,
error handling, tests, CI, and contributor documentation.

## Sprint 01 — Foundation completion

Exact money, currencies, accounts, categories, settings, schema v2, validation,
repositories, and shared product-ready interaction patterns are complete.

## Sprint 02 — Transaction engine

Complete on `feat/sprint-02-transaction-engine`: schema v3, offline expense and
income capture, ledger/search/filters, transaction lifecycle, recently deleted,
derived balances, localization, accessibility, and 10,000-row performance
coverage.

## Sprint 03 — Vault Engine

Complete on `feat/sprint-03-vault-engine`: schema v4, purpose-driven savings
vaults (create/edit/archive/restore), contributions and withdrawals (reusing
the `Transaction` type Sprint 02 reserved), vault-to-vault transfers, goal
tracking (progress, monthly pace, ETA, Goal Health), a merged vault history
timeline, eight seeded starter vaults, and a Home "Active Vaults" preview.

## Later sprints

Budgets, insights, user-facing notifications, and assistant behavior remain
governed by their sprint documents and require focused ADRs where decisions
are not already accepted. Authentication, cloud sync, backend APIs, OCR, and
market integrations remain future work. Offline local data stays the source
of truth throughout.

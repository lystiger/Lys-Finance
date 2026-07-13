# ADR-003: Use Drift (over SQLite) as the local persistence layer

**Status:** Accepted
**Date:** 2026-07-13
**Related:** [01-product-design.md](../01-product-design.md), [02-engineering-architecture.md](../02-engineering-architecture.md), ADR-004

## Context

The app is offline-first (ADR-004): all data — transactions, vaults, budgets,
subscriptions — must be queryable locally, with sync-ready fields (`user_id`,
etc.) reserved for a future cloud-sync layer. The engineering architecture
document calls for typed DAOs, migrations, indexes, and transactions as
first-class concerns, not hand-rolled SQL.

## Decision

Use Drift on top of SQLite as the local database layer, accessed exclusively
through a repository layer (never directly from Presentation/Application code).

## Consequences

- Compile-time-checked queries and typed DAOs reduce SQL bugs vs. raw `sqflite`.
- Schema migrations are explicit and versioned, which matters once real user data exists on-device.
- Drift's stream queries (`watch()`) give reactive UI updates for free, pairing naturally with Riverpod's `StreamProvider` (ADR-002).
- Adds a code-generation step (`build_runner`) to the dev workflow.

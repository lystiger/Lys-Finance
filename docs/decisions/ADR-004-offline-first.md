# ADR-004: Offline-first — cloud is a mirror, never a dependency

**Status:** Accepted
**Date:** 2026-07-13
**Related:** [01-product-design.md](../01-product-design.md) (Assumption A3), ADR-003

## Context

From the product design doc: *"The app is fully usable with no network. Cloud is
an optional mirror, never a dependency... Logging must be instant and always
available. Finance anxiety often comes from friction; friction here is fatal."*
Expense logging is the app's core, highest-frequency action, and it must never
block on network availability.

## Decision

All reads and writes go to the local database first (Drift/SQLite, ADR-003) and
succeed independent of connectivity. Cloud sync, when it exists, is an
additive, asynchronous mirror layered on top — never a blocking dependency for
any core flow.

## Consequences

- Every entity carries sync-ready fields (`user_id`, etc.) from v1 so a future sync layer doesn't require a schema rewrite.
- No feature may gate its primary action (e.g. logging a transaction) on network state.
- Conflict resolution and multi-device sync are deferred to a future ADR when cloud sync is actually built.
- Local storage becomes the permanent source of truth, raising the bar on backup/export tooling (see engineering architecture doc, §12 Security and §6 Database Design Rules).

# Architecture

Lys Finance uses feature-first Clean Architecture with Riverpod as dependency
injection and Drift/SQLite as the offline source of truth. Cloud services are not
part of Sprint 00 and may never block a local operation.

## Top-level structure

- `lib/app`: composition root, routing, shell, and bootstrap behavior.
- `lib/core`: cross-cutting technical capabilities such as configuration,
  database, errors, localization, logging, providers, storage, and theme.
- `lib/features`: independently owned product slices. Sprint 00 contains only
  presentation placeholders.
- `lib/shared`: reusable UI with no feature ownership.

Do not create empty layers. Add `presentation`, `application`, `domain`, and
`data` inside a feature only when that feature has real responsibilities.

## Dependency direction

```text
presentation -> application -> domain
                         ^         ^
                         |         |
                         +------ data -> core infrastructure
```

- Presentation renders state and sends user intent; it contains no persistence.
- Application orchestrates use cases and owns Riverpod notifiers/providers.
- Domain contains immutable rules, entities, failures, and repository contracts;
  it imports neither Flutter nor Drift.
- Data implements domain contracts with Drift models/DAOs and maps failures.
- Core exposes narrow infrastructure boundaries. Features may depend on core;
  core never depends on features.

Cross-feature imports are prohibited. Shared behavior moves to `shared` only when
at least two concrete consumers exist. Presentation and application code never
access Drift directly. A feature's data implementation is injected into its
domain repository contract through Riverpod.

## State and lifecycle

Riverpod is the sole state/DI framework. Generated providers use descriptive
lower-camel names and live beside the layer they compose. Use `Provider` for
dependencies/derived synchronous values, `Notifier` for synchronous mutable UI
state, and `AsyncNotifier` or stream/future providers for asynchronous work.
Auto-dispose screen-scoped state; explicitly keep infrastructure providers alive.
All dependencies must remain overridable in tests. Global mutable singletons are
not allowed.

The database provider owns `AppDatabase` and closes it when its container is
disposed. Schema version 1 has no business tables. Every future schema change
must increment the version, add a tested forward migration, and preserve local
data. Downgrades fail explicitly.

## Errors, privacy, and configuration

Framework, platform-async, zoned-async, and Riverpod failures are captured by the
composition root and emitted as event names. Logs must never contain amounts,
account identifiers, notes, tokens, secrets, or raw financial records. Typed
`AppFailure` values carry user-safe messages; unexpected widgets render a calm
fallback screen.

`AppConfig` is immutable and JSON-serializable for deterministic flavor/tooling
inputs. Secrets are not configuration values. Secure values go through the
`SecureStorage` boundary. Notifications have an initialization-only boundary in
Sprint 00; no user-facing financial notification is scheduled.

See ADR-001 through ADR-004 for accepted framework, state, persistence, and
offline-first decisions.

## Temporary Freezed compatibility constraint

Sprint 00 pins `freezed` 3.2.6-dev.1 intentionally. The current stable
`riverpod_generator` 4.0.4 requires analyzer 12, while stable `freezed` 3.2.3
requires analyzer below 9 and therefore cannot resolve alongside the current
Riverpod generator and `json_serializable` 6.14.0. Freezed 3.2.6-dev.1 is the
available analyzer-12-compatible release selected by Pub and is used only for
the immutable `AppConfig` model. Replace it with the next stable Freezed release
that supports analyzer 12 or later; do not broaden this prerelease dependency to
business models in the meantime.

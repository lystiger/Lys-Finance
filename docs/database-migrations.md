# Database migrations

The Drift database is forward-only. Schema version 1 is empty; version 2 creates
only `accounts`, `categories`, `app_settings_entries`, and
`app_metadata_entries`, plus their documented indexes and checks. Version 3 is
additive: it creates `transactions`, ledger/balance/filter indexes, and the
version-2 income category seed set. It does not rewrite foundation rows.

Opening a database runs migrations transactionally, enables foreign keys, and
applies stable seed identities with `insertOrIgnore`. Seed labels are localization
keys, so changing locale never rewrites persisted translated text. Reopening or
rerunning initialization must not duplicate seeds or settings.

Migration tests simulate a real schema-version-2 SQLite file with populated
foundation rows, open it with the current application database, compare those
rows, close it, reopen it, and prove idempotency. Foreign keys are enabled on
every open and downgrades are rejected.

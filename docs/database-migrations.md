# Database migrations

The Drift database is forward-only. Schema version 1 is empty; version 2 creates
only `accounts`, `categories`, `app_settings_entries`, and
`app_metadata_entries`, plus their documented indexes and checks.

Opening a database runs migrations transactionally, enables foreign keys, and
applies stable seed identities with `insertOrIgnore`. Seed labels are localization
keys, so changing locale never rewrites persisted translated text. Reopening or
rerunning initialization must not duplicate seeds or settings.

Migration tests create a physical schema-version-1 SQLite file, open it with the
current application database, inspect the results, close it, reopen it, and prove
idempotency. Downgrades are rejected.

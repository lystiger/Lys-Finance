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

Version 4 is additive plus one widening: it creates `vaults`, `vault_transfers`,
and `vault_history`, seeds eight starter vaults, and recreates the
`transactions` table under its current (wider) definition — `category_id`
becomes nullable and a nullable `vault_id` is added, with a table-level check
that a row has exactly one of them depending on its `type`. SQLite cannot
alter a column's nullability in place, so the migration renames the existing
table, creates the new one, copies every row across unchanged (`vault_id`
defaults to `NULL`), drops the renamed table, and re-creates all indexes. This
only runs when a database already has the narrower version-3 table; a fresh
install creates the final schema directly. The migration test suite builds a
real version-3 file with a populated transaction row, opens it with version-4
code, and confirms the row survives unchanged with `vault_id` null, the eight
seed vaults exist exactly once, and reopening is idempotent.

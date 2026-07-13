# Domain model

Sprint 01 implements immutable `Money`, `Currency`, `Account`, `Category`, and
`AppSettings` values. Money always uses signed 64-bit integer minor units: VND
has zero fraction digits and USD has two. Arithmetic is same-currency only and
returns typed failures for mismatch, overflow, or invalid allocation.

Accounts represent real locations of money, while categories classify future
ledger entries. Seed labels are stored as stable localization keys and resolved
from ARB resources. Records use UTC audit timestamps, optimistic versions, and
soft deletion. Transaction, budget, vault, notification, AI, sync, and exchange
rate models remain explicitly outside this sprint.

The normative field rules and examples live in
[Sprint 01](04-sprint-01-foundation.md).

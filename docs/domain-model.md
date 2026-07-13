# Domain model

The implemented model includes immutable `Money`, `Currency`, `Account`,
`Category`, `AppSettings`, `Transaction`, `TransactionDraft`, and
`TransactionFilter` values. Money always uses signed 64-bit integer minor units: VND
has zero fraction digits and USD has two. Arithmetic is same-currency only and
returns typed failures for mismatch, overflow, or invalid allocation.

Accounts represent real locations of money, while categories classify ledger
entries. Transactions publicly support expense and income only. Each references
one active account and category, uses the account currency, stores a positive
minor-unit amount, and carries UTC audit timestamps and an optimistic version.
Expense transactions require exactly one INC classification; income
transactions cannot carry one. Seed labels are stored as stable localization keys and resolved
from ARB resources. Records use UTC audit timestamps, optimistic versions, and
soft deletion. Account balance is derived as opening balance plus active income
minus active expense, including future-dated rows. Transfer, contribution, and
withdrawal values are storage reservations only and have no creation workflow.
Budget, vault, notification, AI, sync, recurring-payment, and exchange-rate
models remain outside Sprint 02.

The normative field rules and examples live in
[Sprint 02](05-sprint-02-transactions.md).

Sprint 03 adds `Vault` and `VaultTransfer`. A vault is a virtual earmark
against real account money, never a separate wallet: contributing or
withdrawing is a `Transaction` (reusing the `contribution`/`withdrawal`
enum values Sprint 02 reserved) with a `vaultId` instead of a `categoryId`,
so it appears in the ledger's data model without affecting derived account
balance. Vault-to-vault transfers move no real cash and live in their own
append-only `VaultTransfer` table. A vault's own balance, goal progress,
monthly pace, ETA, and goal health are all derived reads, never stored,
matching Sprint 02's account-balance discipline. `VaultHistoryEvent` records
only lifecycle facts with no other home (created, edited, archived, restored,
milestone reached, goal completed, goal reopened); contributions,
withdrawals, and transfers are read from their own tables and merged into one
timeline at the application layer. The normative field rules live in
[Sprint 03](06-sprint-03-vaults.md).

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

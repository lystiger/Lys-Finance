# Validation

Validation is deterministic and UI-independent. It returns normalized values or
stable codes; presentation localizes those codes. Names are Unicode-trimmed,
whitespace-collapsed, limited by grapheme clusters, and reject control or line
separator characters. Vietnamese text and emoji are valid.

Currency input is normalized to three uppercase ASCII letters and checked
against the catalog. Money parsing uses explicit locale separators and currency
precision without `double`; excessive precision and signed-64-bit overflow are
rejected. Duplicate names use the same normalized key in services, repositories,
and partial unique indexes to protect against races.

Transactions additionally require a positive amount, an active account and
category, exact account-currency equality, category/type compatibility, and the
expense/income INC pairing rule. Notes are trimmed and limited to 2,000 grapheme
clusters. Presentation maps stable failure codes to localized English and
Vietnamese messages; no validation message is persisted.

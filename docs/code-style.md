# Code style

Use the analyzer rules in `analysis_options.yaml` and format with `fvm dart
format .`. Files and directories are `snake_case`; types are `UpperCamelCase`;
members, providers, and parameters are `lowerCamelCase`; compile-time constants
use `lowerCamelCase` per Dart conventions.

- Prefer small immutable widgets and `const` constructors.
- Name providers after the value they expose (`appClockProvider`), not their type.
- Suffix contracts with their capability (`SecureStorage`, `UuidGenerator`) and
  concrete platform adapters with an implementation qualifier.
- Keep one public primary type per file when practical.
- Use explicit return types and final locals.
- Comments explain constraints or intent, not syntax. Public APIs that are not
  self-explanatory require DartDoc.
- Do not use `print`, dynamic maps beyond serialization boundaries, global mutable
  state, force unwraps without proof, or swallowed errors.
- Do not write secrets, personal data, or financial values to logs, fixtures,
  screenshots, or golden files.

Code generation is committed and deterministic. Modify the annotated source,
run build_runner, review the generated diff, and never hand-edit generated files.

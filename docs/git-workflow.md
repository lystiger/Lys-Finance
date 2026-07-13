# Git workflow

`main` is protected and releasable. Branch from an up-to-date `main` using:

- `feat/<scope>` for user-visible capabilities
- `fix/<scope>` for corrections
- `chore/<scope>` for infrastructure and maintenance
- `docs/<scope>` for documentation-only changes

Use Conventional Commit subjects such as `chore: bootstrap Flutter targets` or
`test: cover navigation shell`. Keep commits independently understandable and do
not mix formatting or unrelated cleanup into feature commits.

Open a draft pull request early. The PR must explain scope, impact, verification,
screenshots for visible work, migration/security risk, and deferred work. Require
green CI and review before marking ready. Squash merge is preferred; releases use
Semantic Versioning tags (`vMAJOR.MINOR.PATCH`). Never merge your own draft or
force-push shared branches without coordination.

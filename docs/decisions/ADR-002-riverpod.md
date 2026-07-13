# ADR-002: Use Riverpod for state management

**Status:** Accepted
**Date:** 2026-07-13
**Related:** [02-engineering-architecture.md](../02-engineering-architecture.md)

## Context

The engineering architecture document specifies Feature-First, Clean Architecture
with a strict Presentation → Application → Domain → Data dependency graph and no
circular dependencies. State management needs compile-safe dependency injection,
first-class async (`FutureProvider`/`StreamProvider`) support for repository and
database reads, and `autoDispose`/family providers to keep feature modules
independent of each other.

## Decision

Use Riverpod as the sole state management and dependency-injection mechanism
across the app.

## Consequences

- Compile-time safety for provider access removes an entire class of runtime DI errors.
- `AsyncNotifier`/`FutureProvider`/`StreamProvider` map cleanly onto repository-layer calls into Drift (ADR-003).
- One state-management paradigm across all features simplifies onboarding and code review — no mixing with Provider/Bloc/GetX.
- Team commits to Riverpod's upgrade path and codegen tooling.

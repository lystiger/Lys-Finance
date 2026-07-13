# ADR-001: Use Flutter as the client framework

**Status:** Accepted
**Date:** 2026-07-13
**Related:** [01-product-design.md](../01-product-design.md), [02-engineering-architecture.md](../02-engineering-architecture.md)

## Context

Lys Finance targets iOS and Android from a single codebase, with an offline-first
requirement (see ADR-004) and no dedicated native mobile teams. The product needs
fast iteration speed, a rich widget/animation system for a "calm, premium" UI
(per the design philosophy in the product doc), and a realistic path to desktop/web
later without a rewrite.

## Decision

Build the client in Flutter (Dart), targeting iOS and Android in v1.

## Consequences

- Single codebase and single engineer can ship both platforms.
- Access to mature local-storage/offline tooling in the Dart ecosystem (Drift, see ADR-003).
- Desktop and web are plausible future targets on the same codebase (see "Future Scalability" in the engineering architecture doc), without committing to them now.
- Ties the team to Dart's package ecosystem and Flutter's release cadence.

# Golden tests

Golden baselines live in this directory and are reviewed as UI artifacts. Use
`pumpGoldenSurface` from `test/helpers/golden.dart`, keep the fixed logical
viewport, and regenerate intentionally with `flutter test --update-goldens`.
Sprint 00 establishes the harness without committing platform-sensitive text
baselines.

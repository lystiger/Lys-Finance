# Contributing

Read the architecture, code style, testing, and git workflow guides before making
changes. Install the FVM-pinned SDK and create a scoped branch from `main`.

Before opening or updating a pull request, run:

```sh
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm dart format --output=none --set-exit-if-changed .
fvm flutter analyze
fvm flutter test
fvm flutter build apk --debug
```

Commit generated Dart sources and `pubspec.lock`. Do not commit `.env` files,
keystores, certificates, provisioning profiles, exported databases, screenshots
with private data, or local SDK artifacts. New dependencies require a current
Sprint consumer and a rationale in the PR. New persistence changes require a
schema-version increment and migration test.

Use the pull-request template, keep the PR in draft until CI is green, and never
merge a draft PR.

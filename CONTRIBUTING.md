# Contributing

Thanks for your interest in Flutter MapLibre! Bug reports, ideas,
documentation and code are all welcome.

## Before you start

- Search the [issues](https://github.com/josxha/flutter-maplibre/issues) and
  [pull requests](https://github.com/josxha/flutter-maplibre/pulls) to check
  that your bug or idea isn't covered yet. Planned work is tracked in issues.
- For a larger feature or a breaking change, open an issue first so we can
  agree on the design before you spend time on it.
- Make sure the feature can be built on both
  [MapLibre Native](https://github.com/maplibre/maplibre-native) (through
  [maplibre-native-ffi](https://github.com/maplibre/maplibre-native-ffi)) and
  [MapLibre GL JS](https://github.com/maplibre/maplibre-gl-js).
- If you're unsure whether a bug comes from this package, try to reproduce it
  with the [example app](examples).

## Repository layout

The repository is a [pub workspace](https://dart.dev/tools/pub/workspaces):

| Path                                   | Content                                                     |
|----------------------------------------|-------------------------------------------------------------|
| `packages/maplibre`                    | The app-facing package                                      |
| `packages/maplibre_platform_interface` | Shared API, style classes and gesture recognizer            |
| `packages/maplibre_native`             | Every platform except web, on the MapLibre Native C API     |
| `packages/maplibre_web`                | Web, on MapLibre GL JS                                      |
| `packages/maplibre_geolocator`         | Adapter from `geolocator` to `UserLocationLayer`            |
| `examples`                             | Example app and integration tests (`examples/integration_test`) |
| `website`                              | Documentation website                                       |

[Architecture](https://flutter-maplibre.pages.dev/docs/contributing/architecture/)
explains how the packages fit together, and [AGENTS.md](AGENTS.md) lists the
code generation commands and the rules of the code base.

## Development

You need Flutter 3.47 or newer. One `flutter pub get` in the repository root
resolves every package:

```bash
flutter pub get
cd examples
flutter run -d windows   # or macos, linux, chrome, an iOS simulator or an Android device
```

Before you open a pull request:

```bash
dart format .
dart analyze --fatal-warnings --fatal-infos
flutter test                                                # inside the package you changed
cd examples && flutter test integration_test/all_test.dart -d <device>
```

Optionally, install [pre-commit](https://pre-commit.com/) and run
`pre-commit install` to run the formatting and analysis checks on every commit.

## Pull requests

1. [Fork the repository](https://github.com/josxha/flutter-maplibre/fork) and
   work on a new branch.
2. Add tests. Prefer unit tests (shared logic belongs in
   `packages/maplibre_platform_interface/test`); add an integration test in
   `examples/integration_test` when the behavior depends on a platform.
3. Showcase new features in the example app and document them on the
   [website](website/docs).
4. Add user-facing changes to
   [packages/maplibre/CHANGELOG.md](packages/maplibre/CHANGELOG.md), with one
   short bullet per feature or breaking change.
5. Give your pull request a [conventional](https://www.conventionalcommits.org/)
   title and list the important changes and any linked issues. Open it as a
   draft if you'd like early feedback. Pull requests are squash merged, so the
   title and description become the commit message.

## Use of AI

If you use AI tools to write code, tests, documentation, issues or pull
request descriptions, disclose it in your contribution. You are responsible
for every change you submit and must understand it. Follow the
[MapLibre AI policy](https://github.com/maplibre/maplibre/blob/main/AI_POLICY.md).

## Building the MapLibre Native C library locally

`maplibre_native` uses the MapLibre Native C API through
[maplibre_native_ffi](https://pub.dev/packages/maplibre_native_ffi), whose
build hook downloads a prebuilt library for each target. You only need a local
build to work on the C library itself.

Clone [maplibre-native-ffi](https://github.com/maplibre/maplibre-native-ffi)
at the release tag the pubspec resolves to, build the presets you need as its
development docs describe, and name the build root in the root
`pubspec.yaml`. The hook then takes `<preset>/install` under it for each
target:

```yaml
hooks:
  user_defines:
    maplibre_native_ffi:
      local_build: ../maplibre-native-ffi/build
```

Remove the setting to go back to the prebuilt library.

## Community

Chat with us in the `#flutter-maplibre` channel of the
[OSM-US Slack](https://slack.openstreetmap.us). Everyone taking part is
expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

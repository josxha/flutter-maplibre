---
title: 'Local development'
icon: lucide/wrench
---

# Local development

This page explains how to work on the packages themselves. To use the
packages in your app, read [Installation](../getting-started/setup.md).

## Get started

The repository is a [pub workspace](https://dart.dev/tools/pub/workspaces),
so one `flutter pub get` in its root resolves every package. You need Flutter
3.47 or newer:

```bash
git clone https://github.com/josxha/flutter-maplibre
cd flutter-maplibre
flutter pub get
cd examples
flutter run -d windows   # or macos, linux, chrome, an iOS simulator or an Android device
```

| Path                                    | Content                                                |
|-----------------------------------------|--------------------------------------------------------|
| `packages/maplibre`                     | The app-facing package                                 |
| `packages/maplibre_platform_interface`  | The shared API, style classes and gesture recognizer   |
| `packages/maplibre_web`                 | The web implementation on MapLibre GL JS               |
| `packages/maplibre_native`              | The implementation for every other platform            |
| `packages/maplibre_geolocator`          | The `geolocator` adapter for `UserLocationLayer`       |
| `examples`                              | The example app, which also runs the integration tests |
| `website`                               | This documentation                                     |

See [Architecture](architecture.md) for how the packages fit together.

## Tests

```bash
# Unit tests, inside a package
flutter test

# Integration tests on a device
cd examples && flutter test integration_test/all_test.dart -d windows
```

## Before you commit

```bash
dart format .
dart analyze --fatal-warnings --fatal-infos
```

## More

[CONTRIBUTING.md](https://github.com/josxha/flutter-maplibre/blob/main/CONTRIBUTING.md)
covers building the MapLibre Native C library locally, and
[AGENTS.md](https://github.com/josxha/flutter-maplibre/blob/main/AGENTS.md)
lists the code generation commands and the rules of the code base.

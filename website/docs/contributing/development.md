---
title: 'Local development'
icon: lucide/wrench
---

# Local development

This page explains how to work on the packages themselves. To use the
packages in your app, read [Installation](../getting-started/setup.md).

## Repository layout

The repository is a [pub workspace](https://dart.dev/tools/pub/workspaces).
One `flutter pub get` in its root resolves every package:

| Path                                    | Content                                                        |
|-----------------------------------------|----------------------------------------------------------------|
| `packages/maplibre`                     | The app-facing package                                         |
| `packages/maplibre_platform_interface`  | The platform interface and the shared gesture recognizer       |
| `packages/maplibre_web`                 | The web implementation on MapLibre GL JS                       |
| `packages/maplibre_native`              | The implementation for every other platform                    |
| `packages/maplibre_geolocator`          | The adapter from `geolocator` positions to `UserLocationLayer` |
| `examples`                              | The example app, which also runs the integration tests         |
| `tool`                                  | Scripts for code generation and releases                       |
| `website`                               | This documentation                                             |

## Get started

You need Flutter 3.47 or newer. Clone the repository and get the
dependencies:

```bash
git clone https://github.com/josxha/flutter-maplibre
cd flutter-maplibre
flutter pub get
```

Then run the example app:

```bash
cd examples
flutter run -d windows   # or macos, linux, chrome, an iOS simulator or an Android device
```

Flutter's own requirements of each platform apply, for example Visual Studio
2022 with the *Desktop development with C++* workload on Windows. Windows and
Linux need a Vulkan 1.1 driver. Android renders with OpenGL ES 3.0 by default; to try the Vulkan
build there, uncomment the `hooks:` block at the end of the root
`pubspec.yaml` and keep only its `backend` entry.

## The MapLibre Native C library

The Dart binding
[maplibre_native_ffi](https://pub.dev/packages/maplibre_native_ffi) comes
from pub.dev, and its build hook downloads the prebuilt C library of its
release for each target. You only need to build the library yourself to
change it or to try an unreleased version.

### Build on Windows

Clone [maplibre-native-ffi](https://github.com/maplibre/maplibre-native-ffi),
for example next to this repository, at the release tag that the workspace
resolves to. Install:

- Visual Studio 2022 with the *Desktop development with C++* workload
- Standalone [LLVM](https://github.com/llvm/llvm-project/releases), so that
  `C:\Program Files\LLVM\bin\clang-cl.exe` exists
- CMake and Ninja
- Rust, and `cargo install cargo-about --version 0.9.2 --locked --features cli`
- Git for Windows, for Git Bash

Then, in Git Bash from the clone:

```bash
bash .mise/bin/sync-submodules
source .mise/bin/windows-msvc-env.sh
cmake --preset windows-x64-vulkan -DBUILD_TESTING=OFF
cmake --build --preset windows-x64-vulkan
```

A first build takes most of an hour. `-DBUILD_TESTING=OFF` leaves out the C
library's tests, which would also need the Vulkan SDK.

!!! note "MSVC and LLVM versions"

    The MSVC standard library requires a matching Clang version: MSVC 14.44
    needs LLVM 19 or newer. With an older LLVM, use an older MSVC toolset
    such as 14.37. Install it in the Visual Studio Installer and load its
    environment instead of sourcing `windows-msvc-env.sh`, for example with
    `vcvars64.bat -vcvars_ver=14.37`.

### Build for Android

The Android presets build against the Android SDK and NDK from
`ANDROID_HOME`. Build `android-arm64-egl` for devices or `android-x64-egl` for
emulators, the same way as the Windows preset above. The
[development overview](https://github.com/maplibre/maplibre-native-ffi/blob/main/docs/src/content/docs/development/overview.md)
lists the requirements and how to install the pinned SDK with mise. The
`android-*-vulkan` presets build the Vulkan opt-in.

### Use the local build

Name the clone's build root in the root `pubspec.yaml`:

```yaml
hooks:
  user_defines:
    maplibre_native_ffi:
      local_build: ../maplibre-native-ffi/build
```

The hook takes `<preset>/install` under it for each target, so one setting
serves every platform and Android ABI you have built. Without a `backend`
entry it takes the platform's default preset (`-egl` on Android); select
`backend: { android: vulkan }` to use an `android-*-vulkan` build. Remove
`local_build` to go back to the prebuilt library.

## Tests

```bash
# Unit tests of the gesture recognizer
cd packages/maplibre_platform_interface && flutter test

# Unit tests of the app-facing package
cd packages/maplibre && flutter test

# Loads the C library and opens a runtime and a map
cd packages/maplibre_native && flutter test

# Integration tests on a device: windows, linux, macos, an iOS simulator or
# an Android device
cd examples && flutter test integration_test/all_test.dart -d windows

# Integration tests on web, with chromedriver running on port 4444
cd examples && flutter drive --driver test_driver/integration_test.dart \
  --target integration_test/all_test.dart -d web-server --browser-name chrome
```

CI runs the integration tests on every platform. Its runners have no GPU, so
the maps render in software there.

## Code generation

`maplibre_native` reaches its platform plugins through ffigen on Windows,
Linux, iOS and macOS, and jnigen on Android. The style layer classes are
generated from the style spec. The generators run from `tool/codegen`, a
package outside the workspace, which keeps the binding's build hook out of
code generation:

```bash
cd tool/codegen
dart pub get
dart run ffigen.dart        # after changing the desktop or Darwin C API header
dart run style_layers.dart  # after raising the style spec version in the script
dart run jnigen.dart        # after changing the Kotlin API; build the example APK in release mode first
```

## Documentation

The website is built with [Zensical](https://zensical.org/) from `mkdocs.yml`
and `website/`:

```bash
pip install zensical
zensical serve
```

## Before you commit

Format and analyze the code, or install [pre-commit](https://pre-commit.com/)
and run `pre-commit install` once to do both on every commit:

```bash
dart format .
dart analyze --fatal-warnings --fatal-infos
```

Design decisions and known gaps are recorded in `.agents/decisions.md`. See
[Architecture](architecture.md) for an overview of the packages.

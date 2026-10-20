---
title: 'Local development'
icon: lucide/wrench
---

# Local development

This page explains how to work on the packages themselves. To use the
packages in your app, read [How to setup](setup.md).

## Repository layout

The repository is a [pub workspace](https://dart.dev/tools/pub/workspaces).
One `flutter pub get` in its root resolves every package:

| Path                                    | Content                                                        |
|-----------------------------------------|----------------------------------------------------------------|
| `packages/maplibre`                     | The app-facing package                                         |
| `packages/maplibre_platform_interface`  | The platform interface and the shared gesture recognizer       |
| `packages/maplibre_web`                 | The web implementation on MapLibre GL JS                       |
| `packages/maplibre_native`              | The implementation for every other platform                    |
| `packages/maplibre_native/vendor/maplibre-native-ffi` | The MapLibre Native C API and its Dart binding, as a Git submodule |
| `examples`                              | The example app, also used for the integration tests           |
| `tool`                                  | Scripts for the native build and code generation               |
| `website`                               | This documentation                                             |

## Get started

You need Flutter 3.47 or newer. Clone the repository with its submodule and
get the dependencies:

```bash
git clone --recurse-submodules https://github.com/josxha/flutter-maplibre
cd flutter-maplibre
flutter pub get
```

In an existing clone, run `git submodule update --init` once, and again
whenever the pinned submodule commit changes.

Then run the example app:

```bash
cd examples
flutter run -d windows   # or chrome, or an Android device
```

On Windows, Flutter's own requirements apply: Visual Studio 2022 with the
*Desktop development with C++* workload. On Windows, the device needs a Vulkan
1.1 driver. Android renders with OpenGL ES 3.0 by default; to try the Vulkan
build there, uncomment the `hooks:` block at the end of the root
`pubspec.yaml`.

## The MapLibre Native C library

By default, the build hook of the Dart binding `maplibre_native_ffi` downloads
a prebuilt snapshot of the C library. That snapshot is built from the
binding's main branch and can lag the pinned submodule. If the build fails on
missing or mismatching symbols, or you change the C library, build it from the
submodule.

### Build on Windows

Install:

- Visual Studio 2022 with the *Desktop development with C++* workload
- Standalone [LLVM](https://github.com/llvm/llvm-project/releases), so that
  `C:\Program Files\LLVM\bin\clang-cl.exe` exists
- CMake and Ninja
- Rust, and `cargo install cargo-about --version 0.9.2 --locked --features cli`
- Git for Windows, for Git Bash

Then, in Git Bash from `packages/maplibre_native/vendor/maplibre-native-ffi`:

```bash
bash .mise/bin/sync-submodules
powershell -ExecutionPolicy Bypass -File .mise/bin/sync-rustls-platform-verifier.ps1
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
of the submodule lists the requirements and how to install the pinned SDK
with mise. The `android-*-vulkan` presets build the Vulkan opt-in.

### Use the local build

Point the build hook at a build from the repository root:

```bash
dart tool/use_native_build.dart windows-x64-vulkan
dart tool/use_native_build.dart android-arm64-egl  # devices
dart tool/use_native_build.dart android-x64-egl    # emulators
dart tool/use_native_build.dart --download         # back to the snapshot
```

The tool writes the install prefix to
`bindings/dart/.dart_tool/maplibre_native_install_dir` in the submodule. The
hook takes one prefix at a time and rejects other targets, so switch it to the
platform you build for next. On Android, build the matching ABI only, for
example `flutter build apk --target-platform android-arm64`. Without a backend
user-define, the hook takes the backend of the prefix, so pointing it at an
`android-*-vulkan` build is enough to run the Vulkan path.

## Tests

```bash
# Unit tests of the gesture recognizer
cd packages/maplibre_platform_interface && flutter test

# Unit tests of the app-facing package
cd packages/maplibre && flutter test

# Loads the C library and opens a runtime and a map
cd packages/maplibre_native && flutter test

# Integration tests on a device, e.g. Windows
cd examples && flutter test integration_test/main.dart -d windows
```

The integration tests need a device with a GPU. CI runners have none, so CI
only runs the unit tests and builds the apps.

## Code generation

`maplibre_native` reaches its platform plugins through ffigen on Windows and
jnigen on Android. The generators run from `tool/codegen`, a package outside
the workspace, because they need newer native-asset packages than the
binding allows:

```bash
cd tool/codegen
dart pub get
dart run ffigen.dart   # after changing windows/include/maplibre_native/maplibre_native_api.h
dart run jnigen.dart   # after changing the Kotlin API; build the example APK in release mode first
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

Design decisions and known gaps are recorded in `.agents/decisions.md`.

# AGENTS.md

Flutter MapLibre: a federated plugin in a Dart pub workspace.

## Layout

- `packages/maplibre`: the app-facing package.
- `packages/maplibre_platform_interface`: shared API that the platform packages
  implement, and the shared gesture recognizer (`lib/src/gestures/`).
- `packages/maplibre_web`: browser, via maplibre-gl-js.
- `packages/maplibre_native`: every other platform, on the MapLibre Native C API.
  - The C API and its Dart binding come from `maplibre_native_ffi` on pub.dev,
    whose build hook downloads the prebuilt C library of its release.
  - `lib/src/frame_target.dart`: how frames reach Flutter. `MapRenderer`
    drives the session the same way everywhere; each platform's
    `FrameTarget` (`lib/src/<platform>/*_target.dart`) owns its texture and
    plugin calls.
  - `desktop/`: C++ shared by the Windows and Linux plugins: the Vulkan device
    and the C API `desktop/include/maplibre_native/maplibre_native_api.h`,
    bound in `lib/src/desktop/bindings.g.dart`.
  - `windows/`: C++ plugin (D3D11 shared textures).
  - `linux/`: C++ GTK plugin (Vulkan memory imported into OpenGL for an
    `FlTextureGL`).
  - `android/`: Kotlin plugin and JNI shim (SurfaceProducer surfaces as EGL
    surfaces with a render thread per map, or as Vulkan surfaces of its own
    device). Its API is `MaplibreNativeApi.kt`, bound in
    `lib/src/android/bindings.g.dart`.
  - `darwin/`: Objective-C plugin for iOS and macOS, a SwiftPM package only
    (Metal texture ring copied into IOSurface pixel buffers). Its C API is
    `darwin/maplibre_native/Sources/maplibre_native/include/maplibre_native/maplibre_native_api.h`,
    bound in `lib/src/darwin/bindings.g.dart`.
- `examples/`: the reference app.
- `tool/codegen/`: ffigen and jnigen scripts. A separate package outside the
  workspace, because the generators need newer native-asset packages than the
  binding allows.

## Commands

Run these from the repo root unless noted:

```bash
dart format $(git ls-files '*.dart')
dart analyze --fatal-warnings --fatal-infos
flutter test                                  # inside a package
cd tool/codegen && dart run ffigen.dart       # after changing the desktop or Darwin C API header
cd tool/codegen && dart run jnigen.dart       # after changing MaplibreNativeApi.kt; build examples for Android in release first
packages/maplibre_native/linux/test/run_gl_texture_test.sh  # Linux zero-copy check, no Flutter build needed
```

Building the C library locally is covered in `CONTRIBUTING.md`: name the
build root of a maplibre-native-ffi clone in
`hooks.user_defines.maplibre_native_ffi.local_build` of the root
`pubspec.yaml`.

## Rules

- Maps render only through Flutter's texture registry and the `Texture`
  widget, never through platform views.
- Gestures are recognized once, in `MapGestureDetector`. Platforms only
  implement `GestureCameraSink`, applying screen-space steps with their own
  camera engine.
- Never use method channels. Dart calls native code through ffigen (C/C++)
  or jnigen (Kotlin/Java) bindings.
- Note API gaps of `maplibre_native_ffi` in `.agents/decisions.md`.
- Use conventional commits (`feat(native): …`, `fix: …`, `ci: …`).
- Read `.agents/decisions.md` before changing rendering, threading, or the
  native build.
- Keep this file and `.agents/decisions.md` up to date in the same commit as
  the change: new commands, rules, layout, decisions, and known gaps.

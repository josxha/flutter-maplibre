# AGENTS.md

Flutter MapLibre: a federated plugin in a Dart pub workspace.

## Layout

- `packages/maplibre`: the app-facing package.
- `packages/maplibre_platform_interface`: shared API that the platform packages
  implement, and the shared gesture recognizer (`lib/src/gestures/`).
- `packages/maplibre_web`: browser, via maplibre-gl-js.
- `packages/maplibre_native`: every other platform, on the MapLibre Native C API.
  - `vendor/maplibre-native-ffi`: git submodule with the C API and its Dart binding.
    Treat it as read-only.
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
dart tool/use_native_build.dart <preset>      # local C library: windows-x64-vulkan, linux-gnu-x64-vulkan, android-arm64-egl, android-x64-egl, android-*-vulkan, --download
cd tool/codegen && dart run ffigen.dart       # after changing the desktop or Darwin C API header
cd tool/codegen && dart run jnigen.dart       # after changing MaplibreNativeApi.kt; build examples for Android in release first
packages/maplibre_native/linux/test/run_gl_texture_test.sh  # Linux zero-copy check, no Flutter build needed
```

Building the C library is covered in `CONTRIBUTING.md`. The build hook accepts
one target per prefix, so build Android one ABI at a time
(`flutter build apk --target-platform android-arm64`).

## Rules

- Maps render only through Flutter's texture registry and the `Texture`
  widget, never through platform views.
- Gestures are recognized once, in `MapGestureDetector`. Platforms only
  implement `GestureCameraSink`, applying screen-space steps with their own
  camera engine.
- Never use method channels. Dart calls native code through ffigen (C/C++)
  or jnigen (Kotlin/Java) bindings.
- Never edit the submodule. Note API gaps in `.agents/decisions.md` instead.
- Use conventional commits (`feat(native): …`, `fix: …`, `ci: …`).
- Read `.agents/decisions.md` before changing rendering, threading, or the
  native build.
- Keep this file and `.agents/decisions.md` up to date in the same commit as
  the change: new commands, rules, layout, decisions, and known gaps.

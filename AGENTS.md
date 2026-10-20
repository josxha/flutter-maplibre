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
  - `windows/`: C++ plugin (Vulkan device, D3D11 shared textures). Its C API
    is `windows/include/maplibre_native/maplibre_native_api.h`, bound in
    `lib/src/windows/bindings.g.dart`.
  - `android/`: Kotlin plugin and JNI shim (SurfaceProducer surfaces as EGL
    surfaces with a render thread per map, or as Vulkan surfaces of its own
    device). Its API is `MaplibreNativeApi.kt`, bound in
    `lib/src/android/bindings.g.dart`.
  - `upstream/`: patches proposed to maplibre-native-ffi, against the pinned
    commit. Apply them in the submodule only to test, never commit them there.
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
dart tool/use_native_build.dart <preset>      # local C library: windows-x64-vulkan, android-arm64-egl, android-x64-egl, android-*-vulkan, --download
cd tool/codegen && dart run ffigen.dart       # after changing the Windows C API header
cd tool/codegen && dart run jnigen.dart       # after changing MaplibreNativeApi.kt; build examples for Android in release first
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
- Never edit the submodule. Note API gaps in `.agents/decisions.md` instead,
  and put proposed fixes in `packages/maplibre_native/upstream/`.
- Use conventional commits (`feat(native): …`, `fix: …`, `ci: …`).
- Read `.agents/decisions.md` before changing rendering, threading, or the
  native build.
- Keep this file and `.agents/decisions.md` up to date in the same commit as
  the change: new commands, rules, layout, decisions, and known gaps.

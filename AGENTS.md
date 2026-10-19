# AGENTS.md

Flutter MapLibre: a federated plugin in a Dart pub workspace.

## Layout

- `packages/maplibre`: the app-facing package.
- `packages/maplibre_platform_interface`: shared API that the platform packages implement.
- `packages/maplibre_web`: browser, via maplibre-gl-js.
- `packages/maplibre_native`: every other platform, on the MapLibre Native C API.
  - `vendor/maplibre-native-ffi`: git submodule with the C API and its Dart binding.
    Treat it as read-only.
  - `windows/`: C++ plugin (Vulkan device, D3D11 shared textures).
  - `android/`: Kotlin plugin and JNI shim (Vulkan device, SurfaceProducer surfaces).
- `examples/`: the reference app.

## Commands

Run these from the repo root unless noted:

```bash
dart format $(git ls-files '*.dart')
dart analyze --fatal-warnings --fatal-infos
flutter test                                  # inside a package
dart tool/use_native_build.dart <preset>      # local C library: windows-x64-vulkan, android-arm64-vulkan, android-x64-vulkan, --download
```

Building the C library is covered in `CONTRIBUTING.md`. The build hook accepts
one target per prefix, so build Android one ABI at a time
(`flutter build apk --target-platform android-arm64`).

## Rules

- Maps render only through Flutter's texture registry and the `Texture`
  widget, never through platform views.
- Never edit the submodule. Note API gaps in `.agents/decisions.md` instead.
- Use conventional commits (`feat(native): …`, `fix: …`, `ci: …`).
- Read `.agents/decisions.md` before changing rendering, threading, or the
  native build. Add an entry when you make a decision of that kind.

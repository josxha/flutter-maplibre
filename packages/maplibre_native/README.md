# maplibre_native

MapLibre Native implementation for [maplibre](https://pub.dev/packages/maplibre).

It renders through the experimental
[MapLibre Native C API](https://github.com/maplibre/maplibre-native-ffi),
vendored as a submodule in `vendor/maplibre-native-ffi`, and shows each map as
a Flutter `Texture`.

| Platform | Rendering                                                                   |
|----------|-----------------------------------------------------------------------------|
| Windows  | Vulkan into D3D11 textures shared with Flutter, or CPU readback             |
| Android  | OpenGL ES (default) or Vulkan on the Surface of a Flutter `SurfaceProducer` |
| iOS      | Metal into a texture ring, copied on the GPU into IOSurface pixel buffers   |
| macOS    | Metal into a texture ring, copied on the GPU into IOSurface pixel buffers   |
| Linux    | Vulkan into memory imported by OpenGL for Flutter, or CPU readback          |

## Android

- Renders with OpenGL ES 3.0 by default, and needs API level 24 or later.
- To render with Vulkan instead, which needs Vulkan 1.1, select the Vulkan
  build of the C library in the root `pubspec.yaml` of the app or workspace.
  The setting applies to every target, and iOS and macOS render through
  Metal only, so remove it when building for them.

  ```yaml
  hooks:
    user_defines:
      maplibre_native_ffi:
        backend: vulkan
  ```

- The plugin ships the Android TLS certificate verifier that the C library
  calls over JNI, and keeps it from R8 with its consumer rules.

## iOS and macOS

- Render with Metal, on iOS 13 and macOS 10.15 or later.
- The plugin is a Swift Package Manager package only, without a podspec, so
  apps need `flutter config --enable-swift-package-manager`.
- The C library is published for arm64 only: devices, arm64 simulators, and
  Apple silicon Macs. Apps exclude x86_64 with `EXCLUDED_ARCHS`, as the
  example's xcconfigs do.
- Sandboxed macOS apps need the `com.apple.security.network.client`
  entitlement to load styles and tiles.

## Linux

- Renders with Vulkan 1.1. Frames reach Flutter without a CPU copy when
  OpenGL has `GL_EXT_memory_object_fd` and runs on the same GPU and driver as
  Vulkan, and when Dart runs on the GTK main thread. Otherwise they are read
  back into a pixel buffer texture.
- Building needs the GTK and libepoxy development packages
  (`libgtk-3-dev libepoxy-dev` on Debian and Ubuntu), and running needs a
  Vulkan driver.
- `MAPLIBRE_NATIVE_DISABLE_ZERO_COPY=1` forces the CPU readback, on Linux and
  Windows.

## Building the C library locally

By default the build hook of `maplibre_native_ffi` downloads a published
snapshot of the C library, which can lag the pinned submodule. To use a local
build of the submodule instead, build its preset (see the submodule's
`CONTRIBUTING.md`) and point the hook at it from the repository root:

```bash
dart tool/use_native_build.dart android-arm64-egl
```

The hook takes one install prefix at a time, so build one ABI per run, e.g.
`flutter build apk --target-platform android-arm64`. Use
`android-x64-egl` for emulators, `android-*-vulkan` for the Vulkan opt-in,
`windows-x64-vulkan` for Windows, `linux-gnu-x64-vulkan` for Linux, and
`--download` to go back to the snapshot.

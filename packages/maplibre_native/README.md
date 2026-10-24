# maplibre_native

MapLibre Native implementation for [maplibre](https://pub.dev/packages/maplibre).

It renders through the experimental
[MapLibre Native C API](https://github.com/maplibre/maplibre-native-ffi)
through its Dart binding
[maplibre_native_ffi](https://pub.dev/packages/maplibre_native_ffi), whose
build hook downloads the prebuilt C library, and shows each map as a Flutter
`Texture`.

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
  build of the C library for Android in the root `pubspec.yaml` of the app or
  workspace:

  ```yaml
  hooks:
    user_defines:
      maplibre_native_ffi:
        backend:
          android: vulkan
  ```

## iOS and macOS

- Render with Metal, on iOS 15 and macOS 14.3 or later, the
  minimums of the C library.
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

By default the build hook of `maplibre_native_ffi` downloads the C library of
the release it was published with. To use a local build of
[maplibre-native-ffi](https://github.com/maplibre/maplibre-native-ffi)
instead, name its CMake build root in the root `pubspec.yaml`. The hook takes
`<preset>/install` under it for each target, so one setting serves every
platform and Android ABI you have built:

```yaml
hooks:
  user_defines:
    maplibre_native_ffi:
      local_build: ../maplibre-native-ffi/build
```

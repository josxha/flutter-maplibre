---
icon: lucide/sparkles
---

# How to setup

## Packages

You only depend on `maplibre`. It endorses one implementation per platform,
so Flutter picks the right one without any further dependency:

| Package                       | Used for                                                                                   |
|-------------------------------|--------------------------------------------------------------------------------------------|
| `maplibre`                    | The widgets and API your app uses                                                          |
| `maplibre_web`                | Web, through [MapLibre GL JS](https://github.com/maplibre/maplibre-gl-js)                  |
| `maplibre_native`             | Every other platform, through the [MapLibre Native C API](https://github.com/maplibre/maplibre-native-ffi) |
| `maplibre_platform_interface` | The interface both implementations share, including the gesture recognizer                |

Every map is shown as a Flutter `Texture` (or as an HTML element on web), never
as a platform view, so transforms, clipping and widgets on top of the map work
like with any other widget. Map gestures are recognized in Flutter on every
platform, so widgets over the map keep their own taps and drags without a
`PointerInterceptor`.

## Add the dependency

=== "Run command"

    Add `maplibre` to your project by running this command:
    
    ```bash
    flutter pub add maplibre
    ```

=== "Edit `pubspec.yaml`"

    Alternatively, add it directly as a dependency to your `pubspec.yaml` file:
    
    ```yaml title="pubspec.yaml" hl_lines="2"
    dependencies:
      maplibre: ^0.3.7+1
    ```
    and then run `flutter pub get` to install the package.
    
    ```bash
    flutter pub get
    ```

!!! warning "The MapLibre Native implementation is not released yet"

    The releases of `maplibre` on pub.dev up to 0.3.x don't use
    `maplibre_native` yet. Until its first release, the version described
    here is only available from the repository.

??? info "Using the development version"

    !!! warning

        The development version is not considered stable and shouldn't be
        used in production systems.

    Depend on the packages from the Git repository. `maplibre` depends on
    the other packages by version, so override them, too:

    ```yaml title="pubspec.yaml"
    dependencies:
      maplibre:
        git:
          url: https://github.com/josxha/flutter-maplibre
          path: packages/maplibre

    dependency_overrides:
      maplibre_native:
        git:
          url: https://github.com/josxha/flutter-maplibre
          path: packages/maplibre_native
      maplibre_platform_interface:
        git:
          url: https://github.com/josxha/flutter-maplibre
          path: packages/maplibre_platform_interface
      maplibre_web:
        git:
          url: https://github.com/josxha/flutter-maplibre
          path: packages/maplibre_web
    ```

## Platform support

| Platform | Implementation    | Renderer        | Rendering backend                      |
|----------|-------------------|-----------------|----------------------------------------|
| Web      | `maplibre_web`    | MapLibre GL JS  | WebGL                                  |
| Android  | `maplibre_native` | MapLibre Native | OpenGL ES 3.0 (default) or Vulkan      |
| iOS      | `maplibre_native` | MapLibre Native | Metal                                  |
| macOS    | `maplibre_native` | MapLibre Native | Metal                                  |
| Windows  | `maplibre_native` | MapLibre Native | Vulkan, shared with Flutter via D3D11  |
| Linux    | `maplibre_native` | MapLibre Native | Vulkan, shared with Flutter via OpenGL |

Linux is implemented but not yet tested on a Linux machine.

!!! warning

    The native implementation renders through the experimental
    [MapLibre Native C API](https://github.com/maplibre/maplibre-native-ffi),
    whose ABI is not stable yet. Globe projection, offline regions, the user
    location and location permissions are not available on native platforms
    yet.

The MapLibre Native library reaches your app as a Dart
[native asset](https://dart.dev/tools/hooks): the build hook of
[maplibre_native_ffi](https://pub.dev/packages/maplibre_native_ffi) downloads
the prebuilt library for each target, and Flutter bundles it with your app.
The packages need Flutter 3.47 or newer.

## Setup Web

Include the following JavaScript and CSS files in the `<head>` tag of
your `web/index.html` file:

```html title="web/index.html" hl_lines="5-7 9"
<!DOCTYPE html>
<html>
<head>
    <!-- other html -->
    <script src='https://unpkg.com/maplibre-gl@^5.0/dist/maplibre-gl.js'></script>
    <link href='https://unpkg.com/maplibre-gl@^5.0/dist/maplibre-gl.css'
          rel='stylesheet'/>
    <!-- Next line only required if you want to use PMTiles as source. -->
    <script src='https://unpkg.com/pmtiles@^4.0/dist/pmtiles.js'></script>
</head>
</html>
```

`^5.0` ensures that your app will always use the latest version of
[maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) version 5 but not
suddenly use an incompatible version.

If you want to always use the latest version use `latest` or use the full
version number like `5.0.0` if you want to use a specific version.

You can read about changes in maplibre-gl-js in
the [changelog file](https://github.com/maplibre/maplibre-gl-js/blob/main/CHANGELOG.md).

Gestures on web are handled by Flutter, not by MapLibre GL JS, so GL JS's
keyboard navigation and Shift + drag box zoom are not available.

## Setup Windows

The map renders with Vulkan into textures shared with Flutter through D3D11, so the device needs a GPU
driver with Vulkan 1.1 support (`vulkan-1.dll`). Recent drivers from AMD,
Intel and NVIDIA include it.

No further setup is needed.

## Setup Android

The map renders with OpenGL ES into the surface of a Flutter texture, so the
device needs OpenGL ES 3.0 and Android 7.0 (API level 24) or newer. No further
setup is needed.

Styles and tiles load through Android's `HttpURLConnection`, which follows
your app's network security config. Android blocks plain `http://` URLs by
default; permit cleartext for the hosts that need it in a
[network security config](https://developer.android.com/privacy-and-security/security-config).

To render with Vulkan instead, which needs a device with Vulkan 1.1, select
the Vulkan build of the C library in the root `pubspec.yaml` of your app, or of
your workspace if your app is part of one:

```yaml title="pubspec.yaml"
hooks:
  user_defines:
    maplibre_native_ffi:
      backend:
        android: vulkan
```

The C library carries the Java code its TLS verification needs, so no
ProGuard setup is needed.

## Setup iOS and macOS

The plugin is a Swift Package Manager package only and has no CocoaPods
podspec. Flutter uses Swift Package Manager by default since 3.44, and the
plugin requires Flutter 3.47 or newer, so no setup is needed. Apps that still
have a `Podfile` from older Flutter versions can remove CocoaPods with
`pod deintegrate` and delete the `Podfile`, `Podfile.lock` and the
`#include? "Pods/..."` lines of their xcconfigs.

## Setup iOS

The map renders with Metal into a Flutter texture, on iOS 15 or newer. The C
library is published for devices and for arm64 simulators, so exclude the
x86_64 simulator slice in `ios/Flutter/Debug.xcconfig` and
`ios/Flutter/Release.xcconfig`:

```text title="ios/Flutter/Debug.xcconfig"
EXCLUDED_ARCHS[sdk=iphonesimulator*] = x86_64
```

## Setup macOS

The map renders with Metal into a Flutter texture, on macOS 14.3 or newer.
Raise `MACOSX_DEPLOYMENT_TARGET` of the Runner target in
`macos/Runner.xcodeproj` to 14.3, as Flutter's template sets an older one. The
C library is published for Apple silicon and Intel Macs, so apps build for
both.

Sandboxed apps need the outgoing network entitlement to load styles and tiles.
Add it to `macos/Runner/DebugProfile.entitlements` and
`macos/Runner/Release.entitlements`:

```xml
<key>com.apple.security.network.client</key>
<true/>
```

## Setup Linux

The map renders with Vulkan 1.1. Frames reach Flutter without a CPU copy when
OpenGL supports `GL_EXT_memory_object_fd` on the same GPU and driver;
otherwise they are read back into a pixel buffer texture. Building needs the
GTK and libepoxy development packages:

```bash
sudo apt install libgtk-3-dev libepoxy-dev
```

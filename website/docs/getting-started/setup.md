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

No setup is needed. The first map loads the latest
[maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) v6 and
[PMTiles](https://github.com/protomaps/PMTiles) v4 from the
[jsDelivr](https://www.jsdelivr.com/) CDN. A new major version, which may
break your app, is never loaded unless you ask for it.

To choose what is loaded, set `window.flutterMapLibre` in the `<head>` tag of
your `web/index.html` file. Every option is optional:

```html title="web/index.html" hl_lines="5-12"
<!DOCTYPE html>
<html>
<head>
    <!-- other html -->
    <script>
      window.flutterMapLibre = {
        // An npm version or version range of maplibre-gl-js.
        maplibreGlVersion: '~6.16.0',
        // An npm version or version range of PMTiles.
        pmtilesVersion: '4.5.0',
      };
    </script>
</head>
</html>
```

| Option              | Default    | Description                                                                                  |
|---------------------|------------|----------------------------------------------------------------------------------------------|
| `maplibreGlVersion` | `^6.0.0`   | The [npm version range](https://docs.npmjs.com/cli/v10/configuring-npm/package-json#dependencies) of maplibre-gl-js, for example `6.16.0`, `~6.16.0` or `>=6.10.0 <6.15.0`. |
| `maplibreGlBaseUrl` | jsDelivr   | The URL of a folder with `maplibre-gl.mjs` and `maplibre-gl.css`, for example the `dist` folder of the npm package on your own server. Takes precedence over `maplibreGlVersion`. |
| `pmtilesVersion`    | `^4.0.0`   | The npm version range of PMTiles.                                                            |
| `pmtilesBaseUrl`    | jsDelivr   | The URL of a folder with `pmtiles.js`. Takes precedence over `pmtilesVersion`.               |

Only maplibre-gl-js v6 is supported. If you upgrade from an earlier version
of this package, remove the maplibre-gl-js and PMTiles `<script>` and `<link>`
tags from your `web/index.html`.

If your `web/index.html` already loads maplibre-gl-js, which sets
`window.maplibregl`, or PMTiles, which sets `window.pmtiles`, that copy is
used and nothing is loaded. maplibre-gl-js v6 is published only as an ES
module, so import it in a module script, and load `flutter_bootstrap.js` with
`defer` instead of `async`, so that the app starts after it:

```html title="web/index.html"
<script type="module">
  import * as maplibregl from 'https://cdn.jsdelivr.net/npm/maplibre-gl@^6.0.0/dist/maplibre-gl.mjs';
  window.maplibregl = maplibregl;
</script>
<link href='https://cdn.jsdelivr.net/npm/maplibre-gl@^6.0.0/dist/maplibre-gl.css'
      rel='stylesheet'/>
<!-- in the body -->
<script src="flutter_bootstrap.js" defer></script>
```

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

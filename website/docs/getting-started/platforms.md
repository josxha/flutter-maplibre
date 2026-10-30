---
title: 'Platform setup'
icon: lucide/monitor-smartphone
---

# Platform setup

This page lists the setup steps of each platform. Required steps are listed
first, optional steps are collapsed below them. See [Installation](setup.md) for the minimum versions.

## Web

??? note "Optional: choose the version or host maplibre-gl-js yourself"

    The first map loads the latest
    [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) v6 and
    [PMTiles](https://github.com/protomaps/PMTiles) v4 from the
    [jsDelivr](https://www.jsdelivr.com/) CDN. To change that, set `window.flutterMapLibre` in the `<head>` tag of
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
    | `maplibreGlVersion` | `^6.0.0`   | The [npm version range](https://docs.npmjs.com/cli/v10/configuring-npm/package-json#dependencies) of maplibre-gl-js, for example `6.16.0`, `~6.16.0` or `>=6.10.0 <6.15.0`. Only v6 is supported. |
    | `maplibreGlBaseUrl` | jsDelivr   | The URL of a folder with `maplibre-gl.mjs`, `maplibre-gl-worker.mjs` and `maplibre-gl.css` of the same version, for example the `dist` folder of the npm package on your own server. Takes precedence over `maplibreGlVersion`. |
    | `pmtilesVersion`    | `^4.0.0`   | The npm version range of PMTiles.                                                            |
    | `pmtilesBaseUrl`    | jsDelivr   | The URL of a folder with `pmtiles.js`. Takes precedence over `pmtilesVersion`.               |

## Android

??? note "Optional: load styles or tiles over `http://`"

    Android blocks plain `http://` by default. Permit cleartext for the hosts
    that need it in a
    [network security config](https://developer.android.com/privacy-and-security/security-config).

??? note "Optional: render with Vulkan"

    Maps render with OpenGL ES 3.0 by default. To render with Vulkan instead,
    which needs a device with Vulkan 1.1, select the Vulkan build of the C
    library in the root `pubspec.yaml` of your app, or of your workspace if your
    app is part of one:

    ```yaml title="pubspec.yaml"
    hooks:
      user_defines:
        maplibre_native_ffi:
          backend:
            android: vulkan
    ```

## iOS

**Required:**

1. Raise `IPHONEOS_DEPLOYMENT_TARGET` of the Runner target in
   `ios/Runner.xcodeproj` to 15.0 if your app targets an older version.
2. Use Swift Package Manager, Flutter's default. If you turned it off, turn
   it on again:

    ```bash
    flutter config --enable-swift-package-manager
    ```

??? note "Optional: build for simulators on Apple Silicon only"

    The C library is published for devices and arm64 simulators. If a
    simulator build fails to link the x86_64 slice, exclude it in
    `ios/Flutter/Debug.xcconfig` and `ios/Flutter/Release.xcconfig`:

    ```text title="ios/Flutter/Debug.xcconfig"
    EXCLUDED_ARCHS[sdk=iphonesimulator*] = x86_64
    ```

## macOS

**Required:**

1. Raise `MACOSX_DEPLOYMENT_TARGET` of the Runner target in
   `macos/Runner.xcodeproj` to 14.3, as Flutter's template sets an older one.
2. Sandboxed apps need the outgoing network entitlement to load styles and
   tiles. Add it to `macos/Runner/DebugProfile.entitlements` and
   `macos/Runner/Release.entitlements`:

    ```xml
    <key>com.apple.security.network.client</key>
    <true/>
    ```

3. Use Swift Package Manager, Flutter's default. If you turned it off, turn
   it on again:

    ```bash
    flutter config --enable-swift-package-manager
    ```

## Linux

**Required:** building needs the GTK and libepoxy development packages:

```bash
sudo apt install libgtk-3-dev libepoxy-dev
```

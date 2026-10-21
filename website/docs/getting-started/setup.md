---
icon: lucide/sparkles
---

# How to setup

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
      maplibre: ^0.3.0
    ```
    and then run `flutter pub get` to install the package.
    
    ```bash
    flutter pub get
    ```

??? info "Using the development version"

    If you want to have access to the latest features and changes, you
    can use the package directly from GitHub.

    !!! warning

        Note, that the development version is not considered stable and shouldn't be
        used in production systems.

    This is how you include the package directly from GitHub. Either use it in your
    `dependecies:` or temporarily override it inside the `dependency_overrides:`
    list.
    
    ```yaml title="pubspec.yaml" hl_lines="2-5"
    dependencies:
      maplibre:
        git:
          url: https://github.com/josxha/flutter-maplibre
          ref: main # or a specific commit hash 
    ```

## Setup Android

### Use a compatible Kotlin version

Ensure that you are using Kotlin version
**1.9.0 or newer**. You can check the most recent Kotlin version on
[kotlinlang.org](https://kotlinlang.org/docs/releases.html#release-details).

Open `android/settings.gradle` and ensure that the Kotlin plugin is applied
with a compatible version.

```gradle title="android/settings.gradle" hl_lines="3"
plugins {
    // ...
    id "org.jetbrains.kotlin.android" version "1.9.0" apply false
}
```

??? info "In case you can't find the `plugins {}` block your app still uses the old apply script method. Click here to view the instructions."

    Open `android/app/build.gradle` and set the Kotlin version like this:
    
    ```gradle title="android/app/build.gradle" hl_lines="2"
    buildscript {
        ext.kotlin_version = '1.9.0'
        // ...
    }
    ```

### Set the permissions

If you want to show the user's location on the map you need to add
the permissions in the application
manifest`android/app/src/main/AndroidManifest.xml`.

```xml title="android/app/src/main/AndroidManifest.xml" hl_lines="3 5"

<manifest>
    ...
    <!-- Always include this permission -->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    <!-- Include only if your app benefits from precise location access. -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
</manifest>
```

## Setup iOS

### Activate the Swift Package Manager

`maplibre` requires the Swift Package Manager to be enabled for your project.
Enable it by running the following command:

```bash
flutter config --enable-swift-package-manager
```

You can also add it just for this project by adding the following line to the
pubspec.yaml file of your app:

```yaml title="pubspec.yaml"
flutter:
  config:
    enable-swift-package-manager: true
```

## Setup Web

Include the following JavaScript and CSS files in the `<head>` tag of
your `web/index.html` file and load `flutter_bootstrap.js` with `defer`
instead of `async`:

```html title="web/index.html" hl_lines="5-11 13 16"
<!DOCTYPE html>
<html>
<head>
    <!-- other html -->
    <script type="module">
        import * as maplibregl from 'https://unpkg.com/maplibre-gl@^6.0/dist/maplibre-gl.mjs';
        window.maplibregl = maplibregl;
    </script>
    <link href='https://unpkg.com/maplibre-gl@^6.0/dist/maplibre-gl.css'
          rel='stylesheet'/>
    <!-- Next line only required if you want to use PMTiles as source. -->
    <script src='https://unpkg.com/pmtiles@^4.0/dist/pmtiles.js'></script>
</head>
<body>
    <script src="flutter_bootstrap.js" defer></script>
</body>
</html>
```

Starting with version 6,
[maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) is only published
as an ES module. The module script above loads it and exposes it as the global
`maplibregl` object that this package uses. Module scripts and `defer` scripts
run in document order, so `defer` on `flutter_bootstrap.js` makes sure that
MapLibre is loaded before your app starts.

`^6.0` ensures that your app will always use the latest version of
maplibre-gl-js version 6 but not suddenly use an incompatible version. Use the
full version number like `6.15.0` if you want to use a specific version. Don't
use `latest`, a future major version can break your app without warning.

??? info "Still using maplibre-gl-js version 5?"

    Version 5 is still supported. If your `web/index.html` loads
    `maplibre-gl@^5.0/dist/maplibre-gl.js` with a normal `<script>` tag, it
    keeps working. Replace it with the snippet above to upgrade to version 6.
    See the
    [maplibre-gl-js v5 to v6 migration guide](https://github.com/maplibre/maplibre-gl-js/blob/main/docs/guides/v5-to-v6-migration-guide.md)
    for the rendering changes that come with it.

You can read about changes in maplibre-gl-js in
the [changelog file](https://github.com/maplibre/maplibre-gl-js/blob/main/CHANGELOG.md).

## Setup Windows and macOS

!!! warning

    Windows and macOS support is experimental and powered by displaying the map 
    though a web view.
    It requires at least version 0.3.4 of the `maplibre` package.

### Add the dependency

To enable Windows support, make sure to add the `maplibre_webview` dependency to
your dependency list.

=== "Run command"

     Run the following command in your terminal:
    
    ```bash
    flutter pub add maplibre_webview
    ```

=== "Edit `pubspec.yaml`"

    Add `maplibre_webview` to your `pubspec.yaml` file:

    ```yaml title="pubspec.yaml" hl_lines="3"
    dependencies:
      maplibre: ^0.3.4
      maplibre_webview: ^0.3.4
    ```

### flutter_inappwebview Setup

InAppWebView that is used to display the map in a WebView requires some
additional platform specific setup steps. Please follow the instructions in the
flutter_inappwebview documentation.

- [Setup flutter_inappwebview for Windows](https://inappwebview.dev/docs/intro#setup-windows)
- [Setup flutter_inappwebview for macOS](https://inappwebview.dev/docs/intro#setup-macos)

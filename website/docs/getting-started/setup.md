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

## Platform support

| Platform | Implementation    | Renderer                                       | Status       |
|----------|-------------------|------------------------------------------------|--------------|
| Web      | `maplibre_web`    | MapLibre GL JS                                 | Supported    |
| Windows  | `maplibre_native` | MapLibre Native (C API, Vulkan)                | Experimental |
| Android  | `maplibre_native` | MapLibre Native (C API)                        | Planned      |
| iOS      | `maplibre_native` | MapLibre Native (C API)                        | Planned      |
| macOS    | `maplibre_native` | MapLibre Native (C API)                        | Planned      |
| Linux    | `maplibre_native` | MapLibre Native (C API)                        | Planned      |

Both implementations are endorsed by `maplibre`, so no extra dependency is
needed. On a platform marked as planned, creating a `MapLibreMap` throws an
`UnsupportedError`.

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
suddenly
use an incompatible version.

If you want to always use the latest version use `latest` or use the full
version number like `5.0.0` if you want to use a specific version.

You can read about changes in maplibre-gl-js in
the [changelog file](https://github.com/maplibre/maplibre-gl-js/blob/main/CHANGELOG.md).

## Setup Windows

!!! warning

    Windows support is experimental. It renders through the experimental
    [MapLibre Native C API](https://github.com/maplibre/maplibre-native-ffi),
    whose ABI is not stable yet.

The map renders with Vulkan into a Flutter texture, so the device needs a GPU
driver with Vulkan 1.1 support (`vulkan-1.dll`). Recent drivers from AMD,
Intel and NVIDIA include it.

The MapLibre Native library reaches your app as a Dart native asset, which
Flutter bundles next to the executable when it builds the app. No further
setup is needed.

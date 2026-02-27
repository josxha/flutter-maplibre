---
sidebar_position: 50
---

# Setup macOS

:::warning

macOS support is experimental and powered by displaying the map though a web
view.
macOS requires at least version 0.3.4 of the maplibre package.

:::

## Add the dependency

To enable macOS support, make sure to add the `maplibre_webview` dependency to
your `pubspec.yaml` file:

```yaml title="pubspec.yaml"
dependencies:
  maplibre: ^0.3.4
  # highlight-next-line
  maplibre_webview: ^0.3.4
```

Alternatively, you can run the following command in your terminal:

```bash
flutter pub add maplibre_webview
```

## WebView Setup

InAppWebView that is used to display the map on macOS requires some additional
setup. `maplibre` spins up a local web server to serve the map and its
resources. Please follow the instructions in the
[flutter_inappwebview documentation](https://inappwebview.dev/docs/intro#setup-macos)
to set up the WebView for macOS.

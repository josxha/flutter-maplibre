---
sidebar_position: 50
---

# Setup Windows

:::warning

Windows support is experimental and powered by displaying the map though a web
view.
Windows requires at least version 0.3.4 of the maplibre package.

:::

## Add the dependency

To enable Windows support, make sure to add the `maplibre_webview` dependency to
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

InAppWebView that is used to display the map on Windows requires some additional
setup. Please follow the instructions in the
[flutter_inappwebview documentation](https://inappwebview.dev/docs/intro/#setup-windows)
to set up the WebView for Windows.

# MapLibre Flutter

[![Pub Version](https://img.shields.io/pub/v/maplibre)](https://pub.dev/packages/maplibre)
[![stars](https://img.shields.io/github/stars/josxha/flutter-maplibre?style=flat&logo=github)](https://github.com/josxha/flutter-maplibre)
[![likes](https://img.shields.io/pub/likes/maplibre?logo=flutter)](https://pub.dev/packages/maplibre)
[![Pub Points](https://img.shields.io/pub/points/maplibre)](https://pub.dev/packages/maplibre/score)
[![Pub Downloads](https://img.shields.io/pub/dm/maplibre)](https://pub.dev/packages/maplibre)

[![codecov](https://codecov.io/gh/josxha/flutter-maplibre/graph/badge.svg?token=3LK7EQMSUM)](https://codecov.io/gh/josxha/flutter-maplibre)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

Interactive vector maps for Flutter on Android, iOS, macOS, Windows, Linux and
web, built on [MapLibre](https://maplibre.org). Show any MapLibre or Mapbox
compatible style, from any tile provider or your own server. `maplibre` needs
no API key of its own; keys and fees depend only on the tile provider you
choose.

<p align="center">
  <a href="https://josxha.github.io/flutter-maplibre/demo">
    <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/07cb9504aa76482b3707d0e18f4d86d37f7e2ad6/website/assets/images/showcase-map.jpg" alt="A styled map" width="49%" />
  </a>
  <a href="https://josxha.github.io/flutter-maplibre/demo">
    <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/07cb9504aa76482b3707d0e18f4d86d37f7e2ad6/website/assets/images/showcase-tilt.jpg" alt="A tilted and rotated map" width="49%" />
  </a>
</p>

<p align="center">
  <a href="https://josxha.github.io/flutter-maplibre/docs/getting-started/setup/"><b>Get started</b></a> ·
  <a href="https://josxha.github.io/flutter-maplibre/demo"><b>Live demo</b></a> ·
  <a href="https://josxha.github.io/flutter-maplibre/docs/"><b>Documentation</b></a> ·
  <a href="https://pub.dev/documentation/maplibre/latest/maplibre/"><b>API reference</b></a>
</p>

## Features

- **Six platforms, one API**: Android, iOS, macOS, Windows, Linux and web,
  with the same gestures and behavior everywhere.
- **Flutter first**: maps render into a Flutter `Texture` (an HTML element on
  web), so widgets over and around the map compose like any other widget. Annotations are declarative
  layers that you update with `setState()`.
- **Fast interop**: calls MapLibre through FFI (and maplibre-gl-js through JS
  interop on web) instead of platform channels, and many values, such as the
  camera and the style layers, can be read synchronously.
- **The full style spec**: typed style layers, sources and expressions, vector
  and raster tiles, PMTiles, MBTiles, MapLibre Tiles (MLT), hillshading,
  heatmaps and 3D extrusions.
- **Offline maps**: download regions or the tiles along a route.
- **Batteries included**: user location, compass, scale bar, attribution, zoom
  buttons, clustering, feature queries and events for taps, drags and hover.

## Quick start

```dart
import 'package:maplibre/maplibre.dart';

MapLibreMap(
  options: MapOptions(
    style: MapStyle.url('https://demotiles.maplibre.org/style.json'),
    initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7),
  ),
  layers: [
    CircleLayer(
      points: [Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68)))],
      color: const .literal(Colors.blue),
      radius: const .literal(12),
    ),
  ],
)
```

See [Installation](https://josxha.github.io/flutter-maplibre/docs/getting-started/setup/)
and [Platform setup](https://josxha.github.io/flutter-maplibre/docs/getting-started/platforms/)
for the steps each platform needs.

## Platforms

| Platform | Package           | Rendering                              |
|----------|-------------------|----------------------------------------|
| Android  | `maplibre_native` | OpenGL ES 3.0 (default) or Vulkan      |
| iOS      | `maplibre_native` | Metal                                  |
| macOS    | `maplibre_native` | Metal                                  |
| Windows  | `maplibre_native` | Vulkan, shared with Flutter via D3D11  |
| Linux    | `maplibre_native` | Vulkan, shared with Flutter via OpenGL |
| Web      | `maplibre_web`    | WebGL 2 (maplibre-gl-js)               |

`maplibre_native` uses the
[C API of MapLibre Native](https://github.com/maplibre/maplibre-native-ffi)
through the [maplibre_native_ffi](https://pub.dev/packages/maplibre_native_ffi)
binding. `maplibre_web` uses
[maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js). You only add
`maplibre` to your app.

## maplibre or maplibre_gl?

There are two Flutter packages for MapLibre. They take different approaches:

|                 | `maplibre` (this package)                                   | `maplibre_gl`                                                   |
|-----------------|-------------------------------------------------------------|-----------------------------------------------------------------|
| Principle       | What can be done in Dart is done in Dart                    | What the MapLibre SDKs can do is done by the SDKs               |
| Platforms       | Android, iOS, macOS, Windows, Linux, web                    | Android, iOS, web                                               |
| Interop         | FFI, JS interop on web                                      | Platform channels, JS interop on web                            |
| Map in Flutter  | `Texture`, HTML element on web                              | Platform view, HTML element on web                              |
| API             | Declarative annotations and an imperative controller, synchronous where possible | Imperative controller, asynchronous                             |

The
[comparison](https://josxha.github.io/flutter-maplibre/compare/) covers other map
packages as well.

## ❤️ Development & Contributing

All kinds of contributions are welcome. Thanks a lot if you consider to
contribute in any way! There are different ways how you can help the
development:

- 🌟 Give the project on [GitHub](https://github.com/josxha/flutter-maplibre) a
  star and like it on [pub.dev](https://pub.dev/packages/maplibre). This helps
  the package to grow!
- 🪴 Use the package in your project
  and [share feedback](https://github.com/josxha/flutter-maplibre/discussions/categories/show-and-tell).
- 🐛
  Open [bug reports](https://github.com/josxha/flutter-maplibre/issues/new?assignees=&labels=bug&projects=&template=1-bug.yml)
  in case you find any.
- 💡 If you need a specific
  feature, [open a feature request](https://github.com/josxha/flutter-maplibre/issues/new?assignees=&labels=feature&projects=&template=2-feature.yml&title=%5BFEATURE%5D+%3Ctitle%3E).
  or [post your idea as discussion](https://github.com/josxha/flutter-maplibre/discussions/categories/ideas).
- 💬 Use the [invite link](https://slack.openstreetmap.us) to chat with us on Slack in the `#flutter-maplibre` channel.
- 📖 Enhance the package documentation.
- 💝 Sponsor this
  project: [GitHub-Sponsors](https://github.com/sponsors/josxha), [PayPal](https://www.paypal.com/paypalme/joschaeckert).

## 👀 Preview Images

<table>
  <tbody>
    <tr>
      <td style="text-align: center;">
        <strong>Globe View</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/2244278ecb87117286a8c3fbad89717bc1231a1d/globe%20view.jpg" alt="Tilted and rotated map" />
      </td>
      <td style="text-align: center;">
        <strong>Custom Styling</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/d8e2c7daf15221f716a2ebbd63e57a317cb089ab/docs/static/img/showcase-map.jpg" alt="Custom styled map" />
      </td>
      <td style="text-align: center;">
        <strong>Pitch and Rotate</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/2244278ecb87117286a8c3fbad89717bc1231a1d/tilt%20map.jpg" alt="Tilted and rotated map" />
      </td>
    </tr>
    <tr>
      <td style="text-align: center;">
        <strong>Raster Tiles</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/raster_layer.jpg" alt="Fill Layer" />
      </td>
      <td style="text-align: center;">
        <strong>3D Building Outlines</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/fill_extrusion_layer.jpg" alt="Fill Extrusion Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Heatmaps</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/heatmap_layer.jpg" alt="Fill Layer" />
      </td>
    </tr>
    <tr>
      <td style="text-align: center;">
        <strong>Polygons</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/fill_layer.jpg" alt="Fill Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Elevation</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/hillshade_layer.jpg" alt="Fill Extrusion Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Lines</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/line_layer.jpg" alt="Fill Layer" />
      </td>
    </tr>
    <tr>
      <td style="text-align: center;">
        <strong>Circles</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/fe660b8d1c055d32e74cbc2ee0809281331a130b/docs/static/img/layers/circle_layer.jpg" alt="Circle Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Markers</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/symbol_layer.jpg" alt="Symbol Layer" />
      </td>
      <td style="text-align: center;">
      </td>
    </tr>
  </tbody>
</table>

## 😎 A huge thanks to all contributors!

[![List of contributors](https://contrib.rocks/image?repo=josxha/flutter-maplibre)](https://github.com/josxha/flutter-maplibre/graphs/contributors)
---
title: Home
hide: [ navigation, toc ]
---

# MapLibre Flutter

This package is a modern rewrite
of [maplibre_gl](https://pub.dev/packages/maplibre_gl). It provides Flutter
bindings for the MapLibre SDKs through native interoperability (FFI/JNI) with
the goal to deliver a consistent, cross-platform experience with excellent
performance.

[![Pub Version](https://img.shields.io/pub/v/maplibre)](https://pub.dev/packages/maplibre)
[![stars](https://img.shields.io/github/stars/josxha/flutter-maplibre?style=flat&logo=github)](https://github.com/josxha/flutter-maplibre)
[![likes](https://img.shields.io/pub/likes/maplibre?logo=flutter)](https://pub.dev/packages/maplibre)
[![Pub Points](https://img.shields.io/pub/points/maplibre)](https://pub.dev/packages/maplibre/score)
[![Pub Downloads](https://img.shields.io/pub/dm/maplibre)](https://pub.dev/packages/maplibre)
[![codecov](https://codecov.io/gh/josxha/flutter-maplibre/graph/badge.svg?token=3LK7EQMSUM)](https://codecov.io/gh/josxha/flutter-maplibre)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

- For web, it uses [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js),
  a fork of [mapbox-gl-js](https://github.com/mapbox/mapbox-gl-js).
- Every other platform uses
  [maplibre-native](https://github.com/maplibre/maplibre-native) through its
  experimental [C API](https://github.com/maplibre/maplibre-native-ffi) and
  the [maplibre_native_ffi](https://pub.dev/packages/maplibre_native_ffi)
  binding, rendering into a Flutter `Texture`. No platform views are used.

| Platform | Implementation    | Rendering backend                      | Status       |
|----------|-------------------|----------------------------------------|--------------|
| Web      | `maplibre_web`    | WebGL (MapLibre GL JS)                 | Supported    |
| Android  | `maplibre_native` | OpenGL ES 3.0 (default) or Vulkan      | Experimental |
| iOS      | `maplibre_native` | Metal                                  | Experimental |
| macOS    | `maplibre_native` | Metal                                  | Experimental |
| Windows  | `maplibre_native` | Vulkan, shared with Flutter via D3D11  | Experimental |
| Linux    | `maplibre_native` | Vulkan, shared with Flutter via OpenGL | Experimental |

MapLibre is a permissive, open-source implementation of the Mapbox Vector Tile
(MVT) standard. By leveraging native SDKs, this package enables high-performance
rendering while supporting advanced mapping features.

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
- 📖 Enhance the package documentation.
- 💝 Sponsor this
  project: [GitHub-Sponsors](https://github.com/sponsors/josxha), [PayPal](https://www.paypal.com/paypalme/joschaeckert).

## 😎 A huge thanks to all contributors!

[![List of contributors](https://contrib.rocks/image?repo=josxha/flutter-maplibre)](https://github.com/josxha/flutter-maplibre/graphs/contributors)
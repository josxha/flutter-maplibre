---
title: Compare
description: How maplibre compares to maplibre_gl, flutter_map, mapbox_maps_flutter and google_maps_flutter.
icon: lucide/scale
hide: [ navigation ]
---

# Compare Map Packages

Flutter has several map packages, and each fits different projects. This page
compares `maplibre` with the most used alternatives. The migration guides
show how to move from
[maplibre_gl](../docs/migrate/maplibre_gl.md),
[flutter_map](../docs/migrate/flutter_map.md),
[google_maps_flutter](../docs/migrate/google_maps_flutter.md) and
[mapbox_maps_flutter](../docs/migrate/mapbox_maps_flutter.md).

## At a glance

|                     | maplibre                 | maplibre_gl            | flutter_map              | mapbox_maps_flutter     | google_maps_flutter       |
|---------------------|--------------------------|------------------------|--------------------------|-------------------------|---------------------------|
| Map data            | Any tile provider        | Any tile provider      | Any tile provider        | Mapbox                  | Google                    |
| API key and billing | Only if your provider needs one | Only if your provider needs one | Only if your provider needs one | Mapbox access token, billed by usage | Google API key, billed by usage |
| Rendering           | MapLibre, GPU            | MapLibre, GPU          | Flutter canvas, Dart     | Mapbox, GPU             | Google Maps SDKs          |
| Map in Flutter as   | `Texture`, HTML element on web | Platform view, HTML element on web | Widgets                  | Platform view           | Platform view             |
| Android, iOS        | ✅                        | ✅                      | ✅                        | ✅                       | ✅                         |
| Web                 | ✅                        | ✅                      | ✅                        | ✅                       | ✅                         |
| macOS, Windows, Linux | ✅                      | ❌                      | ✅                        | ❌                       | ❌                         |
| Vector tiles        | ✅                        | ✅                      | With `vector_map_tiles`  | ✅                       | ❌ (Google's own maps)     |
| Style spec          | MapLibre, typed          | MapLibre, untyped      | ❌                        | Mapbox                  | Cloud styling or JSON     |
| Annotations         | Declarative layers       | Imperative controller  | Declarative widgets      | Imperative managers     | Declarative sets          |
| Offline regions     | ✅ (not on web)           | Android and iOS        | With plugins             | Android and iOS         | ❌                         |
| Widgets at map coordinates | ✅                        | ❌                      | ✅                        | ❌                       | ❌                         |
| License             | BSD-3-Clause             | BSD-3-Clause           | BSD-3-Clause             | Plugin BSD/MIT, SDK under Mapbox terms | BSD-3-Clause, service under Google terms |

## maplibre

This package. It runs on all six Flutter platforms with one API, renders
with MapLibre into a Flutter `Texture` through FFI, and on web into an HTML
element through JS interop. Annotations are declarative layers, and style layers,
sources and expressions are typed. It reads many values, such as the camera
and the style layers, synchronously.

It keeps its tech stack up to date and follows semantic versioning. Every
breaking release comes with a
[migration guide](../docs/migrate/upgrade-from-v0.3.x.md). `maplibre` is being
onboarded to the MapLibre organization as a
[hosted project](https://github.com/maplibre/maplibre/blob/main/PROJECT_TIERS.md#hosted-project).

## maplibre_gl

[maplibre_gl](https://pub.dev/packages/maplibre_gl)
([GitHub](https://github.com/maplibre/flutter-maplibre-gl)) is the other
MapLibre package for Flutter and a
[hosted project](https://github.com/maplibre/maplibre/blob/main/PROJECT_TIERS.md#hosted-project)
of the MapLibre organization. It
started as a fork of `flutter-mapbox-gl` and wraps the MapLibre Android and
iOS SDKs and maplibre-gl-js. Both packages use the same map styles and tiles.

|                 | maplibre                                                  | maplibre_gl                                                    |
|-----------------|-----------------------------------------------------------|----------------------------------------------------------------|
| Principle       | What can be done in Dart is done in Dart                  | What the MapLibre SDKs can do is done by the SDKs              |
| Platforms       | Android, iOS, macOS, Windows, Linux, web                  | Android, iOS, web                                              |
| Interop         | FFI, JS interop on web                                    | Platform channels, JS interop on web                           |
| Map in Flutter  | `Texture`, HTML element on web                            | Platform view, HTML element on web                             |
| API             | Declarative annotations and an imperative controller, synchronous where possible | Imperative controller, asynchronous                            |

## flutter_map

[flutter_map](https://pub.dev/packages/flutter_map) draws maps with Flutter
itself, written in Dart. It runs on every Flutter platform, layers are
widgets, and a large plugin ecosystem adds vector tiles
(`vector_map_tiles`), offline caching (`flutter_map_tile_caching`, GPL-3.0
or a commercial license) and the user location
(`flutter_map_location_marker`).

It is a good fit for raster tiles and apps that want everything in Dart.
`maplibre` draws on the GPU with MapLibre, which renders vector tiles, large
data, labels, 3D extrusions and hillshading faster, and has those features,
offline regions and the user location built in.

## mapbox_maps_flutter

[mapbox_maps_flutter](https://pub.dev/packages/mapbox_maps_flutter) is the
official Mapbox package, built on the Mapbox Maps SDKs and Mapbox GL JS. It
has Mapbox features such as the Mapbox Standard style, 3D terrain and
globe, and Mapbox services. It needs a Mapbox access token, and usage beyond
the free tier is billed.

MapLibre started as a fork of the open source Mapbox SDKs, so styles, layers
and expressions are very similar. `maplibre` works with any tile provider or
your own server, has no usage fees, and also runs on desktop platforms.

## google_maps_flutter

[google_maps_flutter](https://pub.dev/packages/google_maps_flutter) is the
Flutter team's plugin for Google Maps on Android, iOS and web. It shows
Google's map data, with Google's place and traffic layers, and needs a Google
Maps Platform API key with billing enabled. Map styles are limited to Google's
cloud styling or style JSON, and markers, polylines, polygons and circles are
the main ways to show data.

`maplibre` shows any vector or raster tiles with full control over the style,
has style layers for large data, heatmaps and 3D, and runs on desktop
platforms.

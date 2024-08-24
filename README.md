# MapLibre for Flutter

This package provides unofficial Flutter bindings for MapLibre libraries.

- [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) is used for web
- [maplibre-native](https://github.com/maplibre/maplibre-native) (previously
  named maplibre-gl) is used for android, iOS,
  windows, macOS and Linux

### What is the difference to [maplibre_gl](https://pub.dev/packages/maplibre_gl)?

Both, `maplibre_gl` and `maplibre` try to solve the same purpose to create
bindings between the
platform specific MapLibre SDK and Flutter. `maplibre_gl` is a fork
of `mapbox_gl` and already some
years around. `maplibre` on the other hand is a brand new and fresh
implementation. It tries to
provide the following improvements:

1. A WebAssembly compatible web implementation using the new JavaScript interop
   from `package:web`
   and `js_interop`.
2. Zero cost JavaScript interop
   using [extension types](https://dart.dev/language/extension-types)
   that got delivered
   in [Dart 3.3](https://medium.com/dartlang/dart-3-3-325bf2bf6c13).
3. More type safety and reducing the amount of platform custom code using code
   generation.
4. No legacy code or workarounds in the code base (with the risk of not yet
   including necessary
   fixes).
5. Get rid of code where the licensing is not clear. For example some files
   have
   a `Copyright 2018 The Chromium Authors. All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.`
   header but the LICENSE file doesn't mention it.
6. Using Kotlin instead of Java to benefit from null safety and reduce potential
   NullPointerExceptions.
7. Keep all platforms in one package to simplify the release cycle.
8. Use [geotypes](https://pub.dev/packages/geotypes)
   from [dart_turf](https://pub.dev/packages/turf)
   which are completely GeoJSON compatible
   ([RFC 7946](https://datatracker.ietf.org/doc/html/rfc7946) compliant).

### State of implementation

This is a broad orientation about what functionality could be added. The list
is orientated on MapLibre GL JS and the flutter-maplibre-gl map controller.
Some controller methods will be changed to provide a different annotation API.

| Feature                                        | web | android | iOS | windows | macOS | linux |
|------------------------------------------------|-----|---------|-----|---------|-------|-------|
| Map                                            | ✅   | ✅       | ❌   | ❌       | ❌     | ❌     |
| MapController                                  | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| ScaleControl                                   | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| TerrainControl                                 | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| AttributionControl                             | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| GeolocateControl                               | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| FullscreenControl                              | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| LogoControl                                    | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| NavigationControl                              | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| Annotation Symbol                              | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| Annotation LineString                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| Annotation Circle                              | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| Annotation Fill                                | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| Annotation Tap Events                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| Offline                                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| click callback                                 | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| long click callback                            | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| secondary click callback                       | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.jumpTo()                            | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.flyTo()                             | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addGeoJsonSource()                  | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setGeoJsonSource()                  | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setGeoJsonFeature()                 | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addSymbolLayer()                    | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addLineLayer()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setLayerProperties()                | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addFillLayer()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addFillExtrusionLayer()             | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addCircleLayer()                    | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addRasterLayer()                    | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addHillshadeLayer()                 | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addHeatmapLayer()                   | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.updateMyLocationTrackingMode()      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.matchMapLanguageWithDeviceDefault() | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.updateContentInsets()               | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setMapLanguage()                    | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addSymbol()                         | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addSymbols()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.updateSymbol()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getSymbolLatLng()                   | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeSymbol()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeSymbols()                     | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.clearSymbols()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addLine()                           | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addLines()                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.updateLine()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getLineLatLngs()                    | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeLine()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeLines()                       | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.clearLines()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addCircle()                         | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addCircles()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.updateCircle()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getCircleLatLng()                   | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeCircle()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeCircles()                     | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.clearCircles()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addFill()                           | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addFills()                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.updateFill()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.clearFills()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeFill()                        | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeFills()                       | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.queryRenderedFeatures()             | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.queryRenderedFeaturesInRect()       | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.querySourceFeatures()               | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.querySourceFeatures()               | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.invalidateAmbientCache()            | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.requestMyLocationLatLng()           | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getVisibleRegion()                  | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addImage()                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addImage()                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setSymbolIconAllowOverlap()         | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setSymbolIconIgnorePlacement()      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setSymbolTextAllowOverlap()         | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setSymbolTextIgnorePlacement()      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addImageSource()                    | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.updateImageSource()                 | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeImageSource()                 | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeSource()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addImageLayer()                     | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addImageLayerBelow()                | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addLayerBelow()                     | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.removeLayer()                       | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setFilter()                         | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getFilter()                         | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.toScreenLocation()                  | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.toScreenLocationBatch()             | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.toLatLng()                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getMetersPerPixelAtLatitude()       | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addSource()                         | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setCameraBounds()                   | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.addLayer()                          | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.setLayerVisibility()                | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getLayerIds()                       | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |
| controller.getSourceIds()                      | ❌   | ❌       | ❌   | ❌       | ❌     | ❌     |

Support for windows, macOS and linux is currently not possible because of the
lack of platform views of these platforms.

- Windows: https://github.com/flutter/flutter/issues/31713
- MacOS: https://github.com/flutter/flutter/issues/41722
- Linux: https://github.com/flutter/flutter/issues/41724

## Development & Contributing

If you need a feature or experience a bug you want to fix contributions are
always welcome.

### Run code generation

```bash
dart run build_runner build
dart run pigeon --input pigeons/pigeon.dart 
```

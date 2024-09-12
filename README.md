# MapLibre for Flutter

[![Pub Version](https://img.shields.io/pub/v/maplibre)](https://pub.dev/packages/maplibre)
[![likes](https://img.shields.io/pub/likes/maplibre?logo=flutter)](https://pub.dev/packages/maplibre)
[![Pub Points](https://img.shields.io/pub/points/maplibre)](https://pub.dev/packages/maplibre/score)
[![Pub Popularity](https://img.shields.io/pub/popularity/maplibre)](https://pub.dev/packages/maplibre)

[![GitHub last commit](https://img.shields.io/github/last-commit/josxha/flutter-maplibre)](https://github.com/josxha/flutter-maplibre)
[![stars](https://badgen.net/github/stars/josxha/flutter-maplibre?label=stars&color=green&icon=github)](https://github.com/josxha/flutter-maplibre/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/josxha/flutter-maplibre)](https://github.com/josxha/flutter-maplibre/issues)

This package provides unofficial Flutter bindings for MapLibre libraries.

- [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) is used for web
- [maplibre-native](https://github.com/maplibre/maplibre-native) (previously
  named maplibre-gl) is used for android and in the future for iOS,
  windows, macOS and Linux

### Get started

Check out the docs to learn how to get started. 
https://josxha.github.io/flutter-maplibre/docs/get-started

### State of implementation

This is a broad orientation about what functionality could be added. The list
is orientated on MapLibre GL JS and the flutter-maplibre-gl map controller.
Some controller methods will be changed to provide a different annotation API.

| Feature                                  | web | android | iOS | windows | macOS | linux |
|------------------------------------------|-----|---------|-----|---------|-------|-------|
| Map                                      | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| MapController                            | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| maplibre-gl-js Web Controls              | ✅   | ➖       | ➖   | ➖       | ➖     | ➖     |
| Offline                                  | ➖   | ❌       | ❌   | ➖       | ➖     | ➖     |
| click callback                           | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| long click callback                      | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| secondary click callback                 | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| controller.jumpTo()                      | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.flyTo()                       | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.addSource()                   | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.addLayer()                    | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.setMyLocationTrackingMode()   | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| controller.setMapLanguage()              | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| controller.toScreenLocation()            | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.toLatLng()                    | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.getMetersPerPixelAtLatitude() | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |

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
dart run pigeon --input pigeons/pigeon.dart 
cp ios/Classes/Pigeon.g.swift macos/Classes/Pigeon.g.swift
```

### Test with WebAssembly

```bash
flutter pub global activate dhttpd # only once
cd example
flutter build web --wasm
dhttpd '--headers=Cross-Origin-Embedder-Policy=credentialless;Cross-Origin-Opener-Policy=same-origin' --path=build/web
```

or follow
the [flutter documentation](https://docs.flutter.dev/platform-integration/web/wasm#serving-wasm-locally)
about WebAssembly builds.
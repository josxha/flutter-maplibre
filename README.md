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
   generation with [pigeon](https://pub.dev/packages/pigeon).
4. No legacy code or workarounds in the code base (with the risk of not yet
   including necessary
   fixes).
5. Get rid of code where the licensing is not clear. For example some files
   have
   a `Copyright 2018 The Chromium Authors. All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.`
   header but the LICENSE file doesn't mention it.
6. Using Kotlin instead of Java to benefit from null safety and reduce potential
   NullPointerExceptions.
7. Keep all platforms in one package to simplify the release cycle. Having
   multiple packages is a potential cause of bugs (e.g.
   https://github.com/maplibre/flutter-maplibre-gl/pull/476)
8. Use [geotypes](https://pub.dev/packages/geotypes) which are
   GeoJSON compatible
   ([RFC 7946](https://datatracker.ietf.org/doc/html/rfc7946) compliant). This
   makes it compatible with all the functionality
   from [dart_turf](https://pub.dev/packages/turf).
   from [dart_turf](https://pub.dev/packages/turf).

### State of implementation

See https://josxha.github.io/flutter-maplibre/docs/features/supported-features

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
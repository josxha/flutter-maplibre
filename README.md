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
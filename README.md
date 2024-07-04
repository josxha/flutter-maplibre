# MapLibre for Flutter

This package provides unofficial Flutter bindings for MapLibre libraries.

- [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) is used for web
- [maplibre-native](https://github.com/maplibre/maplibre-native) (previously
  named maplibre-gl) is used for android, iOS,
  windows, macOS and Linux

## Run code generation

```bash
dart run build_runner build
dart run pigeon --input pigeons/messages.dart 
```
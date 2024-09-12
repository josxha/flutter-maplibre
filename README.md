# MapLibre for Flutter

[![Pub Version](https://img.shields.io/pub/v/maplibre)](https://pub.dev/packages/maplibre)
[![likes](https://img.shields.io/pub/likes/maplibre?logo=flutter)](https://pub.dev/packages/maplibre)
[![Pub Points](https://img.shields.io/pub/points/maplibre)](https://pub.dev/packages/maplibre/score)
[![Pub Popularity](https://img.shields.io/pub/popularity/maplibre)](https://pub.dev/packages/maplibre)

[![GitHub last commit](https://img.shields.io/github/last-commit/josxha/flutter-maplibre)](https://github.com/josxha/flutter-maplibre)
[![stars](https://badgen.net/github/stars/josxha/flutter-maplibre?label=stars&color=green&icon=github)](https://github.com/josxha/flutter-maplibre/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/josxha/flutter-maplibre)](https://github.com/josxha/flutter-maplibre/issues)

This package provides unofficial Flutter bindings for MapLibre SDKs.

- [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) is used for web
- [maplibre-native](https://github.com/maplibre/maplibre-native) (previously
  named maplibre-gl) is used for android and in the future for iOS,
  windows, macOS and Linux

MapLibre is a permissive and open source solution for the MVT 
(Mapbox Vector Tile) standard. By binding to native SDKs the package 
accomplishes performant rendering while supporting a lot of complex 
functionality.

<table>
<thead>
<th>Use custom styles for your map</th>
<th>Tilt or rotate your map</th>
</thead>
<tbody>
<tr>
<td><img src="https://private-user-images.githubusercontent.com/34318751/366865128-9871beb1-9887-4970-8ece-f8e3cb26f5c8.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjYxNDM2MjQsIm5iZiI6MTcyNjE0MzMyNCwicGF0aCI6Ii8zNDMxODc1MS8zNjY4NjUxMjgtOTg3MWJlYjEtOTg4Ny00OTcwLThlY2UtZjhlM2NiMjZmNWM4LmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA5MTIlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwOTEyVDEyMTUyNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTg1NDEwMTFjYWJkZjZmYzFmYmIyNjRlNjMyMTE5ZGI0ZWI0YmJiMWE4NGNkNGNlNmRjZmM5MDgzMjNhZGViZDkmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.rHi7xVLk-vP_3X_Cpi550-GcU7F5oKvPaBK2xf83Ks0" alt="Custom styled map" /></td>
<td><img src="https://private-user-images.githubusercontent.com/34318751/366865159-eab6cf27-38cb-4111-9900-b109f86df57e.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjYxNDM2MjQsIm5iZiI6MTcyNjE0MzMyNCwicGF0aCI6Ii8zNDMxODc1MS8zNjY4NjUxNTktZWFiNmNmMjctMzhjYi00MTExLTk5MDAtYjEwOWY4NmRmNTdlLmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA5MTIlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwOTEyVDEyMTUyNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTBkYzkzZjZhYjQ2Yzk4YWMxZjdlZGZhN2E3OTdhZWYzNjNkNGU0NDBkM2MyMzAzMTIyM2MwNTBjNjRjMTRkOGEmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.-AlEyjQ_qAYfgK0T6zddggZF3UU1Ck1VwB3-Ow9gCtg" alt="Tilted and rotated map" /></td>
</tr>
</tbody>
</table>

## Resources

### Demo Application

Check out the [hosted demo application](https://flutter-maplibre.pages.dev/demo)
or dive into
the [example app code](https://github.com/josxha/flutter-maplibre/tree/main/example/lib).

### Get started & Documentation

Visit the docs to learn how to get started with maplibre in your
project: [Get Started](https://flutter-maplibre.pages.dev/docs/category/getting-started)

If you want to know more about the classes and properties of the package, have
a look at
the [API docs](https://pub.dev/documentation/maplibre/latest/maplibre/maplibre-library.html).

### State of implementation

This package is still a young package and in an early stage.
While it offers a modern implementation, it currently lacks some
functionality. [See our documentation to learn more.](https://flutter-maplibre.pages.dev/docs/features/supported-features)

## Development & Contributing

If you need a feature or experience a bug you want to fix contributions are
welcome.

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
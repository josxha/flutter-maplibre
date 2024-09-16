# MapLibre for Flutter

[![Pub Version](https://img.shields.io/pub/v/maplibre)](https://pub.dev/packages/maplibre)
[![likes](https://img.shields.io/pub/likes/maplibre?logo=flutter)](https://pub.dev/packages/maplibre)
[![Pub Points](https://img.shields.io/pub/points/maplibre)](https://pub.dev/packages/maplibre/score)
[![Pub Popularity](https://img.shields.io/pub/popularity/maplibre)](https://pub.dev/packages/maplibre)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

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
<td><img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/d8e2c7daf15221f716a2ebbd63e57a317cb089ab/docs/static/img/showcase-map.jpg" alt="Custom styled map" /></td>
<td><img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/d8e2c7daf15221f716a2ebbd63e57a317cb089ab/docs/static/img/showcase-tilt.jpg" alt="Tilted and rotated map" /></td>
</tr>
</tbody>
</table>

## Resources

### Demo Application

Check out the [hosted demo application](https://flutter-maplibre.pages.dev/demo)
or dive into
the [example app code](https://github.com/josxha/flutter-maplibre/tree/main/example/lib).

### Get Started & Documentation

Visit the docs to learn how to get started with maplibre in your
project: [Get Started](https://flutter-maplibre.pages.dev/docs/category/getting-started)

If you want to know more about the classes and properties of the package, have
a look at
the [API docs](https://pub.dev/documentation/maplibre/latest/maplibre/maplibre-library.html).

### State of Implementation

This package is still a young package and in an early stage.
While it offers a modern implementation, it currently lacks some
functionality. [See our documentation to learn more.](https://flutter-maplibre.pages.dev/docs/features/supported-features)

## Development & Contributing

If you need a feature or experience a bug you want to fix contributions are
welcome.

#### Run Code Generation

We use code generation from [pigeon](https://pub.dev/packages/pigeon). 
If you change the file [pigeons/pigeon.dart](pigeons/pigeon.dart) you'll have
to run the code generator.
Use the generator script (or run the commands yourself) to generate the code.

On unix systems (macos, linux):
```bash
./pigeon/run.sh
```

On windows systems:

```powershell
.\pigeon\run.sh
```


#### Test with WebAssembly

This package supports WebAssembly builds! 🥳

```bash
flutter pub global activate dhttpd # only once
cd example
flutter build web --wasm
dhttpd '--headers=Cross-Origin-Embedder-Policy=credentialless;Cross-Origin-Opener-Policy=same-origin' --path=build/web
```

or follow
the [flutter documentation](https://docs.flutter.dev/platform-integration/web/wasm#serving-wasm-locally)
about Flutter WASM builds.
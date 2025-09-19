# MapLibre for Flutter

> [!WARNING]
> The iOS implementation is during the funding phase provided under
> the [Non-Profit Open Software License version 3.0 (NPOSL-3.0)](https://opensource.org/license/osl-3-0-php).
> After funding is completed, it will get released under the permissive 3-Clause BSD License.

[![Pub Version](https://img.shields.io/pub/v/maplibre)](https://pub.dev/packages/maplibre)
[![stars](https://badgen.net/github/stars/josxha/flutter-maplibre?label=stars&color=green&icon=github)](https://github.com/josxha/flutter-maplibre/stargazers)
[![likes](https://img.shields.io/pub/likes/maplibre?logo=flutter)](https://pub.dev/packages/maplibre)
[![Pub Points](https://img.shields.io/pub/points/maplibre)](https://pub.dev/packages/maplibre/score)
[![Pub Downloads](https://img.shields.io/pub/dm/maplibre)](https://pub.dev/packages/maplibre)

[![codecov](https://codecov.io/gh/josxha/flutter-maplibre/graph/badge.svg?token=3LK7EQMSUM)](https://codecov.io/gh/josxha/flutter-maplibre)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

This package provides Flutter bindings for the MapLibre SDKs through native
interoperability (FFI/JNI). Its goal is to deliver a consistent, cross-platform
experience with excellent performance.

- For web, it uses [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js),
  a fork of [mapbox-gl-js](https://github.com/mapbox/mapbox-gl-js).
- For Android and iOS, it
  uses [maplibre-native](https://github.com/maplibre/maplibre-native) (formerly
  maplibre-gl), a fork
  of [mapbox-gl-native](https://github.com/mapbox/mapbox-gl-native).

MapLibre is a permissive, open-source implementation of the Mapbox Vector Tile
(MVT) standard. By leveraging native SDKs, this package enables high-performance
rendering while supporting advanced mapping features.

<table>
  <tbody>
    <tr>
      <td style="text-align: center;">
        <strong>View the planet as a globe</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/2244278ecb87117286a8c3fbad89717bc1231a1d/globe%20view.jpg" alt="Tilted and rotated map" />
      </td>
      <td style="text-align: center;">
        <strong>Use custom vector styles</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/d8e2c7daf15221f716a2ebbd63e57a317cb089ab/docs/static/img/showcase-map.jpg" alt="Custom styled map" />
      </td>
      <td style="text-align: center;">
        <strong>Pitch or rotate the map</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/2244278ecb87117286a8c3fbad89717bc1231a1d/tilt%20map.jpg" alt="Tilted and rotated map" />
      </td>
    </tr>
    <tr>
      <td style="text-align: center;">
        <strong>Use raster tiles</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/raster_layer.jpg" alt="Fill Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Add 3D building outlines</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/fill_extrusion_layer.jpg" alt="Fill Extrusion Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Add heatmaps</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/heatmap_layer.jpg" alt="Fill Layer" />
      </td>
    </tr>
    <tr>
      <td style="text-align: center;">
        <strong>Add polygons</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/fill_layer.jpg" alt="Fill Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Render elevation</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/hillshade_layer.jpg" alt="Fill Extrusion Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Add lines</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/line_layer.jpg" alt="Fill Layer" />
      </td>
    </tr>
    <tr>
      <td style="text-align: center;">
        <strong>Add circles</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/fe660b8d1c055d32e74cbc2ee0809281331a130b/docs/static/img/layers/circle_layer.jpg" alt="Circle Layer" />
      </td>
      <td style="text-align: center;">
        <strong>Add markers</strong>
        <img src="https://raw.githubusercontent.com/josxha/flutter-maplibre/427311f8f4577c215bf73caf46e3769629e74e3b/docs/static/img/layers/symbol_layer.jpg" alt="Symbol Layer" />
      </td>
      <td style="text-align: center;">
      </td>
    </tr>
  </tbody>
</table>

## Resources

### Demo Application

- [Hosted Demo App](https://flutter-maplibre.pages.dev/demo)
- [Code of the Example App](https://github.com/josxha/flutter-maplibre/tree/main/example/lib)

### Get Started & Documentation

Visit the docs to learn how to get started with maplibre in your
project: [Get Started](https://flutter-maplibre.pages.dev/docs/category/getting-started)

If you want to know more about the classes and properties of the package, have
a look at
the [API docs](https://pub.dev/documentation/maplibre/latest/maplibre/maplibre-library.html).

## Development & Contributing

All kinds of contributions are welcome. Thanks a lot if you consider to
contribute in any way! There are different ways how you can help the
development:

- Use the package in your project
  and [share feedback](https://github.com/josxha/flutter-maplibre/discussions/categories/show-and-tell).
- [Open bug reports](https://github.com/josxha/flutter-maplibre/issues/new?assignees=&labels=bug&projects=&template=1-bug.yml&title=%5BBUG%5D+%3Ctitle%3E)
  in case you find any.
- If you need a specific
  feature, [open a feature request](https://github.com/josxha/flutter-maplibre/issues/new?assignees=&labels=feature&projects=&template=2-feature.yml&title=%5BFEATURE%5D+%3Ctitle%3E).
  or [post your idea as discussion](https://github.com/josxha/flutter-maplibre/discussions/categories/ideas).
- Enhance the package documentation.
- Sponsor this
  project: [GitHub-Sponsors](https://github.com/sponsors/josxha), [PayPal](https://www.paypal.com/paypalme/joschaeckert).

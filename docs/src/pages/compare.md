# Comparison

This page gives a brief comparison between `maplibre` and similar solutions.

## Similar Packages

### maplibre_gl

The [maplibre_gl](https://pub.dev/packages/maplibre_gl) package,
or [flutter-maplibre-gl](https://github.com/maplibre/flutter-maplibre-gl/) on
GitHub,
is a fork of [mapbox_gl](https://pub.dev/packages/mapbox_gl), a community effort
to provide Mapbox bindings for MapBox SDKs whose development has stopped in
favor of the first party MapBox package `mapbox_maps_flutter`.
`maplibre_gl` was initially maintained by [@m0nac0](https://github.com/m0nac0)
and got transferred to the MapLibre organization eventually as
a [hosted project](https://github.com/maplibre/maplibre/blob/main/PROJECT_TIERS.md),
"a project that the MapLibre Organization does not allocate any resources to".

New collaborators came in and became inactive again. I became a collaborator
of the `maplibre_gl` package myself in 05/2024 in a team of two. We had some
different ideas about long term goals of the package but had a good
collaboration together. We managed to publish 2 releases before development
slowed down and suddenly stopped again.

In my opinion, `maplibre_gl` had and still has up to this day has a couple of
issues:

- **Lack of Stability**: When I tried to include `maplibre_gl` into a project, I
  experienced a variety of bugs and even app crashes. A more
  recent [User Survey](https://maplibre.org/news/2024-12-01-maplibre-newsletter-november-2024/)
  showed that 44% of package users experienced app crashes using `maplibre_gl`.
- **Platform specific behavior**: When including the `package` in a project
  myself, I experienced a couple of different behaviors across iOS and Android.
  Developing for Flutter, I'd prefer to write code one and have the same
  behavior on all targeted platforms. The User Survey mentioned earlier
  yielded that 46% of package users experienced platform specific behavior in
  any way.
- **Legacy Code and Workarounds**: As most libraries, `maplibre_gl` contains
  some workaround code that sometimes isn't needed any longer. Those workarounds
  are often not well documented and for example date back to when
  Dart-JavaScript interoperability was still in the early days or from before
  null safety got added to Dart.
- **WebAssembly**: As Flutter on Web can now be compiled to WebAssembly, its web
  interoperability has changed and require that web implementation to be revised
  and partially get rewritten.
- **License compliance**: 31 files in maplibre_gl contain a copyright header
  mentioning "The Chromium Authors" with a "BSD-style license". However, the
  license isn't included in the LICENSE file. Looking at the git history reveals
  that they were merged in along with code years ago.
- **Example app**: Some sample implementations in the example app are broken or
  don't work on all platforms.
- **Performance**: As `maplibre_gl` relies on platform channels alone, sending
  or receiving large objects and data can lead to a bottleneck and performance
  implications.

Seeing all of those problems and the cumbersome development of `maplibre_gl`, a
green-field-approach with a clean migration guide was the way to go for me.
I started a new package and announced it
as [a discussion thread](https://github.com/maplibre/flutter-maplibre-gl/discussions/503).

- `maplibre` is ground-up a completely new package to get rid of licensing
  issues and all legacy implementations (with the risk of some fixes being not
  added yet).
- It uses the
  new [JavaScript interoperability](https://dart.dev/interop/js-interop) to
  ensure compatibility with WebAssembly.
- To ensure a higher level of stability, `maplibre` aims to reduce the amount
  of platform specific code and uses code generation for better type safety. It
  uses a combination of unit tests, widget tests and integration tests.
- Like the package, example app is written from ground up with a responsive
  design
  and [hosted example application](https://flutter-maplibre.pages.dev/demo/).
- To avoid a bottleneck using platform channels, the package makes use of FFI
  interoperability with Objective-C and Swift and a combination of JNI and FFI
  for Java and Kotlin. Many of those features are still considered experimental
  by the Dart Native team but
  something [they want to focus on during 2025](https://www.youtube.com/watch?v=ukW-l_sRefg).
  Whenever interop is not suitable, the package falls back to generated method
  channels.

### flutter_map

`flutter_map` probably offers the best cross-platform experience and is
published under a permissive license. It is written in pure Dart it can be used
on every Platform that is supported by Flutter and has an active community on
GitHub and Discord.

It has a sleepless integration into Flutter and plugin system to have its
functionality supplemented by other plugin-packages. This sometimes limits the
package possibilities as a built-in feature could potentially have a better
integration that relying on third party package authors. Vector tile support is
not built-in either but can be using by adding the package `vector_map_tiles`.

The strength to be 100% written in Dart can sometimes cause problems as it is
not as performant as a more low level renderer. This is especially noticeable
when rendering larger amount of data or using vector tiles.

## Features

#### Legend

- ✅ Completely Supported
- ⚠️ Supported with Limitations
- ❌ Not Supported
- No icon: Unknown (open a pull request to fill in the blanks)

#### Footnotes

1) Only with third party extensions
2) Performance implications
3) Not on all platforms

### General

| **Topic**   | maplibre       | maplibre_gl    | flutter_map    | mapbox_maps_flutter  | google_maps_flutter |
|-------------|----------------|----------------|----------------|----------------------|---------------------|
| Licensing   | ✅ BSD-3-Clause | ✅ BSD-3-Clause | ✅ BSD-3-Clause | ⚠️ Mapbox TOS        | ✅ BSD-3-Clause      |
| Vendor-Free | ✅ yes          | ✅ yes          | ✅ yes          | ❌ Mapbox only        | ⚠️ Google API only  |
| Costs       | ✅ None         | ✅ None         | ✅ None         | ⚠️ Per user, per use | ⚠️ Per Use          |

### Core Functionality

| **Feature**               | maplibre | maplibre_gl | flutter_map | mapbox_maps_flutter | google_maps_flutter |
|---------------------------|----------|-------------|-------------|---------------------|---------------------|
| Mapbox Vector Tiles (MVT) | ✅        | ✅           | ⚠️ 1        | ✅                   | ❌                   |
| Raster Tiles              | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Vector Tiles              | ✅        | ✅           | ⚠️ 1,2      | ✅                   | ✅                   |
| Hillshade Tiles           | ✅        | ✅           | ❌           | ✅                   | ❌                   |
| Animations                | ✅        | ✅           | ⚠️ 1        | ✅                   |                     |
| User Location             | ⚠️ 3     | ⚠️ 1,3      | ⚠️ 1        |                     |                     |
| Caching                   | ⚠️ 3     | ⚠️ 3        | ⚠️ 1        |                     |                     |
| Offline                   | ⚠️ 3     | ⚠️ 3        | ⚠️ 1        |                     |                     |
| Gestures                  | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Events                    | ✅        |             | ✅           | ✅                   |                     |

### Annotation Layers

| **Layer** | maplibre | maplibre_gl | flutter_map | mapbox_maps_flutter | google_maps_flutter |
|-----------|----------|-------------|-------------|---------------------|---------------------|
| Widgets   | ✅        | ❌           | ✅           | ❌                   | ⚠️ 1                |
| Polygons  | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Polylines | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Circles   | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Markers   | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Heatmap   | ✅        | ✅           | ⚠️ 1        | ✅                   | ⚠️ 1                |

### Platform Support

| **Platform** | maplibre | maplibre_gl | flutter_map | mapbox_maps_flutter | google_maps_flutter |
|--------------|----------|-------------|-------------|---------------------|---------------------|
| Android      | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| iOS          | ❌        | ✅           | ✅           | ✅                   | ✅                   |
| Web          | ✅        | ✅           | ✅           | ❌                   | ✅                   |
| Windows      | ❌        | ❌           | ✅           | ❌                   | ❌                   |
| macOS        | ❌        | ❌           | ✅           | ❌                   | ❌                   |
| Linux        | ❌        | ❌           | ✅           | ❌                   | ❌                   |
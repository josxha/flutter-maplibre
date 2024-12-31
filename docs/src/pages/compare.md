# Comparison

This page gives a brief comparison between `maplibre` and similar solutions.

## Similar Packages

### maplibre_gl

The [maplibre_gl](https://pub.dev/packages/maplibre_gl) package,
or [flutter-maplibre-gl](https://github.com/maplibre/flutter-maplibre-gl/) on
GitHub, is a fork of [mapbox_gl](https://pub.dev/packages/mapbox_gl), a
community effort to provide Mapbox bindings for Mapbox SDKs whose development
has stopped in favor of the first-party Mapbox
package `mapbox_maps_flutter`. `maplibre_gl` was initially maintained
by [@m0nac0](https://github.com/m0nac0) and was eventually transferred to the
MapLibre organization as
a [hosted project](https://github.com/maplibre/maplibre/blob/main/PROJECT_TIERS.md), "
a project that the MapLibre Organization does not allocate any resources to."

New collaborators joined but later became inactive again. I became a
collaborator of the `maplibre_gl` package myself in 05/2024 as part of a team of
two. While we had different ideas about the long-term goals of the package, we
maintained a good collaboration. We managed to publish two releases before
development slowed down and eventually stopped again.

In my opinion, `maplibre_gl` had, and still has to this day, several issues:

- **Lack of Stability**: When I tried to include `maplibre_gl` in a project, I
  experienced a variety of bugs and even app crashes. A more
  recent [User Survey](https://maplibre.org/news/2024-12-01-maplibre-newsletter-november-2024/)
  showed that 44% of package users experienced app crashes using `maplibre_gl`.
- **Platform-specific Behavior**: When including the package in a project
  myself, I noticed different behaviors across iOS and Android. As a Flutter
  developer, I'd prefer to write code once and have the same behavior across all
  targeted platforms. The User Survey mentioned earlier revealed that 46% of
  package users experience platform-specific behavior.
- **Legacy Code and Workarounds**: Like most libraries, `maplibre_gl` contains
  workaround code that sometimes isn't needed anymore. These workarounds are
  often not well-documented and date back to the early days of Dart-JavaScript
  interoperability or from before null safety was added to Dart.
- **WebAssembly**: As Flutter for Web can now be compiled to WebAssembly, its
  web interoperability has changed, requiring the web implementation to be
  revised and partially rewritten.
- **License Compliance**: 31 files in `maplibre_gl` contain a copyright header
  mentioning "The Chromium Authors" with a "BSD-style license." However, this
  license isn't included in the LICENSE file. Looking at the Git history reveals
  that these files were merged in along with code years ago.
- **Example App**: Some sample implementations in the example app are broken or
  don't work across all platforms.
- **Performance**: As `maplibre_gl` relies solely on platform channels, sending
  or receiving large objects and data can lead to bottlenecks and performance
  issues.

Considering all these problems and the cumbersome development of `maplibre_gl`,
I decided to adopt a greenfield approach with a clean migration guide. I started
a new package and announced it
in [a discussion thread](https://github.com/maplibre/flutter-maplibre-gl/discussions/503).

- `maplibre` is a completely new package, built from the ground up to eliminate
  licensing issues and legacy implementations (with the risk that some fixes are
  not yet included).
- It uses the
  new [JavaScript interoperability](https://dart.dev/interop/js-interop) to
  ensure compatibility with WebAssembly.
- To ensure greater stability, `maplibre` aims to reduce platform-specific code
  and employs code generation for better type safety. It uses a combination of
  unit tests, widget tests, and integration tests.
- Like the package, the example app is written from scratch with a responsive
  design and
  a [hosted example application](https://flutter-maplibre.pages.dev/demo/).
- To avoid bottlenecks caused by platform channels, the package utilizes FFI
  interoperability with Objective-C and Swift, as well as a combination of JNI
  and FFI for Java and Kotlin. Many of these interop features are still
  considered experimental by the Dart Native team but
  are [a focus for 2025](https://www.youtube.com/watch?v=ukW-l_sRefg). When
  interop is unsuitable, the package falls back to generated method channels.

### flutter_map

`flutter_map` likely offers the best cross-platform experience and is published
under a permissive license. Written in pure Dart, it can be used on every
platform supported by Flutter and has an active community on GitHub and Discord.
I am joined the flutter_map team as a maintainer myself in 05/2023.

The package has seamless integration into Flutter and a plugin system to extend
its functionality through other plugin packages. However, this sometimes limits
the package’s capabilities, as a built-in feature might offer better integration
than relying on third-party plugin authors. Vector tile support is not built-in
but basic support can be added using the `vector_map_tiles` package.

The advantage of being 100% written in Dart can sometimes be a drawback, as it
is not as performant as a lower-level renderer. This limitation is especially
noticeable when rendering large amounts of data or using vector tiles.

Learning from `flutter_map`, the `maplibre` package aims a have a similar
integration into Flutter and allows to set and update map annotations in a
declarative way, just like any other Flutter widget. Additionally, `maplibre`
has a similar plugin system, where plugin authors can enhance the functionality
in an easy way.

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
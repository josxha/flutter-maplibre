---
sidebar_position: 100
title: 'Upgrade from 0.1.x'
---

# Upgrade from version 0.1.x

Version `0.2.0` introduced some breaking changes. This site will guide you
through all of them.

## General Information on Breaking Changes

We are using
the [pub.dev version convention](https://dart.dev/tools/pub/versioning#semantic-versions)
for the package. While the package is prior its `1.0.0` release, the following
rules apply:

- Every minor `0.x.0` release can introduce breaking changes.
- Every increase of the patch value `0.0.x` adds new features and functionality.
- Every increase of 0.0.1+x indicates changes that don't affect the public API
  like bug fixes.

## Step-by-Step guide

### 1. Compatible Flutter Version

Version `0.2.0` increased the minimum allowed version of Flutter
to [3.24](https://medium.com/flutter/whats-new-in-flutter-3-24-6c040f87d1e4).

Run `flutter upgrade` to upgrade Flutter.

### 2. Name Changes

Some properties and class names have changed. Replace the old with the new
names.

| Old Name                | New Name                |
|-------------------------|-------------------------|
| MapZoomButtons          | MapControlButtons       |
| CircleLayer             | CircleStyleLayer        |
| FillExtrusionLayer      | FillExtrusionStyleLayer |
| FillLayer               | FillStyleLayer          |
| HeatmapLayer            | HeatmapStyleLayer       |
| HillshadeLayer          | HillshadeStyleLayer     |
| LineLayer               | LineStyleLayer          |
| RasterLayer             | RasterStyleLayer        |
| SymbolLayer             | SymbolStyleLayer        |
| CircleAnnotationLayer   | CircleLayer             |
| MarkerAnnotationLayer   | MarkerLayer             |
| PolygonAnnotationLayer  | PolygonLayer            |
| PolylineAnnotationLayer | PolylineLayer           |

### 3. Programmatic Style Control

Style related functionality is now loaded in the new `StyleController`.
For an easy migration, you can access it using the
nullable `mapController.style` getter.

The `onStyleLoaded` callback now returns the `StyleController` of the loaded
style: `onStyleLoaded: (style) { ... }`

### 4. Update your web integration

maplibre 0.2.0
uses [MapLibre GL JS version 5.0.0](https://github.com/maplibre/maplibre-gl-js/releases/tag/v5.0.0)
onwards. Open your `web/index.html` file and update the used library version.

```html title="web/index.html"
<!DOCTYPE html>
<html>
<head>
    <!-- other html -->
    <!-- highlight-start -->
    <script src='https://unpkg.com/maplibre-gl@^5.0/dist/maplibre-gl.js'></script>
    <link href='https://unpkg.com/maplibre-gl@^5.0/dist/maplibre-gl.css'
          rel='stylesheet'/>
    <!-- highlight-end -->
</head>
</html>
```
# Comparison with similar packages

This page gives a brief comparison between `maplibre` and similar solutions.

### Legend

- ✅ Completely Supported
- ⚠️ Supported with Limitations
- ❌ Not Supported
- No icon: Unknown (open a pull request to fill in the blanks)

### Footnotes

1) Only with third party extensions
2) Performance implications
3) Not on all platforms

## General

| **Topic**   | maplibre       | maplibre_gl    | flutter_map    | mapbox_maps_flutter  | google_maps_flutter |
|-------------|----------------|----------------|----------------|----------------------|---------------------|
| Licensing   | ✅ BSD-3-Clause | ✅ BSD-3-Clause | ✅ BSD-3-Clause | ⚠️ Mapbox TOS        | ✅ BSD-3-Clause      |
| Vendor-Free | ✅ yes          | ✅ yes          | ✅ yes          | ❌ Mapbox only        | ⚠️ Google API only  |
| Costs       | ✅ None         | ✅ None         | ✅ None         | ⚠️ Per user, per use | ⚠️ Per Use          |

## Core Functionality

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

## Annotation Layers

| **Layer** | maplibre | maplibre_gl | flutter_map | mapbox_maps_flutter | google_maps_flutter |
|-----------|----------|-------------|-------------|---------------------|---------------------|
| Widgets   | ✅        | ❌           | ✅           | ❌                   | ⚠️ 1                |
| Polygons  | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Polylines | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Circles   | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Markers   | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| Heatmap   | ✅        | ✅           | ⚠️ 1        | ✅                   | ⚠️ 1                |

## Platform Support

| **Platform** | maplibre | maplibre_gl | flutter_map | mapbox_maps_flutter | google_maps_flutter |
|--------------|----------|-------------|-------------|---------------------|---------------------|
| Android      | ✅        | ✅           | ✅           | ✅                   | ✅                   |
| iOS          | ❌        | ✅           | ✅           | ✅                   | ✅                   |
| Web          | ✅        | ✅           | ✅           | ❌                   | ✅                   |
| Windows      | ❌        | ❌           | ✅           | ❌                   | ❌                   |
| macOS        | ❌        | ❌           | ✅           | ❌                   | ❌                   |
| Linux        | ❌        | ❌           | ✅           | ❌                   | ❌                   |
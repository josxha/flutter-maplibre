---
title: 'Sources'
description: 'The data sources that style layers draw on the map.'
icon: lucide/database
---

# Sources

A source holds data for the map, and [style layers](../style-layers/index.md)
draw it. Several layers can use the same source, for example a fill and a line
layer for the areas and outlines of the same polygons.

| Source                                                     | Data                                                  | Shown by                          |
|------------------------------------------------------------|-------------------------------------------------------|-----------------------------------|
| [`GeoJsonSource`](geojson.md)                              | Points, lines and polygons, optionally clustered      | Circle, fill, heatmap, line, symbol layers |
| [`VectorSource`](tiles.md#vector-tiles)                    | Vector tiles (MVT or MLT), also from PMTiles and MBTiles | Circle, fill, heatmap, line, symbol layers |
| [`RasterSource`](tiles.md#raster-tiles)                    | Image tiles, such as satellite imagery                | Raster layer                      |
| [`RasterDemSource`](tiles.md#raster-dem-tiles)             | Elevation tiles                                       | Hillshade and color relief layers |
| [`ImageSource`](media.md#image)                            | One image at four coordinates                         | Raster layer                      |
| [`VideoSource`](media.md#video)                            | One video at four coordinates, only on web            | Raster layer                      |

Every source has a named constructor for its input, such as
`GeoJsonSource.url` and `GeoJsonSource.data`. Add sources once the style has
loaded:

```dart
MapLibreMap(
  onStyleLoaded: (style) async {
    await style.sources.add(
      const VectorSource.url(id: 'roads', url: 'https://example.com/tiles.json'),
    );
  },
)
```

## Read and update sources

`style.sources` holds the sources of the style. It reads synchronously, and is
filled once the style has loaded. Sources are immutable, so an update replaces
the object:

```dart
final source = style.sources['points'];

await style.sources.updateGeoJsonData('points', .text(geoJsonString));
await style.sources.updateGeoJsonUrl('points', 'https://example.com/data.geojson');
await style.sources.updateImageCoordinates('radar', coordinates);
await style.sources.updateTiles('roads', ['https://example.com/{z}/{x}/{y}.pbf']);
await style.sources.updateTileJsonUrl('roads', 'https://example.com/tiles.json');
await style.sources.remove('points');
```

See [GeoJSON](geojson.md#update-the-data) and [Tiles](tiles.md) for what the
updates do.

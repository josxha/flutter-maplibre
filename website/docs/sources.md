---
sidebar_position: 70
---

# Sources

MapLibre can use a variety of different data sources for its style layers.
You can use the same source for multiple style layers.

## Data

### GeoJSON

You can use
the [GeoJsonSource](https://pub.dev/documentation/maplibre/latest/maplibre/GeoJsonSource-class.html)
to attach data like points, lines or polygons. The data can then be used in a
[StyleCircleLayer](style-layers/circle-layer),
[FillStyleLayer](style-layers/fill-layer),
[HeatmapStyleLayer](style-layers/heatmap-layer),
[LineStyleLayer](style-layers/line-layer) or
[SymbolStyleLayer](style-layers/symbol-layer).

An example use cases is to display and visualize any kind of data on the map.

## Media

### Image

Use
the [ImageSource](https://pub.dev/documentation/maplibre/latest/maplibre/ImageSource-class.html)
If you want to render an image on the map.

An example use case is to position a weather radar image on the map.

### Video

Likewise,
the [VideoSource](https://pub.dev/documentation/maplibre/latest/maplibre/VideoSource-class.html)
can be used to render a video on the map.

The video source is only supported on web.

## Tiles

The most common way to use a tile source is by an URL. This can either be

- the direct URL of a tile server, e.g. `https://example.com/{z}/{x}/{y}.mvt`
- the URL of a [TileJSON](https://github.com/mapbox/tilejson-spec) that provides
  a tile server with additional metadata, e.g. `https://example.com/tiles.json`
- a PMTiles file by adding `pmtiles://` in front of your url, e.g.
  `pmtiles://https://example.com/tiles.pmtiles` or
  `pmtiles://files://path/tiles.pmtiles`

### Raster Tiles

The [RasterSource](https://pub.dev/documentation/maplibre/latest/maplibre/RasterSource-class.html)
can be used to add a raster tile server. Raster tiles are images that are
positioned in a grid next to each other on the map. They are hosted on a tile
server that follows the format `z/x/y.png` or any other image file extension.

A common use case is to display a satellite map using
a [RasterStyleLayer](style-layers/raster-layer).

### Raster DEM Tiles

Raster DEM tiles are similar to regular [raster tiles](#raster-tiles) but are
used in the [HillshadeStyleLayer](style-layers/hillshade-layer) to display
elevation. Use
the [RasterDemSource](https://pub.dev/documentation/maplibre/latest/maplibre/RasterDemSource-class.html)
for it.

### Vector Tiles

Last but not least you can use
the [VectorSource](https://pub.dev/documentation/maplibre/latest/maplibre/VectorSource-class.html)
to supply the map with a source of Mapbox Vector Tiles (MVT). The data is then
shown in a combination of circle, fill, line and symbol layers on the map.
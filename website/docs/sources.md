---
icon: lucide/braces
---

# Sources

MapLibre can use a variety of different data sources for its style layers.
You can use the same source for multiple style layers.

## Data

### GeoJSON

You can use
the [GeoJsonSource](https://pub.dev/documentation/maplibre/latest/maplibre/GeoJsonSource-class.html)
to attach data like points, lines or polygons, from a GeoJSON file with
`GeoJsonSource.url` or a GeoJSON string with `GeoJsonSource.data`. The data can then be used in a
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
if you want to render an image on the map. `ImageSource.url` loads the image
from a URL, `ImageSource.bytes` takes an encoded image such as a PNG, and
`ImageSource.provider` takes any Flutter `ImageProvider`, for example an
`AssetImage` or a `FileImage`.

```dart
await style.sources.add(
  const ImageSource.provider(
    id: 'radar',
    image: AssetImage('assets/radar.png'),
    coordinates: LngLatQuad(
      topLeft: Geographic(lon: -80.425, lat: 46.437),
      topRight: Geographic(lon: -71.516, lat: 46.437),
      bottomRight: Geographic(lon: -71.516, lat: 37.936),
      bottomLeft: Geographic(lon: -80.425, lat: 37.936),
    ),
  ),
);
```

An example use case is to position a weather radar image on the map.

### Video

Likewise,
the [VideoSource](https://pub.dev/documentation/maplibre/latest/maplibre/VideoSource-class.html)
can be used to render a video on the map, from URLs with `VideoSource.urls`,
encoded video bytes with `VideoSource.bytes` or a Flutter asset with
`VideoSource.asset`.

The video source is only supported on web.

## Tiles

The most common way to use a tile source is by an URL. This can either be

- the direct URL of a tile server, e.g. `https://example.com/{z}/{x}/{y}.mvt`,
  with the `.tiles` constructor of a tile source
- the URL of a [TileJSON](https://github.com/mapbox/tilejson-spec) that provides
  a tile server with additional metadata, e.g. `https://example.com/tiles.json`,
  with the `.url` constructor
- a [PMTiles](#pmtiles) archive, with `pmtiles://` in front of its URL and
  the `.url` constructor

### PMTiles

A [PMTiles](https://docs.protomaps.com/pmtiles/) archive holds all tiles of a
tileset in one file. Pass its URL with `pmtiles://` in front to the `.url`
constructor of a `VectorSource`, `RasterSource` or `RasterDemSource`, or use
it as the `url` of a source in a style JSON. The archive replaces the
TileJSON, so don't use the `.tiles` constructor for it. For a
`RasterDemSource`, set the `encoding` that the archive's terrain tiles use,
for example `RasterDemTerrariumEncoding()` for Terrarium tiles; the default
is Mapbox Terrain RGB.

```dart
await style.sources.add(
  const VectorSource.url(
    id: 'protomaps',
    url: 'pmtiles://https://example.com/tiles.pmtiles',
  ),
);
```

- **Android, iOS, macOS, Windows and Linux**: MapLibre Native reads PMTiles
  itself, nothing to set up. Use `pmtiles://https://…` (or `http://`) for a
  remote archive and `pmtiles://file:///absolute/path/tiles.pmtiles` for a
  file on the device.
- **Web**: the plugin loads PMTiles together with MapLibre GL JS, see
  [Setup](getting-started/setup) to pin or self-host its version. Use
  `pmtiles://https://…` or `pmtiles://http://…`; a browser can't read local
  files, and blocks `http://` archives on a page served over `https://`.

The server must answer HTTP range requests, since the map reads only the parts
of the archive it needs. On web, it must also send CORS headers.

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

## Read and update sources

`style.sources` holds the sources of the style. It reads synchronously, and is
filled once the style has loaded. Sources are immutable, so an update replaces
the object:

```dart
final source = style.sources['points'];

await style.sources.updateGeoJsonData('points', geoJsonString);
await style.sources.updateGeoJsonUrl('points', 'https://example.com/data.geojson');
await style.sources.updateImageCoordinates('radar', coordinates);
await style.sources.updateTiles('roads', ['https://example.com/{z}/{x}/{y}.pbf']);
await style.sources.updateTileJsonUrl('roads', 'https://example.com/tiles.json');
await style.sources.remove('points');
```

On native maps, `updateTiles` and `updateTileJsonUrl` remove the layers that use
the source and add them back at their positions in one frame, as MapLibre Native
can't change them in place.

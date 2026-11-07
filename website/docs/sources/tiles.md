---
title: 'Tiles'
description: 'Vector, raster and elevation tiles from tile servers, PMTiles and MBTiles.'
icon: lucide/grid-3x3
---

# Tile Sources

Tile sources load the map data in tiles, only for the area and zoom level on
screen. The most common way to use a tile source is by a URL. This can either be

- the direct URL of a tile server, e.g. `https://example.com/{z}/{x}/{y}.mvt`,
  with the `.tiles` constructor of a tile source
- the URL of a [TileJSON](https://github.com/mapbox/tilejson-spec) that provides
  a tile server with additional metadata, e.g. `https://example.com/tiles.json`,
  with the `.url` constructor
- a [PMTiles](#pmtiles) archive, with `pmtiles://` in front of its URL and
  the `.url` constructor

## PMTiles

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

- **Android, iOS, macOS, Windows and Linux**: the map reads PMTiles itself.
  Use `pmtiles://https://…` (or `http://`) for a
  remote archive and `pmtiles://file:///absolute/path/tiles.pmtiles` for a
  file on the device.
- **Web**: the plugin loads PMTiles together with MapLibre GL JS, see
  [Setup](../getting-started/platforms.md#web) to pin or self-host its version. Use
  `pmtiles://https://…` or `pmtiles://http://…`; a browser can't read local
  files, and blocks `http://` archives on a page served over `https://`.

The server must answer HTTP range requests, since the map reads only the parts
of the archive it needs. On web, it must also send CORS headers.

## MBTiles

The map also reads [MBTiles](https://github.com/mapbox/mbtiles-spec) files on
the device, but not on web. Pass
`mbtiles://` followed by the absolute path of the file to the `.url`
constructor, for example `mbtiles:///data/tiles.mbtiles`. MBTiles are not
supported on web.

## Raster Tiles

The [RasterSource](https://pub.dev/documentation/maplibre/latest/maplibre/RasterSource-class.html)
can be used to add a raster tile server. Raster tiles are images that are
positioned in a grid next to each other on the map. They are hosted on a tile
server that follows the format `z/x/y.png` or any other image file extension.

A common use case is to display a satellite map using
a [RasterStyleLayer](../style-layers/index.md#raster).

## Raster DEM Tiles

Raster DEM tiles are similar to regular [raster tiles](#raster-tiles) but are
used in the [HillshadeStyleLayer](../style-layers/index.md#hillshade) to display
elevation. Use
the [RasterDemSource](https://pub.dev/documentation/maplibre/latest/maplibre/RasterDemSource-class.html)
for it.

## Vector Tiles

Last but not least you can use
the [VectorSource](https://pub.dev/documentation/maplibre/latest/maplibre/VectorSource-class.html)
to supply the map with a source of Mapbox Vector Tiles (MVT). The data is then
shown in a combination of circle, fill, line and symbol layers on the map.

## MapLibre Tiles (MLT)

A vector source can also serve [MapLibre Tiles](https://maplibre.org/maplibre-tile-spec/)
instead of MVT. Set `"encoding": "mlt"` on the source in the style JSON.

Encoders such as [Martin](https://maplibre.org/martin/) compress integers with
FastPFOR. Create the map with `fastPforEnabled` to decode them; without it,
such tiles are dropped with the warning
`MLT parse failed: FastPFOR decoding is not enabled`. It is not needed on web,
where FastPFOR decoding is always enabled.

```dart
MapLibreMap(
  options: MapOptions(
    style: MapStyle.url('https://example.com/style-with-mlt.json'),
    fastPforEnabled: true,
  ),
)
```

## Update tiles

Change the tiles of a source with `style.sources.updateTiles` or
`style.sources.updateTileJsonUrl`. Not on web, they remove the layers that use
the source and add them back at their positions in one frame, as the map can't
change them in place there.

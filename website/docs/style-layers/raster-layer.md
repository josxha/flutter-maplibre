---
title: 'Raster'
description: 'Add Raster Tiles on the map.'
icon: lucide/image
---

# Raster Style Layer

The `RasterStyleLayer` is either used by the map style or can be added to the map
programmatically to render raster tiles on your map.

[![Raster Style Layer](../../assets/images/layers/raster_layer.jpg)](/demo/#/style-layers/raster)

## Basic Usage

```dart linenums="1" hl_lines="9-23"
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
      options: MapOptions(center: Geographic(lon: 9.17, lat: 47.68)),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: (style) async {
        const openStreetMap = RasterSource.tiles(
          id: _sourceId,
          tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
          maxZoom: 20,
          tileSize: 256,
          attribution:
          '<a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
        );
        await style.sources.add(openStreetMap);
        final layer = RasterStyleLayer(
          id: _layerId,
          sourceId: _sourceId,
        );
        await style.layers.add(layer);
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.4/examples/lib/style_layers_raster_page.dart)
to learn more.

## Style & Layout

Every property of the style spec is an optional parameter and a getter and
setter of the layer. See [Paint & Layout](paint-and-layout) and
[Expressions](expressions).

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
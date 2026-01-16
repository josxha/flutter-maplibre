---
sidebar_position: 1
title: 'Raster'
description: 'Add Raster Tiles on the map.'
---

# Raster Layer

The `RasterLayer` is either used by the map style or can be added to the map
programmatically to render raster tiles on your map.

[![Raster Layer](/img/layers/raster_layer.jpg)](/demo/#/layers/raster)

## Basic Usage

```dart
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
      options: MapOptions(center: Position(9.17, 47.68)),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: () async {
        // highlight-start
        const openStreetMap = RasterSource(
          id: _sourceId,
          tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
          maxZoom: 20,
          tileSize: 256,
          attribution:
          '<a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
        );
        await _controller.addSource(openStreetMap);
        const layer = RasterLayer(
          id: _layerId,
          sourceId: _sourceId,
        );
        await _controller.addLayer(layer);
        // highlight-end
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.1.2/example/lib/layers_raster_page.dart)
to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
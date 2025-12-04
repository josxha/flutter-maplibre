---
sidebar_position: 1
title: 'Hillshade'
description: 'Render elevation on the map.'
---

# Hillshade Layer

The `HillshadeLayer` is either used by the map style or can be added to the map
programmatically to use DEM tiles. Those tiles are used to render elevation on 
the map.

[![Hillshade Layer](/img/layers/hillshade_layer.jpg)](/demo/#/layers/hillshade)

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
        const hillshade = RasterDemSource(
          id: _sourceId,
          url: 'https://demotiles.maplibre.org/terrain-tiles/tiles.json',
          tileSize: 256,
        );
        await _controller.addSource(hillshade);
        const layer = HillshadeLayer(
          id: _layerId,
          sourceId: _sourceId,
          paint: {'hillshade-shadow-color': '#473B24'},
        );
        await _controller.addLayer(layer);
        // highlight-end
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_hillshade_page.dart)
to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
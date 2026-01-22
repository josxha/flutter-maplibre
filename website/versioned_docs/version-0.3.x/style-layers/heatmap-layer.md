---
sidebar_position: 1
title: 'Heatmap'
description: 'Add Heatmaps to the map.'
---

# Heatmap Style Layer

The `HeatmapStyleLayer` is either used by the map style or can be added to the map
programmatically to symbolize data on the map.

[![Heatmap Layer](/img/layers/heatmap_layer.jpg)](/demo/#/style-layers/heatmap)

## Basic Usage

```dart
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
      options: MapOptions(center: Geographic(lon: 9.17, lat: 47.68)),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: (style) async {
        // highlight-start
        const earthquakes = GeoJsonSource(
          id: _sourceId,
          data:
          'https://maplibre.org/maplibre-gl-js/docs/assets/earthquakes.geojson',
        );
        await style.addSource(earthquakes);
        const layer = HeatmapStyleLayer(id: _layerId, sourceId: _sourceId);
        await style.addLayer(layer);
        // highlight-end
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.3/example/lib/style_layers_heatmap_page.dart)
to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
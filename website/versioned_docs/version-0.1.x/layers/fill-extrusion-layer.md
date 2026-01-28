---
sidebar_position: 1
title: 'Fill Extrusion'
description: 'Add 3D building outlines to the map.'
---

# Fill Extrusion Layer

The `FillExtrusionLayer` is either used by the map style or can be added to the
map programmatically to symbolize data on the map.

[![Fill Extrusion Layer](/img/layers/fill_extrusion_layer.jpg)](/demo/#/layers/fill-extrusion)

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
        await _controller.addSource(
          const GeoJsonSource(
            id: _sourceId,
            data:
            'https://maplibre.org/maplibre-gl-js/docs/assets/indoor-3d-map.geojson',
          ),
        );
        await _controller.addLayer(_fillExtrusionLayer);
        // highlight-end
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.1.2/example/lib/layers_fill_extrusion_page.dart)
to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
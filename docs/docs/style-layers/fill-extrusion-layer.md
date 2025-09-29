---
sidebar_position: 1
title: 'Fill Extrusion'
description: 'Add 3D building outlines to the map.'
---

# Fill Extrusion Style Layer

The `FillExtrusionStyleLayer` is either used by the map style or can be added to the
map programmatically to symbolize data on the map.

[![Fill Extrusion Style Layer](/img/layers/fill_extrusion_layer.jpg)](/demo/#/style-layers/fill-extrusion)

## Basic Usage

```dart
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
      options: MapOptions(center: Geographic(lon: 9.17, lat: 47.68)),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: (style) async {
        // add the tile source
        // highlight-start
        await style.addSource(
          const GeoJsonSource(
            id: _sourceId,
            data:
            'https://maplibre.org/maplibre-gl-js/docs/assets/indoor-3d-map.geojson',
          ),
        );
        // highlight-end
        const layer = FillExtrusionStyleLayer(
          id: 'room-extrusion',
          sourceId: _sourceId,
          paint: {
            // See the MapLibre Style Specification for details on data expressions.
            // https://maplibre.org/maplibre-style-spec/expressions/
            'fill-extrusion-color': ['get', 'color'],
            'fill-extrusion-height': ['get', 'height'],
            'fill-extrusion-base': ['get', 'base_height'],
            'fill-extrusion-opacity': 0.5
          },
        );
        // add the layer
        // highlight-start
        await style.addLayer(layer);
        // highlight-end
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/style-layers_circle_page.dart)
for to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
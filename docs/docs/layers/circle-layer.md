---
sidebar_position: 1
description: 'Add Circles to the map.'
---

# Circle Layer

The `CircleLayer` is either used by the map style or can be added to the map
programmatically to symbolize data on the map.

[![Circle Layer](/img/layers/circle_layer.jpg)](/demo/#/layers/circle)

## Basic Usage

```dart
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Events')),
    body: MapLibreMap(
        options: MapOptions(center: Position(9.17, 47.68)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: () async {
          // highlight-start
          // add the source
          const earthquakes = GeoJsonSource(
            id: _sourceId,
            data:
            'https://maplibre.org/maplibre-gl-js/docs/assets/earthquakes.geojson',
          );
          await _controller.addSource(earthquakes);

          // add the source with a layer on the map
          const circleLayer = CircleLayer(id: _layerId, sourceId: _sourceId);
          await _controller.addLayer(circleLayer);
          // highlight-end
        }
    ),
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_circle_page.dart)
for to learn more.

## Style

Use the `paint` property to style your `CircleLayer` to change the style of the
map.

See
the [MapLibre Style Specification](https://maplibre.org/maplibre-style-spec/layers/#circle)
for all available properties.

## Layout

Use the `layout` property to change how the circles behave on the map.
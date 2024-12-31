---
sidebar_position: 1
title: 'Marker'
description: 'Add Markers to the map.'
---

# Marker Annotations

Markers are a way to show data on the map with labels and/or icons.

<a href="/demo/#/layers/marker">
<img src="/img/annotations/annotations-markers.jpg" 
     alt="Markers" />
</a>

## Basic Usage

```dart
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(center: Position(9.17, 47.68)),
    onEvent: (event) async {
      switch (event) {
        case MapEventMapCreated():
          _controller = event.mapController;
        case MapEventStyleLoaded():
          // add marker image to map
          // highlight-start
          final response =
          await http.get(Uri.parse(LayersSymbolPage.imageUrl));
          final bytes = response.bodyBytes;
          await _controller.addImage('marker', bytes);
          // highlight-end
        case MapEventClick():
        // add a new marker on click
          setState(() {
            _points.add(Point(coordinates: event.point));
          });
        default:
        // ignore all other events
          break;
      }
    },
    layers: [
      // highlight-start
      MarkerLayer(
        points: <Point>[
          Point(coordinates: Position(9.17, 47.68)),
          Point(coordinates: Position(9.17, 48)),
          Point(coordinates: Position(9, 48)),
          Point(coordinates: Position(9.5, 48)),
        ],
        textField: 'Marker',
        textAllowOverlap: true,
        iconImage: 'marker',
        iconSize: 0.08,
        iconAnchor: IconAnchor.bottom,
        textOffset: const [0, 1],
      ),
      // highlight-end
    ],
  );
}
```

That's it! You can add multiple `MarkerLayer`s with different
properties.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_marker_page.dart)
if you want to see how things come together.

## Style & Layout

The `MarkerLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Markers, you can use the more
low level [SymbolLayer](../style-layers/symbol-layer).
---
title: 'Marker'
description: 'Add Markers to the map.'
icon: lucide/map-pin
---

# Marker Annotations

Markers are a way to show data on the map with labels and/or icons.

<a href="/demo/#/layers/marker">
<img src="/assets/images/annotations/annotations-markers.jpg" 
     alt="Markers" />
</a>

## Basic Usage

```dart linenums="1" hl_lines="13-16 28-41"
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(center: Geographic(lon: 9.17, lat: 47.68)),
    onEvent: (event) async {
      switch (event) {
        case MapEventMapCreated():
          _controller = event.mapController;
        case MapEventStyleLoaded():
          // add marker image to map
          final response =
          await http.get(Uri.parse(LayersSymbolPage.imageUrl));
          final bytes = response.bodyBytes;
          await _controller.addImage('marker', bytes);
        case MapEventClick():
        // add a new marker on click
          setState(() {
            _points.add(Point(event.point));
          });
        default:
        // ignore all other events
          break;
      }
    },
    layers: [
      MarkerLayer(
        points: <Point>[
          Point(Geographic(lon: 9.17, lat: 47.68)),
          Point(Geographic(lon: 9.17, lat: 48)),
          Point(Geographic(lon: 9, lat: 48)),
          Point(Geographic(lon: 9.5, lat: 48)),
        ],
        textField: 'Marker',
        textAllowOverlap: true,
        iconImage: 'marker',
        iconSize: 0.08,
        iconAnchor: IconAnchor.bottom,
        textOffset: const [0, 1],
      ),
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
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.4/examples/lib/layers_marker_page.dart)
if you want to see how things come together.

## Style & Layout

The `MarkerLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Markers, you can use the more
low level [SymbolLayer](../style-layers/symbol-layer).
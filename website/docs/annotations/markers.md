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

```dart linenums="1" hl_lines="13-20 28-36"
bool _imageLoaded = false;
final _points = <Feature<Point>>[
  const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
  const Feature(geometry: Point(Geographic(lon: 9, lat: 48))),
];

@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
    onEvent: (event) async {
      switch (event) {
        case MapEventStyleLoaded():
          // add a marker image to the map
          await event.style.addImageFromIconData(
            id: 'marker',
            iconData: Icons.location_on,
            color: Colors.red,
          );
          setState(() => _imageLoaded = true);
        case MapEventClick():
          // add a new marker on click
          setState(() => _points.add(Feature(geometry: Point(event.point))));
        default:
          break;
      }
    },
    layers: [
      MarkerLayer(
        points: _points,
        textField: const .literal('Marker'),
        textAllowOverlap: const .literal(true),
        iconImage: _imageLoaded ? const .literal('marker') : null,
        iconAnchor: const .literal(IconAnchor.bottom),
        textOffset: const .literal(Offset(0, 1)),
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
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/examples/lib/layers_marker_page.dart)
if you want to see how things come together.

## Style & Layout

The `MarkerLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Markers, you can use the more
low level [SymbolLayer](../style-layers/symbol-layer).
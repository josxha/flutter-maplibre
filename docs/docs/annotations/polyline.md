---
sidebar_position: 3
title: 'Polyline'
description: 'Add Polylines to the map.'
---

# Polyline Annotations

Polylines are way to show paths or similar on the map.

<a href="/demo/#/annotations/polyline">
<img src="/img/annotations/annotations-polyline.jpg" 
     alt="Polylines" />
</a>

## Basic Usage

```dart
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
    layers: [
      // highlight-start
      PolylineAnnotationLayer(
        polylines: <LineString>[
          LineString(
            coordinates: [
              Position(9.17, 47.68),
              Position(9.5, 48),
              Position(9, 48),
            ],
          ),
        ],
        color: Colors.red,
        width: 4,
        blur: 3,
        dashArray: const [5, 5],
      ),
      // highlight-end
    ],
  );
}
```

That's it! You can add multiple `PolylineAnnotationLayer`s with different
properties.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/annotations_polyline_page.dart)
if you want to see how things come together.

## Style & Layout

The `PolylineAnnotationLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Polylines, you can use the more
low level [LineLayer](../layers/line-layer).
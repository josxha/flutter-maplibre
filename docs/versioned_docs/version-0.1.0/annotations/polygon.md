---
sidebar_position: 4
title: 'Polygon'
description: 'Add Polygons to the map.'
---

# Polygon Annotations

Polygons are way to highlight an area on the map.

<a href="/demo/#/annotations/polygon">
<img src="/img/annotations/annotations-polygon.jpg" 
     alt="Polygons" />
</a>

## Basic Usage

```dart
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
    layers: [
      // highlight-start
      PolygonAnnotationLayer(
        polygons: <Polygon>[
          Polygon(
            coordinates: [
              [
                Position(9.17, 47.68),
                Position(9.5, 48),
                Position(9, 48),
              ],
            ],
          ),
        ],
        color: Colors.lightBlueAccent.withOpacity(0.6),
        outlineColor: Colors.blue,
      ),
      // highlight-end
    ],
  );
}
```

That's it! You can add multiple `PolygonAnnotationLayer`s with different
properties.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/annotations_polygon_page.dart)
if you want to see how things come together.

## Style & Layout

The `PolygonAnnotationLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Polygons, you can use the more
low level [FillLayer](../layers/fill-layer).
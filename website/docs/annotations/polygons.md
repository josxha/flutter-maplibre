---
title: 'Polygon'
description: 'Add Polygons to the map.'
icon: lucide/square
---

# Polygon Annotations

Polygons are way to highlight an area on the map.

<a href="/demo/#/layers/polygon">
<img src="/assets/images/annotations/annotations-polygon.jpg" 
     alt="Polygons" />
</a>

## Basic Usage

```dart linenums="1" hl_lines="6-25"
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
    layers: [
      PolygonLayer(
        polygons: [
          Feature(
            geometry: Polygon.from(const [
              [
                Geographic(lon: 8.2013, lat: 48.1074),
                Geographic(lon: 8.8853, lat: 48.0943),
                Geographic(lon: 8.7597, lat: 47.6933),
                Geographic(lon: 9.6320, lat: 48.0893),
                Geographic(lon: 8.6854, lat: 48.4538),
                Geographic(lon: 8.2013, lat: 48.1074),
              ],
            ]),
          ),
        ],
        color: .literal(Colors.lightBlueAccent.withValues(alpha: 0.6)),
        outlineColor: const .literal(Colors.blue),
      ),
    ],
  );
}
```

That's it! You can add multiple `PolygonLayer`s with different
properties.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/examples/lib/layers_polygon_page.dart)
if you want to see how things come together.

## Style & Layout

The `PolygonLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Polygons, you can use the more
low level [FillLayer](../style-layers/fill-layer).
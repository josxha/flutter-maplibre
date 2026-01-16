---
sidebar_position: 4
title: 'Polygon'
description: 'Add Polygons to the map.'
---

# Polygon Annotations

Polygons are way to highlight an area on the map.

<a href="/demo/#/layers/polygon">
<img src="/img/annotations/annotations-polygon.jpg" 
     alt="Polygons" />
</a>

## Basic Usage

```dart
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(zoom: 7, center: Geographic(lon: 9.17, lat: 47.68)),
    layers: [
      // highlight-start
      PolygonLayer(
        polygons: <Polygon>[
          Polygon(
            coordinates: [
              [
                Geographic(lon: 8.201306116882563, lat: 48.107357488669464),
                Geographic(lon: 8.885254895692924, lat: 48.09428546381665),
                Geographic(lon: 8.759684141159909, lat: 47.69326800157776),
                Geographic(lon: 9.631980099303235, lat: 48.08929468133098),
                Geographic(lon: 8.68543348810175, lat: 48.45383566718806),
                Geographic(lon: 8.201306116882563, lat: 48.107357488669464),
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

That's it! You can add multiple `PolygonLayer`s with different
properties.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.3/example/lib/layers_polygon_page.dart)
if you want to see how things come together.

## Style & Layout

The `PolygonLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Polygons, you can use the more
low level [FillLayer](../style-layers/fill-layer).
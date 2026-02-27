---
title: 'Polyline'
description: 'Add Polylines to the map.'
icon: lucide/line-squiggle
---

# Polyline Annotations

Polylines are way to show paths or similar on the map.

<a href="/demo/#/layers/polyline">
<img src="/assets/images/annotations/annotations-polyline.jpg" 
     alt="Polylines" />
</a>

## Basic Usage

```dart linenums="1" hl_lines="6-20"
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(zoom: 7, center: Geographic(lon: 9.17, lat: 47.68)),
    layers: [
      PolylineLayer(
        polylines: <LineString>[
          LineString(
            coordinates: [
              Geographic(lon: 9.17, lat: 47.68),
              Geographic(lon: 9.5, lat: 48),
              Geographic(lon: 9, lat: 48),
            ],
          ),
        ],
        color: Colors.red,
        width: 4,
        blur: 3,
        dashArray: const [5, 5],
      ),
    ],
  );
}
```

That's it! You can add multiple `PolylineLayer`s with different
properties.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.4/examples/lib/layers_polyline_page.dart)
if you want to see how things come together.

## Style & Layout

The `PolylineLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Polylines, you can use the more
low level [LineLayer](../style-layers/line-layer).
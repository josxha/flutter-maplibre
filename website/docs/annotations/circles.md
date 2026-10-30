---
title: 'Circle'
description: 'Add Circles to the map.'
icon: lucide/circle
---

# Circle Annotations

Circles are a simple way to show data on the map.

<a href="/demo/#/layers/circle">
<img src="/assets/images/annotations/annotations-circles.jpg" 
     alt="Circles" />
</a>

## Basic Usage

```dart linenums="1" hl_lines="6-17"
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(center: Geographic(lon: 9.17, lat: 47.68)),
    layers: [
      CircleLayer(
        points: <Point>[
          Point(Geographic(lon: 9.17, lat: 47.68)),
          Point(Geographic(lon: 9.17, lat: 48)),
          Point(Geographic(lon: 9, lat: 48)),
          Point(Geographic(lon: 9.5, lat: 48)),
        ],
        color: .literal(Colors.orange.withOpacity(0.5)),
        radius: .literal(20),
        strokeColor: .literal(Colors.red),
        strokeWidth: .literal(2),
      ),
    ],
  );
}
```

That's it! You can add multiple `CircleLayer`s with different
properties.

## Style each feature

Every style field is an [expression](../style-layers/expressions), so it can
depend on the properties of the feature:

```dart
CircleLayer(
  points: points,
  radius: .get('size').asNumber(),
  color: .get('color').convertToColor(),
)
```

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.4/examples/lib/layers_circle_page.dart)
if you want to see how things come together.

## Style & Layout

The `CircleLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Circles, you can use the more
low level [CircleLayer](../style-layers/circle-layer).
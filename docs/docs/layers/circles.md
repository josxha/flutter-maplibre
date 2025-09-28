---
sidebar_position: 2
title: 'Circle'
description: 'Add Circles to the map.'
---

# Circle Annotations

Circles are a simple way to show data on the map.

<a href="/demo/#/layers/circle">
<img src="/img/annotations/annotations-circles.jpg" 
     alt="Circles" />
</a>

## Basic Usage

```dart
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(center: Geographic(lon: 9.17, lat: 47.68)),
    layers: [
      // highlight-start
      CircleLayer(
        points: <Point>[
          Point(Geographic(lon: 9.17, lat: 47.68)),
          Point(Geographic(lon: 9.17, lat: 48)),
          Point(Geographic(lon: 9, lat: 48)),
          Point(Geographic(lon: 9.5, lat: 48)),
        ],
        color: Colors.orange.withOpacity(0.5),
        radius: 20,
        strokeColor: Colors.red,
        strokeWidth: 2,
      ),
      // highlight-end
    ],
  );
}
```

That's it! You can add multiple `CircleLayer`s with different
properties.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_circle_page.dart)
if you want to see how things come together.

## Style & Layout

The `CircleLayer` has a lot of parameters you can use for styling.

If you need more powerful customizations for your Circles, you can use the more
low level [CircleLayer](../style-layers/circle-layer).
---
sidebar_position: 1
title: 'Line'
description: 'Add Lines to the map.'
---

# Line Layer

The `LineLayer` is either used by the map style or can be added to the map
programmatically to symbolize data on the map.

[![Line Layer](/img/layers/line_layer.jpg)](/demo/#/layers/line)

## Basic Usage

```dart
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
      options: MapOptions(center: Position(9.17, 47.68)),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: () async {
        // highlight-start
        final geojsonLine = await rootBundle.loadString('assets/geojson/path.json');
        await _controller.addSource(
          GeoJsonSource(id: 'Path', data: geojsonLine),
        );
        await _controller.addLayer(
          const LineLayer(
            id: 'geojson-line',
            sourceId: 'Path',
            paint: {'line-color': '#F00', 'line-width': 3},
          ),
        );
        // highlight-end
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.1.2/example/lib/layers_line_page.dart)
to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
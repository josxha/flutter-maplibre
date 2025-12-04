---
sidebar_position: 1
title: 'Line'
description: 'Add Lines to the map.'
---

# Line Style Layer

The `LineStyleLayer` is either used by the map style or can be added to the map
programmatically to symbolize data on the map.

[![Line Style Layer](/img/layers/line_layer.jpg)](/demo/#/style-layers/line)

## Basic Usage

```dart
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
      options: MapOptions(center: Geographic(lon: 9.17, lat: 47.68)),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: (style) async {
        // highlight-start
        final geojsonLine = await rootBundle.loadString('assets/geojson/path.json');
        await style.addSource(
          GeoJsonSource(id: 'Path', data: geojsonLine),
        );
        await style.addLayer(
          const LineStyleLayer(
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
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/style-layers_line_page.dart)
to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
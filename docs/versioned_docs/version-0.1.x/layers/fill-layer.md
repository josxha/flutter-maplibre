---
sidebar_position: 1
title: 'Fill'
description: 'Add Polygons to the map.'
---

# Fill Layer

The `FillLayer` is either used by the map style or can be added to the map
programmatically to symbolize data on the map.

[![Fill Layer](/img/layers/fill_layer.jpg)](/demo/#/layers/fill)

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
        final geojsonPolygon =
        await rootBundle.loadString('assets/geojson/lake-constance.json');
        await _controller.addSource(
          GeoJsonSource(id: 'LakeConstance', data: geojsonPolygon),
        );
        await _controller.addLayer(
          const FillLayer(
            id: 'geojson-fill',
            sourceId: 'LakeConstance',
            paint: {'fill-color': '#429ef5'},
          ),
        );
        // highlight-end
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_fill_page.dart)
to learn more.

## Style & Layout

Use the `paint` property to change the style and the `layout`
property to change the behavior on the map.

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
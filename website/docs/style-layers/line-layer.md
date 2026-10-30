---
title: 'Line'
description: 'Add Lines to the map.'
icon: lucide/line-squiggle
---

# Line Style Layer

The `LineStyleLayer` is either used by the map style or can be added to the map
programmatically to symbolize data on the map.

[![Line Style Layer](../../assets/images/layers/line_layer.jpg)](/demo/#/style-layers/line)

## Basic Usage

```dart linenums="1" hl_lines="9-19"
late final MapController _controller;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
      options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: (style) async {
        final geojsonLine = await rootBundle.loadString('assets/geojson/path.json');
        await style.sources.add(
          GeoJsonSource.data(id: 'Path', data: geojsonLine),
        );
        await style.layers.add(
          LineStyleLayer(
            id: 'geojson-line',
            sourceId: 'Path',
            color: const .literal(Color(0xFFFF0000)),
            width: const .literal(3),
          ),
        );
      }
  );
}
```

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/examples/lib/style_layers_line_page.dart)
to learn more.

## Style & Layout

Every property of the style spec is an optional parameter and a getter and
setter of the layer. See [Paint & Layout](paint-and-layout) and
[Expressions](expressions).

Read the [Paint & Layout](./paint-and-layout) chapter to learn more on this
topic. 
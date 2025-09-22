---
sidebar_position: 10
title: 'Widget'
description: 'Add Flutter Widget to the map.'
---

# Widget Annotations

The `WidgetLayer` jumps a bit out of the row when compared to the other
annotation layers.

## Differences to other Layers

- The `WidgetLayer` is the only built-in map layer that has support for all kind
  of flutter widgets.
- As the `WidgetLayer` is just a Widget itself, it needs to be placed in
  the `children` list. All the map layers need to be placed in the `layers`
  list.
- `WidgetLayer`s will always be displayed above other layers as it is not part
  of the map style but displayed above.

## Basic Usage

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Widget Layer')),
    body: MapLibreMap(
      options: MapOptions(
        initZoom: 3,
        initCenter: Geographic(lon: 0, lat: 0),
      ),
      children: [
        // highlight-start
        WidgetLayer(
          markers: [
            Marker(
              // must be the same dimension as the inner widget
              size: const Size.square(50),
              // the longitude / latitude position on the map
              point: Geographic(lon: -10, lat: 0),
              // child can be any flutter widget tree
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                // must be the same as Marker.size
                size: 50,
              ),
              // the used Icon should be attached to the map at the bottom center 
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
        // highlight-end
        // display the UI widgets above the widget markers.
        const SourceAttribution(),
      ],
    ),
  );
}
```

By default, widgets in the `WidgetLayer` will stay upright when the map gets
rotated or pitched. You are able to change this behavior with the `flat`
and `rotate` flags.

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/widget_layer_page.dart)
if you want to see how things come together.

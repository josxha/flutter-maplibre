---
title: 'Annotation Layers'
description: 'Show circles, markers, polygons and polylines on the map and update them with setState().'
icon: lucide/map-pin
---

# Annotation Layers

Annotation layers show your own points, lines and areas on the map. Put them
in the `MapLibreMap.layers` list and change them like any other widget
parameter, with `setState()` or the state management of your choice. The map
adds, updates and removes only what changed.

| Layer                         | Geometry       | Built on                                                       |
|-------------------------------|----------------|----------------------------------------------------------------|
| [`CircleLayer`](#circles)     | `Point`        | [`CircleStyleLayer`](../style-layers/index.md#circle)          |
| [`MarkerLayer`](#markers)     | `Point`        | [`SymbolStyleLayer`](../style-layers/index.md#symbol)          |
| [`PolygonLayer`](#polygons)   | `Polygon`      | [`FillStyleLayer`](../style-layers/index.md#fill)              |
| [`PolylineLayer`](#polylines) | `LineString`   | [`LineStyleLayer`](../style-layers/index.md#line)              |

Flutter widgets on the map go into a [`WidgetLayer`](widgets.md). For large or
frequently changing data, add a [source](../sources/index.md) and a
[style layer](../style-layers/index.md) to the style instead.

## Circles

<a href="../../demo/#/layers/circle">
<img src="../../assets/images/annotations/annotations-circles.jpg" alt="Circles" />
</a>

```dart linenums="1" hl_lines="5-16"
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
    layers: [
      CircleLayer(
        points: const [
          Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
          Feature(geometry: Point(Geographic(lon: 9.17, lat: 48))),
          Feature(geometry: Point(Geographic(lon: 9, lat: 48))),
          Feature(geometry: Point(Geographic(lon: 9.5, lat: 48))),
        ],
        color: .literal(Colors.orange.withValues(alpha: 0.5)),
        radius: const .literal(20),
        strokeColor: const .literal(Colors.red),
        strokeWidth: const .literal(2),
      ),
    ],
  );
}
```

See the
[example app](https://github.com/maplibre/flutter-maplibre/blob/main/examples/lib/layers_circle_page.dart).

## Markers

<a href="../../demo/#/layers/marker">
<img src="../../assets/images/annotations/annotations-markers.jpg" alt="Markers" />
</a>

Markers show an icon, a label or both. Add the icon image to the style first:

```dart linenums="1" hl_lines="11-17 22-29"
bool _imageLoaded = false;
final _points = <Feature<Point>>[
  const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
  const Feature(geometry: Point(Geographic(lon: 9, lat: 48))),
];

@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
    onStyleLoaded: (style) async {
      await style.addImageFromIconData(
        id: 'marker',
        iconData: Icons.location_on,
        color: Colors.red,
      );
      setState(() => _imageLoaded = true);
    },
    // add a marker where the user taps
    onClick: (event) =>
        setState(() => _points.add(Feature(geometry: Point(event.point)))),
    layers: [
      MarkerLayer(
        points: _points,
        textField: const .literal('Marker'),
        textAllowOverlap: const .literal(true),
        iconImage: _imageLoaded ? const .literal('marker') : null,
        iconAnchor: const .literal(IconAnchor.bottom),
        textOffset: const .literal(Offset(0, 1)),
      ),
    ],
  );
}
```

See the
[example app](https://github.com/maplibre/flutter-maplibre/blob/main/examples/lib/layers_marker_page.dart).

## Polygons

<a href="../../demo/#/layers/polygon">
<img src="../../assets/images/annotations/annotations-polygon.jpg" alt="Polygons" />
</a>

```dart linenums="1" hl_lines="5-23"
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

See the
[example app](https://github.com/maplibre/flutter-maplibre/blob/main/examples/lib/layers_polygon_page.dart).

## Polylines

<a href="../../demo/#/layers/polyline">
<img src="../../assets/images/annotations/annotations-polyline.jpg" alt="Polylines" />
</a>

```dart linenums="1" hl_lines="5-19"
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
    layers: [
      PolylineLayer(
        polylines: [
          Feature(
            geometry: LineString.from(const [
              Geographic(lon: 9.17, lat: 47.68),
              Geographic(lon: 9.5, lat: 48),
              Geographic(lon: 9, lat: 48),
            ]),
          ),
        ],
        color: const .literal(Colors.red),
        width: const .literal(4),
        blur: const .literal(3),
        dashArray: const .literal([5, 5]),
      ),
    ],
  );
}
```

See the
[example app](https://github.com/maplibre/flutter-maplibre/blob/main/examples/lib/layers_polyline_page.dart).

## Style each feature

Every style parameter is an [expression](../style-layers/expressions.md), so
it can depend on the properties of each feature:

```dart
CircleLayer(
  points: points,
  radius: .get('size').asNumber(),
  color: .get('color').convertToColor(),
)
```

A map can show any number of annotation layers, each with its own style. For
properties that the annotation layers don't have, use the
[style layer](../style-layers/index.md) they are built on.

## Interaction

- [Click and Hover](click-and-hover.md): react to taps and the mouse on
  features.
- [Drag](drag.md): let the user move features.

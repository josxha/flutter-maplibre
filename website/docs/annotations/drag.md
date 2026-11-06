---
title: 'Drag'
description: 'Let the user drag annotations on the map.'
icon: lucide/move
---

# Drag Annotations

Every annotation layer can let the user drag its features. Set `onDrag`, and
optionally `onDragStart` and `onDragEnd`. A drag that starts on a feature of
the layer moves that feature instead of the map.

<a href="/demo/#/layers/drag">Try it in the demo.</a>

## Basic Usage

The layer doesn't move the feature itself. It reports which feature in its
list is dragged and where to, and the app moves it, like any other change of
the layer:

```dart linenums="1" hl_lines="11-15"
final _points = <Feature<Point>>[
  const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
];

@override
Widget build(BuildContext context) {
  return MapLibreMap(
    layers: [
      CircleLayer(
        points: _points,
        radius: const .literal(16),
        onDrag: (event) => setState(() {
          _points[event.index] = Feature(geometry: Point(event.point));
        }),
        onDragEnd: (event) => print('dropped at ${event.point}'),
      ),
    ],
  );
}
```

`LayerDragEvent` holds:

- `index`: the dragged feature in the layer's list.
- `point` and `screenPoint`: where it moves to. A point feature keeps its
  offset from the pointer, so it doesn't jump when it is grabbed off its
  center.

## Details

- A drag grabs a feature within a few pixels of where it went down, the
  nearest one if several are close, of the top-most draggable layer.
- A drag that starts beside every draggable feature pans the map as usual.
- The map's own `onDragStart`, `onDrag` and `onDragEnd` still fire. The start
  event of a drag that grabbed a feature has `defaultPrevented` set.
- To drag something other than an annotation, such as the features of a
  style layer, use the map's [drag events](../events.md#drags).
- Widgets in a `WidgetLayer` take their own gestures, see
  [Widgets](widgets.md).

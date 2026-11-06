---
title: 'Drag'
description: 'Let the user drag annotations on the map.'
icon: lucide/move
---

# Drag Annotations

Every annotation layer can let the user drag its features. Set
`draggable: true`, and a drag that starts on a feature of the layer moves
that feature instead of the map.

<a href="/demo/#/layers/drag">Try it in the demo.</a>

## Basic Usage

The layer moves the feature itself while it is dragged, so the app doesn't
rebuild on every step. When the user drops it, save the new place in
`onDragEnd`. Otherwise the feature goes back where it was, because the list
of the layer still has it there:

```dart linenums="1" hl_lines="11-14"
final _points = <Feature<Point>>[
  const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
];

@override
Widget build(BuildContext context) {
  return MapLibreMap(
    layers: [
      CircleLayer(
        points: _points,
        draggable: true,
        onDragEnd: (event) => setState(() {
          _points[event.index] = Feature(geometry: Point(event.point));
        }),
      ),
    ],
  );
}
```

`onDragStart` and `onDrag` report the start and every step of the drag, for
example to show where the feature is. Each `LayerDragEvent` holds:

- `index`: the dragged feature in the layer's list.
- `geometry`: the feature's geometry, moved as far on screen as the pointer.
  A polygon or a line moves as a whole.
- `point` and `screenPoint`: where a point feature moves to, or where the
  pointer is for other features.

## Details

- A drag grabs a feature within a few pixels of where it went down, the
  nearest one if several are close, of the top-most draggable layer.
- A drag that starts beside every draggable feature pans the map as usual.
- While it is dragged, the feature is drawn by a layer of its own above its
  layer, so each step costs the same however many features the layer has.
- The map's own `onDragStart`, `onDrag` and `onDragEnd` still fire. The start
  event of a drag that grabbed a feature has `defaultPrevented` set.
- To drag something other than an annotation, such as the features of a
  style layer, use the map's [drag events](../events.md#drags).
- Widgets in a `WidgetLayer` take their own gestures, see
  [Widgets](widgets.md).

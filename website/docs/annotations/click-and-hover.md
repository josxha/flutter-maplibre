---
title: 'Click and Hover'
description: 'React to taps and the mouse on annotations.'
icon: lucide/mouse-pointer-click
---

# Click and Hover

Every annotation layer reports taps and the mouse on its features:

- `onClick`: the user tapped or clicked a feature.
- `onEnter`: a mouse or stylus moved onto a feature, or from one feature of
  the layer onto another.
- `onLeave`: the mouse or stylus left the feature that `onEnter` reported.

<a href="../../../demo/#/layers/hover">Try it in the demo.</a>

## Hover effect

Keep the hovered feature in the state and draw it again in a second, more
opaque layer:

```dart linenums="1" hl_lines="8-11"
int? _hovered;

@override
Widget build(BuildContext context) {
  return MapLibreMap(
    layers: [
      PolygonLayer(
        polygons: _areas,
        opacity: const .literal(0.3),
        onEnter: (event) => setState(() => _hovered = event.index),
        onLeave: (event) => setState(() => _hovered = null),
      ),
      PolygonLayer(
        polygons: [if (_hovered case final hovered?) _areas[hovered]],
        opacity: const .literal(0.6),
      ),
    ],
  );
}
```

## Details

- Each `LayerFeatureEvent` holds the feature's `index` in the layer's list,
  the `feature` itself, its `geometry`, and where the pointer is as `point`
  and `screenPoint`.
- Of features of several layers, a tap goes to the layer drawn on top, which
  [anchors](index.md#order-and-anchors) can make differ from the last in the
  list, and of its
  points to the nearest. A tap next to a small feature still hits it.
  `MapLibreMap.onClick` is called as well.
- `onEnter` and `onLeave` are tracked per layer, also while the list is
  reordered: moving from a feature of one
  layer onto an overlapping feature of a layer above enters the second
  without leaving the first.
- Touches don't hover, so `onEnter` and `onLeave` are only called for mice
  and styluses. Use `onClick` on touch screens.

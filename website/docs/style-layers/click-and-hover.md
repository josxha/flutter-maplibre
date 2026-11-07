---
title: 'Click and Hover'
description: 'React to taps and the mouse on the features of style layers.'
icon: lucide/mouse-pointer-click
weight: 110
---

# Click and Hover

Style layers with vector features report taps and the mouse on their
features while they are on a map:

- `onClick`: the user tapped or clicked a feature of the layer.
- `onEnter`: a mouse or stylus moved onto a feature of the layer.
- `onLeave`: the mouse or stylus left the feature that `onEnter` reported.

Set them as constructor parameters of a layer you add, or on a layer of the
loaded style:

```dart linenums="1"
Future<void> _onStyleLoaded(StyleController style) async {
  await style.sources.add(
    const GeoJsonSource.url(id: 'states', url: 'https://example.com/states.geojson'),
  );
  await style.layers.add(
    FillStyleLayer(
      id: 'states',
      sourceId: 'states',
      onClick: (event) => print(event.feature.properties['name']),
    ),
  );

  // A layer that came with the style.
  final roads = style.layers['roads'];
  roads?.onEnter = (event) => setState(() => _road = event.feature);
  roads?.onLeave = (event) => setState(() => _road = null);
}
```

## Details

- Each `StyleLayerFeatureEvent` holds the topmost `RenderedFeature` of the
  layer under the pointer, and where the pointer is as `point` and
  `screenPoint`.
- Every layer under a tap reports it, not only the topmost one, like gl-js
  `map.on('click', layerId, ...)`. `MapLibreMap.onClick` is called as well.
- Features with an id are told apart: moving from one onto another reports
  `onLeave` for the first and `onEnter` for the second. A layer of features
  without ids reports entering and leaving its features as a whole.
- Removing the layer or loading a new style ends the calls.
- `CircleStyleLayer`, `FillStyleLayer`, `FillExtrusionStyleLayer`,
  `HeatmapStyleLayer`, `LineStyleLayer` and `SymbolStyleLayer` report them.
- Touches don't hover, so `onEnter` and `onLeave` are only called for mice
  and styluses.
- For annotation layers, see
  [annotations: click and hover](../annotations/click-and-hover.md).

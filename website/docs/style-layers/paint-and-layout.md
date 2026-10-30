---
title: 'Paint & Layout'
description: 'Paint and Layout properties can be used to style your layers and change their behaviors.'
icon: lucide/paintbrush
weight: 100
---

# Paint & Layout Properties

While the annotation [Layers](../category/layers) can use simple values for
styling, [Style Layers](../category/style-layers) can use the powerful paint and layout
properties. See
the [MapLibre Style Specification](https://maplibre.org/maplibre-style-spec/layers)
for all available properties for the different layers.

Every property is a typed parameter of its layer class without the prefix of
the layer type, so `line-width` is `LineStyleLayer.width`, and takes an
[Expression](expressions) for zoom level dependent and data driven styling. A
`paint` and a `layout` map also take the JSON of the style spec, by property
name:

```dart
final layer = LineStyleLayer(
  id: 'route',
  sourceId: 'route',
  width: const .literal(4),
  cap: const .literal(LineCap.round),
  paint: {
    'line-color-transition': {'duration': 500},
  },
);
```

Creating these maps can be a bit tricky. In case you are not experienced, it is
recommended to build and test your paint and layout properties
in [Maputnik](https://maplibre.org/maputnik) first and copy it over.

[![Maputnik Paint Properties](../../assets/images/maputnik-paint.jpg)](https://maplibre.org/maputnik)
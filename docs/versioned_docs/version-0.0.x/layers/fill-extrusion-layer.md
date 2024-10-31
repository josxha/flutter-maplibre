---
sidebar_position: 1
description: 'Add 3D building outlines to the map.'
---

# Fill Extrusion Layer

:::info
The features described on this site have been added in version `0.1.1`.
:::

The `FillExtrusionLayer` is either used by the map style or can be added to the
map programmatically to symbolize data on the map.

[![Fill Extrusion Layer](/img/layers/fill_extrusion_layer.jpg)](/demo/#/layers/fill-extrusion)

## Basic Usage

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_fill_extrusion_page.dart)
to learn more.

## Style

Use the `paint` property to style your `FillExtrusionLayer` to change the style
of the map.

See
the [MapLibre Style Specification](https://maplibre.org/maplibre-style-spec/layers/#fill-extrusion)
for all available properties.

## Layout

Use the `layout` property to change how the
fill extrusions behave on the map.
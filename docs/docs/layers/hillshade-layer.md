---
sidebar_position: 1
description: 'Add Polygons to the map.'
---

# Hillshade Layer

The `HillshadeLayer` is either used by the map style or can be added to the map
programmatically to use DEM tiles. Those tiles are used to render elevation on 
the map.

[![Hillshade Layer](/img/layers/hillshade_layer.jpg)](https://flutter-maplibre.pages.dev/demo/#/layers/hillshade)

## Basic Usage

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_hillshade_page.dart)
to learn more.

## Hillshade Style

Use the `paint` property to style your `HillshadeLayer` to change the style of the
map.

See
the [MapLibre Style Specification](https://maplibre.org/maplibre-style-spec/layers/#hillshade)
for all available properties.

## Hillshade Layout

Use the `layout` property to change how the layer behave on the map.
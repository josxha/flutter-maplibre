---
sidebar_position: 1
description: 'Render elevation on the map.'
---

# Hillshade Layer

:::info
The features described on this site have been added in version `0.1.1`.
:::

The `HillshadeLayer` is either used by the map style or can be added to the map
programmatically to use DEM tiles. Those tiles are used to render elevation on 
the map.

[![Hillshade Layer](/img/layers/hillshade_layer.jpg)](/demo/#/layers/hillshade)

## Basic Usage

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_hillshade_page.dart)
to learn more.

## Style

Use the `paint` property to style your `HillshadeLayer` to change the style of the
map.

See
the [MapLibre Style Specification](https://maplibre.org/maplibre-style-spec/layers/#hillshade)
for all available properties.

## Layout

Use the `layout` property to change how the layer behave on the map.
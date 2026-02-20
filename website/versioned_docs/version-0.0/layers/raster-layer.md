---
sidebar_position: 1
description: 'Add Raster Tiles on the map.'
---

# Raster Layer

:::info
The features described on this site have been added in version `0.1.1`.
:::

The `RasterLayer` is either used by the map style or can be added to the map
programmatically to render raster tiles on your map.

[![Raster Layer](/img/layers/raster_layer.jpg)](/demo/#/layers/raster)

## Basic Usage

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.0.2/example/lib/layers_raster_page.dart)
to learn more.

## Style

Use the `paint` property to style your `RasterLayer` to change the style of the
map.

See
the [MapLibre Style Specification](https://maplibre.org/maplibre-style-spec/layers/#raster)
for all available properties.

## Layout

Use the `layout` property to change how the rasters
behave on the map.
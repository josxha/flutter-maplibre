---
sidebar_position: 1
description: 'Add Polygons to the map.'
---

# Raster Layer

The `RasterLayer` is either used by the map style or can be added to the map
programmatically to render raster tiles on your map.

[![Raster Layer](/img/layers/raster_layer.jpg)](https://flutter-maplibre.pages.dev/demo/#/layers/raster)

## Basic Usage

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/layers_raster_page.dart)
to learn more.

## Raster Style

Use the `paint` property to style your `RasterLayer` to change the style of the
map.

See
the [MapLibre Style Specification](https://maplibre.org/maplibre-style-spec/layers/#raster)
for all available properties.

## Raster Layout

Use the `layout` property to change how the rasters
behave on the map.
---
sidebar_position: 20
title: 'flutter_map'
description: 'Check this guide if you worked with flutter_map before and want to migrate to maplibre.'
---

# Migrate from flutter_map

This site will guide you though the process of migrating from the `flutter_map`
package.

In general, `maplibre` follows a more centric design when it comes to
functionality. While `flutter_map` offloads a lot of features like animations,
user location, caching, offline, geojson and so on to third party
plugins, the idea behind `maplibre` is to provide all code functionality out of
the box.

## Feature Parity

`maplibre` has the goal to have replacement for every
functionality `flutter_map` provides eventually. Check out
the [flutter_map parity](https://github.com/josxha/flutter-maplibre/labels/flutter_map%20parity)
label on GitHub to see what functionality is missing.

## Programmatic control

Programmatic control in `flutter_map` works via imperative calls to its
map controller. `maplibre` on the other hand makes use of declarative control
for a more natural integration into the Flutter ecosystem.

This means that properties that have no `init*` prefix can be updated using
Flutters' state management, like `setState()`.

Everything else can be applied using the `MapController` just as you would
in `flutter_map`.

## Annotations & Layers

`maplibre` has a similar concept as `flutter_map` on how to update
its `MapOptions` and `Layer`s. You can simply use Flutters' state management,
like `setState()` for updating. `Layer`s in `maplibre` can be placed in
the `MapLibreMap(layers: [...])` list as they are no widgets but converted and
passed to the native MapLibre SDKs for performant rendering.

As this declarative way comes with a performance impact (e.g. comparing
countless huge polygons on every frame takes some time) `maplibre` provides
direct access to the map style for performant operations. Checkout
the `StyleController` to learn more!

`flutter_map` and `maplibre` both have support to display regular Flutter
widgets or complete widget trees on top of the map. Use the `WidgetLayer` and
apply it in the `MapLibreMap(children: [...])` list.
`WidgetLayer`s can only be displayed above other map `Layer`s.

## UI Overlays

`maplibre` has a variety of built-in user interface widgets that overlay the
map. As they are all Widgets, you can apply as you would in `flutter_map`
in the `MapLibreMap(children: [...])` list.

Similar to the plugin system in `flutter_map`, you are able to build your own
extensive overlay widgets. You can access important map information in
your `build()` method with:

- `MapController.of(context)` / `MapController.maybeOf(context)`
- `MapOptions.of(context)` / `MapOptions.maybeOf(context)`
- `MapCamera.of(context)` / `MapCamera.maybeOf(context)`

## User Location & Permissions

`maplibre` has built-in user location functionality that can be accessed via
the `MapController` and a `PermissionManager` to handle location
permissions without the need of any third party package.
---
sidebar_position: 10
title: 'maplibre_gl'
description: 'Check this guide if you worked with maplibre_gl before and want to migrate to maplibre.'
---

# Migrate from maplibre_gl

This site will guide you though the process of migrating from the `maplibre_gl`
package, also known as `maplibre/flutter-maplibre-gl` on GitHub to this package.

## Feature Parity

`maplibre` has the goal to have replacement for every
functionality `maplibre_gl` provides eventually. Check out
the [maplibre_gl parity](https://github.com/josxha/flutter-maplibre/labels/maplibre_gl%20parity)
label on GitHub to see what functionality is missing.

## Programmatic control

Programmatic control in `maplibre_gl` works via imperative calls to its
map controller. `maplibre` on the other hand makes use of declarative control
for a more natural integration into the Flutter ecosystem.

This means that properties that have no `init*` prefix can be updated using
Flutters' state management, like `setState()`.

Everything else can be applied using the `MapController` just as you would
in `maplibre_gl`.

## Annotations & Layers

`maplibre` does not use things the `AnnotationManager` on Android. Instead, the
annotations are implemented in Dart in a way that feels natural for Flutter.

Use `Layer`s such as the `MarkerLayer` inside the `MapLibreMap(layers: [...])`
list. You can update your layers just like you would with any other Flutter
widget by using `setState()` or any other Flutter state management framework.

In case you need to display *lots* of annotations, `maplibre` provides you with
direct access to the style layer using `StyleSource`s and `StyleLayer`s. These
layers can be applied programmatically for example by using
methods such as `mapController.style?.addSource()` on the `StyleController`.

All Paint and Layout Expressions are supported as they can be applied via raw
lists. There is
an [open issue](https://github.com/josxha/flutter-maplibre/issues/72) for static
typed expressions. So if you are interested in it, consider give it an upvote.

## UI Overlays

`maplibre` focus heavily on a unified cross-platform experience and easy user
customization. Flutter has a great and easy way to build user interfaces. That's
why overlays like zoom buttons, a compass or the scale bar are re-implemented
using Flutter widgets.

As they are all Widgets, you can apply them in
the `MapLibreMap(children: [...])` list.

You are able to build your own extensive overlay widgets. You can access
important map information in your `build()` method with:

- `MapController.of(context)` / `MapController.maybeOf(context)`
- `MapOptions.of(context)` / `MapOptions.maybeOf(context)`
- `MapCamera.of(context)` / `MapCamera.maybeOf(context)`

## PermissionManager

`maplibre` has a built-in `PermissionManager` class to handle location
permissions without the need of any third party package.
---
sidebar_position: 5
---

# Programmatic Control

It is possible to update or change the `MapLibreMap` widget during its lifetime.

## The MapLibreMap widget

The `MapLibreMap` is used to specify
initial values. Parameters that don't begin with `init*` can be updated in a
declarative way just like any other Flutter Widget. The most simple way is to
use the `MapLibreMap` widget in a `StatefulWidget` and calling `setState()`.

## The MapController

The `MapController` can be used by either using the `onMapCreated` callback or
by listening in the `onEvent` callback for the `MapEventMapCreated` event type.

You can store the `MapController` in a field variable for later use.

## The StyleController

The `StyleController` is a construct to make style related operations on the
map. It can be used either by listening to the `MapEventStyleLoaded` event or
the `onStyleLoaded` callback.

After is is loaded you can access the `StyleController` at any time
from the `style` getter of `MapController`.
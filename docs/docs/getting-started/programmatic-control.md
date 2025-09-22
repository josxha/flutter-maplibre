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

```dart
@immutable
class MyMapWidget extends StatefulWidget {
  const MyMapWidget({super.key});

  @override
  State<MyMapWidget> createState() => _MyMapWidget();
}

class _MyMapWidget extends State<GesturesPage> {
  // Using this field to store the widget state
  // highlight-next-line
  bool _gesturesEnabed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLibreMap(
          options: MapOptions(
            // parameters that start with init* can't be updated
            initCenter: Geographic(lon: 9.17, lat: 47.68),
            initZoom: 3,
            // other parameters can be updated
            // highlight-start
            gestures: _gesturesEnabled
                ? MapGestures.all()
                : MapGestures.none(),
            // highlight-end
          ),
          onEvent: (event) {
            if (event case MapEventClick()) {
              // update the map widget using Flutters' state management
              // highlight-start
              setState() {
                _gesturesEnabed = !_gesturesEnabed;
              }
              // highlight-end
            }
          }
      ),
    );
  }
}
```

All parameters that start with `init*` can't be updated using this method and
need to use the [MapController](#the-mapcontroller) or
the [StyleController](#the-stylecontroller).

## The MapController

The `MapController` can be used by either using the `onMapCreated` callback or
by listening in the `onEvent` callback for the `MapEventMapCreated` event type.

You can store the `MapController` in a field variable for later use.

```dart
class _MyMapWidget extends State<GesturesPage> {
  // highlight-next-line
  MapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLibreMap(
          options: MapOptions(initCenter: Geographic(lon: 9.17, lat: 47.68), initZoom: 3),
          onEvent: (event) {
            // check if the MapEvent type is a MapEventMapCreated
            if (event case MapEventMapCreated()) {
              // store the MapController for later use
              // highlight-next-line
              _mapController = event.mapController;
            }
          }
      ),
    );
  }
}
```

## The StyleController

The `StyleController` is a construct to make style related operations on the
map. It can be used either by listening to the `MapEventStyleLoaded` event or
the `onStyleLoaded` callback.

After is is loaded you can access the `StyleController` at any time
from the `style` getter of `MapController`.

```dart
class _MyMapWidget extends State<GesturesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLibreMap(
          options: MapOptions(initCenter: Geographic(lon: 9.17, lat: 47.68), initZoom: 3),
          onEvent: (event) {
            // check if the MapEvent type is a MapEventStyleLoaded
            if (event case MapEventStyleLoaded()) {
              // This event gets emitted every time a style finishes loading.
              // highlight-start
              event.style.addSource(...);
              event.style.addLayer(...);
              // highlight-end
            }
          }
      ),
    );
  }
}
```

Another way to access the `StyleController` is by calling the `style` getter on
the `MapController`. Modifications on the map style are only possible after the
style has been loaded. In case it hasn't loaded, the getter returns null.

```dart
MapController? _mapController;

void doSomething() {
  // only adds the source if the style has finished loading and a source can be added.
  // highlight-next-line
  _mapController?.style?.addSource(...);
}
```
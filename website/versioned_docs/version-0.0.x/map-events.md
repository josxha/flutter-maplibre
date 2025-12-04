---
sidebar_position: 6
---

# Map Events

:::info
The features described on this site have been added in version `0.1.1`.
:::

The event system is the used if you want to listen to any user interactions or
state changes on the map.

## Basic Usage

To listen to map events, implement a callback function for the `onEvent`
parameter.

```dart
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Events')),
    body: MapLibreMap(
      options: MapOptions(center: Position(9.17, 47.68)),
      // highlight-start
      onEvent: _onEvent,
      // highlight-end
    ),
  );
}

void _onEvent(event) {
  print(event.runtimeType);

  // check for the event type
  // highlight-start
  if (event is MapEventClicked) {
    print('The map has been clicked at ${event.point.lng}, ${event.point.lat}');
  }
  // highlight-end

  // or use a switch statement to listen to all the events you are interested in
  // highlight-start
  switch (event) {
    case MapEventMapCreated():
      print('map created');
    case MapEventStyleLoaded():
      print('style loaded');
    default:
    // ignore all other events
  }
  // highlight-end
}
```

## Available Events

- [MapLibre GL JS MapEventType](https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/MapEventType/)
- [MapLibre Native Android Listeners](https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.maps/-map-view/index.html)

| Flutter                  | Web         | Android                           | iOS | Windows | MacOS | Linux |
|--------------------------|-------------|-----------------------------------|-----|---------|-------|-------|
| MapEventMapCreated       |             |                                   |     |         |       |       |
| MapEventStyleLoaded      | load        | (OnDidFinishLoadingStyleListener) |     |         |       |       |
| MapEventClicked          | click       | OnMapClickListener                |     |         |       |       |
| MapEventDoubleClicked    | dblclick    |                                   |     |         |       |       |
| MapEventSecondaryClicked | contextmenu |                                   |     |         |       |       |
| MapEventLongClicked      |             | OnMapLongClickListener            |     |         |       |       |
| MapEventIdle             | idle        | OnDidBecomeIdleListener           |     |         |       |       |
|                          | mousedown   |                                   |     |         |       |       |
| MapEventStartMoveCamera  |             | OnCameraMoveStartedListener       |     |         |       |       |
| MapEventMoveCamera       | move        | OnCameraMoveListener              |     |         |       |       |
| MapEventCameraIdle       | moveend     | OnCameraMoveCanceledListener      |     |         |       |       |

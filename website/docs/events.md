---
icon: lucide/send
---

# Events

The event system is used if you want to listen to any user interactions or
state changes on the map.

## Basic Usage

To listen to map events, implement a callback function for the `onEvent`
parameter.

```dart hl_lines="5 13-15 18-25"
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
    onEvent: _onEvent,
  );
}

void _onEvent(event) {
  print(event.runtimeType);

  // check for the event type
  if (event is MapEventClick) {
    print('The map has been clicked at ${event.point.lng}, ${event.point.lat}');
  }

  // or use a switch statement to listen to all the events you are interested in
  switch (event) {
    case MapEventMapCreated():
      print('map created');
    case MapEventStyleLoaded():
      print('style loaded');
    default:
    // ignore all other events
  }
}
```

## Available Events

Every platform emits the same events. Map gestures are recognized in Flutter,
so the user input events behave the same everywhere.

| Event                       | Emitted when                                                                          |
|-----------------------------|---------------------------------------------------------------------------------------|
| `MapEventMapCreated`        | The map was created. Holds the `MapController`.                                       |
| `MapEventStyleLoaded`       | A style finished loading, also after `MapOptions.style` changed. Holds the `StyleController`. |
| `MapEventClick`             | The user tapped or clicked the map.                                                   |
| `MapEventDoubleClick`       | The user double tapped or double clicked the map.                                     |
| `MapEventSecondaryClick`    | The user clicked the map with the secondary (right) mouse button.                     |
| `MapEventLongClick`         | The user pressed the map for a longer time.                                           |
| `MapEventStartMoveCamera`   | The camera starts to move. `reason` says whether a gesture, the app or the map moved it. |
| `MapEventMoveCamera`        | The camera moved. Holds the new `MapCamera`.                                          |
| `MapEventCameraIdle`        | The camera stopped moving.                                                            |
| `MapEventIdle`              | The map finished rendering and no animation runs.                                     |
| `MapEventRenderingChanged`  | The map stopped or resumed rendering, see [paused rendering](map.md#paused-rendering). |

`MapEventClick`, `MapEventDoubleClick`, `MapEventSecondaryClick` and
`MapEventLongClick` extend `MapEventUserInput`, which holds the `point` on the
map and the `screenPoint` in logical pixels.

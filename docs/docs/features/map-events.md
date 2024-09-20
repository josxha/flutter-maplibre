---
sidebar_position: 2
---

# Map Events

The event system is the used if you want to listen to any user interactions or
state changes on the map.

## Basic usage

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

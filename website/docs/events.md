---
icon: lucide/send
---

# Events

`MapLibreMap` reports user input and state changes through one `on…`
callback per event. Set only the callbacks you need: the map doesn't track
events that nothing listens to.

## Basic Usage

```dart hl_lines="5-9"
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    options: MapOptions(initCamera: .position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 7)),
    onMapCreated: (controller) => print('map created'),
    onStyleLoaded: (style) => print('style loaded'),
    onClick: (event) => print('clicked at ${event.point.lon}, ${event.point.lat}'),
    onCameraMoveEnd: (event) => print('camera stopped at ${event.camera.zoom}'),
    onError: (event) => print('${event.kind}: ${event.message}'),
  );
}
```

Each callback gets an event object of its own type, such as `MapEventClick`
for `onClick`. All of them extend `MapEvent`.

## Available Events

Map gestures are recognized in Flutter, so the user input events behave the
same on every platform.

| Callback              | Called when                                                                                       |
|-----------------------|---------------------------------------------------------------------------------------------------|
| `onMapCreated`        | The map was created. Gets the `MapController`.                                                    |
| `onStyleLoaded`       | A style finished loading, also after `MapOptions.style` changed. Gets the `StyleController`.      |
| `onClick`             | The user tapped or clicked the map.                                                               |
| `onDoubleClick`       | The user double tapped or double clicked the map.                                                 |
| `onSecondaryClick`    | The user clicked the map with the secondary (right) mouse button.                                 |
| `onLongClick`         | The user pressed the map for a longer time.                                                       |
| `onCameraMoveStart`   | The camera starts to move. `reason` says whether a gesture, the app or the map moved it.          |
| `onCameraMove`        | The camera moved. Holds the new `CameraPosition` and the `reason`.                                     |
| `onCameraMoveEnd`     | The camera stopped moving. Holds the `CameraPosition` it ended at and the `reason`.                    |
| `onIdle`              | The map finished rendering and no animation runs.                                                 |
| `onError`             | The style, a source, glyphs or a sprite failed to load, or rendering failed.                      |
| `onStyleImageMissing` | A layer uses an image that the style doesn't have. Add it with `StyleController.addImage`.        |
| `onLoadingStarted`    | The map starts to load a style.                                                                   |
| `onLoadingFinished`   | The map loaded its style and what the view needs.                                                 |
| `onSourceChanged`     | A source of the style changed, such as when its TileJSON arrives.                                 |
| `onRenderFrame`       | The map rendered a frame. Native maps report the frame's statistics.                              |
| `onRenderingChanged`  | The map stopped or resumed rendering, see [paused rendering](map.md#paused-rendering).            |
| `onResize`            | The map changed its size.                                                                         |

Some events exist on one platform only:

| Callback                              | Platform | Called when                                                        |
|---------------------------------------|----------|--------------------------------------------------------------------|
| `onTile`                              | native   | A tile moved to another step of loading.                           |
| `onRenderMap`                         | native   | The map finished rendering a view, partially or fully.             |
| `onGlyphs`                            | native   | The map requested or loaded glyphs of a font.                      |
| `onSprite`                            | native   | The map requested or loaded a sprite.                              |
| `onContextLost`, `onContextRestored`  | web      | The browser took the map's WebGL context away or gave it back.     |
| `onProjectionChanged`                 | web      | The map switched its projection.                                   |

`MapEventClick`, `MapEventDoubleClick`, `MapEventSecondaryClick` and
`MapEventLongClick` extend `MapEventUserInput`, which holds the `point` on the
map and the `screenPoint` in logical pixels.

## Double taps

A double tap zooms in while the zoom gesture of `MapOptions.gestures` is on.
To handle it yourself, call `preventDefault()` on the event. `onDoubleClick`
can be async, for example to check for features under the tap first. The map
waits for it before it zooms:

```dart
onDoubleClick: (event) async {
  final features = await _controller.featuresAtPoint(event.screenPoint);
  if (features.isNotEmpty) {
    event.preventDefault();
    // handle the double tap on the feature
  }
},
```

`preventDefault()` also keeps the double tap and drag gesture from zooming.

A tap only waits for a possible second tap while double taps mean something:
while `onDoubleClick` is set or the zoom gesture is on. Turn both off and
`onClick` fires right away.

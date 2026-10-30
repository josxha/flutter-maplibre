---
title: 'Map & Camera'
icon: lucide/locate
---

# Map & Camera

## Map options

`MapOptions` configures a `MapLibreMap`. Every option except `initCamera` can
change at any time, for example with `setState()`, and the map follows:

```dart
MapLibreMap(
  options: MapOptions(
    style: MapStyle.url('https://demotiles.maplibre.org/style.json'),
    initCamera: InitialCamera.position(
      center: Geographic(lon: 9.17, lat: 47.68),
      zoom: 7,
    ),
    minZoom: 3,
    maxZoom: 18,
    maxPitch: 60,
    maxBounds: GeoBox(west: 5, south: 45, east: 17, north: 55),
    gestures: MapGestures.all(pitch: false),
  ),
)
```

| Option                  | Description                                                                     |
|-------------------------|---------------------------------------------------------------------------------|
| `style`                 | The [map style](styles.md). A new style loads when it changes.                  |
| `initCamera`            | Where the map starts, see [below](#initial-camera). Only read once.             |
| `minZoom`, `maxZoom`    | The zoom range the camera stays in.                                             |
| `minPitch`, `maxPitch`  | The pitch range the camera stays in.                                            |
| `maxBounds`             | The area the camera stays in.                                                   |
| `gestures`              | Which gestures move the map, see [Gestures](#gestures).                         |

## Initial camera

`initCamera` sets where the map starts:

- `InitialCamera.position` starts at a `center`, `zoom`, `bearing` and
  `pitch`.
- `InitialCamera.bounds` fits a `GeoBox` into the map from its first frame,
  inset by `padding`, with an optional `bearing` and `pitch`.
- Without `initCamera`, the map starts at the camera stored in the style.

```dart
MapOptions(
  initCamera: InitialCamera.bounds(
    GeoBox(west: 9.5, south: 47.4, east: 9.8, north: 47.6),
    padding: EdgeInsets.all(32),
  ),
)
```

## Move the camera

Use the `MapController` to move the camera after the map was created:

```dart
// jump to a position
await controller.moveCamera(center: Geographic(lon: 9.17, lat: 47.68), zoom: 10);

// animate to a position
await controller.animateCamera(
  center: Geographic(lon: 9.17, lat: 47.68),
  zoom: 12,
  bearing: 45,
  pitch: 30,
  nativeDuration: const Duration(seconds: 1),
);

// fit bounds into the map
await controller.fitBounds(
  bounds: GeoBox(west: 9.5, south: 47.4, east: 9.8, north: 47.6),
  padding: const EdgeInsets.all(32),
);
```

The returned `Future`s complete when the camera arrived. `nativeDuration`
sets the length of an animation on native platforms; on web, MapLibre GL JS
picks it from `webSpeed` and `webMaxDuration`.

## Read the camera

`MapController.getCamera()` returns the current camera, and the
`MapController.camera` getter returns it too, or null before the map is
ready. The `MapEventMoveCamera` event reports every change. Widgets in `MapLibreMap.children` can read the camera with
`MapCamera.of(context)` and rebuild when it changes.

The controller also converts between coordinates and screen positions with
`toScreenLocation`, `toLngLat` and their list variants, returns the visible
area with `getVisibleRegion()` and the scale with
`getMetersPerPixelAtLatitude()`.

## Gestures

Gestures are recognized in Flutter and are the same on every platform:

| Gesture                                                | Action               |
|--------------------------------------------------------|----------------------|
| Drag with one finger or the left mouse button          | Pan                  |
| Pinch, scroll wheel, double tap, double tap and drag   | Zoom                 |
| Twist with two fingers                                 | Rotate               |
| Drag up or down with two fingers                       | Tilt                 |
| Drag with the right mouse button or Ctrl + left button | Rotate and tilt      |

`MapGestures` turns the `pan`, `zoom`, `rotate` and `pitch` gestures on or
off, for example `MapGestures.all(rotate: false)` or `MapGestures.none()`.
Widgets in `MapLibreMap.children` receive their own taps and drags before the
map does.

## Query features

`featuresAtPoint` and `featuresInRect` return the rendered features at a
screen position or in a rectangle, optionally only from some layers:

```dart
onEvent: (event) async {
  if (event case MapEventClick(:final screenPoint)) {
    final features = await controller.featuresAtPoint(
      screenPoint,
      layerIds: ['points'],
    );
    for (final feature in features) {
      print('${feature.layerId}: ${feature.properties}');
    }
  }
},
```

Each `RenderedFeature` holds its `id`, `properties` and `geometry`, and the
`sourceId`, `sourceLayer` and `layerId` it comes from.

## Paused rendering

A map stops rendering while `MapLibreMap.paused` is true, and keeps its style,
camera, sources and cached tiles. Changes made while it is paused show once it
resumes.

Maps also pause on their own while they are hidden by an `IndexedStack` or a
`Visibility` that keeps their state, or while `TickerMode` is disabled, as for
a route that another route covers. Set `paused` for the cases Flutter does not
report, such as a kept-alive page of a `PageView` or `TabBarView` while
another page shows:

```dart
MapLibreMap(
  paused: _tabController.index != 0,
  options: MapOptions(/* ... */),
)
```

`MapController.isRenderingPaused` and the `MapEventRenderingChanged` event tell
whether the map renders. On web, the browser already skips hidden maps, so
`paused` has no effect there.

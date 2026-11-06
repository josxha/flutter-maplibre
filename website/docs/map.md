---
title: 'Map & Camera'
icon: lucide/locate
---

# Map & Camera

## Map options

`MapOptions` configures a `MapLibreMap`. Every option except `initCamera` and
`fastPforEnabled` can change at any time, for example with `setState()`, and
the map follows:

```dart
MapLibreMap(
  options: MapOptions(
    style: MapStyle.url('https://demotiles.maplibre.org/style.json'),
    initCamera: CameraUpdate.position(
      center: Geographic(lon: 9.17, lat: 47.68),
      zoom: 7,
    ),
    minZoom: 3,
    maxZoom: 18,
    maxPitch: 60,
    maxBounds: GeoBox(west: 5, south: 45, east: 17, north: 55),
    gestures: MapGestures(pitch: false),
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
| `fastPforEnabled`       | Decode MLT tiles that use FastPFOR, see [Sources](sources.md#maplibre-tiles-mlt). Only read once. Always on for web. |

## Initial camera

`initCamera` sets where the map starts. It takes a `CameraUpdate`, like the
camera methods of the controller:

- `CameraUpdate.position` starts at a `center`, `zoom`, `bearing`, `pitch`
  and `roll`.
- `CameraUpdate.bounds`, `CameraUpdate.points` and `CameraUpdate.geometry`
  fit a target into the map from its first frame, inset by `padding`, with an
  optional `bearing`, `pitch` and `maxZoom`.
- Without `initCamera`, the map starts at the camera stored in the style.

```dart
MapOptions(
  initCamera: CameraUpdate.bounds(
    GeoBox(west: 9.5, south: 47.4, east: 9.8, north: 47.6),
    padding: EdgeInsets.all(32),
  ),
)
```

## Move the camera

Use the `MapController` to move the camera after the map was created. Every
method takes a `CameraUpdate`, and fields of `CameraUpdate.position` that you
leave out keep their value:

```dart
// jump to a position
await controller.moveCamera(
  const CameraUpdate.position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 10),
);

// ease to a position, 300 ms by default
await controller.animateCamera(
  const CameraUpdate.position(zoom: 12, bearing: 45, pitch: 30),
);

// fly to bounds
final result = await controller.animateCamera(
  CameraUpdate.bounds(
    GeoBox(west: 9.5, south: 47.4, east: 9.8, north: 47.6),
    padding: const EdgeInsets.all(32),
  ),
  animation: const CameraAnimation.fly(duration: Duration(seconds: 2)),
);

// the camera that shows some points, without moving the map
final camera = await controller.cameraFor(CameraUpdate.points(stops));
```

`CameraAnimation.ease` interpolates the camera over a `duration` along a
`curve`. `CameraAnimation.fly` zooms out and in again like a flight, which
suits far targets; without a `duration`, it takes as long as its `speed`
needs.

`animateCamera` completes when the animation ends, with
`CameraAnimationResult.completed`, or with `CameraAnimationResult.cancelled`
if a gesture, `moveCamera` or `stopCamera()` stopped it. A later
`animateCamera` takes over and completes the earlier one.

## Read the camera

`MapController.getCamera()` returns the current camera, and the
`MapController.camera` getter returns it too, or null before the map is
ready. `MapLibreMap.onCameraMove` reports every change. Widgets in `MapLibreMap.children` can read the camera with
`CameraPosition.of(context)` and rebuild when it changes.

The controller also converts between coordinates and screen positions with
`toScreenLocation`, `toLngLat` and their list variants, returns the visible
area with `getVisibleBounds()` and the scale with
`getMetersPerPixelAtLatitude()`.

## Gestures

Gestures are recognized in Flutter and are the same on every platform.
`MapGestures` has two kinds of switch, and every one is on by default.

The camera movements say what the user may change, with any gesture:
`pan`, `zoom`, `rotate` and `pitch`. The inputs say which gestures work, and
each one moves the camera only along the movements that are on:

| Input           | Gesture                                                         | Moves                |
|-----------------|-----------------------------------------------------------------|----------------------|
| `drag`          | Drag with one finger or the left mouse button                   | pan                  |
| `fling`         | Keep moving after a fast drag or pinch                          | pan                  |
| `pinch`         | Move, spread or twist two fingers on the screen or a trackpad   | pan, zoom, rotate    |
| `scrollWheel`   | Scroll wheel                                                    | zoom                 |
| `doubleTap`     | Double tap or double click                                      | zoom                 |
| `doubleTapDrag` | Double tap and drag up or down                                  | zoom                 |
| `mouseDrag`     | Drag with the right mouse button or Ctrl + left button          | rotate, pitch        |
| `twoFingerDrag` | Drag two fingers side by side up or down                        | pitch                |

```dart
// No tilting, and no scroll wheel zoom.
const MapGestures(pitch: false, scrollWheel: false)

// Pinch zooms and pans, but doesn't rotate the map.
const MapGestures(rotate: false)

// Only pan, by dragging.
const MapGestures.none(pan: true, fling: false)
```

The switches only stop the user. To keep the camera within limits for the app
too, use `minZoom`, `maxZoom`, `minPitch`, `maxPitch` and `maxBounds`.

Widgets in `MapLibreMap.children` receive their own taps and drags before the
map does.

## Query features

`queryRenderedFeatures` returns the features drawn at a screen position
(`QueryGeometry.point`), in a rectangle (`.rect`) or anywhere in the map
(`.viewport`), optionally only from some layers or matching a filter:

```dart
onClick: (event) async {
  final features = await controller.queryRenderedFeatures(
    .point(event.screenPoint),
    layerIds: ['points'],
    filter: .equal(.get('kind'), .literal('cafe')),
  );
  for (final feature in features) {
    print('${feature.layerId}: ${feature.properties}');
  }
},
```

Each `RenderedFeature` holds its `id`, `properties` and geobase `geometry`, and the
`sourceId`, `sourceLayer` and `layerId` it comes from.

`querySourceFeatures` returns the features of a source in the tiles it loaded,
also those that a filter hides or that lie outside the visible part of the
map. A source loads tiles only while a visible layer uses it. For a vector
tile source, name the `sourceLayer`:

```dart
final countries = await controller.querySourceFeatures(
  'openmaptiles',
  sourceLayer: 'boundary',
  filter: .equal(.get('admin_level'), const .literal(2)),
);
```

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

`MapController.isRenderingPaused` and the `onRenderingChanged` callback tell
whether the map renders. On web, the browser already skips hidden maps, so
`paused` has no effect there.

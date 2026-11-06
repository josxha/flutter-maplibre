---
title: 'Upgrade to 0.4'
icon: lucide/arrow-up-right
---

# Upgrade from 0.3.x to 0.4

The 0.4 series replaces the MapLibre Android and iOS SDKs and the WebView
desktop integration with one implementation on the
[MapLibre Native C API](https://github.com/maplibre/maplibre-native-ffi). It
also makes style layers, expressions, sources and map options typed. This
guide applies to the `0.4.0-pre.*` pre-releases and to 0.4.0. The
[changelog](https://pub.dev/packages/maplibre/changelog) lists every change.

## 1. Update the dependency

```yaml title="pubspec.yaml"
dependencies:
  maplibre: ^0.4.0-pre.1
```

The packages need Dart 3.13 and Flutter 3.47 or newer.

## 2. Platform setup

`maplibre` now uses `maplibre_web` in the browser and `maplibre_native` on
Android, iOS, macOS, Windows and Linux. `maplibre_android`, `maplibre_ios`
and `maplibre_webview` are discontinued. If you depend on one of them
directly, remove it.

| Platform | Change                                                                                                                         |
|----------|--------------------------------------------------------------------------------------------------------------------------------|
| Web      | maplibre-gl-js v6 loads on its own. Remove the maplibre-gl-js and PMTiles `<script>` and `<link>` tags from `web/index.html`. |
| Android  | Requires Android 7.0 (API level 24) and OpenGL ES 3.0. Plain `http://` URLs need a network security config.                   |
| iOS      | Requires iOS 15. Swift Package Manager only, CocoaPods is not supported.                                                       |
| macOS    | Requires macOS 14.3. Swift Package Manager only. Works out of the box, `maplibre_webview` is no longer needed.                |
| Windows  | Works out of the box, `maplibre_webview` is no longer needed.                                                                  |
| Linux    | New. Needs the GTK and libepoxy development packages to build.                                                                |

See [Platform setup](../getting-started/platforms.md) for the details.

maplibre-gl-js v6 requires WebGL 2, returns nested objects in GeoJSON
feature properties as maps instead of JSON strings, and sets
`zoomLevelsToOverscale` to 4 by default, which can change label rendering and
`queryRenderedFeatures()` results. See the
[maplibre-gl-js migration guide](https://github.com/maplibre/maplibre-gl-js/blob/main/docs/guides/v5-to-v6-migration-guide.md).

## 3. Map options

The style and the initial camera are typed, so they are no longer guessed:

```dart
// 0.3
MapOptions(
  initStyle: 'https://demotiles.maplibre.org/style.json',
  initCenter: Geographic(lon: 9.17, lat: 47.68),
  initZoom: 7,
)

// 0.4
MapOptions(
  style: MapStyle.url('https://demotiles.maplibre.org/style.json'),
  initCamera: CameraUpdate.position(
    center: Geographic(lon: 9.17, lat: 47.68),
    zoom: 7,
  ),
)
```

- `initStyle` is now `style`, a `MapStyle.url`, `MapStyle.json`,
  `MapStyle.asset` or `MapStyle.file`. The map loads a new style when `style`
  changes, so `MapController.setStyle` was removed.
- `initCenter`, `initZoom`, `initBearing` and `initPitch` are now
  `initCamera`, a `CameraUpdate` such as `CameraUpdate.position` or
  `CameraUpdate.bounds`, see [Camera](#14-camera). Without
  `initCamera`, the map starts at the camera of the style instead of zoom 0.
- `androidMode`, `androidTextureMode`, `androidTranslucentTextureSurface`,
  `androidForegroundLoadColor`, `webviewDebugMode` and the deprecated
  `pitch` were removed.

`MapGestures` has a switch for each gesture, grouped by category, and every
gesture is on by default:

| 0.3                               | 0.4                                         |
|-----------------------------------|---------------------------------------------|
| `MapGestures.all()`               | `MapGestures()`                             |
| `MapGestures.all(pitch: false)`   | `MapGestures(pitch: PitchGestures.none())`  |
| `MapGestures.none(zoom: true)`    | `MapGestures.none(zoom: ZoomGestures())`    |
| `gestures.zoom`                   | `gestures.zoom.anyEnabled`                  |

Single gestures can be turned off too, for example
`MapGestures(zoom: ZoomGestures(scrollWheel: false))`. See
[Gestures](../map.md#gestures).

## 4. Style layers and expressions

Style layers take typed properties and
[expressions](../style-layers/expressions.md) instead of `paint` and `layout`
maps. The annotation layers take expressions too.

```dart
// 0.3
LineStyleLayer(
  id: 'route',
  sourceId: 'route',
  paint: {'line-color': '#FF0000', 'line-width': 3},
  layout: {'line-cap': 'round'},
)

// 0.4
LineStyleLayer(
  id: 'route',
  sourceId: 'route',
  color: const .literal(Color(0xFFFF0000)),
  width: const .literal(3),
  cap: const .literal(LineCap.round),
)
```

`Expression.raw` takes the JSON of a single property, and
`StyleLayer.fromJson` the JSON of a whole layer.

## 5. Sources and layers of the style

`style.layers` and `style.sources` replace the layer and source methods of
`StyleController`:

| 0.3                               | 0.4                                         |
|-----------------------------------|---------------------------------------------|
| `style.addLayer(layer)`           | `style.layers.add(layer)`                   |
| `style.removeLayer(id)`           | `style.layers.remove(id)`                   |
| `style.addSource(source)`         | `style.sources.add(source)`                 |
| `style.removeSource(id)`          | `style.sources.remove(id)`                  |
| `style.updateGeoJsonSource(...)`  | `style.sources.updateGeoJsonData(...)` or `updateGeoJsonUrl(...)` |
| `style.getLayerIds()`             | `style.layers.map((layer) => layer.id)`     |
| `style.getAttributions()`         | `style.attributions`                        |

Sources are sealed classes with named constructors:

| 0.3                                 | 0.4                                                  |
|-------------------------------------|------------------------------------------------------|
| `GeoJsonSource(data: url)`          | `GeoJsonSource.url(url: url)`                        |
| `GeoJsonSource(data: geoJson)`      | `GeoJsonSource.data(data: geoJson)`                  |
| `ImageSource(url: url)`             | `ImageSource.url(url: url)`, or `.bytes` / `.provider` |
| `VectorSource(url: tileJsonUrl)`    | `VectorSource.url(url: tileJsonUrl)`                 |
| `VectorSource(tiles: [...])`        | `VectorSource.tiles(tiles: [...])`                   |
| `RasterSource`, `RasterDemSource`   | `.url` and `.tiles`, like `VectorSource`             |
| `VideoSource(urls: [...])`          | `VideoSource.urls(urls: [...])`                      |

`VideoSource.coordinates` is a `LngLatQuad`, like `ImageSource.coordinates`.
`VideoSource` is only supported on web.

## 6. Images

`addImage`, `addImages` and `addImageFromAssets` take a `pixelRatio` of image
pixels per logical pixel, 1 by default, instead of the device pixel ratio.
Images now show at the same logical size on every screen, so they grow on
high-DPI screens. Pass the ratio the image was made for to keep their size:

```dart
await style.addImage('marker', bytes, pixelRatio: 2);
```

`addImageFromCanvas` and `addImageFromIconData` take their sizes in logical
pixels.

## 7. Geometry types

- `LngLatBounds` is replaced by geobase's `GeoBox` in `fitBounds`,
  `getVisibleRegion`, `MapOptions.maxBounds` and offline regions.
  `GeoBox.from(points)` replaces `LngLatBounds.fromPoints(points)`.
- `maplibre` exports only the geobase types its API uses. Import
  `package:geobase/geobase.dart` for the others.

## 8. Feature queries

`featuresAtPoint` and `featuresInRect` are now one `queryRenderedFeatures`,
which returns a `Future`, so `await` it:

```dart
// 0.3
final features = controller.featuresAtPoint(point);
final inRect = controller.featuresInRect(rect);

// 0.4
final features = await controller.queryRenderedFeatures(.point(point));
final inRect = await controller.queryRenderedFeatures(.rect(rect));
```

- `QueryGeometry.viewport()` queries the whole map, and `filter` takes an
  `Expression<bool>`, like a layer filter.
- `RenderedFeature.geometry` is a geobase `Geometry` instead of a GeoJSON
  map, for example a `Point` or a `Polygon`.
- `queryLayers` and `QueriedLayer` were removed. Use `queryRenderedFeatures`
  with `layerIds`, and `RenderedFeature.layerId`, `sourceId` and
  `sourceLayer`.

## 9. User location and permissions

`PermissionManager`, `MapController.enableLocation`, `trackLocation`,
`userLocationIsSupported`, `BearingRenderMode` and `BearingTrackMode` were
removed. Show the location with a [UserLocationLayer](../user-location.md)
and ask for permissions with `geolocator` or `permission_handler`.
`MapControlButtons` takes `tracking` and `onTrackingPressed` instead of
`showTrackLocation`.

## 10. Offline regions

`OfflineManager.downloadRegion` takes an `OfflineRegionDefinition`:

```dart
// 0.3
manager.downloadRegion(
  mapStyleUrl: styleUrl,
  bounds: bounds,
  minZoom: 10,
  maxZoom: 14,
  pixelDensity: 1,
);

// 0.4
manager.downloadRegion(
  definition: OfflineTilePyramidRegionDefinition(
    styleUrl: styleUrl,
    bounds: bounds,
    minZoom: 10,
    maxZoom: 14,
    pixelRatio: 1,
  ),
);
```

`OfflineRegion` holds the `definition`, `DownloadProgress` holds an
`OfflineRegionStatus`, and download errors are an `OfflineResourceException`
or an `OfflineTileCountLimitException`. `setOfflineTileCountLimit` and
`runPackDatabaseAutomatically` were removed. See
[Offline & Cache](../offline.md).

## 11. Web gestures

Map gestures are recognized in Flutter on every platform, also on web.
MapLibre GL JS's keyboard navigation and Shift + drag box zoom are no longer
available. Widgets over the map no longer need a `PointerInterceptor`.

## 12. Native platforms

MapLibre Native has no globe projection, so
`setProjection(MapProjection.globe)` keeps Mercator on Android, iOS and
desktop.

## 13. Events

`onEvent` is replaced by one callback per event, and each callback gets its
own event type:

```dart
// 0.3
MapLibreMap(
  onEvent: (event) {
    switch (event) {
      case MapEventClick():
        print(event.point);
      case MapEventCameraIdle():
        print('camera idle');
      default:
        break;
    }
  },
)

// 0.4
MapLibreMap(
  onClick: (event) => print(event.point),
  onCameraMoveEnd: (event) => print('camera idle at ${event.camera}'),
)
```

| 0.3                                | 0.4                                  |
|------------------------------------|--------------------------------------|
| `MapEventMapCreated`               | `onMapCreated`                       |
| `MapEventStyleLoaded`              | `onStyleLoaded`                      |
| `MapEventClick`, `MapEventDoubleClick`, `MapEventSecondaryClick`, `MapEventLongClick` | `onClick`, `onDoubleClick`, `onSecondaryClick`, `onLongClick` |
| `MapEventStartMoveCamera`          | `onCameraMoveStart`                  |
| `MapEventMoveCamera`               | `onCameraMove`, which also carries the `reason` |
| `MapEventCameraIdle`               | `onCameraMoveEnd`, with the camera and the `reason` |
| `MapEventIdle`                     | `onIdle`                             |
| `MapEventRenderingChanged`         | `onRenderingChanged`                 |

`CameraChangeReason.apiGesture`, `developerAnimation` and `apiAnimation` are
now `gesture`, `programmatic` and `map`. See [Events](../events.md) for the
new events.

## 14. Camera

`moveCamera` and `animateCamera` take a `CameraUpdate`, the same type as
`MapOptions.initCamera`. `fitBounds` is now `CameraUpdate.bounds`, and the
platform-prefixed animation parameters are a `CameraAnimation`:

```dart
// 0.3
await controller.moveCamera(zoom: 10);
await controller.animateCamera(
  center: Geographic(lon: 9.17, lat: 47.68),
  zoom: 12,
  nativeDuration: const Duration(seconds: 1),
  webSpeed: 1.5,
);
await controller.fitBounds(bounds: bounds, padding: const EdgeInsets.all(32));

// 0.4
await controller.moveCamera(const CameraUpdate.position(zoom: 10));
await controller.animateCamera(
  const CameraUpdate.position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 12),
  animation: const CameraAnimation.fly(duration: Duration(seconds: 1)),
);
await controller.animateCamera(
  CameraUpdate.bounds(bounds, padding: const EdgeInsets.all(32)),
);
```

| 0.3                                  | 0.4                                                  |
|--------------------------------------|------------------------------------------------------|
| `InitialCamera.position`, `.bounds`  | `CameraUpdate.position`, `.bounds`                   |
| `fitBounds(bounds: ...)`             | `animateCamera(CameraUpdate.bounds(...))`            |
| `nativeDuration`, `webMaxDuration`   | `CameraAnimation.ease(duration:)` or `.fly(duration:)` |
| `webSpeed`                           | `CameraAnimation.fly(speed:)`                        |
| `webLinear: true`                    | `CameraAnimation.ease()`                             |
| `webMaxZoom`                         | `maxZoom` of `CameraUpdate.bounds`                   |
| `fitBounds(offset:)`                 | Removed; uneven `padding` of `CameraUpdate.bounds` moves the fitted area instead |
| `getVisibleRegion()`                 | `getVisibleBounds()`                                 |
| `MapCamera`, `MapCamera.of(context)` | `CameraPosition`, `CameraPosition.of(context)`       |
| `MapCompass.nativeRotationDuration`, `webRotationSpeed` | `MapCompass.animation`            |
| A `PlatformException` when an animation is cancelled (web) | `CameraAnimationResult.cancelled` |

`animateCamera` now eases for 300 ms by default, where 0.3 flew for 2 seconds
on native platforms. Pass `animation: const CameraAnimation.fly()` to fly.


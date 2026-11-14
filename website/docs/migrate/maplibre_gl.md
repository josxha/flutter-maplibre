---
title: 'maplibre_gl'
description: 'Move an app from maplibre_gl to maplibre.'
icon: lucide/box
---

# Migrate from maplibre_gl

`maplibre_gl` and `maplibre` show the same MapLibre styles, tiles and layers,
so your styles, tile URLs and expressions keep working. What changes is the
Flutter API: `maplibre` takes map options and annotations as widget
parameters that you update with `setState()`, has typed style layers and
expressions, and renders into a Flutter `Texture` instead of a platform view
(an HTML element on web).
It also runs on macOS, Windows and Linux.

Both packages define `MapLibreMap`, `CameraPosition`, `CameraUpdate` and more,
so replace the import in each file instead of using both.

## 1. Replace the dependency

```bash
flutter pub remove maplibre_gl
flutter pub add maplibre:^0.4.0-pre.2
```

Follow [Platform setup](../getting-started/platforms.md) for each platform
your app targets.

## 2. The map widget

=== "maplibre_gl"

    ```dart
    MapLibreMap(
      styleString: 'https://demotiles.maplibre.org/style.json',
      initialCameraPosition: const CameraPosition(
        target: LatLng(47.68, 9.17),
        zoom: 7,
      ),
      minMaxZoomPreference: const MinMaxZoomPreference(3, 18),
      rotateGesturesEnabled: false,
      compassEnabled: true,
      onMapCreated: (controller) => _controller = controller,
      onStyleLoadedCallback: _addLayers,
      onMapClick: (point, latLng) => print(latLng),
    )
    ```

=== "maplibre"

    ```dart
    MapLibreMap(
      options: MapOptions(
        style: MapStyle.url('https://demotiles.maplibre.org/style.json'),
        initCamera: .position(
          center: Geographic(lon: 9.17, lat: 47.68),
          zoom: 7,
        ),
        minZoom: 3,
        maxZoom: 18,
        movements: MapMovements(rotate: false),
      ),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: _addLayers, // gets the StyleController
      onClick: (event) => print(event.point),
      children: const [MapCompass()],
    )
    ```

Coordinates are geobase `Geographic(lon: …, lat: …)` instead of
`LatLng(lat, lng)`, and bounds are a `GeoBox(west:, south:, east:, north:)`
instead of `LatLngBounds`.

| maplibre_gl                                 | maplibre                                                       |
|---------------------------------------------|----------------------------------------------------------------|
| `styleString`                               | `MapOptions.style`: `MapStyle.url`, `.asset`, `.file`, `.json` |
| `initialCameraPosition`                     | `MapOptions.initCamera`                                        |
| `minMaxZoomPreference`, `cameraTargetBounds`| `MapOptions.minZoom`, `maxZoom`, `maxBounds`                   |
| `rotateGesturesEnabled`, `tiltGesturesEnabled`, `zoomGesturesEnabled`, `scrollGesturesEnabled` | `MapOptions.movements` (`rotate`, `pitch`, `zoom`, `pan`) and `MapOptions.gestures` for single gestures |
| `compassEnabled`, `attributionButtonPosition`, `logoViewMargins` | `MapCompass`, `SourceAttribution` and other widgets in `children`, see [User Interface](../ui.md) |
| `myLocationEnabled`, `myLocationTrackingMode` | `UserLocationLayer` in `children`, see [User Location](../user-location.md) |
| `onStyleLoadedCallback`                     | `onStyleLoaded`, which gets the `StyleController`              |
| `onMapClick`, `onMapLongClick`              | `onClick`, `onLongClick`                                       |
| `onCameraIdle`, `trackCameraPosition`       | `onCameraMoveEnd`, `onCameraMove`; the `camera` getter is always up to date |
| `onMapIdle`                                 | `onIdle`                                                       |

Every option of `MapOptions` except `initCamera` and `fastPforEnabled` can
change with `setState()`; those two are read once when the map is created. A new `style` loads the style, and `onStyleLoaded` is called
again.

## 3. Camera

=== "maplibre_gl"

    ```dart
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(const LatLng(47.68, 9.17), 10),
      duration: const Duration(seconds: 1),
    );
    await controller.moveCamera(
      CameraUpdate.newLatLngBounds(bounds, left: 32, top: 32, right: 32, bottom: 32),
    );
    final position = controller.cameraPosition;
    ```

=== "maplibre"

    ```dart
    await controller.animateCamera(
      const CameraUpdate.position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 10),
      animation: const CameraAnimation.ease(duration: Duration(seconds: 1)),
    );
    await controller.moveCamera(
      CameraUpdate.bounds(box, padding: const EdgeInsets.all(32)),
    );
    final position = controller.camera;
    ```

`CameraUpdate.position` sets only the fields you pass, to absolute values, so
it replaces `zoomTo`, `bearingTo` and `tiltTo`. For `zoomIn`, pass
`zoom: controller.getCamera().zoom + 1`. `CameraAnimation.fly` zooms out
and in for far targets. `animateCamera` returns whether the animation
completed or was cancelled. See [Map & Camera](../map.md).

## 4. Annotations

`maplibre_gl` adds symbols, circles, lines and fills one by one through the
controller. `maplibre` takes [annotation layers](../annotations/index.md) in
`MapLibreMap.layers`. Each layer holds a list of features with one style, and
the map updates only what changed when you call `setState()`:

=== "maplibre_gl"

    ```dart
    final circle = await controller.addCircle(
      const CircleOptions(
        geometry: LatLng(47.68, 9.17),
        circleRadius: 12,
        circleColor: '#2196F3',
      ),
    );
    controller.onCircleTapped.add((circle) => print(circle.id));
    await controller.updateCircle(circle, const CircleOptions(circleRadius: 20));
    ```

=== "maplibre"

    ```dart
    double _radius = 12;

    @override
    Widget build(BuildContext context) {
      return MapLibreMap(
        layers: [
          CircleLayer(
            points: const [Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68)))],
            radius: .literal(_radius),
            color: const .literal(Colors.blue),
            onClick: (event) => setState(() => _radius = 20),
          ),
        ],
      );
    }
    ```

| maplibre_gl                                 | maplibre                                                        |
|---------------------------------------------|-----------------------------------------------------------------|
| `addSymbol`, `SymbolOptions`                | `MarkerLayer`, or `WidgetLayer` for Flutter widgets             |
| `addCircle`, `CircleOptions`                | `CircleLayer`                                                   |
| `addLine`, `LineOptions`                    | `PolylineLayer`                                                 |
| `addFill`, `FillOptions`                    | `PolygonLayer`                                                  |
| `update*`, `remove*`, `clear*`              | Change the `layers` list with `setState()`                      |
| `onSymbolTapped`, `onFeatureTapped`         | `onClick` on the layer, see [Click and Hover](../annotations/click-and-hover.md) |
| `draggable: true` on the options, `onFeatureDrag` | `draggable: true` and `onDragEnd` on the layer, see [Drag](../annotations/drag.md) |
| Colors as `'#rrggbb'` strings               | Flutter `Color`s                                                |

## 5. Sources and style layers

The source and layer methods of the controller are `style.sources` and
`style.layers` of the `StyleController`. Layers take typed properties and
[expressions](../style-layers/expressions.md) instead of property classes
with untyped values:

=== "maplibre_gl"

    ```dart
    await controller.addGeoJsonSource('route', routeGeoJson);
    await controller.addLineLayer(
      'route',
      'route-line',
      const LineLayerProperties(
        lineColor: '#FF0000',
        lineWidth: ['interpolate', ['linear'], ['zoom'], 10, 2, 16, 8],
      ),
      belowLayerId: 'labels',
    );
    await controller.setGeoJsonSource('route', newGeoJson);
    await controller.setLayerVisibility('route-line', false);
    ```

=== "maplibre"

    ```dart
    await style.sources.add(
      GeoJsonSource.data(id: 'route', data: .json(routeGeoJson)),
    );
    await style.layers.add(
      LineStyleLayer(
        id: 'route-line',
        sourceId: 'route',
        color: const .literal(Color(0xFFFF0000)),
        width: .interpolate(.linear(), .zoom(), {10: .literal(2), 16: .literal(8)}),
      ),
      belowLayerId: 'labels',
    );
    await style.sources.updateGeoJsonData('route', .json(newGeoJson));
    style.layers['route-line']?.visible = false;
    ```

`Expression.raw` takes the JSON of an expression, so existing expressions can
be kept as they are while you migrate.

| maplibre_gl                                     | maplibre                                                     |
|-------------------------------------------------|--------------------------------------------------------------|
| `addSource`, `addGeoJsonSource`, `removeSource` | `style.sources.add`, `style.sources.remove`                  |
| `setGeoJsonSource`, `setGeoJsonFeature`         | `style.sources.updateGeoJsonData`                            |
| `addLayer`, `add*Layer`, `removeLayer`          | `style.layers.add(layer, belowLayerId: …)`, `style.layers.remove` |
| `setLayerProperties`, `setFilter`, `setLayerVisibility` | The setters of the layer from `style.layers[id]`, such as `filter` and `visible` |
| `getLayerIds`, `getSourceIds`                   | `style.layers` and `style.sources`, read synchronously       |
| `addImage`                                      | `style.addImage` and `addImageFromAssets`, `addImageFromIconData`, `addImageFromWidget` |
| `queryRenderedFeatures(point, layerIds, filter)`, `queryRenderedFeaturesInRect` | `controller.queryRenderedFeatures(.point(…) or .rect(…), layerIds:, filter:)` |
| `querySourceFeatures`                           | `controller.querySourceFeatures`                             |
| `setFeatureState`                               | Not available yet ([#646](https://github.com/maplibre/flutter-maplibre/issues/646)) |

## 6. Offline

`downloadOfflineRegion(OfflineRegionDefinition(...))` becomes
`OfflineManager.downloadRegion`, which also downloads the tiles that a
geometry such as a route touches. See [Offline & Cache](../offline.md). The
`OfflineManager` is not available on web.

## 7. What changes for your app

- Widgets over the map need no `PointerInterceptor` on web, and a
  `WidgetLayer` places widgets at coordinates.
- Gestures are recognized in Flutter, so they behave the same on every
  platform.
- Many values, such as `controller.camera`, `style.layers` and
  `style.sources`, are read synchronously.
- `maplibre` follows semantic versioning and has a migration guide for every
  breaking release, such as [Upgrade to 0.4](upgrade-from-v0.3.x.md).

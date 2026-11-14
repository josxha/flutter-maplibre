---
title: 'mapbox_maps_flutter'
description: 'Move an app from mapbox_maps_flutter to maplibre.'
icon: lucide/box
---

# Migrate from mapbox_maps_flutter

MapLibre started as a fork of the open source Mapbox SDKs. The style spec,
sources, layers and expressions are close to those of Mapbox, so styles and
layer code carry over with few changes. The main differences are where the
map data comes from and how the Flutter API is shaped: `maplibre` takes map
options and annotations as widget parameters and has typed style layers,
while `mapbox_maps_flutter` configures the map through its `MapboxMap`
object and annotation managers.

## 1. Choose map data

Mapbox styles (`mapbox://styles/…`) and the Mapbox Standard style need Mapbox
services and don't work with MapLibre. Use the style of a tile provider that
serves MapLibre styles, such as those in
[awesome-maplibre](https://github.com/maplibre/awesome-maplibre#maptile-providers),
or host your own tiles, for example as a [PMTiles](../sources/tiles.md#pmtiles)
file. Your own styles from Mapbox Studio work if you replace their `mapbox://`
sources, sprites and glyphs with your own URLs.

## 2. Replace the dependency

```bash
flutter pub remove mapbox_maps_flutter
flutter pub add maplibre:^0.4.0-pre.3
```

Remove `MapboxOptions.setAccessToken`, the access token from your build
configuration, and the Mapbox Maven repository from the Android Gradle files.
Follow [Platform setup](../getting-started/platforms.md) for the platforms of
your app. If your tile provider needs a key, it is usually part of the style
URL; [`MapLibreNetwork`](../network.md) adds headers to requests if it needs
them there.

## 3. The map widget

=== "mapbox_maps_flutter"

    ```dart
    MapWidget(
      styleUri: MapboxStyles.OUTDOORS,
      cameraOptions: CameraOptions(
        center: Point(coordinates: Position(9.17, 47.68)),
        zoom: 7,
      ),
      onMapCreated: (mapboxMap) {
        _mapboxMap = mapboxMap;
        mapboxMap.gestures.updateSettings(GesturesSettings(rotateEnabled: false));
        mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: true));
      },
      onStyleLoadedListener: (_) => _addLayers(),
      onTapListener: (context) => print(context.point),
    )
    ```

=== "maplibre"

    ```dart
    MapLibreMap(
      options: MapOptions(
        style: MapStyle.url('https://tiles.openfreemap.org/styles/liberty'),
        initCamera: .position(
          center: Geographic(lon: 9.17, lat: 47.68),
          zoom: 7,
        ),
        movements: MapMovements(rotate: false),
      ),
      onMapCreated: (controller) => _controller = controller,
      onStyleLoaded: (style) => _addLayers(style),
      onClick: (event) => print(event.point),
      children: const [MapScalebar()],
    )
    ```

`maplibre` uses geobase types: `Geographic(lon: …, lat: …)` for a coordinate
and `Point`, `LineString` or `Polygon` for geometries. Both packages have a
`Point`, `Position` and `CameraOptions`-like types, so don't import both in the
same file.

| mapbox_maps_flutter                               | maplibre                                                     |
|---------------------------------------------------|--------------------------------------------------------------|
| `MapWidget.styleUri`, `style.setStyleURI`         | `MapOptions.style`, changed with `setState()`                |
| `MapWidget.cameraOptions`                         | `MapOptions.initCamera`                                      |
| `MapboxMap`                                       | `MapController` from `onMapCreated`                          |
| `mapboxMap.style`                                 | `StyleController` from `onStyleLoaded` or `controller.style` |
| `setBounds(CameraBoundsOptions(...))`             | `MapOptions.minZoom`, `maxZoom`, `minPitch`, `maxPitch`, `maxBounds` |
| `gestures.updateSettings(GesturesSettings(...))`  | `MapOptions.movements` and `MapOptions.gestures`             |
| `compass`, `scaleBar`, `attribution` settings     | `MapCompass`, `MapScalebar`, `SourceAttribution` in `children` |
| `location.updateSettings(LocationComponentSettings(enabled: true))` | `UserLocationLayer` in `children`, see [User Location](../user-location.md) |
| `onTapListener`, `onLongTapListener`              | `onClick`, `onLongClick`                                     |
| `onCameraChangeListener`, `onMapIdleListener`     | `onCameraMove`, `onIdle`                                     |
| `onStyleLoadedListener`                           | `onStyleLoaded`                                              |
| `onMapLoadErrorListener`                          | `onError`                                                    |

## 4. Camera

=== "mapbox_maps_flutter"

    ```dart
    mapboxMap.setCamera(CameraOptions(zoom: 10));
    mapboxMap.flyTo(
      CameraOptions(center: Point(coordinates: Position(9.17, 47.68)), zoom: 12),
      MapAnimationOptions(duration: 2000),
    );
    final camera = await mapboxMap.cameraForCoordinateBounds(bounds, padding, null, null, null, null);
    ```

=== "maplibre"

    ```dart
    await controller.moveCamera(const CameraUpdate.position(zoom: 10));
    await controller.animateCamera(
      const CameraUpdate.position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 12),
      animation: const CameraAnimation.fly(duration: Duration(seconds: 2)),
    );
    final camera = await controller.cameraFor(
      CameraUpdate.bounds(box, padding: const EdgeInsets.all(32)),
    );
    ```

`easeTo` is `animateCamera` with `CameraAnimation.ease`, the default.
`getCamera()` and the `camera` getter return the camera without a `Future`.
See [Map & Camera](../map.md).

## 5. Annotations

`mapbox_maps_flutter` creates annotations through managers. In `maplibre`,
annotation layers are parameters of `MapLibreMap` and update with
`setState()`:

=== "mapbox_maps_flutter"

    ```dart
    final manager = await mapboxMap.annotations.createCircleAnnotationManager();
    await manager.create(
      CircleAnnotationOptions(
        geometry: Point(coordinates: Position(9.17, 47.68)),
        circleRadius: 12,
        circleColor: Colors.blue.toARGB32(),
      ),
    );
    ```

=== "maplibre"

    ```dart
    MapLibreMap(
      layers: [
        CircleLayer(
          points: const [Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68)))],
          radius: const .literal(12),
          color: const .literal(Colors.blue),
        ),
      ],
    )
    ```

| mapbox_maps_flutter                 | maplibre                                                        |
|-------------------------------------|-----------------------------------------------------------------|
| `PointAnnotationManager`            | `MarkerLayer`, or `WidgetLayer` for Flutter widgets             |
| `CircleAnnotationManager`           | `CircleLayer`                                                   |
| `PolylineAnnotationManager`         | `PolylineLayer`                                                 |
| `PolygonAnnotationManager`          | `PolygonLayer`                                                  |
| `tapEvents`, `dragEvents` of a manager | `onClick`, `onEnter`, `onLeave` and `draggable: true` with `onDragEnd` on the layer, see [Click and Hover](../annotations/click-and-hover.md) and [Drag](../annotations/drag.md) |
| View annotations                    | `WidgetLayer`                                                   |

## 6. Sources and style layers

Sources and layers work the same way. In `maplibre` they are typed: sources
have a named constructor for their input, and layer properties take an
`Expression` instead of a value or a JSON list.

=== "mapbox_maps_flutter"

    ```dart
    await mapboxMap.style.addSource(GeoJsonSource(id: 'route', data: routeJson));
    await mapboxMap.style.addLayer(
      LineLayer(
        id: 'route',
        sourceId: 'route',
        lineColor: Colors.red.toARGB32(),
        lineWidthExpression: ['interpolate', ['linear'], ['zoom'], 10, 2, 16, 8],
      ),
    );
    await mapboxMap.style.setStyleLayerProperty('route', 'visibility', 'none');
    ```

=== "maplibre"

    ```dart
    await style.sources.add(GeoJsonSource.data(id: 'route', data: .text(routeJson)));
    await style.layers.add(
      LineStyleLayer(
        id: 'route',
        sourceId: 'route',
        color: const .literal(Colors.red),
        width: .interpolate(.linear(), .zoom(), {10: .literal(2), 16: .literal(8)}),
      ),
    );
    style.layers['route']?.visible = false;
    ```

`Expression.raw` takes the JSON form of an expression, so expressions of an
existing style can be copied as they are. See [Sources](../sources/index.md),
[Style Layers](../style-layers/index.md) and
[Expressions](../style-layers/expressions.md).

| mapbox_maps_flutter                          | maplibre                                                  |
|----------------------------------------------|-----------------------------------------------------------|
| `style.addSource`, `removeStyleSource`       | `style.sources.add`, `style.sources.remove`               |
| `GeoJsonSource.updateGeoJSON`                | `style.sources.updateGeoJsonData`                         |
| `style.addLayer`, `addLayerAt`, `removeStyleLayer`, `moveStyleLayer` | `style.layers.add(layer, belowLayerId: …)`, `remove`, `move` |
| `setStyleLayerProperty`                      | The setters of the layer from `style.layers[id]`          |
| `style.addStyleImage`                        | `style.addImage` and the other `addImage*` methods        |
| `queryRenderedFeatures`, `querySourceFeatures` | `controller.queryRenderedFeatures`, `controller.querySourceFeatures` |
| `getGeoJsonClusterLeaves`, `getGeoJsonClusterChildren`, `getGeoJsonClusterExpansionZoom` | `controller.getClusterLeaves`, `getClusterChildren`, `getClusterExpansionZoom` |
| `setFeatureState`                            | Not available yet ([#646](https://github.com/josxha/flutter-maplibre/issues/646)) |

## 7. Offline

`OfflineManager` downloads regions of a style for offline use, by bounds or
by a geometry such as a route. It replaces `TileStore` and the offline
manager of Mapbox, but not on web. See [Offline & Cache](../offline.md).

## 8. What `maplibre` doesn't have

- Mapbox data and services: the Mapbox Standard style, search, navigation and
  the Mapbox terrain and satellite tiles. Use other providers for these.
- 3D terrain, sky and 3D models ([#657](https://github.com/josxha/flutter-maplibre/issues/657)).
- The globe projection, except on web ([#602](https://github.com/josxha/flutter-maplibre/issues/602)).

## What `maplibre` adds

- macOS, Windows and Linux.
- Any tile provider or your own tiles. Tokens and fees depend only on the
  provider you choose.
- Declarative annotation layers and [Flutter widgets on the map](../annotations/widgets.md).
- Typed style layers and [expressions](../style-layers/expressions.md).

---
title: 'google_maps_flutter'
description: 'Move an app from google_maps_flutter to maplibre.'
icon: lucide/box
---

# Migrate from google_maps_flutter

`google_maps_flutter` shows Google's maps with a Google Maps Platform API key.
`maplibre` shows vector or raster tiles from any provider or your own server,
styled with the [MapLibre style spec](https://maplibre.org/maplibre-style-spec/),
and also runs on macOS, Windows and Linux. The widget and its markers, polylines,
polygons and circles map closely to `maplibre`, so most of a migration is
renaming.

## 1. Choose map data

Google's map data is only available through Google's SDKs. Pick a tile
provider that serves MapLibre styles, such as those in
[awesome-maplibre](https://github.com/maplibre/awesome-maplibre#maptile-providers),
or host your own tiles, for example as a [PMTiles](../sources/tiles.md#pmtiles)
file. Without a style, the map shows the MapLibre demo tiles.

## 2. Replace the dependency

```bash
flutter pub remove google_maps_flutter
flutter pub add maplibre
```

Remove the Google API key from `AndroidManifest.xml`, `AppDelegate` and
`web/index.html`, and follow [Platform setup](../getting-started/platforms.md).
If your tile provider needs a key, it is usually part of the style URL.

Both packages have a `CameraPosition`, `CameraUpdate` and `Marker`, so don't
import both in the same file.

## 3. The map widget

=== "google_maps_flutter"

    ```dart
    GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(47.68, 9.17),
        zoom: 7,
      ),
      style: myStyleJson,
      minMaxZoomPreference: const MinMaxZoomPreference(3, 18),
      rotateGesturesEnabled: false,
      onMapCreated: (controller) => _controller = controller,
      onTap: (latLng) => print(latLng),
    )
    ```

=== "maplibre"

    ```dart
    MapLibreMap(
      options: MapOptions(
        initCamera: .position(
          center: Geographic(lon: 9.17, lat: 47.68),
          zoom: 7,
        ),
        style: MapStyle.url('https://tiles.openfreemap.org/styles/liberty'),
        minZoom: 3,
        maxZoom: 18,
        movements: MapMovements(rotate: false),
      ),
      onMapCreated: (controller) => _controller = controller,
      onClick: (event) => print(event.point),
    )
    ```

Coordinates are geobase `Geographic(lon: …, lat: …)` instead of
`LatLng(lat, lng)`; mind the order when you convert.

| google_maps_flutter                          | maplibre                                                        |
|----------------------------------------------|-----------------------------------------------------------------|
| `initialCameraPosition`                      | `MapOptions.initCamera`                                         |
| `style`, `mapType`, cloud `mapId`            | `MapOptions.style`, see [Styles](../styles.md)                  |
| `minMaxZoomPreference`                       | `MapOptions.minZoom`, `maxZoom`                                 |
| `cameraTargetBounds`                         | `MapOptions.maxBounds`                                          |
| `rotateGesturesEnabled`, `tiltGesturesEnabled`, `zoomGesturesEnabled`, `scrollGesturesEnabled` | `MapOptions.movements` (`rotate`, `pitch`, `zoom`, `pan`) |
| `zoomControlsEnabled`, `compassEnabled`      | `MapControlButtons`, `MapCompass` in `children`                 |
| `myLocationEnabled`, `myLocationButtonEnabled` | `UserLocationLayer` in `children`                             |
| `onTap`, `onLongPress`                       | `onClick`, `onLongClick`                                        |
| `onCameraMoveStarted`, `onCameraMove`, `onCameraIdle` | `onCameraMoveStart`, `onCameraMove`, `onCameraMoveEnd`  |
| `padding`                                    | `padding` of `CameraUpdate.position` and `CameraUpdate.bounds`  |

Options of `MapOptions` can change at any time with `setState()`, except
`initCamera`.

## 4. Camera

=== "google_maps_flutter"

    ```dart
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(const LatLng(47.68, 9.17), 10),
    );
    await controller.moveCamera(
      CameraUpdate.newLatLngBounds(bounds, 32),
    );
    final region = await controller.getVisibleRegion();
    ```

=== "maplibre"

    ```dart
    await controller.animateCamera(
      const CameraUpdate.position(center: Geographic(lon: 9.17, lat: 47.68), zoom: 10),
    );
    await controller.moveCamera(
      CameraUpdate.bounds(box, padding: const EdgeInsets.all(32)),
    );
    final bounds = await controller.getVisibleBounds();
    ```

`CameraUpdate.points` and `CameraUpdate.geometry` fit points or a geometry,
and `animateCamera` takes a `CameraAnimation.ease` or `.fly`. `getCamera()`
and the `camera` getter return the camera without a `Future`. See
[Map & Camera](../map.md).

## 5. Markers, polylines, polygons and circles

Both packages take annotations as widget parameters, so they update with
`setState()`. In `maplibre`, each layer holds a list of features with one
style, instead of one object with its own style per annotation. Features
with different styles go into different layers, or the style reads
properties of the feature with an [expression](../style-layers/expressions.md).

=== "google_maps_flutter"

    ```dart
    GoogleMap(
      markers: {
        Marker(
          markerId: const MarkerId('office'),
          position: const LatLng(47.68, 9.17),
          onTap: () => print('office'),
        ),
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId('route'),
          points: const [LatLng(47.68, 9.17), LatLng(48, 9.5)],
          color: Colors.red,
          width: 4,
        ),
      },
      circles: {
        Circle(
          circleId: const CircleId('area'),
          center: const LatLng(47.68, 9.17),
          radius: 1000, // meters
          fillColor: Colors.blue.withValues(alpha: 0.3),
        ),
      },
    )
    ```

=== "maplibre"

    ```dart
    MapLibreMap(
      onStyleLoaded: (style) => style.addImageFromIconData(
        id: 'pin',
        iconData: Icons.location_on,
        color: Colors.red,
      ),
      layers: [
        MarkerLayer(
          points: const [
            Feature(
              geometry: Point(Geographic(lon: 9.17, lat: 47.68)),
              properties: {'name': 'office'},
            ),
          ],
          iconImage: const .literal('pin'),
          iconAnchor: const .literal(IconAnchor.bottom),
          onClick: (event) => print(event.index),
        ),
        PolylineLayer(
          polylines: [
            Feature(
              geometry: LineString.from(const [
                Geographic(lon: 9.17, lat: 47.68),
                Geographic(lon: 9.5, lat: 48),
              ]),
            ),
          ],
          color: const .literal(Colors.red),
          width: const .literal(4),
        ),
        CircleLayer(
          points: const [Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68)))],
          radius: const .literal(20), // logical pixels
          color: .literal(Colors.blue.withValues(alpha: 0.3)),
        ),
      ],
    )
    ```

| google_maps_flutter        | maplibre                                                                  |
|----------------------------|---------------------------------------------------------------------------|
| `Marker`                   | A `MarkerLayer` with an icon image, or a `WidgetLayer` for any widget     |
| `Marker.icon` (`BitmapDescriptor`) | `StyleController.addImage`, `addImageFromAssets`, `addImageFromIconData`, `addImageFromWidget` |
| `Marker.draggable`, `onDragEnd` | `draggable: true` and `onDragEnd` on the layer, see [Drag](../annotations/drag.md) |
| `InfoWindow`               | A widget in a `WidgetLayer`, shown after `onClick`                        |
| `Polyline`                 | `PolylineLayer`                                                           |
| `Polygon`                  | `PolygonLayer`                                                            |
| `Circle`                   | `CircleLayer`; its `radius` is in logical pixels, not meters. Draw a polygon for a radius in meters. |
| `ClusterManager`           | A `GeoJsonSource` with a [`GeoJsonCluster`](../sources/geojson.md#clusters) |
| `heatmaps`                 | [`HeatmapStyleLayer`](../style-layers/index.md#heatmap)                   |
| `tileOverlays`             | A [`RasterSource`](../sources/tiles.md#raster-tiles) and a `RasterStyleLayer` |
| `GroundOverlay`            | An [`ImageSource`](../sources/media.md#image)                             |

For thousands of features, or data from a URL, add a
[source](../sources/index.md) and a [style layer](../style-layers/index.md)
instead, which the map styles on its own.

## 6. User location

`google_maps_flutter` shows the location with `myLocationEnabled`. In
`maplibre`, a [`UserLocationLayer`](../user-location.md) in `children` shows a
stream of locations, for example from `geolocator` through the
`maplibre_geolocator` package. Ask for the permission with `geolocator` or
`permission_handler`.

## 7. What `maplibre` doesn't have

- Google's map data, places, traffic, indoor maps and Street View.
- Map types such as satellite or terrain as a switch. Load another style, or
  add a raster source with satellite imagery.

## What `maplibre` adds

- macOS, Windows and Linux.
- Your own [map styles](../styles.md), vector tiles, PMTiles and MBTiles.
- [Style layers](../style-layers/index.md) such as 3D extrusions, hillshading
  and color relief, with data-driven [expressions](../style-layers/expressions.md).
- [Offline regions](../offline.md) (not on web).
- Flutter widgets on the map with a [`WidgetLayer`](../annotations/widgets.md).

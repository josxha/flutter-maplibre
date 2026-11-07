---
title: 'flutter_map'
description: 'Move an app from flutter_map to maplibre.'
icon: lucide/box
---

# Migrate from flutter_map

`flutter_map` and `maplibre` both take their layers as widget parameters and
update with `setState()`, so the structure of your map code stays the same.
The difference is the renderer: `flutter_map` draws tiles and layers with
Flutter in Dart, while `maplibre` renders vector and raster tiles with
MapLibre on the GPU and shows the result in a Flutter `Texture` (an HTML
element on web). Vector tiles,
labels, large data, 3D extrusions, offline regions and the user location
are built in instead of plugins.

Both packages have a `MapOptions`, `MapController`, `MarkerLayer`,
`PolylineLayer`, `PolygonLayer` and `CircleLayer`, so replace the import in
each file instead of using both.

## 1. Replace the dependency

```bash
flutter pub remove flutter_map latlong2
flutter pub add maplibre:^0.4.0-pre.2
```

Also remove the plugins that `maplibre` covers, such as `vector_map_tiles`,
`flutter_map_tile_caching`, `flutter_map_location_marker` and
`flutter_map_marker_cluster`. Then follow
[Platform setup](../getting-started/platforms.md).

## 2. Map data

`flutter_map` gets its map from `TileLayer`s. `maplibre` loads a
[map style](../styles.md), which names the tile sources and how to draw them.
Use the style of a vector tile provider, or keep your raster tiles with a
style of one raster source:

=== "flutter_map"

    ```dart
    FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(47.68, 9.17),
        initialZoom: 7,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [TextSourceAttribution('OpenStreetMap contributors')],
        ),
      ],
    )
    ```

=== "maplibre"

    ```dart
    MapLibreMap(
      options: MapOptions(
        style: MapStyle.json('''
          {
            "version": 8,
            "sources": {
              "osm": {
                "type": "raster",
                "tiles": ["https://tile.openstreetmap.org/{z}/{x}/{y}.png"],
                "tileSize": 256,
                "attribution": "© <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap contributors</a>"
              }
            },
            "layers": [{"id": "osm", "type": "raster", "source": "osm"}]
          }
        '''),
        initCamera: .position(
          center: Geographic(lon: 9.17, lat: 47.68),
          zoom: 7,
        ),
      ),
      // OpenStreetMap requires an attribution that stays visible.
      children: const [SourceAttribution(keepExpanded: true)],
    )
    ```

For vector tiles, use a style URL instead, for example
`MapStyle.url('https://tiles.openfreemap.org/styles/liberty')`. Additional
tile layers become [sources](../sources/index.md) and
[style layers](../style-layers/index.md), and WMS or other overlays become a
`RasterSource`.

## 3. Map options and controller

Coordinates are geobase `Geographic(lon: …, lat: …)` instead of latlong2's
`LatLng(lat, lng)`, and bounds are a `GeoBox` instead of `LatLngBounds`.

| flutter_map                                   | maplibre                                                     |
|-----------------------------------------------|--------------------------------------------------------------|
| `initialCenter`, `initialZoom`, `initialRotation` | `MapOptions.initCamera: .position(center:, zoom:, bearing:)` |
| `initialCameraFit`                            | `MapOptions.initCamera: .bounds(…)` or `.points(…)`          |
| `minZoom`, `maxZoom`                          | `MapOptions.minZoom`, `maxZoom`                              |
| `cameraConstraint: CameraConstraint.contain(bounds:)` | `MapOptions.maxBounds`                               |
| `interactionOptions: InteractionOptions(flags: …)` | `MapOptions.movements` and `MapOptions.gestures`        |
| `onTap`, `onLongPress`, `onSecondaryTap`      | `onClick`, `onLongClick`, `onSecondaryClick`                 |
| `onPositionChanged`, `onMapEvent`             | `onCameraMove` and the other [events](../events.md)          |
| `onMapReady`                                  | `onMapCreated`, `onStyleLoaded`                              |
| `mapController.move(center, zoom)`            | `controller.moveCamera(.position(center:, zoom:))`           |
| `mapController.rotate(degree)`                | `controller.moveCamera(.position(bearing:))`                 |
| `mapController.fitCamera(CameraFit.bounds(…))`| `controller.moveCamera(.bounds(…, padding:))`                |
| `mapController.camera`, `MapCamera.of(context)` | `controller.camera`, `CameraPosition.of(context)`          |
| `camera.latLngToScreenOffset`, `screenOffsetToLatLng` | `controller.toScreenLocation`, `toLngLat`            |

`flutter_map` animates with plugins such as `flutter_map_animations`;
`maplibre` has `controller.animateCamera` with `CameraAnimation.ease` and
`.fly`. Unlike `flutter_map`, the map can also pitch, so `MapOptions` has
`minPitch` and `maxPitch`. See [Map & Camera](../map.md).

## 4. Layers

Annotation layers go into `MapLibreMap.layers`, not `children`. They take
geobase `Feature`s and style each one with
[expressions](../style-layers/expressions.md), instead of an object with a
style per marker or line.

=== "flutter_map"

    ```dart
    PolylineLayer(
      polylines: [
        Polyline(
          points: const [LatLng(47.68, 9.17), LatLng(48, 9.5)],
          color: Colors.red,
          strokeWidth: 4,
        ),
      ],
    )
    ```

=== "maplibre"

    ```dart
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
    )
    ```

| flutter_map                                   | maplibre                                                    |
|-----------------------------------------------|-------------------------------------------------------------|
| `MarkerLayer` with `Marker(child: …)` widgets | `WidgetLayer` in `children` for widgets, or a `MarkerLayer` in `layers` for icons and labels drawn by the map |
| `PolylineLayer`, `Polyline`                   | `PolylineLayer` with `LineString` features                  |
| `PolygonLayer`, `Polygon`                     | `PolygonLayer` with `Polygon` features                      |
| `CircleLayer`, `CircleMarker`                 | `CircleLayer` with `Point` features. The radius is in logical pixels; draw a polygon for a radius in meters. |
| `hitNotifier`, `GestureDetector` on markers   | `onClick`, `onEnter`, `onLeave` on the layer, see [Click and Hover](../annotations/click-and-hover.md) |
| `flutter_map_dragmarker`                      | `draggable: true` on the layer, see [Drag](../annotations/drag.md) |
| `flutter_map_marker_cluster`                  | A `GeoJsonSource` with a [`GeoJsonCluster`](../sources/geojson.md#clusters) |
| `flutter_map_heatmap`                         | [`HeatmapStyleLayer`](../style-layers/index.md#heatmap)     |
| `vector_map_tiles`                            | A style with vector tiles, built in                         |

A `MarkerLayer` of the map draws thousands of points without building a
widget for each. Prefer it over a `WidgetLayer` when the markers are icons or
text. For large data, a [source](../sources/index.md) with
[style layers](../style-layers/index.md) skips comparing the layer lists on
rebuilds.

## 5. Overlays and plugins

Widgets in `MapLibreMap.children` are drawn over the map, like non-layer
children in `flutter_map`. They can read the map with
`MapController.of(context)`, `MapOptions.of(context)` and
`CameraPosition.of(context)`, as plugins read `MapCamera.of(context)`.

| flutter_map plugin                            | maplibre                                                    |
|-----------------------------------------------|-------------------------------------------------------------|
| `flutter_map_location_marker`                 | [`UserLocationLayer`](../user-location.md) with `maplibre_geolocator` |
| `flutter_map_tile_caching`                    | Built-in cache and [offline regions](../offline.md) (not on web) |
| `RichAttributionWidget`                       | `SourceAttribution`, which reads the attribution of the style's sources |
| `Scalebar`, compass and zoom button plugins   | `MapScalebar`, `MapCompass`, `MapControlButtons`, see [User Interface](../ui.md) |

## 6. What changes for your app

- The map is drawn by MapLibre, not by Flutter widgets, so painting the map
  with your own widgets or `CustomPainter`s per tile is not possible. Draw
  over it with `children`, or style it with layers.
- Styles and layers follow the
  [MapLibre style spec](https://maplibre.org/maplibre-style-spec/), so you
  can edit them in [Maputnik](https://maplibre.org/maputnik) and reuse them in
  MapLibre apps on other platforms.

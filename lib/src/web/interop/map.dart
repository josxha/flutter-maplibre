part of 'interop.dart';

/// The JavaScript MapLibre Map object.
@JS('Map')
extension type JsMap._(Camera _) implements Camera {
  /// Create a new MapLibre map.
  external JsMap(MapOptions options);

  /// Add a web-only control button to the map.
  external void addControl(IControl control);

  /// https://github.com/maplibre/maplibre-gl-js/blob/76410880f81de2582be073bc2d730b3f4b8f254d/src/ui/map.ts#L1383
  external void on(String type, JSExportedDartFunction listener);

  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L1935
  external void addSource(String id, SourceSpecification source);

  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L2412
  external void addLayer(LayerSpecification layer, [String? beforeId]);

  /// Convert a coordinate to a screen location.
  ///
  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L1160
  external Point project(LngLat lngLat);

  /// Convert a screen location to a coordinate.
  ///
  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L1178
  external LngLat unproject(Point point);

  /// Get the [HTMLElement] of the map.
  ///
  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L2891
  external HTMLElement getContainer();

  /// Get the JS canvas of the map.
  ///
  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L2919
  external HTMLCanvasElement getCanvas();

  /// Manually trigger a resize of the map to fit the size of the screen.
  external void resize();

  /// Clean up and release all internal JS resources associated with this map.
  external void remove();

  /// Returns the map's geographical centerpoint.
  external LngLat getCenter();

  /// Returns the map's current zoom level.
  external num getZoom();

  /// Returns the map's current bearing. The bearing is the compass direction
  /// that is "up"; for example, a bearing of 90° orients the map so that
  /// east is up.
  external num getBearing();

  /// Returns the map's current pitch (tilt).
  external num getPitch();

  /// Returns the map's geographical bounds. When the bearing or pitch is
  /// non-zero, the visible region is not an axis-aligned rectangle, and the
  /// result is the smallest bounds that encompasses the visible region.
  external LngLatBounds getBounds();

  /// Removes the layer with the given ID from the map's style.
  external void removeLayer(String id);

  /// Removes the source with the given ID from the map's style.
  external void removeSource(String id);

  /// Add an image to the map.
  external void addImage(String id, ImageSpecification data);

  /// Remove an image from the map by its id.
  external void removeImage(String id);

  /// Update the min zoom level.
  external void setMinZoom(double? minZoom);

  /// Update the max zoom level.
  external void setMaxZoom(double? maxZoom);

  /// Update the min camera tilt.
  external void setMinPitch(double? minPitch);

  /// Update the max camera tilt.
  external void setMaxPitch(double? maxPitch);

  /// Update the maximum bounding box of the map camera.
  external void setMaxBounds(LngLatBounds? maxBounds);

  /// Get a Source by its id.
  external SourceSpecification getSource(String id);
}

/// Anonymous MapOptions for the MapLibre JavaScript [JsMap].
@anonymous
@JS()
extension type MapOptions._(JSObject _) implements JSObject {
  /// Create a new JS [MapOptions] object.
  external factory MapOptions({
    required String style,
    required JSObject container,
    double zoom = 0,
    LngLat? center,
    double bearing = 0,
    double pitch = 0,
  });
}

/// Options to specify the map bounds.
@anonymous
@JS()
extension type FitBoundsOptions._(JSObject _) implements JSObject {
  /// Create a new JS [FitBoundsOptions] object.
  external FitBoundsOptions({
    bool? linear,
    // TODO  Offset? offset,
    num? maxZoom,
    // TODO All parameters from FlyToOptions
  });
}

/// The specifications of map sources.
@anonymous
@JS()
extension type SourceSpecification._(JSObject _) implements JSObject {
  /// The default constructor for a [SourceSpecification].
  external SourceSpecification({required String type});

  /// Create a new GeoJSON source.
  external factory SourceSpecification.geoJson({
    required String type,
    required JSAny data,
    num? maxzoom,
    String? attribution,
    num? buffer,
  });

  /// Create a new raster DEM source.
  external factory SourceSpecification.rasterDem({
    required String type,
    required String? url,
    required int tileSize,
    required String? attribution,
  });

  /// Create a new raster source.
  external factory SourceSpecification.raster({
    required String type,
    required JSAny? tiles,
    required int tileSize,
    required String? attribution,
  });

  /// Create a new vector source.
  external factory SourceSpecification.vector({
    required String type,
    required String? url,
  });

  /// Create a new image source.
  external factory SourceSpecification.image({
    required String type,
    required String url,
    required JSAny coordinates,
  });

  /// Create a new video source.
  external factory SourceSpecification.video({
    required String type,
    required JSAny urls,
    required JSAny coordinates,
  });

  /// Used to update the data of a GeoJSON source.
  external void setData(JSAny data);
}

/// The specifications of map layers.
@anonymous
@JS()
extension type LayerSpecification._(JSObject _) implements JSObject {
  /// The default constructor for a [LayerSpecification].
  external LayerSpecification({
    required String id,
    required String type,
    required String? source,
    required JSAny layout,
    required JSAny paint,
  });
}

/// Image data used by [JsMap.addImage].
@anonymous
@JS()
extension type ImageSpecification._(JSObject _) implements JSObject {
  /// Create a new [ImageSpecification] object.
  external ImageSpecification({
    required int width,
    required int height,
    required JSUint8Array data,
  });
}

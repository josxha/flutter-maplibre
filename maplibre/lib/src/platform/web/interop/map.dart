part of 'interop.dart';

/// The JavaScript MapLibre Map object.
@JS('Map')
extension type JsMap._(Camera _) implements Camera {
  /// Create a new MapLibre map.
  external JsMap(MapOptions options);

  /// Register a callback.
  ///
  /// https://github.com/maplibre/maplibre-gl-js/blob/76410880f81de2582be073bc2d730b3f4b8f254d/src/ui/map.ts#L1383
  external void on(String type, JSExportedDartFunction listener);

  /// Register a one-time callback.
  ///
  /// https://github.com/maplibre/maplibre-gl-js/blob/02103f820a524ed359d94a81015e2d8e966f2c2a/src/ui/map.ts#L1593
  external void once(String type, JSExportedDartFunction listener);

  /// https://github.com/maplibre/maplibre-gl-js/blob/76410880f81de2582be073bc2d730b3f4b8f254d/src/ui/map.ts#L1685
  external void setStyle(JSAny style, [StyleSwapOptions? options]);

  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L1935
  external void addSource(String id, SourceSpecification source);

  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L2412
  external void addLayer(LayerSpecification layer, [String? beforeId]);

  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L2467
  external JSObject? getLayer(String id);

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

  /// Returns the map's current pitch / tilt.
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

  /// Update the min camera pitch / tilt.
  external void setMinPitch(double? minPitch);

  /// Update the max camera pitch / tilt.
  external void setMaxPitch(double? maxPitch);

  /// Update the maximum bounding box of the map camera.
  external void setMaxBounds(LngLatBounds? maxBounds);

  /// Update the used projection.
  ///
  /// https://maplibre.org/maplibre-style-spec/projection/
  external void setProjection(ProjectionSpecification projection);

  /// Get a Source by its id.
  external SourceSpecification? getSource(String id);

  /// Get the loaded style.
  external StyleSpecification? getStyle();

  external DoubleClickZoomHandler doubleClickZoom;
  external DragPanHandler dragPan;
  external DragRotateHandler dragRotate;
  external KeyboardHandler keyboard;
  external ScrollZoomHandler scrollZoom;

  /// Shift and drag to draw a box to zoom in
  external BoxZoomHandler boxZoom;

  /// Pitch with rotate
  external bool pitchWithRotate;
  external TwoFingersTouchPitchHandler touchPitch;
  external TwoFingersTouchZoomRotateHandler touchZoomRotate;

  /// Returns an array of MapGeoJSONFeature objects representing visible
  /// features that satisfy the query parameters.
  external JSArray<MapGeoJSONFeature> queryRenderedFeatures(
    Point jsPoint,
    JSAny? options,
  );

  /// Returns an array of MapGeoJSONFeature objects representing visible
  /// features that satisfy the query parameters.
  @JS('queryRenderedFeatures')
  external JSArray<MapGeoJSONFeature> queryRenderedFeaturesRect(
    JSArray<Point> rect,
    JSAny? options,
  );
}

/// Anonymous MapOptions for the MapLibre JavaScript [JsMap].
@anonymous
@JS()
extension type MapOptions._(JSObject _) implements JSObject {
  /// Create a new JS [MapOptions] object.
  external factory MapOptions({
    required JSAny style,
    required JSObject container,
    required double zoom,
    required LngLat? center,
    required double bearing,
    required double pitch,
    required bool attributionControl,
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
    required double? minzoom,
    required double? maxzoom,
    @JS('source-layer') String? sourceLayer,
  });

  /// Get the layer id.
  external String id;

  external JSAny filter;
  external JSAny metadata;
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

/// Projection used by [JsMap.setProjection].
///
/// Defaults to mercator. Supports interpolate expressions.
@anonymous
@JS()
extension type ProjectionSpecification._(JSObject _) implements JSObject {
  /// Create a new [ProjectionSpecification] object.
  external ProjectionSpecification({
    /// The projection definition type. Can be specified as a string, a
    /// transition state, or an expression.
    required String type,
  });
}

/// StyleSwapOptions
///
/// https://github.com/maplibre/maplibre-gl-js/blob/76410880f81de2582be073bc2d730b3f4b8f254d/src/style/style.ts#L159
@anonymous
@JS()
extension type StyleSwapOptions._(JSObject _) implements JSObject {
  /// Create a new [StyleSwapOptions] object.
  external StyleSwapOptions({
    /// If false, force a 'full' update, removing the current style
    /// and building the given one instead of attempting a diff-based update.
    bool? diff,
  });
}

/// QueryRenderedFeaturesOptions
///
/// https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/QueryRenderedFeaturesOptions/
@anonymous
@JS()
extension type QueryRenderedFeaturesOptions._(JSObject _) implements JSObject {
  /// Create a new JS [MapOptions] object.
  external factory QueryRenderedFeaturesOptions({JSArray<JSString>? layers});
}

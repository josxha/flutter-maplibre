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
  external void addLayer(JSAny layer, [String? beforeId]);

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
  ///
  /// https://github.com/maplibre/maplibre-gl-js/blob/42ecfef53c25150227256bb0b5daa29af6efd9e7/src/ui/map.ts#L2530-L2531
  external void addImage(
    String id,
    JSObject image, [
    StyleImageMetadata? options,
  ]);

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

  /// Sets the value of a paint property of the layer [layerId].
  ///
  /// https://maplibre.org/maplibre-gl-js/docs/API/classes/Map/#setpaintproperty
  external void setPaintProperty(String layerId, String name, JSAny? value);

  /// Sets the value of a layout property of the layer [layerId].
  ///
  /// https://maplibre.org/maplibre-gl-js/docs/API/classes/Map/#setlayoutproperty
  external void setLayoutProperty(String layerId, String name, JSAny? value);

  /// Sets the filter of the layer [layerId].
  ///
  /// https://maplibre.org/maplibre-gl-js/docs/API/classes/Map/#setfilter
  external void setFilter(String layerId, JSAny? filter);

  /// Sets the zoom range of the layer [layerId].
  ///
  /// https://maplibre.org/maplibre-gl-js/docs/API/classes/Map/#setlayerzoomrange
  external void setLayerZoomRange(
    String layerId,
    double minZoom,
    double maxZoom,
  );

  /// Moves the layer [id] below the layer [beforeId], or to the top.
  ///
  /// https://maplibre.org/maplibre-gl-js/docs/API/classes/Map/#movelayer
  external void moveLayer(String id, [String? beforeId]);

  /// Get the loaded style.
  external StyleSpecification? getStyle();

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
    required bool attributionControl,
    bool? interactive,
  });
}

/// The specifications of map sources.
@anonymous
@JS()
extension type SourceSpecification._(JSObject _) implements JSObject {
  /// The default constructor for a [SourceSpecification].
  external SourceSpecification({required String type});

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

  /// Used to update the corners of an image source.
  external void setCoordinates(JSAny coordinates);

  /// Used to update the tile URLs of a raster or vector source.
  external void setTiles(JSAny tiles);

  /// Used to update the TileJSON URL of a raster or vector source.
  external void setUrl(String url);
}

/// The specifications of map layers.
@anonymous
@JS()
extension type LayerSpecification._(JSObject _) implements JSObject {
  /// Get the layer id.
  external String id;
}

/// Raw image data used by [JsMap.addImage], RGBA8 without premultiplied
/// alpha.
///
/// https://github.com/maplibre/maplibre-gl-js/blob/42ecfef53c25150227256bb0b5daa29af6efd9e7/src/style/style_image.ts#L92-L93
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

/// The style's image metadata
///
/// https://github.com/maplibre/maplibre-gl-js/blob/42ecfef53c25150227256bb0b5daa29af6efd9e7/src/style/style_image.ts#L58-L59
@anonymous
@JS()
extension type StyleImageMetadata._(JSObject _) implements JSObject {
  /// Create a new [StyleImageMetadata] object.
  external StyleImageMetadata({
    /// The ratio of pixels in the image to physical pixels on the screen
    double? pixelRatio,

    /// Whether the image should be interpreted as an SDF image
    bool? sdf,
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

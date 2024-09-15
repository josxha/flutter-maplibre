part of 'interop.dart';

/// The JavaScript MapLibre Map object.
@JS()
extension type Map._(Camera _) implements Camera {
  /// Create a new MapLibre map.
  external Map(MapOptions options);

  /// Add a web-only control button to the map.
  external void addControl(IControl control);

  /// https://github.com/maplibre/maplibre-gl-js/blob/76410880f81de2582be073bc2d730b3f4b8f254d/src/ui/map.ts#L1383
  external void on(String type, JSExportedDartFunction listener);

  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L1935
  external void addSource(String id, SourceSpecification source);

  /// https://github.com/maplibre/maplibre-gl-js/blob/41e5b32f5bd6264cbc4a8b38210ec6a410152259/src/ui/map.ts#L2412
  external void addLayer(AddLayerObject layer, [String? beforeId]);

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
}

/// Anonymous MapOptions for the MapLibre JavaScript [Map].
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

/// A coordinate object
@anonymous
@JS()
extension type LngLat._(JSObject _) implements JSObject {
  /// Create a new [LngLat] coordinates object.
  external factory LngLat({
    required num lng,
    required num lat,
  });

  /// Create a new JS [LngLat] object from a [Position].
  factory LngLat.fromPosition(Position p) => LngLat(lng: p.lng, lat: p.lat);

  external num lng;
  external num lat;

  /// Convert the JS [LngLat] object to a dart [Position] object.
  Position toPosition() => Position(lng, lat);
}

/// A [LngLatBounds] object represents a geographical bounding box,
/// defined by its southwest and northeast points in longitude and latitude.
@JS()
extension type LngLatBounds._(JSObject _) implements JSObject {
  /// Returns the west edge of the bounding box.
  external num getWest();

  /// Returns the south edge of the bounding box.
  external num getSouth();

  /// Returns the east edge of the bounding box.
  external num getEast();

  /// Returns the north edge of the bounding box.
  external num getNorth();
}

/// Options to specify the map bounds.
@anonymous
@JS()
extension type FitBoundsOptions._(JSObject _) implements JSObject {
  /// Create a new JS [FitBoundsOptions] object.
  external factory FitBoundsOptions({
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
  external factory SourceSpecification({required String type});

  /// Create a new GeoJSON source.
  external factory SourceSpecification.geoJson({
    required String type,
    required JSAny data,
    num? maxzoom,
    String? attribution,
    num? buffer,
  });
}

/// The specifications of map layers.
@anonymous
@JS()
extension type AddLayerObject._(JSObject _) implements JSObject {
  /// The default constructor for a [AddLayerObject].
  external factory AddLayerObject({
    required String id,
    required String type,
    required String source,
  });
}

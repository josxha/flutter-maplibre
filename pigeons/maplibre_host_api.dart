part of 'pigeon.dart';

@HostApi()
abstract interface class MapLibreHostApi {
  /// Move the viewport of the map to a new location without any animation.
  @async
  void jumpTo({
    required LngLat? center,
    required double? zoom,
    required double? bearing,
    required double? pitch,
  });

  /// Animate the viewport of the map to a new location.
  @async
  void flyTo({
    required LngLat? center,
    required double? zoom,
    required double? bearing,
    required double? pitch,
    required int durationMs,
  });

  /// Get the current camera position with the map center, zoom level, camera
  /// tilt and map rotation.
  @async
  MapCamera getCamera();

  /// Get the visible region of the current map camera.
  @async
  LngLatBounds getVisibleRegion();

  /// Convert a coordinate to a location on the screen.
  @async
  ScreenLocation toScreenLocation(double lng, double lat);

  /// Convert a screen location to a coordinate.
  @async
  LngLat toLngLat(double x, double y);

  /// Add a fill layer to the map style.
  @async
  void addFillLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a circle layer to the map style.
  @async
  void addCircleLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a background layer to the map style.
  @async
  void addBackgroundLayer({
    required String id,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a fill extrusion layer to the map style.
  @async
  void addFillExtrusionLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a heatmap layer to the map style.
  @async
  void addHeatmapLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a hillshade layer to the map style.
  @async
  void addHillshadeLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a line layer to the map style.
  @async
  void addLineLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a raster layer to the map style.
  @async
  void addRasterLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Add a symbol layer to the map style.
  @async
  void addSymbolLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
  });

  /// Removes the layer with the given ID from the map's style.
  @async
  void removeLayer(String id);

  /// Removes the source with the given ID from the map's style.
  @async
  void removeSource(String id);

  /// Loads an image to the map. An image needs to be loaded before it can
  /// get used.
  @async
  Uint8List loadImage(String url);

  /// Add an image to the map.
  @async
  void addImage(String id, Uint8List bytes);

  /// Removes an image from the map
  @async
  void removeImage(String id);

  /// Add a GeoJSON source to the map style.
  @async
  void addGeoJsonSource({
    required String id,
    required String data,
  });

  /// Update the data of a GeoJSON source.
  @async
  void updateGeoJsonSource({
    required String id,
    required String data,
  });

  /// Add a image source to the map style.
  @async
  void addImageSource({
    required String id,
    required String url,
    required List<LngLat> coordinates,
  });

  /// Add a raster source to the map style.
  @async
  void addRasterSource({
    required String id,
    required String? url,
    required List<String>? tiles,
    required List<double> bounds,
    required double minZoom,
    required double maxZoom,
    required int tileSize,
    required TileScheme scheme,
    required String? attribution,
    required bool volatile,
  });

  /// Add a raster DEM source to the map style.
  @async
  void addRasterDemSource({
    required String id,
    required String? url,
    required List<String>? tiles,
    required List<double> bounds,
    required double minZoom,
    required double maxZoom,
    required int tileSize,
    required String? attribution,
    required RasterDemEncoding encoding,
    required bool volatile,
    double redFactor = 1,
    double blueFactor = 1,
    double greenFactor = 1,
    double baseShift = 0,
  });

  /// Add a vector source to the map style.
  @async
  void addVectorSource({
    required String id,
    required String? url,
    required List<String>? tiles,
    required List<double> bounds,
    required TileScheme scheme,
    required double minZoom,
    required double maxZoom,
    required String? attribution,
    required bool volatile,
    required String? sourceLayer,
  });

  /// Returns the distance spanned by one pixel at the specified latitude and
  /// current zoom level.
  double getMetersPerPixelAtLatitude(double latitude);

  /// Update the map options.
  @async
  void updateOptions(MapOptions options);
}

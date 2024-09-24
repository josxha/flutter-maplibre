import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/native/pigeon.g.dart',
    dartOptions: DartOptions(),
    dartPackageName: 'maplibre',
    // linux
    gobjectHeaderOut: 'linux/pigeon.g.h',
    gobjectSourceOut: 'linux/pigeon.g.cc',
    gobjectOptions: GObjectOptions(),
    // windows
    cppOptions: CppOptions(namespace: 'pigeon_maplibre'),
    cppHeaderOut: 'windows/runner/pigeon.g.h',
    cppSourceOut: 'windows/runner/pigeon.g.cpp',
    // android
    kotlinOut: 'android/src/main/kotlin/com/github/josxha/maplibre/Pigeon.g.kt',
    kotlinOptions: KotlinOptions(),
    // ios
    swiftOut: 'ios/Classes/Pigeon.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
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
  /// pitch and map rotation.
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

@FlutterApi()
abstract interface class MapLibreFlutterApi {
  /// Get the map options from dart.
  MapOptions getOptions();

  /// Callback for when the style has been loaded.
  void onStyleLoaded();

  /// Callback when the user clicks on the map.
  void onClick(LngLat point);

  /// Callback when the user performs a secondary click on the map
  /// (e.g. by default a click with the right mouse button).
  void onSecondaryClick(LngLat point);

  /// Callback when the user performs a double click on the map.
  void onDoubleClick(LngLat point);

  /// Callback when the user performs a long lasting click on the map.
  void onLongClick(LngLat point);

  /// Callback when the map camera changes.
  void onCameraMoved(MapCamera camera);
}

/// The map options define initial values for the MapLibre map.
class MapOptions {
  const MapOptions({
    required this.style,
    required this.zoom,
    required this.center,
    required this.pitch,
    required this.bearing,
    required this.maxBounds,
    required this.minZoom,
    required this.maxZoom,
    required this.minPitch,
    required this.maxPitch,
    required this.listensOnClick,
    required this.listensOnLongClick,
  });

  /// The URL of the used map style.
  final String style;

  /// The initial zoom level of the map.
  final double zoom;

  /// The initial pitch / tilt of the map.
  final double pitch;

  /// The initial bearing of the map.
  final double bearing;

  /// The initial center coordinates of the map.
  final LngLat? center;

  /// The maximum bounding box of the map camera.
  final LngLatBounds? maxBounds;

  /// The minimum zoom level of the map.
  final double minZoom;

  /// The maximum zoom level of the map.
  final double maxZoom;

  /// The minimum pitch / tilt of the map.
  final double minPitch;

  /// The maximum pitch / tilt of the map.
  final double maxPitch;

  /// If the native map should listen to click events.
  final bool listensOnClick;

  /// If the native map should listen to long click events.
  final bool listensOnLongClick;
}

/// A longitude/latitude coordinate object.
class LngLat {
  const LngLat({required this.lng, required this.lat});

  /// The longitude
  final double lng;

  /// The latitude
  final double lat;
}

/// A pixel location / location on the device screen.
class ScreenLocation {
  const ScreenLocation({required this.x, required this.y});

  /// The x coordinate
  final double x;

  /// The y coordinate
  final double y;
}

/// The current position of the map camera.
class MapCamera {
  const MapCamera({
    required this.center,
    required this.zoom,
    required this.pitch,
    required this.bearing,
  });

  final LngLat center;
  final double zoom;
  final double pitch;
  final double bearing;
}

/// LatLng bound object
class LngLatBounds {
  const LngLatBounds({
    required this.longitudeWest,
    required this.longitudeEast,
    required this.latitudeSouth,
    required this.latitudeNorth,
  });

  final double longitudeWest;
  final double longitudeEast;
  final double latitudeSouth;
  final double latitudeNorth;
}

/// Influences the y direction of the tile coordinates.
enum TileScheme {
  /// Slippy map tilenames scheme.
  xyz,

  /// OSGeo spec scheme.
  tms;
}

/// The encoding used by this source. Mapbox Terrain RGB is used by default.
enum RasterDemEncoding {
  /// Terrarium format PNG tiles.
  terrarium,

  /// Mapbox Terrain RGB tiles.
  mapbox,

  /// Decodes tiles using the redFactor, blueFactor, greenFactor, baseShift
  /// parameters.
  custom;
}

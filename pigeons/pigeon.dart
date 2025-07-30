import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/platform/pigeon.g.dart',
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
  /// Add a fill layer to the map style.
  @async
  void addFillLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a circle layer to the map style.
  @async
  void addCircleLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a background layer to the map style.
  @async
  void addBackgroundLayer({
    required String id,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a fill extrusion layer to the map style.
  @async
  void addFillExtrusionLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a heatmap layer to the map style.
  @async
  void addHeatmapLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a hillshade layer to the map style.
  @async
  void addHillshadeLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a line layer to the map style.
  @async
  void addLineLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a raster layer to the map style.
  @async
  void addRasterLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Add a symbol layer to the map style.
  @async
  void addSymbolLayer({
    required String id,
    required String sourceId,
    required Map<String, Object> layout,
    required Map<String, Object> paint,
    String? belowLayerId,
    String? aboveLayerId,
  });

  /// Loads an image to the map. An image needs to be loaded before it can
  /// get used.
  @async
  Uint8List loadImage(String url);

  /// Add an image to the map.
  @async
  void addImage(String id, Uint8List bytes);

  /// Add multiple images to the map.
  @async
  void addImages(Map<String, Uint8List> images);
}

@FlutterApi()
abstract interface class MapLibreFlutterApi {
  /// Get the map options from dart.
  MapOptions getOptions();

  /// Callback for when the style has been loaded.
  void onStyleLoaded();

  /// Callback for when the map is ready and can be used.
  void onMapReady();

  /// Callback when the user clicks on the map.
  void onClick(LngLat point);

  /// Callback when the map idles.
  void onIdle();

  /// Callback when the map camera idles.
  void onCameraIdle();

  /// Callback when the user performs a secondary click on the map
  /// (e.g. by default a click with the right mouse button).
  void onSecondaryClick(LngLat point);

  /// Callback when the user performs a double click on the map.
  void onDoubleClick(LngLat point);

  /// Callback when the user performs a long lasting click on the map.
  void onLongClick(LngLat point);

  /// Callback when the map camera changes.
  void onMoveCamera(MapCamera camera);

  /// Callback when the map camera starts changing.
  void onStartMoveCamera(CameraChangeReason reason);
}

@HostApi()
// ignore: one_member_abstracts
abstract interface class PermissionManagerHostApi {
  /// Request location permissions.
  @async
  bool requestLocationPermissions({required String explanation});
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
    required this.gestures,
    required this.androidTextureMode,
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

  /// The map gestures.
  final MapGestures gestures;

  /// Toggle the texture mode on android.
  final bool androidTextureMode;
}

/// Map gestures
class MapGestures {
  /// Create a new [MapGestures] object by setting all gestures.
  const MapGestures({
    required this.rotate,
    required this.pan,
    required this.zoom,
    required this.tilt,
  });

  /// Rotate the map bearing.
  final bool rotate;

  /// Move the center of the map around.
  final bool pan;

  /// Zoom the map in and out.
  final bool zoom;

  /// Tilt (pitch) the map camera.
  final bool tilt;
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
class Offset {
  const Offset({required this.x, required this.y});

  /// The x coordinate
  final double x;

  /// The y coordinate
  final double y;
}

/// Camera Padding
class Padding {
  const Padding({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  final int top;
  final int bottom;
  final int left;
  final int right;
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
  tms,
}

/// The encoding used by this source. Mapbox Terrain RGB is used by default.
enum RasterDemEncoding {
  /// Terrarium format PNG tiles.
  terrarium,

  /// Mapbox Terrain RGB tiles.
  mapbox,

  /// Decodes tiles using the redFactor, blueFactor, greenFactor, baseShift
  /// parameters.
  custom,
}

/// The reason the camera is changing.
enum CameraChangeReason {
  /// Developer animation.
  developerAnimation,

  /// API animation.
  apiAnimation,

  /// API gesture
  apiGesture,
}

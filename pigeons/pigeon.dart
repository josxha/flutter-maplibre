import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'maplibre/lib/src/platform/pigeon.g.dart',
    dartOptions: DartOptions(),
    dartPackageName: 'maplibre',
    copyrightHeader: 'pigeons/header.txt',
    // linux
    // gobjectHeaderOut: 'linux/pigeon.g.h',
    // gobjectSourceOut: 'linux/pigeon.g.cc',
    // gobjectOptions: GObjectOptions(),
    // windows
    // cppOptions: CppOptions(namespace: 'pigeon_maplibre'),
    // cppHeaderOut: 'windows/runner/pigeon.g.h',
    // cppSourceOut: 'windows/runner/pigeon.g.cpp',
    // android
    // kotlinOut: 'android/src/main/kotlin/com/github/josxha/maplibre/Pigeon.g.kt',
    // kotlinOptions: KotlinOptions(),
    // ios
    swiftOut:
        'maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/Pigeon.g.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
// ignore: one_member_abstracts
abstract interface class MapLibreHostApi {
  /// Add an image to the map.
  @async
  void addImage(String id, Uint8List bytes);
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
  void onClick(LngLat point, Offset screenPoint);

  /// Callback when the map idles.
  void onIdle();

  /// Callback when the map camera idles.
  void onCameraIdle();

  /// Callback when the user performs a secondary click on the map
  /// (e.g. by default a click with the right mouse button).
  void onSecondaryClick(LngLat point, Offset screenPoint);

  /// Callback when the user performs a double click on the map.
  void onDoubleClick(LngLat point, Offset screenPoint);

  /// Callback when the user performs a long lasting click on the map.
  void onLongClick(LngLat point, Offset screenPoint);

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

@HostApi()
abstract interface class OfflineManagerHostApi {
  /// Clear the ambient cache.
  @async
  void clearAmbientCache();

  /// Invalidate the ambient cache.
  @async
  void invalidateAmbientCache();

  /// Reset database.
  @async
  void resetDatabase();

  /// Set maximum ambient cache size.
  @async
  void setMaximumAmbientCacheSize({required int bytes});

  /// Download a map region.
  @async
  void downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    required String metadata,
  });
}

/// The map options define initial values for the MapLibre map.
class MapOptions {
  const MapOptions({
    required this.style,
    required this.zoom,
    required this.pitch,
    required this.bearing,
    required this.minZoom,
    required this.maxZoom,
    required this.minPitch,
    required this.maxPitch,
    required this.gestures,
    required this.androidTextureMode,
    required this.androidTranslucentTextureSurface,
    required this.androidForegroundLoadColor,
    required this.center,
    required this.maxBounds,
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

  /// Toggle the translucent texture surface mode on Android.
  final bool androidTranslucentTextureSurface;

  /// The MapView foreground color that is used when the map surface is being created.
  final int androidForegroundLoadColor;
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

/// A pixel location / location on the device screen, in logical pixels.
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

/// Model that describes an offline map region.
class OfflineRegion {
  const OfflineRegion({
    required this.id,
    required this.bounds,
    required this.minZoom,
    required this.maxZoom,
    required this.pixelRatio,
    required this.styleUrl,
  });

  final int id;
  final LngLatBounds bounds;
  final double minZoom;
  final double maxZoom;
  final double pixelRatio;
  final String styleUrl;
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

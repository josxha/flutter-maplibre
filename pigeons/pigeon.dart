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
  /// tilt and map rotation.
  @async
  MapCamera getCamera();

  /// Convert a coordinate to a location on the screen.
  @async
  ScreenLocation toScreenLocation(double lng, double lat);

  /// Convert a screen location to a coordinate.
  @async
  LngLat toLngLat(double x, double y);

  /// Add a fill layer to the map style.
  @async
  void addFillLayer({required String id, required String sourceId});

  /// Add a circle layer to the map style.
  @async
  void addCircleLayer({required String id, required String sourceId});

  /// Add a GeoJSON source to the map style.
  @async
  void addGeoJsonSource({
    required String id,
    required String data,
  });
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
}

/// The map options define initial values for the MapLibre map.
class MapOptions {
  const MapOptions({
    required this.style,
    required this.zoom,
    required this.center,
    required this.tilt,
    required this.bearing,
    required this.listensOnClick,
    required this.listensOnLongClick,
  });

  /// The URL of the used map style.
  final String style;

  /// The initial zoom level of the map.
  final double zoom;

  /// The initial tilt of the map.
  final double tilt;

  /// The initial bearing of the map.
  final double bearing;

  /// The initial center coordinates of the map.
  final LngLat? center;

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
    required this.tilt,
    required this.bearing,
  });

  final LngLat center;
  final double zoom;
  final double tilt;
  final double bearing;
}

import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

/// The [MapController] can be used to control, update and manipulate a
/// rendered [MapLibreMap].
abstract interface class MapController {
  /// Convert a latitude/longitude coordinate to a screen location.
  Future<Offset> toScreenLocation(Position lngLat);

  /// Get the latitude/longitude coordinate for a screen location.
  Future<Position> toLngLat(Offset screenLocation);

  /// Instantly move the map camera to a new location.
  Future<void> jumpTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? tilt,
  });

  /// Animate the map camera to a new location.
  Future<void> flyTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? tilt,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? maxDuration,
  });

  /// Add a [Marker] to the map.
  ///
  /// Only supported on web.
  Future<Marker> addMarker(Marker marker);

  /// Add a new source to the map.
  Future<void> addSource(Source source);

  /// Add a new layer to the map. The source must be added before adding it to
  /// the map.
  Future<void> addLayer(Layer layer);

  /// Get the current camera position on the map.
  Future<MapCamera> getCamera();
}

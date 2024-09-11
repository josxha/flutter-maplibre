import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

abstract interface class MapController {
  /// Convert a latitude/longitude coordinate to a screen location.
  Future<Offset> toScreenLocation(Position lngLat);

  /// Get the latitude/longitude coordinate for a screen location.
  Future<Position> toLngLat(Offset screenLocation);

  /// Instantly move the map camera to a new location.
  Future<void> jumpTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? pitch,
  });

  /// Animate the map camera to a new location.
  Future<void> flyTo({
    required Position center,
    required double zoom,
    required double bearing,
    required double pitch,
  });

  Future<Marker> addMarker(Marker marker);

  /// Add a new source to the map.
  Future<void> addSource(Source source);

  /// Add a new layer to the map. The source must be added before adding it to
  /// the map.
  Future<void> addLayer(Layer layer);
}

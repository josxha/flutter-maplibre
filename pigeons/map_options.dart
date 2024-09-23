part of 'pigeon.dart';

/// The map options define initial values for the MapLibre map.
class MapOptions {
  const MapOptions({
    required this.style,
    required this.zoom,
    required this.center,
    required this.tilt,
    required this.bearing,
    required this.maxBounds,
    required this.minZoom,
    required this.maxZoom,
    required this.minTilt,
    required this.maxTilt,
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

  /// The maximum bounding box of the map camera.
  final LngLatBounds? maxBounds;

  /// The minimum zoom level of the map.
  final double minZoom;

  /// The maximum zoom level of the map.
  final double maxZoom;

  /// The minimum pitch / tilt of the map.
  final double minTilt;

  /// The maximum pitch / tilt of the map.
  final double maxTilt;

  /// If the native map should listen to click events.
  final bool listensOnClick;

  /// If the native map should listen to long click events.
  final bool listensOnLongClick;
}

import 'package:geotypes/geotypes.dart';

/// The current camera position on the map.
class MapCamera {
  /// Default constructor for a [MapCamera].
  const MapCamera({
    required this.center,
    required this.zoom,
    required this.tilt,
    required this.bearing,
  });

  /// The position of the map center.
  final Position center;

  /// The zoom level of the map.
  final double zoom;

  /// The bearing of the map.
  final double bearing;

  /// The camera tilt of the map.
  final double tilt;

  @override
  String toString() => 'MapCamera('
      'center: Position(lng: ${center.lng}, lat: ${center.lat}), '
      'zoom: $zoom, bearing: $bearing, tilt: $tilt)';
}

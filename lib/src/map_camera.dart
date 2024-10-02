import 'package:geotypes/geotypes.dart';

/// The current camera position on the map.
class MapCamera {
  /// Default constructor for a [MapCamera].
  const MapCamera({
    required this.center,
    required this.zoom,
    required this.bearing,
    required this.pitch,
  });

  /// The position of the map center.
  final Position center;

  /// The zoom level of the map.
  final double zoom;

  /// The bearing of the map.
  final double bearing;

  /// The camera pitch of the map.
  final double pitch;

  @override
  String toString() => 'MapCamera('
      'center: Position(lng: ${center.lng}, lat: ${center.lat}), '
      'zoom: $zoom, bearing: $bearing, pitch: $pitch)';
}

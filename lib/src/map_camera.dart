import 'package:geotypes/geotypes.dart';

/// The current camera position on the map.
class MapCamera {
  /// Default constructor for a [MapCamera].
  const MapCamera({
    required this.center,
    required this.zoom,
    required this.bearing,
    @Deprecated('Renamed to pitch') double? tilt,
    double? pitch,
  })  : assert(
          tilt != null || pitch != null,
          'Either tilt or pitch must be set.',
        ),
        pitch = tilt ?? pitch ?? 0;

  /// The position of the map center.
  final Position center;

  /// The zoom level of the map.
  final double zoom;

  /// The bearing of the map.
  final double bearing;

  /// The camera pitch of the map.
  final double pitch;

  /// The camera pitch.
  @Deprecated('Renamed to pitch')
  double get tilt => pitch;

  @override
  String toString() => 'MapCamera('
      'center: Position(lng: ${center.lng}, lat: ${center.lat}), '
      'zoom: $zoom, bearing: $bearing, pitch: $pitch)';
}

import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/inherited_model.dart';

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

  /// Find the [MapCamera] of the closest [MapLibreMap] in the widget tree.
  /// Returns null if called outside of the [MapLibreMap.children].
  static MapCamera? maybeOf(BuildContext context) =>
      MapLibreInheritedModel.maybeMapCameraOf(context);

  /// Find the [MapCamera] of the closest [MapLibreMap] in the widget tree.
  /// Returns null if called outside of the [MapLibreMap.children].
  static MapCamera of(BuildContext context) =>
      maybeOf(context) ??
      (throw StateError('Unable to find an instance of MapCamera'));

  @override
  String toString() => 'MapCamera('
      'center: Position(lng: ${center.lng}, lat: ${center.lat}), '
      'zoom: $zoom, bearing: $bearing, pitch: $pitch)';
}

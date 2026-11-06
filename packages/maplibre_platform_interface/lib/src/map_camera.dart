import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

/// The current camera position on the map.
///
/// {@category Basic}
@immutable
class MapCamera {
  /// Default constructor for a [MapCamera].
  const MapCamera({
    required this.center,
    required this.zoom,
    required this.bearing,
    required this.pitch,
    this.roll = 0,
    this.padding = EdgeInsets.zero,
  });

  /// The position of the map center.
  final Geographic center;

  /// The zoom level of the map.
  final double zoom;

  /// The bearing of the map.
  final double bearing;

  /// The camera pitch of the map.
  final double pitch;

  /// The camera roll of the map in degrees.
  final double roll;

  /// The insets in logical pixels that move the center of the camera away
  /// from the center of the map.
  final EdgeInsets padding;

  /// A [CameraUpdate] that moves a map to this camera, for example to
  /// restore a saved camera.
  CameraUpdatePosition toCameraUpdate() => CameraUpdatePosition(
    center: center,
    zoom: zoom,
    bearing: bearing,
    pitch: pitch,
    roll: roll,
    padding: padding,
  );

  /// Find the [MapCamera] of the closest [MapLibreMap] in the widget tree.
  /// Returns null if called outside of the [MapLibreMap.children].
  static MapCamera? maybeOf(BuildContext context) =>
      MapLibreInheritedModel.maybeMapCameraOf(context);

  /// Find the [MapCamera] of the closest [MapLibreMap] in the widget tree.
  /// Throws an [StateError] if called outside of the [MapLibreMap.children].
  static MapCamera of(BuildContext context) =>
      maybeOf(context) ??
      (throw StateError('Unable to find an instance of MapCamera'));

  @override
  String toString() =>
      'MapCamera('
      'center: Geographic(lon: ${center.lon}, lat: ${center.lat}), '
      'zoom: $zoom, bearing: $bearing, pitch: $pitch, roll: $roll, '
      'padding: $padding)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapCamera &&
          runtimeType == other.runtimeType &&
          center == other.center &&
          zoom == other.zoom &&
          bearing == other.bearing &&
          pitch == other.pitch &&
          roll == other.roll &&
          padding == other.padding;

  @override
  int get hashCode => Object.hash(center, zoom, bearing, pitch, roll, padding);
}

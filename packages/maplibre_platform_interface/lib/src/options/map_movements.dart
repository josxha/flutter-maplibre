part of 'map_options.dart';

/// How the user may move the map camera, whatever the gesture.
///
/// [MapGestures] decides which gestures work. A gesture moves the camera
/// only along the movements that are on, so with [rotate] off, a pinch still
/// pans and zooms but no longer rotates.
///
/// ```dart
/// MapOptions(
///   // No tilting and no rotating.
///   movements: MapMovements(rotate: false, pitch: false),
/// )
/// ```
///
/// The movements don't limit the camera that the app sets. To keep the
/// camera within bounds for both, use [MapOptions.minZoom],
/// [MapOptions.maxZoom], [MapOptions.minPitch], [MapOptions.maxPitch] and
/// [MapOptions.maxBounds].
///
/// {@category Basic}
@immutable
class MapMovements {
  /// Allows every movement by default.
  const MapMovements({
    this.pan = true,
    this.zoom = true,
    this.rotate = true,
    this.pitch = true,
  });

  /// Allows no movement by default, so that the user can't move the map.
  ///
  /// For example, `MapMovements.none(zoom: true)` only zooms.
  const MapMovements.none({
    this.pan = false,
    this.zoom = false,
    this.rotate = false,
    this.pitch = false,
  });

  /// Whether gestures may move the center of the map.
  final bool pan;

  /// Whether gestures may zoom the map in and out.
  final bool zoom;

  /// Whether gestures may rotate the map bearing.
  final bool rotate;

  /// Whether gestures may tilt (pitch) the map camera.
  final bool pitch;

  /// A copy with the given movements replaced.
  MapMovements copyWith({bool? pan, bool? zoom, bool? rotate, bool? pitch}) =>
      MapMovements(
        pan: pan ?? this.pan,
        zoom: zoom ?? this.zoom,
        rotate: rotate ?? this.rotate,
        pitch: pitch ?? this.pitch,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapMovements &&
          pan == other.pan &&
          zoom == other.zoom &&
          rotate == other.rotate &&
          pitch == other.pitch;

  @override
  int get hashCode => Object.hash(pan, zoom, rotate, pitch);

  @override
  String toString() =>
      'MapMovements(pan: $pan, zoom: $zoom, rotate: $rotate, pitch: $pitch)';
}

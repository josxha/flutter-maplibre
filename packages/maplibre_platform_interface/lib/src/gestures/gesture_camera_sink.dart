import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Applies the camera changes of map gestures.
///
/// [MapGestureDetector] recognizes gestures in Dart and hands them over as
/// screen-space intents. Each platform applies them with its own
/// projection-aware camera engine, so gestures work alike for every map
/// projection, and runs fling inertia itself.
abstract interface class GestureCameraSink {
  /// A continuous gesture starts. Camera changes until [gestureEnd] come from
  /// the user.
  void gestureStart();

  /// Moves the camera by one step of the running gesture.
  void gestureUpdate(GestureCameraUpdate update);

  /// The running gesture ends. [velocity] is how fast it was moving when the
  /// pointers were released, which the platform continues as a fling, or
  /// [GestureVelocity.zero] if it should not fling.
  void gestureEnd({GestureVelocity velocity = GestureVelocity.zero});

  /// Zooms in by [levels] (out if negative) around [around] outside of a
  /// continuous gesture, as for a scroll wheel or a double tap, animated over
  /// [duration].
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  });
}

/// One step of a continuous map gesture, in logical pixels of the map.
@immutable
class GestureCameraUpdate {
  /// Creates a gesture step.
  const GestureCameraUpdate({
    this.panFrom,
    this.panTo,
    this.zoomBy = 0,
    this.rotateBy = 0,
    this.pitchBy = 0,
    this.around,
  }) : assert(
         (panFrom == null) == (panTo == null),
         'panFrom and panTo are set together',
       );

  /// The screen point whose map content moves to [panTo], or null to not pan.
  final Offset? panFrom;

  /// Where the map content under [panFrom] moves to.
  final Offset? panTo;

  /// Zoom levels to add, after panning.
  final double zoomBy;

  /// Degrees to add to the bearing.
  final double rotateBy;

  /// Degrees to add to the pitch. Positive tilts further from straight down.
  final double pitchBy;

  /// The screen point that zoom, rotation and pitch keep in place, or null
  /// for the platform's default.
  final Offset? around;

  /// Whether [panFrom] and [panTo] move the map.
  bool get pans => panFrom != null && panTo != panFrom;

  @override
  bool operator ==(Object other) =>
      other is GestureCameraUpdate &&
      other.panFrom == panFrom &&
      other.panTo == panTo &&
      other.zoomBy == zoomBy &&
      other.rotateBy == rotateBy &&
      other.pitchBy == pitchBy &&
      other.around == around;

  @override
  int get hashCode =>
      Object.hash(panFrom, panTo, zoomBy, rotateBy, pitchBy, around);

  @override
  String toString() =>
      'GestureCameraUpdate(pan: $panFrom -> $panTo, zoomBy: $zoomBy, '
      'rotateBy: $rotateBy, pitchBy: $pitchBy, around: $around)';
}

/// How fast a continuous gesture moved the camera when its pointers were
/// released.
@immutable
class GestureVelocity {
  /// Creates a release velocity.
  const GestureVelocity({
    this.pan = Offset.zero,
    this.zoom = 0,
    this.rotate = 0,
    this.around,
  });

  /// A release that doesn't fling.
  static const zero = GestureVelocity();

  /// How fast the map content moved on the screen, in logical pixels per
  /// second.
  final Offset pan;

  /// How fast the zoom changed, in zoom levels per second.
  final double zoom;

  /// How fast the bearing changed, in degrees per second, with the sign of
  /// [GestureCameraUpdate.rotateBy].
  final double rotate;

  /// The screen point that a zoom or rotation fling keeps in place, or null
  /// for the platform's default.
  final Offset? around;

  /// Whether the release doesn't fling.
  bool get isZero => pan == Offset.zero && zoom == 0 && rotate == 0;

  @override
  bool operator ==(Object other) =>
      other is GestureVelocity &&
      other.pan == pan &&
      other.zoom == zoom &&
      other.rotate == rotate &&
      other.around == around;

  @override
  int get hashCode => Object.hash(pan, zoom, rotate, around);

  @override
  String toString() =>
      'GestureVelocity(pan: $pan, zoom: $zoom, rotate: $rotate, '
      'around: $around)';
}

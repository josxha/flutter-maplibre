import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// How [MapController.animateCamera] moves the camera to its target.
///
/// {@category Basic}
@immutable
sealed class CameraAnimation {
  const CameraAnimation({required this.curve});

  /// Interpolates center, zoom, bearing and pitch over [duration] along
  /// [curve].
  const factory CameraAnimation.ease({Duration duration, Cubic curve}) =
      CameraAnimationEase;

  /// Zooms out, moves and zooms in again, like a flight. Suits targets that
  /// are far away.
  ///
  /// Without a [duration], the duration follows from [speed].
  const factory CameraAnimation.fly({
    Duration? duration,
    double speed,
    double? peakZoom,
    Cubic curve,
  }) = CameraAnimationFly;

  /// The progress of the animation over time.
  final Cubic curve;
}

/// A [CameraAnimation] that eases to the target, see [CameraAnimation.ease].
///
/// {@category Basic}
final class CameraAnimationEase extends CameraAnimation {
  /// Creates a [CameraAnimation] that eases to the target.
  const CameraAnimationEase({
    this.duration = const Duration(milliseconds: 300),
    super.curve = Curves.ease,
  });

  /// How long the animation takes.
  final Duration duration;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraAnimationEase &&
          duration == other.duration &&
          curve == other.curve;

  @override
  int get hashCode => Object.hash(duration, curve);

  @override
  String toString() =>
      'CameraAnimation.ease(duration: $duration, curve: $curve)';
}

/// A [CameraAnimation] that flies to the target, see [CameraAnimation.fly].
///
/// {@category Basic}
final class CameraAnimationFly extends CameraAnimation {
  /// Creates a [CameraAnimation] that flies to the target.
  const CameraAnimationFly({
    this.duration,
    this.speed = 1.2,
    this.peakZoom,
    super.curve = Curves.ease,
  }) : assert(speed > 0, 'speed must be positive');

  /// How long the flight takes. It overrides [speed].
  final Duration? duration;

  /// The average speed in screenfuls per second, used without a [duration].
  final double speed;

  /// The zoom level at the top of the flight. Without it, MapLibre picks
  /// one that keeps the start and the target in view.
  final double? peakZoom;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraAnimationFly &&
          duration == other.duration &&
          speed == other.speed &&
          peakZoom == other.peakZoom &&
          curve == other.curve;

  @override
  int get hashCode => Object.hash(duration, speed, peakZoom, curve);

  @override
  String toString() =>
      'CameraAnimation.fly(duration: $duration, speed: $speed, '
      'peakZoom: $peakZoom, curve: $curve)';
}

/// How a [MapController.animateCamera] call ended.
///
/// {@category Basic}
enum CameraAnimationResult {
  /// The camera reached the target, or a later
  /// [MapController.animateCamera] call took over.
  completed,

  /// A gesture, [MapController.stopCamera] or [MapController.moveCamera]
  /// stopped the animation, or the map was disposed.
  cancelled,
}

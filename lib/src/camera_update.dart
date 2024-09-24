import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

/// Update the camera. Used in [MapController.moveCamera] and
/// [MapController.animateCamera].
@immutable
class CameraUpdate {
  /// Create a new [CameraUpdate] instance.
  const CameraUpdate._();

  /// Create a new [CameraUpdateValues] instance.
  const factory CameraUpdate.values({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) = CameraUpdateValues._;

  /// Create a new [CameraUpdateInsideBounds] instance.
  const factory CameraUpdate.insideBounds({required LngLatBounds bounds}) =
      CameraUpdateInsideBounds._;
}

/// A [CameraUpdate] with optional target values.
@immutable
class CameraUpdateValues extends CameraUpdate {
  /// Create a new [CameraUpdateValues] instance.
  const CameraUpdateValues._({
    this.center,
    this.zoom,
    this.bearing,
    this.pitch,
  }) : super._();

  /// Map center
  final Position? center;

  /// Zoom level
  final double? zoom;

  /// Camera bearing
  final double? bearing;

  /// Camera pitch
  final double? pitch;
}

/// A [CameraUpdate] .
@immutable
class CameraUpdateInsideBounds extends CameraUpdate {
  /// Create a new [CameraUpdateInsideBounds] instance.
  const CameraUpdateInsideBounds._({required this.bounds}) : super._();

  /// Bounding box
  final LngLatBounds bounds;
}

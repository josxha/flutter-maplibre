import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

/// Update the camera. Used in [MapController.moveCamera] and
/// [MapController.animateCamera].
@immutable
sealed class CameraUpdate {
  /// Create a new [CameraUpdateValues] instance.
  const factory CameraUpdate({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) = CameraUpdateValues._;

  /// Create a new [CameraUpdate] instance.
  const CameraUpdate._();

  /// Create a new [CameraUpdateFitBounds] instance.
  const factory CameraUpdate.fitBounds({
    required LngLatBounds bounds,
    double? maxZoom,
    Offset? offset,
  }) = CameraUpdateFitBounds._;
}

/// A [CameraUpdate] with optional target values.
@immutable
final class CameraUpdateValues extends CameraUpdate {
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

/// A [CameraUpdate] with bounds the camera should be inside.
@immutable
final class CameraUpdateFitBounds extends CameraUpdate {
  /// Create a new [CameraUpdateFitBounds] instance.
  const CameraUpdateFitBounds._({
    required this.bounds,
    this.maxZoom,
    this.offset,
    this.linear,
  }) : super._();

  /// Bounding box.
  final LngLatBounds bounds;

  /// The maximum allowed zoom level.
  final double? maxZoom;

  /// Offset for the map center.
  final Offset? offset;

  /// Uses
  final bool? linear;
}

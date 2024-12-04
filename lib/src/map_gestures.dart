import 'package:flutter/foundation.dart';

/// Configure gestures that are enabled on the map.
@immutable
class MapGestures {
  /// Create a new [MapGestures] object by setting all gestures.
  const MapGestures({
    required this.rotate,
    required this.pan,
    required this.zoom,
    required this.pitch,
    required this.drag,
  });

  /// Create a new [MapGestures] object by enabling all gestures or disabling
  /// just some gestures.
  const MapGestures.all({
    this.rotate = true,
    this.pan = true,
    this.zoom = true,
    this.pitch = true,
    this.drag = true,
  });

  /// Create a new [MapGestures] object by disable all gestures or enabling just
  /// some gestures.
  const MapGestures.none({
    this.rotate = false,
    this.pan = false,
    this.zoom = false,
    this.pitch = false,
    this.drag = false,
  });

  /// Rotate the map bearing.
  final bool rotate;

  /// Move the center of the map around.
  final bool pan;

  /// Zoom the map in and out.
  final bool zoom;

  /// Tilt (pitch) the map camera.
  final bool pitch;

  /// Intercepts the drag gestures.
  ///
  /// This setting can impact the performance of the map. Disable to avoid performance issues.
  final bool drag;

  /// Returns true if all gestures are active
  bool get allEnabled => rotate && pan && zoom && pitch && drag;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapGestures &&
          runtimeType == other.runtimeType &&
          rotate == other.rotate &&
          pan == other.pan &&
          zoom == other.zoom &&
          pitch == other.pitch &&
          drag == other.drag;

  @override
  int get hashCode => Object.hash(rotate, pan, zoom, pitch, drag);
}

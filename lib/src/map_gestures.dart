import 'package:flutter/foundation.dart';

/// Configure gestures that are enabled on the map.
@immutable
class MapGestures {
  /// Create a new [MapGestures] object by setting all gestures.
  const MapGestures({
    required this.doubleClickZoom,
    required this.dragPan,
    required this.dragRotate,
    required this.keyboard,
    required this.scrollZoom,
    required this.touchPitch,
    required this.touchZoomRotate,
  });

  /// Create a new [MapGestures] object by enabling all gestures or disabling
  /// just some gestures.
  const MapGestures.all({
    this.doubleClickZoom = true,
    this.dragPan = true,
    this.dragRotate = true,
    this.keyboard = true,
    this.scrollZoom = true,
    this.touchPitch = true,
    this.touchZoomRotate = true,
  });

  /// Create a new [MapGestures] object by disable all gestures or enabling just
  /// some gestures.
  const MapGestures.none({
    this.doubleClickZoom = false,
    this.dragPan = false,
    this.dragRotate = false,
    this.keyboard = false,
    this.scrollZoom = false,
    this.touchPitch = false,
    this.touchZoomRotate = false,
  });

  /// Double click at the same location on the map to zoom in.
  ///
  /// Tap with two fingers to zoom out.
  final bool doubleClickZoom;

  /// Drag the map with your finger or mouse to move the center of the map.
  final bool dragPan;

  /// Drag the map with your right mouse button or left mouse button while
  /// holding a trigger key (e.g. CTRL).
  final bool dragRotate;

  /// Use the keyboard arrows, + and - key of your keyboard as gesture input.
  ///
  /// [Available key combinations on web](https://maplibre.org/maplibre-gl-js/docs/API/classes/KeyboardHandler/)
  final bool keyboard;

  /// Use the scroll wheel of your mouse or perform a scroll gesture on the
  /// trackpad to zoom in or out on the map.
  final bool scrollZoom;

  /// Move two finger vertically on the map to change the camera pitch.
  final bool touchPitch;

  /// Zoom and rotate the map by performing an pinch gesture on the map using
  /// two fingers.
  final bool touchZoomRotate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapGestures &&
          runtimeType == other.runtimeType &&
          doubleClickZoom == other.doubleClickZoom &&
          dragPan == other.dragPan &&
          dragRotate == other.dragRotate &&
          keyboard == other.keyboard &&
          scrollZoom == other.scrollZoom &&
          touchPitch == other.touchPitch &&
          touchZoomRotate == other.touchZoomRotate;

  @override
  int get hashCode =>
      doubleClickZoom.hashCode ^
      dragPan.hashCode ^
      dragRotate.hashCode ^
      keyboard.hashCode ^
      scrollZoom.hashCode ^
      touchPitch.hashCode ^
      touchZoomRotate.hashCode;
}

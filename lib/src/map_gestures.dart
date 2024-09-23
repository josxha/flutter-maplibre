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
    required this.pitchWithRotate,
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
    this.pitchWithRotate = true,
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
    this.pitchWithRotate = false,
    this.scrollZoom = false,
    this.touchPitch = false,
    this.touchZoomRotate = false,
  });

  /// Double click on the map rapidly to zoom in.
  final bool doubleClickZoom;

  /// Drag the map with your finger or mouse to pan the center of the map.
  final bool dragPan;

  /// Drag the map with your finger or mouse while holding a trigger
  /// key (e.g. CTRL).
  final bool dragRotate;

  /// Use the keyboard arrows, + and - key of your keyboard as gesture input.
  ///
  /// [Available key combinations on web](https://maplibre.org/maplibre-gl-js/docs/API/classes/KeyboardHandler/)
  final bool keyboard;

  /// Set to true if it should be possible to pitch the map with the
  /// [dragRotate] gesture.
  final bool pitchWithRotate;

  /// Use the scroll wheel of your mouse or perform a scroll gesture on the
  /// trackpad to zoom in or out on the map.
  final bool scrollZoom;

  /// Use two fingers to drag the map center.
  final bool touchPitch;

  /// Zoom and rotate the map by performing an pinch gesture on the map using
  /// two fingers.
  final bool touchZoomRotate;
}

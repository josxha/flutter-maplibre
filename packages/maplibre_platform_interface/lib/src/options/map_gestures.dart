part of 'map_options.dart';

/// How the user may move the map camera with gestures.
///
/// Two kinds of switch decide what a gesture does, and every one is on by
/// default:
///
/// - The camera movements, [pan], [zoom], [rotate] and [pitch], say what the
///   user may change, whatever the gesture.
/// - The inputs, such as [pinch] or [scrollWheel], say which gestures work.
///   An input moves only the camera along the movements that are on, so
///   with [rotate] off, a [pinch] still pans and zooms but no longer rotates.
///
/// ```dart
/// MapOptions(
///   // No tilting, and no zooming with the scroll wheel.
///   gestures: MapGestures(pitch: false, scrollWheel: false),
/// )
/// ```
///
/// The gestures don't limit the camera that the app sets. To keep the
/// camera within bounds for both, use [MapOptions.minZoom],
/// [MapOptions.maxZoom], [MapOptions.minPitch], [MapOptions.maxPitch] and
/// [MapOptions.maxBounds].
///
/// {@category Basic}
@immutable
class MapGestures {
  /// Creates the gestures of a map, with every movement and input on by
  /// default.
  const MapGestures({
    this.pan = true,
    this.zoom = true,
    this.rotate = true,
    this.pitch = true,
    this.drag = true,
    this.fling = true,
    this.pinch = true,
    this.scrollWheel = true,
    this.doubleTap = true,
    this.doubleTapDrag = true,
    this.mouseDrag = true,
    this.twoFingerDrag = true,
  });

  /// Creates the gestures of a map that the user can't move, unless a
  /// movement is turned on. The inputs stay on by default.
  ///
  /// For example, `MapGestures.none(zoom: true)` zooms with every zoom
  /// gesture and does nothing else.
  const MapGestures.none({
    this.pan = false,
    this.zoom = false,
    this.rotate = false,
    this.pitch = false,
    this.drag = true,
    this.fling = true,
    this.pinch = true,
    this.scrollWheel = true,
    this.doubleTap = true,
    this.doubleTapDrag = true,
    this.mouseDrag = true,
    this.twoFingerDrag = true,
  });

  /// Whether gestures may move the center of the map.
  final bool pan;

  /// Whether gestures may zoom the map in and out.
  final bool zoom;

  /// Whether gestures may rotate the map bearing.
  final bool rotate;

  /// Whether gestures may tilt (pitch) the map camera.
  final bool pitch;

  /// Drag one finger or the mouse to [pan].
  final bool drag;

  /// Keep the map moving after a fast [drag] or [pinch] is released. Only
  /// takes effect with [pan].
  final bool fling;

  /// Move two fingers on the screen or the trackpad: moving them together
  /// pans, spreading or pinching them zooms, and twisting them rotates.
  final bool pinch;

  /// Scroll with a mouse wheel to [zoom].
  final bool scrollWheel;

  /// Double tap or double click to [zoom] in.
  final bool doubleTap;

  /// Double tap, keep the finger down and drag it to [zoom]: down zooms in,
  /// up zooms out.
  final bool doubleTapDrag;

  /// Drag with the right mouse button, or with the left button while Ctrl is
  /// held: sideways to [rotate], up or down to [pitch].
  final bool mouseDrag;

  /// Drag two fingers side by side up or down to [pitch].
  final bool twoFingerDrag;

  /// A copy with the given switches replaced.
  MapGestures copyWith({
    bool? pan,
    bool? zoom,
    bool? rotate,
    bool? pitch,
    bool? drag,
    bool? fling,
    bool? pinch,
    bool? scrollWheel,
    bool? doubleTap,
    bool? doubleTapDrag,
    bool? mouseDrag,
    bool? twoFingerDrag,
  }) => MapGestures(
    pan: pan ?? this.pan,
    zoom: zoom ?? this.zoom,
    rotate: rotate ?? this.rotate,
    pitch: pitch ?? this.pitch,
    drag: drag ?? this.drag,
    fling: fling ?? this.fling,
    pinch: pinch ?? this.pinch,
    scrollWheel: scrollWheel ?? this.scrollWheel,
    doubleTap: doubleTap ?? this.doubleTap,
    doubleTapDrag: doubleTapDrag ?? this.doubleTapDrag,
    mouseDrag: mouseDrag ?? this.mouseDrag,
    twoFingerDrag: twoFingerDrag ?? this.twoFingerDrag,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapGestures &&
          pan == other.pan &&
          zoom == other.zoom &&
          rotate == other.rotate &&
          pitch == other.pitch &&
          drag == other.drag &&
          fling == other.fling &&
          pinch == other.pinch &&
          scrollWheel == other.scrollWheel &&
          doubleTap == other.doubleTap &&
          doubleTapDrag == other.doubleTapDrag &&
          mouseDrag == other.mouseDrag &&
          twoFingerDrag == other.twoFingerDrag;

  @override
  int get hashCode => Object.hash(
    pan,
    zoom,
    rotate,
    pitch,
    drag,
    fling,
    pinch,
    scrollWheel,
    doubleTap,
    doubleTapDrag,
    mouseDrag,
    twoFingerDrag,
  );

  @override
  String toString() =>
      'MapGestures(pan: $pan, zoom: $zoom, rotate: $rotate, pitch: $pitch, '
      'drag: $drag, fling: $fling, pinch: $pinch, scrollWheel: $scrollWheel, '
      'doubleTap: $doubleTap, doubleTapDrag: $doubleTapDrag, '
      'mouseDrag: $mouseDrag, twoFingerDrag: $twoFingerDrag)';
}

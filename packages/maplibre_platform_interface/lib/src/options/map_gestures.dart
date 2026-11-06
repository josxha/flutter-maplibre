part of 'map_options.dart';

/// The gestures that move the map camera, by category.
///
/// Every gesture is on by default. Turn off a whole category with its
/// `none()` constructor, or single gestures with its parameters:
///
/// ```dart
/// MapOptions(
///   gestures: MapGestures(
///     // No tilting at all.
///     pitch: PitchGestures.none(),
///     // Zoom with everything but the scroll wheel.
///     zoom: ZoomGestures(scrollWheel: false),
///   ),
/// )
/// ```
///
/// {@category Basic}
@immutable
class MapGestures {
  /// Creates the gestures of a map, with every gesture on by default.
  const MapGestures({
    this.pan = const PanGestures(),
    this.zoom = const ZoomGestures(),
    this.rotate = const RotateGestures(),
    this.pitch = const PitchGestures(),
  });

  /// Creates the gestures of a map, with every gesture off by default.
  ///
  /// For example, `MapGestures.none(zoom: ZoomGestures())` only zooms.
  const MapGestures.none({
    this.pan = const PanGestures.none(),
    this.zoom = const ZoomGestures.none(),
    this.rotate = const RotateGestures.none(),
    this.pitch = const PitchGestures.none(),
  });

  /// The gestures that move the center of the map.
  final PanGestures pan;

  /// The gestures that zoom the map in and out.
  final ZoomGestures zoom;

  /// The gestures that rotate the map bearing.
  final RotateGestures rotate;

  /// The gestures that tilt (pitch) the map camera.
  final PitchGestures pitch;

  /// Whether every gesture is on.
  bool get allEnabled =>
      pan.allEnabled &&
      zoom.allEnabled &&
      rotate.allEnabled &&
      pitch.allEnabled;

  /// Whether any gesture is on.
  bool get anyEnabled =>
      pan.anyEnabled ||
      zoom.anyEnabled ||
      rotate.anyEnabled ||
      pitch.anyEnabled;

  /// A copy with the given categories replaced.
  MapGestures copyWith({
    PanGestures? pan,
    ZoomGestures? zoom,
    RotateGestures? rotate,
    PitchGestures? pitch,
  }) => MapGestures(
    pan: pan ?? this.pan,
    zoom: zoom ?? this.zoom,
    rotate: rotate ?? this.rotate,
    pitch: pitch ?? this.pitch,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapGestures &&
          pan == other.pan &&
          zoom == other.zoom &&
          rotate == other.rotate &&
          pitch == other.pitch;

  @override
  int get hashCode => Object.hash(pan, zoom, rotate, pitch);

  @override
  String toString() =>
      'MapGestures(pan: $pan, zoom: $zoom, rotate: $rotate, pitch: $pitch)';
}

/// The gestures that move the center of the map. See [MapGestures.pan].
///
/// {@category Basic}
@immutable
class PanGestures {
  /// Creates the pan gestures, all on by default.
  const PanGestures({this.drag = true, this.fling = true});

  /// Creates the pan gestures, all off by default.
  const PanGestures.none({this.drag = false, this.fling = false});

  /// Drag the map with one finger or the mouse.
  final bool drag;

  /// Keep the map moving after a fast drag is released. Only takes effect
  /// with [drag].
  final bool fling;

  /// Whether every pan gesture is on.
  bool get allEnabled => drag && fling;

  /// Whether any pan gesture is on. [fling] counts only with [drag].
  bool get anyEnabled => drag;

  /// A copy with the given gestures replaced.
  PanGestures copyWith({bool? drag, bool? fling}) =>
      PanGestures(drag: drag ?? this.drag, fling: fling ?? this.fling);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanGestures && drag == other.drag && fling == other.fling;

  @override
  int get hashCode => Object.hash(drag, fling);

  @override
  String toString() => 'PanGestures(drag: $drag, fling: $fling)';
}

/// The gestures that zoom the map. See [MapGestures.zoom].
///
/// {@category Basic}
@immutable
class ZoomGestures {
  /// Creates the zoom gestures, all on by default.
  const ZoomGestures({
    this.pinch = true,
    this.scrollWheel = true,
    this.doubleTap = true,
    this.doubleTapDrag = true,
  });

  /// Creates the zoom gestures, all off by default.
  const ZoomGestures.none({
    this.pinch = false,
    this.scrollWheel = false,
    this.doubleTap = false,
    this.doubleTapDrag = false,
  });

  /// Spread or pinch two fingers, or pinch on a trackpad.
  final bool pinch;

  /// Scroll with a mouse wheel.
  final bool scrollWheel;

  /// Double tap or double click to zoom in.
  final bool doubleTap;

  /// Double tap, keep the finger down and drag it: down zooms in, up zooms
  /// out.
  final bool doubleTapDrag;

  /// Whether every zoom gesture is on.
  bool get allEnabled => pinch && scrollWheel && doubleTap && doubleTapDrag;

  /// Whether any zoom gesture is on.
  bool get anyEnabled => pinch || scrollWheel || doubleTap || doubleTapDrag;

  /// A copy with the given gestures replaced.
  ZoomGestures copyWith({
    bool? pinch,
    bool? scrollWheel,
    bool? doubleTap,
    bool? doubleTapDrag,
  }) => ZoomGestures(
    pinch: pinch ?? this.pinch,
    scrollWheel: scrollWheel ?? this.scrollWheel,
    doubleTap: doubleTap ?? this.doubleTap,
    doubleTapDrag: doubleTapDrag ?? this.doubleTapDrag,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZoomGestures &&
          pinch == other.pinch &&
          scrollWheel == other.scrollWheel &&
          doubleTap == other.doubleTap &&
          doubleTapDrag == other.doubleTapDrag;

  @override
  int get hashCode => Object.hash(pinch, scrollWheel, doubleTap, doubleTapDrag);

  @override
  String toString() =>
      'ZoomGestures(pinch: $pinch, scrollWheel: $scrollWheel, '
      'doubleTap: $doubleTap, doubleTapDrag: $doubleTapDrag)';
}

/// The gestures that rotate the map bearing. See [MapGestures.rotate].
///
/// {@category Basic}
@immutable
class RotateGestures {
  /// Creates the rotate gestures, all on by default.
  const RotateGestures({this.twist = true, this.mouseDrag = true});

  /// Creates the rotate gestures, all off by default.
  const RotateGestures.none({this.twist = false, this.mouseDrag = false});

  /// Twist two fingers, or rotate on a trackpad where the platform reports
  /// it.
  final bool twist;

  /// Drag sideways with the right mouse button, or with the left button
  /// while Ctrl is held.
  final bool mouseDrag;

  /// Whether every rotate gesture is on.
  bool get allEnabled => twist && mouseDrag;

  /// Whether any rotate gesture is on.
  bool get anyEnabled => twist || mouseDrag;

  /// A copy with the given gestures replaced.
  RotateGestures copyWith({bool? twist, bool? mouseDrag}) => RotateGestures(
    twist: twist ?? this.twist,
    mouseDrag: mouseDrag ?? this.mouseDrag,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RotateGestures &&
          twist == other.twist &&
          mouseDrag == other.mouseDrag;

  @override
  int get hashCode => Object.hash(twist, mouseDrag);

  @override
  String toString() => 'RotateGestures(twist: $twist, mouseDrag: $mouseDrag)';
}

/// The gestures that tilt (pitch) the map camera. See [MapGestures.pitch].
///
/// {@category Basic}
@immutable
class PitchGestures {
  /// Creates the pitch gestures, all on by default.
  const PitchGestures({this.twoFingerDrag = true, this.mouseDrag = true});

  /// Creates the pitch gestures, all off by default.
  const PitchGestures.none({
    this.twoFingerDrag = false,
    this.mouseDrag = false,
  });

  /// Drag two fingers side by side up or down.
  final bool twoFingerDrag;

  /// Drag up or down with the right mouse button, or with the left button
  /// while Ctrl is held.
  final bool mouseDrag;

  /// Whether every pitch gesture is on.
  bool get allEnabled => twoFingerDrag && mouseDrag;

  /// Whether any pitch gesture is on.
  bool get anyEnabled => twoFingerDrag || mouseDrag;

  /// A copy with the given gestures replaced.
  PitchGestures copyWith({bool? twoFingerDrag, bool? mouseDrag}) =>
      PitchGestures(
        twoFingerDrag: twoFingerDrag ?? this.twoFingerDrag,
        mouseDrag: mouseDrag ?? this.mouseDrag,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PitchGestures &&
          twoFingerDrag == other.twoFingerDrag &&
          mouseDrag == other.mouseDrag;

  @override
  int get hashCode => Object.hash(twoFingerDrag, mouseDrag);

  @override
  String toString() =>
      'PitchGestures(twoFingerDrag: $twoFingerDrag, mouseDrag: $mouseDrag)';
}

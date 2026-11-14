import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Zoom levels per logical pixel of mouse wheel scroll, as MapLibre GL JS
/// uses for wheel zoom.
const double _wheelZoomRate = 1 / 450;

/// Degrees of bearing per logical pixel of horizontal mouse drag, and of
/// pitch per pixel of vertical drag, as in MapLibre GL JS.
const _rotateDegreesPerPixel = 0.8;
const _pitchDegreesPerPixel = 0.5;

const _doubleTapZoomDuration = Duration(milliseconds: 300);

/// Logical pixels of vertical drag per zoom level in a double-tap-and-drag
/// zoom.
const _quickZoomPixelsPerLevel = 150.0;

/// Degrees of pitch per logical pixel that two fingers move vertically.
const _shoveDegreesPerPixel = 0.25;

/// Logical pixels both fingers move vertically before a two-finger drag
/// tilts the map.
const _shoveSlop = 10.0;

/// A long press that only one finger can make.
///
/// The long press recognizer times the first finger alone, and when its
/// deadline passes it wins the gesture arena over every other recognizer,
/// whatever else has landed meanwhile. So two fingers resting on the map for
/// half a second before a pinch, twist or tilt were a long press, and the
/// pinch never moved the camera. A second finger landing before the deadline
/// ends the hold instead, and the recognizer then stays out until every
/// finger has lifted; once the deadline has passed, the hold is left as it
/// is.
class _OneFingerLongPressRecognizer extends LongPressGestureRecognizer {
  _OneFingerLongPressRecognizer({super.debugOwner});

  // Whether the deadline has passed, which a second finger cannot take back.
  // Winning the arena is not enough: the arena can go to the long press
  // early, when it is the only recognizer there or in a sweep.
  var _held = false;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (state == GestureRecognizerState.ready || _held) {
      super.addAllowedPointer(event);
      return;
    }
    // Track the finger too, so the recognizer only gets ready again once it
    // has lifted, and end the hold. Its arena may already have resolved, so
    // stop the timer directly as well.
    startTrackingPointer(event.pointer, event.transform);
    resolve(GestureDisposition.rejected);
    if (primaryPointer case final pointer?) rejectGesture(pointer);
  }

  @override
  void didExceedDeadline() {
    _held = true;
    super.didExceedDeadline();
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    _held = false;
    super.didStopTrackingLastPointer(pointer);
  }
}

/// The long press action of the map's semantics, a long click at the center
/// of the map.
class _LongClickSemantics extends SemanticsGestureDelegate {
  const _LongClickSemantics(this.onLongClick);

  /// Reports a long click at a position in the map, or null without one.
  final void Function(Offset localPosition)? onLongClick;

  @override
  void assignSemantics(RenderSemanticsGestureHandler renderObject) {
    renderObject.onLongPress = switch (onLongClick) {
      final onLongClick? => () => onLongClick(renderObject.paintBounds.center),
      null => null,
    };
  }
}

/// Recognizes map gestures on [child] and hands their camera changes to
/// [camera].
///
/// Flutter hit-tests the pointers, so widgets over the map keep theirs. The
/// gestures follow the platform conventions: a drag pans, a pinch zooms and
/// twists, a scroll wheel and a double tap zoom, a double tap and drag zooms,
/// two fingers side by side dragged vertically tilt, and a right-button or
/// Ctrl + left-button mouse drag rotates and tilts. A long click is a hold of
/// one finger: a second finger landing during the hold ends it, and leaves
/// the fingers to the pinch, twist or tilt. [gestures] turns them off one by
/// one, and [movements] limits what they may change.
class MapGestureDetector extends StatefulWidget {
  /// Creates a gesture layer over a map.
  const MapGestureDetector({
    required this.gestures,
    required this.camera,
    required this.toLngLat,
    required this.child,
    this.movements = const MapMovements(),
    this.onClick,
    this.onDoubleClick,
    this.onSecondaryClick,
    this.onLongClick,
    this.onDragStart,
    this.onDrag,
    this.onDragEnd,
    this.onPointerMove,
    this.onPointerLeave,
    super.key,
  });

  /// The gestures that move the camera.
  final MapGestures gestures;

  /// How the gestures may move the camera.
  final MapMovements movements;

  /// Applies the camera changes.
  final GestureCameraSink camera;

  /// The location at a screen point, or null while the map can't tell.
  final Geographic? Function(Offset screenPoint) toLngLat;

  /// Called on a tap or click.
  final MapEventCallback<MapEventClick>? onClick;

  /// Called on a double tap or click. Double taps are only recognized while
  /// this is set or [MapGestures.doubleTap] zooms, because recognizing them
  /// delays every single tap until a second one can no longer follow.
  ///
  /// The double tap zooms unless the callback calls
  /// [MapEventDoubleClick.preventDefault], before the [Future] it returns
  /// completes if it returns one.
  final FutureOr<void> Function(MapEventDoubleClick event)? onDoubleClick;

  /// Called on a click with the secondary mouse button.
  final MapEventCallback<MapEventSecondaryClick>? onSecondaryClick;

  /// Called on a long press.
  final MapEventCallback<MapEventLongClick>? onLongClick;

  /// Called when a drag with one finger or the primary mouse button starts,
  /// where it went down.
  ///
  /// The drag pans the camera unless the callback calls
  /// [MapEventDragStart.preventDefault], before the [Future] it returns
  /// completes if it returns one. The pan waits for that [Future].
  final FutureOr<void> Function(MapEventDragStart event)? onDragStart;

  /// Called whenever the pointer of a drag moves.
  final MapEventCallback<MapEventDrag>? onDrag;

  /// Called when a drag ends, or when a second finger makes it a pinch.
  final MapEventCallback<MapEventDragEnd>? onDragEnd;

  /// Called when a mouse or stylus moves over the map without a pressed
  /// button.
  final MapEventCallback<MapEventPointerMove>? onPointerMove;

  /// Called when a mouse or stylus leaves the map.
  final MapEventCallback<MapEventPointerLeave>? onPointerLeave;

  /// The map.
  final Widget child;

  /// Logical pixels per pixel of a wheel event's scroll delta, so that a
  /// wheel notch zooms as far as in MapLibre GL JS.
  ///
  /// Flutter web takes the CSS pixels of a browser wheel event as physical
  /// pixels and divides them by the device pixel ratio, except on macOS,
  /// where it multiplies them first. So on a 2x screen a wheel notch would
  /// zoom half as far.
  @visibleForTesting
  static double wheelPixelScale({
    required bool isWeb,
    required TargetPlatform platform,
    required double devicePixelRatio,
  }) => isWeb && platform != TargetPlatform.macOS ? devicePixelRatio : 1;

  @override
  State<MapGestureDetector> createState() => _MapGestureDetectorState();
}

class _MapGestureDetectorState extends State<MapGestureDetector> {
  var _gestureActive = false;

  // Scale gesture state, relative to the previous update.
  var _lastScale = 1.0;
  var _lastRotation = 0.0;

  /// Whether the current scale gesture panned, which it may fling after.
  var _scalePanned = false;

  // Whether the current scale gesture zoomed and rotated, which it may fling
  // after, how far it did, and where its fingers were last.
  var _scaleZoomed = false;
  var _scaleRotated = false;
  var _pinchZoom = 0.0;
  var _pinchRotation = 0.0;
  Offset? _pinchFocal;

  /// Tracks [_pinchZoom] and [_pinchRotation] as x and y, for the release
  /// velocity of a pinch.
  var _pinchTracker = VelocityTracker.withKind(PointerDeviceKind.touch);

  /// Tracks the focal point of a gesture with more than one pointer, whose
  /// pan velocity is not that of its last pointer.
  var _focalTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  var _scaleMultiTouch = false;

  /// Where the primary pointer went down while it was the only one, where a
  /// drag starts.
  Offset? _dragDownPosition;

  // The current drag: its start event, the [Future] that its callback
  // returned until it completes, where its pointer was last, and where the
  // pan it held back while it waited started.
  MapEventDragStart? _drag;
  Future<void>? _dragPending;
  Offset? _dragPosition;
  Offset? _heldPanFrom;

  /// Whether a drag that didn't pan became a pinch, which then doesn't move
  /// the camera either until every pointer is up.
  var _scaleHeld = false;

  /// The pointers that are down.
  final _pointers = <int>{};

  // The mouse pointer that rotates and tilts: a right-button or Ctrl and
  // left-button drag.
  int? _secondaryPointer;

  // Touch pointers that are down, and where the only one went down, to tell
  // a tap from a drag.
  final _touchPointers = <int>{};
  Offset? _touchDownPosition;

  // The last tap's release, which a second touch nearby starts a quick zoom
  // from.
  Duration? _lastTapUpTime;
  Offset? _lastTapUpPosition;

  // Double-tap-and-drag zoom: the second tap's pointer and position, and
  // whether it has moved far enough to zoom.
  int? _quickZoomPointer;
  Offset? _quickZoomAnchor;
  var _quickZooming = false;

  /// Where the second tap of a double tap went down.
  Offset? _doubleTapPosition;

  /// The event of the current double tap, and the [Future] that its callback
  /// returned until it completes. The double tap and the quick zoom that
  /// follows it only zoom once it is done and wasn't prevented.
  MapEventDoubleClick? _doubleClick;
  Future<void>? _doubleClickPending;

  // Two-finger tilt ("shove"): where each of the two fingers was when the
  // second went down, where it is now, and whether the gesture tilts, or was
  // found to be a pinch or rotation instead.
  final _shoveStart = <int, Offset>{};
  final _shovePosition = <int, Offset>{};
  var _shoving = false;
  var _shoveRejected = false;

  MapGestures get _gestures => widget.gestures;

  MapMovements get _movements => widget.movements;

  GestureCameraSink get _camera => widget.camera;

  bool get _zoomsOnDoubleTap => _movements.zoom && _gestures.doubleTap;

  bool get _reportsDrags =>
      widget.onDragStart != null ||
      widget.onDrag != null ||
      widget.onDragEnd != null;

  @override
  void dispose() {
    _endGesture();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gestures = _gestures;
    final movements = _movements;
    final scales =
        (movements.pan && (gestures.drag || gestures.pinch)) ||
        ((movements.zoom || movements.rotate) && gestures.pinch) ||
        _reportsDrags;
    final doubleTaps = _zoomsOnDoubleTap || widget.onDoubleClick != null;
    final onPointerMove = widget.onPointerMove;
    final onPointerLeave = widget.onPointerLeave;
    // The whole map takes part in gestures, whatever its child hit-tests. The
    // opaque listener is the outermost widget, so that the map reports the
    // hit to its ancestors: a MouseRegion that isn't opaque reports a miss,
    // which would hide the pointer from the app's widgets around the map and
    // pass it on to the widgets behind it.
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerHover: switch (onPointerMove) {
        final onPointerMove? => (event) => _emitUserInput(
          event.localPosition,
          (point, screenPoint) => onPointerMove(
            MapEventPointerMove(point: point, screenPoint: screenPoint),
          ),
        ),
        null => null,
      },
      onPointerSignal: _onPointerSignal,
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerEnd,
      onPointerCancel: _onPointerEnd,
      // Always there, so that the child keeps its state when the callback
      // comes or goes.
      child: MouseRegion(
        opaque: false,
        onExit: switch (onPointerLeave) {
          final onPointerLeave? => (_) => onPointerLeave(
            const MapEventPointerLeave(),
          ),
          null => null,
        },
        // Always there too, for the same reason.
        child: RawGestureDetector(
          behavior: HitTestBehavior.opaque,
          gestures: {
            if (widget.onLongClick case final onLongClick?)
              _OneFingerLongPressRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                    _OneFingerLongPressRecognizer
                  >(
                    () => _OneFingerLongPressRecognizer(debugOwner: this),
                    (recognizer) => recognizer
                      ..gestureSettings = MediaQuery.maybeGestureSettingsOf(
                        context,
                      )
                      ..onLongPressStart = (details) =>
                          _emitLongClick(onLongClick, details.localPosition),
                  ),
          },
          // The default semantics only find Flutter's own long press
          // recognizer, so the long press action is given here.
          semantics: _LongClickSemantics(switch (widget.onLongClick) {
            final onLongClick? => (localPosition) => _emitLongClick(
              onLongClick,
              localPosition,
            ),
            null => null,
          }),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: switch (widget.onClick) {
              final onClick? => (details) => _emitUserInput(
                details.localPosition,
                (point, screenPoint) => onClick(
                  MapEventClick(point: point, screenPoint: screenPoint),
                ),
              ),
              null => null,
            },
            onSecondaryTapUp: switch (widget.onSecondaryClick) {
              final onSecondaryClick? => (details) => _emitUserInput(
                details.localPosition,
                (point, screenPoint) => onSecondaryClick(
                  MapEventSecondaryClick(
                    point: point,
                    screenPoint: screenPoint,
                  ),
                ),
              ),
              null => null,
            },
            onDoubleTapDown: doubleTaps ? _onDoubleTapDown : null,
            onDoubleTap: doubleTaps ? _onDoubleTap : null,
            onScaleStart: scales ? _onScaleStart : null,
            onScaleUpdate: scales ? _onScaleUpdate : null,
            onScaleEnd: scales ? _onScaleEnd : null,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  /// Calls [emit] with the location at [position], if the map can tell it.
  void _emitUserInput(
    Offset position,
    void Function(Geographic point, Offset screenPoint) emit,
  ) {
    final point = widget.toLngLat(position);
    if (point == null) return;
    emit(point, position);
  }

  void _onDoubleTapDown(TapDownDetails details) {
    _doubleTapPosition = details.localPosition;
    _clearDoubleClick();
    final onDoubleClick = widget.onDoubleClick;
    if (onDoubleClick == null) return;
    _emitUserInput(details.localPosition, (point, screenPoint) {
      final event = MapEventDoubleClick(point: point, screenPoint: screenPoint);
      _doubleClick = event;
      final result = onDoubleClick(event);
      if (result is! Future<void>) return;
      late final Future<void> pending;
      pending = result
          .catchError((Object error, StackTrace stack) {
            FlutterError.reportError(
              FlutterErrorDetails(
                exception: error,
                stack: stack,
                library: 'maplibre',
                context: ErrorDescription('while handling a double click'),
              ),
            );
          })
          .whenComplete(() {
            if (identical(_doubleClickPending, pending)) {
              _doubleClickPending = null;
            }
          });
      _doubleClickPending = pending;
    });
  }

  void _clearDoubleClick() {
    _doubleClick = null;
    _doubleClickPending = null;
  }

  /// Zooms in on the second release of a double tap, once its callback is
  /// done, unless that prevented it. A second tap that drags instead is a
  /// quick zoom, which the double tap recognizer rejects.
  void _onDoubleTap() {
    final position = _doubleTapPosition;
    final event = _doubleClick;
    final pending = _doubleClickPending;
    _doubleTapPosition = null;
    _clearDoubleClick();
    if (position == null || !_zoomsOnDoubleTap) return;
    void zoomIn() {
      if (!mounted ||
          !_zoomsOnDoubleTap ||
          (event?.defaultPrevented ?? false)) {
        return;
      }
      _camera.zoomBy(1, position, duration: _doubleTapZoomDuration);
    }

    if (pending == null) {
      zoomIn();
    } else {
      unawaited(pending.then((_) => zoomIn()));
    }
  }

  void _onPointerSignal(PointerSignalEvent event) {
    final gestures = _gestures;
    final movements = _movements;
    if (!movements.zoom) return;
    final double levels;
    switch (event) {
      case PointerScrollEvent(:final scrollDelta) when gestures.scrollWheel:
        final scale = MapGestureDetector.wheelPixelScale(
          isWeb: kIsWeb,
          platform: defaultTargetPlatform,
          devicePixelRatio: View.of(context).devicePixelRatio,
        );
        levels = -scrollDelta.dy * scale * _wheelZoomRate;
      // A trackpad pinch where the platform reports it as a signal, as on
      // the web.
      case PointerScaleEvent(:final scale) when gestures.pinch && scale > 0:
        levels = log(scale) / ln2;
      default:
        return;
    }
    if (levels == 0 || !levels.isFinite) return;
    _camera.zoomBy(levels, event.localPosition);
  }

  void _onPointerDown(PointerDownEvent event) {
    _pointers.add(event.pointer);
    _dragDownPosition = switch (event.kind) {
      PointerDeviceKind.touch =>
        _touchPointers.isEmpty ? event.localPosition : null,
      PointerDeviceKind.mouse
          when event.buttons == kPrimaryMouseButton &&
              !HardwareKeyboard.instance.isControlPressed =>
        event.localPosition,
      PointerDeviceKind.stylus ||
      PointerDeviceKind.invertedStylus => event.localPosition,
      _ => null,
    };
    // Rotate and tilt with the right button or Ctrl and the left button, as in
    // MapLibre GL JS.
    if (event.kind == PointerDeviceKind.mouse &&
        (event.buttons & kSecondaryMouseButton != 0 ||
            (event.buttons & kPrimaryMouseButton != 0 &&
                HardwareKeyboard.instance.isControlPressed)) &&
        _gestures.secondaryDrag &&
        (_movements.rotate || _movements.pitch)) {
      _secondaryPointer = event.pointer;
      _beginGesture();
    }
    if (event.kind != PointerDeviceKind.touch) return;

    _touchPointers.add(event.pointer);
    _shovePosition[event.pointer] = event.localPosition;
    if (_touchPointers.length > 1) {
      // A second finger makes it a pinch or tilt, not a tap or a quick zoom.
      _touchDownPosition = null;
      _stopQuickZoom();
      _startShove();
      return;
    }
    _touchDownPosition = event.localPosition;
    final lastTime = _lastTapUpTime;
    final lastPosition = _lastTapUpPosition;
    if (_movements.zoom &&
        _gestures.doubleTapDrag &&
        lastTime != null &&
        lastPosition != null &&
        event.timeStamp - lastTime <= kDoubleTapTimeout &&
        (event.localPosition - lastPosition).distance <= kDoubleTapSlop) {
      _quickZoomPointer = event.pointer;
      _quickZoomAnchor = event.localPosition;
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (event.pointer == _quickZoomPointer) {
      _onQuickZoomMove(event);
      return;
    }
    if (_shovePosition.containsKey(event.pointer)) {
      _shovePosition[event.pointer] = event.localPosition;
      if (_shoveStart.containsKey(event.pointer)) _onShoveMove(event);
    }
    if (event.pointer != _secondaryPointer) return;
    final movements = _movements;
    final center = context.size?.center(Offset.zero);
    // Dragging right raises the bearing below the center and lowers it above,
    // so the map follows the pointer around the center like a wheel.
    var bearing = event.delta.dx * _rotateDegreesPerPixel;
    if (center != null && event.localPosition.dy < center.dy) {
      bearing = -bearing;
    }
    _camera.gestureUpdate(
      GestureCameraUpdate(
        rotateBy: movements.rotate ? bearing : 0,
        // Dragging up tilts further.
        pitchBy: movements.pitch ? -event.delta.dy * _pitchDegreesPerPixel : 0,
        around: center,
      ),
    );
  }

  void _onPointerEnd(PointerEvent event) {
    _pointers.remove(event.pointer);
    if (_pointers.isEmpty) _scaleHeld = false;
    _shovePosition.remove(event.pointer);
    if (_shoveStart.containsKey(event.pointer)) _stopShove();
    if (_touchPointers.remove(event.pointer)) _onTouchEnd(event);
    if (event.pointer != _secondaryPointer) return;
    _secondaryPointer = null;
    _endGesture();
  }

  void _onTouchEnd(PointerEvent event) {
    final down = _touchDownPosition;
    final tapped =
        event is PointerUpEvent &&
        event.pointer != _quickZoomPointer &&
        down != null &&
        (event.localPosition - down).distance <= kTouchSlop;
    // A tap arms a quick zoom for the next touch. The second tap of a double
    // tap does not, so a third tap starts afresh.
    _lastTapUpTime = tapped ? event.timeStamp : null;
    _lastTapUpPosition = tapped ? event.localPosition : null;
    // A first tap starts a new double tap, which the old event has no say in.
    if (tapped) _clearDoubleClick();
    _touchDownPosition = null;
    if (event.pointer == _quickZoomPointer) _stopQuickZoom();
  }

  /// Zooms by the vertical drag of a double tap's second touch: down zooms
  /// in and up zooms out, around where that touch went down.
  void _onQuickZoomMove(PointerMoveEvent event) {
    final anchor = _quickZoomAnchor!;
    if (!_quickZooming) {
      if ((event.localPosition - anchor).distance <= kTouchSlop) return;
      // The double click callback decides first whether the drag zooms.
      if (_doubleClickPending != null) return;
      if (_doubleClick?.defaultPrevented ?? false) return;
      _quickZooming = true;
      _doubleTapPosition = null;
      _beginGesture();
    }
    if (event.delta.dy == 0) return;
    _camera.gestureUpdate(
      GestureCameraUpdate(
        zoomBy: event.delta.dy / _quickZoomPixelsPerLevel,
        around: anchor,
      ),
    );
  }

  void _stopQuickZoom() {
    final zoomed = _quickZooming;
    // A drag rejects the double tap, which then doesn't clear its event.
    if (zoomed) _clearDoubleClick();
    _quickZoomPointer = null;
    _quickZoomAnchor = null;
    _quickZooming = false;
    if (zoomed) _endGesture();
  }

  /// Watches a two-finger touch for a tilt, as long as exactly two fingers
  /// are down.
  void _startShove() {
    _stopShove();
    if (_touchPointers.length != 2 ||
        !_movements.pitch ||
        !_gestures.twoFingerDrag) {
      return;
    }
    for (final pointer in _touchPointers) {
      _shoveStart[pointer] = _shovePosition[pointer]!;
    }
  }

  /// Tilts while two fingers side by side move vertically together: up tilts
  /// further, down back toward straight down, as on MapLibre Android.
  void _onShoveMove(PointerMoveEvent event) {
    if (_shoveRejected) return;
    if (!_shoving) {
      final [a, b] = _shoveStart.keys.toList();
      final moveA = _shovePosition[a]! - _shoveStart[a]!;
      final moveB = _shovePosition[b]! - _shoveStart[b]!;
      final between = _shovePosition[a]! - _shovePosition[b]!;
      final vertical =
          moveA.dy.sign == moveB.dy.sign &&
          moveA.dy.abs() > moveA.dx.abs() &&
          moveB.dy.abs() > moveB.dx.abs();
      final sideBySide = between.dy.abs() < between.dx.abs();
      if (vertical &&
          sideBySide &&
          moveA.dy.abs() >= _shoveSlop &&
          moveB.dy.abs() >= _shoveSlop) {
        _shoving = true;
        _beginGesture();
      } else if (!vertical ||
          !sideBySide ||
          moveA.distance > kTouchSlop * 2 ||
          moveB.distance > kTouchSlop * 2) {
        // Moving apart, around, or sideways: a pinch or rotation.
        _shoveRejected =
            moveA.distance > _shoveSlop || moveB.distance > _shoveSlop;
        return;
      } else {
        return;
      }
    }
    if (event.delta.dy == 0) return;
    // Each finger's move counts half, so both together tilt by their mean.
    _camera.gestureUpdate(
      GestureCameraUpdate(pitchBy: -event.delta.dy / 2 * _shoveDegreesPerPixel),
    );
  }

  void _stopShove() {
    final tilted = _shoving;
    _shoveStart.clear();
    _shoving = false;
    _shoveRejected = false;
    if (tilted) _endGesture();
  }

  void _emitLongClick(
    MapEventCallback<MapEventLongClick> onLongClick,
    Offset localPosition,
  ) => _emitUserInput(
    localPosition,
    (point, screenPoint) =>
        onLongClick(MapEventLongClick(point: point, screenPoint: screenPoint)),
  );

  void _onScaleStart(ScaleStartDetails details) {
    _lastScale = 1;
    _lastRotation = 0;
    _scalePanned = false;
    _scaleZoomed = false;
    _scaleRotated = false;
    _pinchZoom = 0;
    _pinchRotation = 0;
    _pinchFocal = null;
    _pinchTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
    _focalTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
    _scaleMultiTouch = false;
    _endDrag();
    // The gesture begins with its first camera change, so that a drag while
    // only a pinch moves the camera doesn't stop a running animation.
    final down = _dragDownPosition;
    if (details.pointerCount == 1 &&
        down != null &&
        _reportsDrags &&
        _quickZoomPointer == null &&
        _secondaryPointer == null) {
      _startDrag(down, details.localFocalPoint);
    }
  }

  /// Reports the start of a drag that went down at [down] and is at
  /// [position] now.
  void _startDrag(Offset down, Offset position) {
    _emitUserInput(down, (point, screenPoint) {
      final event = MapEventDragStart(point: point, screenPoint: screenPoint);
      _drag = event;
      _dragPosition = position;
      final result = widget.onDragStart?.call(event);
      if (result is! Future<void>) return;
      late final Future<void> pending;
      pending = result
          .catchError((Object error, StackTrace stack) {
            FlutterError.reportError(
              FlutterErrorDetails(
                exception: error,
                stack: stack,
                library: 'maplibre',
                context: ErrorDescription('while handling a drag start'),
              ),
            );
          })
          .whenComplete(() {
            if (identical(_dragPending, pending)) _dragPending = null;
          });
      _dragPending = pending;
    });
  }

  /// Reports the end of the current drag, if there is one. If it didn't pan
  /// and pointers stay down, they don't move the camera either.
  void _endDrag() {
    final position = _dragPosition;
    final drag = _drag;
    final started = drag != null;
    if (started &&
        _pointers.isNotEmpty &&
        (drag.defaultPrevented || _dragPending != null)) {
      _scaleHeld = true;
    }
    _drag = null;
    _dragPending = null;
    _dragPosition = null;
    _heldPanFrom = null;
    if (!started || position == null) return;
    final onDragEnd = widget.onDragEnd;
    if (onDragEnd == null) return;
    _emitUserInput(
      position,
      (point, screenPoint) =>
          onDragEnd(MapEventDragEnd(point: point, screenPoint: screenPoint)),
    );
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scale = details.scale / _lastScale;
    final rotation = details.rotation - _lastRotation;
    _lastScale = details.scale;
    _lastRotation = details.rotation;
    // A quick zoom, tilt, or mouse rotation drives the camera while its
    // pointers also reach the scale recognizer.
    if (_quickZooming || _shoving || _secondaryPointer != null) return;
    final gestures = _gestures;
    final movements = _movements;

    final focal = details.localFocalPoint;
    var pan = details.focalPointDelta;
    if (_scaleHeld) return;
    final drag = _drag;
    if (drag != null) {
      // A second finger makes the drag a pinch, which a prevented drag keeps
      // from moving the camera too.
      if (details.pointerCount > 1) {
        _endDrag();
        if (_scaleHeld) return;
      } else {
        _dragPosition = focal;
        final onDrag = widget.onDrag;
        if (onDrag != null && pan != Offset.zero) {
          _emitUserInput(
            focal,
            (point, screenPoint) =>
                onDrag(MapEventDrag(point: point, screenPoint: screenPoint)),
          );
        }
        if (drag.defaultPrevented) return;
        if (_dragPending != null) {
          // Hold the pan until the callback decides, then catch up.
          _heldPanFrom ??= focal - pan;
          return;
        }
        final heldFrom = _heldPanFrom;
        if (heldFrom != null) {
          _heldPanFrom = null;
          pan = focal - heldFrom;
        }
      }
    }
    // A trackpad counts as two pointers.
    final pinches = gestures.pinch && details.pointerCount >= 2;
    final pans =
        movements.pan &&
        (details.pointerCount < 2 ? gestures.drag : pinches) &&
        pan != Offset.zero;
    final zooms =
        movements.zoom && pinches && scale != 1 && scale.isFinite && scale > 0;
    final rotates = movements.rotate && pinches && rotation != 0;
    if (!pans && !zooms && !rotates) return;
    final zoomBy = zooms ? log(scale) / ln2 : 0.0;
    // A clockwise twist is a positive rotation in Flutter and turns the map
    // clockwise, which lowers the bearing.
    final rotateBy = rotates ? -rotation * 180 / pi : 0.0;
    if (pans) _scalePanned = true;
    if (zooms) _scaleZoomed = true;
    if (rotates) _scaleRotated = true;
    _pinchZoom += zoomBy;
    _pinchRotation += rotateBy;
    if (zooms || rotates) _pinchFocal = focal;
    if (details.pointerCount > 1) _scaleMultiTouch = true;
    if (details.sourceTimeStamp case final time?) {
      _pinchTracker.addPosition(time, Offset(_pinchZoom, _pinchRotation));
      _focalTracker.addPosition(time, focal);
    }
    _beginGesture();
    _camera.gestureUpdate(
      GestureCameraUpdate(
        panFrom: pans ? focal - pan : null,
        panTo: pans ? focal : null,
        zoomBy: zoomBy,
        rotateBy: rotateBy,
        around: zooms || rotates ? focal : null,
      ),
    );
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _endDrag();
    // Only a plain drag or pinch flings; the others drove the camera
    // themselves.
    final flings =
        _gestures.fling &&
        !_quickZooming &&
        !_shoving &&
        _secondaryPointer == null;
    if (!flings) return _endGesture();
    final pinch = _scaleZoomed || _scaleRotated
        ? _pinchTracker.getVelocity().pixelsPerSecond
        : Offset.zero;
    final zoom = _scaleZoomed ? pinch.dx : 0.0;
    final rotate = _scaleRotated ? pinch.dy : 0.0;
    _endGesture(
      velocity: GestureVelocity(
        pan: !_scalePanned
            ? Offset.zero
            : _scaleMultiTouch
            ? _focalTracker.getVelocity().pixelsPerSecond
            : details.velocity.pixelsPerSecond,
        zoom: zoom,
        rotate: rotate,
        around: zoom != 0 || rotate != 0 ? _pinchFocal : null,
      ),
    );
  }

  void _beginGesture() {
    if (_gestureActive) return;
    _gestureActive = true;
    _camera.gestureStart();
  }

  void _endGesture({GestureVelocity velocity = GestureVelocity.zero}) {
    if (!_gestureActive) return;
    _gestureActive = false;
    _camera.gestureEnd(velocity: velocity);
  }
}

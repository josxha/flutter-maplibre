import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/inherited_model.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// The [State] of the [MapLibreMap] widget.
abstract class MapLibreMapState extends State<MapLibreMap>
    with TickerProviderStateMixin
    implements MapController {
  /// The counter is used to ensure an unique [viewName] for the platform view.
  static int _counter = 0;

  /// A unique name for the platform view.
  final viewName = 'plugins.flutter.io/maplibre${_counter++}';

  /// The [LayerManager] handles the high level markers, polygons,
  /// circles and polylines.
  LayerManager? layerManager;

  /// Get the [MapOptions] from [MapLibreMap.options].
  @override
  MapOptions get options => widget.options;

  @override
  MapCamera? camera;

  /// Set to true once the map is initialized and a [MapController.camera]
  /// is set.
  bool isInitialized = false;

  late final _animationController =
      AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        )
        ..addListener(_onAnimation)
        ..addStatusListener(_onAnimationStatus);
  final Map<int, Offset> _pointers = {};
  Animation<MapCamera>? _animation;
  ScaleStartDetails? _onScaleStartEvent;
  TapDownDetails? _doubleTapDownDetails;
  ScaleUpdateDetails? _lastScaleUpdateDetails;
  ScaleUpdateDetails? _secondToLastScaleUpdateDetails;
  PointerDownEvent? _pointerDownEvent;
  MapCamera? _targetCamera;
  bool? _isTwoPointerPitch;

  @override
  void initState() {
    HardwareKeyboard.instance.addHandler(_keyboardHandler);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPlatformWidget(context),
        PointerInterceptor(
          child: Listener(
            onPointerDown: (event) {
              _pointerDownEvent = event;
              _pointers[event.pointer] = event.position;
              _stopAnimation();
            },
            onPointerMove: (event) {
              _pointers[event.pointer] = event.position;
            },
            onPointerUp: (event) {
              _pointers.remove(event.pointer);
              if (_pointers.isEmpty) _pointerDownEvent = null;
            },
            onPointerSignal: (event) {
              switch (event) {
                case final PointerScrollEvent event:
                  _scrollWheelZoom(event);
              }
            },
            child: GestureDetector(
              onDoubleTapDown: _onDoubleTapDown,
              onDoubleTapCancel: _onDoubleTapCancel,
              onDoubleTap: _onDoubleTap,
              // pan and scale, scale is a superset of the pan gesture
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              onScaleEnd: _onScaleEnd,
              // This transparent ColoredBox is needed to make sure the
              // GestureDetector has a size and can detect gestures.
              child: ColoredBox(
                color: Colors.transparent,
                child: MapLibreInheritedModel(
                  mapController: this,
                  mapCamera: camera,
                  child: isInitialized
                      ? Stack(children: widget.children)
                      : const SizedBox.expand(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build the platform specific widget.
  Widget buildPlatformWidget(BuildContext context);

  void _onDoubleTap() {
    debugPrint('Double tap detected');

    final details = _doubleTapDownDetails;
    _doubleTapDownDetails = null;
    if (details == null) return;

    if (options.gestures.zoom) {
      final camera = this.camera!;
      final newCenter = (_targetCamera?.center ?? camera.center)
          .intermediatePointTo(
            toLngLat(details.localPosition),
            fraction: 0.5,
          );

      // zoom in on double tap
      final tweens = _MapCameraTween(
        begin: camera,
        end: camera.copyWith(
          zoom: camera.zoom + 1,
          center: newCenter,
        ),
      );
      _animation = tweens.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
      _animationController
        ..duration = const Duration(milliseconds: 300)
        ..forward(from: 0);
    }
  }

  void _onAnimation() => moveCamera(
    zoom: _animation!.value.zoom,
    center: _animation!.value.center,
    bearing: _animation!.value.bearing,
    pitch: _animation!.value.pitch,
  );

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_keyboardHandler);
    _animation?.removeListener(_onAnimation);
    _animationController.dispose();
    super.dispose();
  }

  void _onDoubleTapDown(TapDownDetails details) {
    // zoom in or out on double tap down
    debugPrint('Double tap down at position: ${details.localPosition}');
    _doubleTapDownDetails = details;
  }

  void _onDoubleTapCancel() {
    debugPrint('Double tap cancelled');
  }

  void _stopAnimation() {
    _animationController.stop();
    _animation = null;
    _targetCamera = null;
  }

  void _scrollWheelZoom(PointerScrollEvent event) {
    // debugPrint('Scroll wheel event: ${event.scrollDelta.dy}');
    if (options.gestures.zoom) {
      final currCamera = camera!;
      final zoomChange = -event.scrollDelta.dy / 300; // sensitivity
      final prevTarget = _targetCamera ?? currCamera;

      var targetZoom = prevTarget.zoom;
      if (options.gestures.zoom) {
        targetZoom = prevTarget.zoom + zoomChange;
      }
      var targetCenter = prevTarget.center;
      if (options.gestures.pan) {
        targetCenter = prevTarget.center.intermediatePointTo(
          toLngLat(event.localPosition),
          fraction: zoomChange > 0 ? 0.2 : -0.2,
        );
      }
      final targetCamera = _targetCamera = currCamera.copyWith(
        zoom: targetZoom,
        center: targetCenter,
      );
      final tweens = _MapCameraTween(begin: currCamera, end: targetCamera);
      _animation = tweens.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
      );
      _animationController.forward(from: 0);
    }
  }

  // ignore: use_setters_to_change_properties
  void _onScaleStart(ScaleStartDetails details) {
    // debugPrint('Scale start: $details');
    _onScaleStartEvent = details;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // debugPrint('Scale update: $details');
    final camera = this.camera!;
    final startEvent = _onScaleStartEvent;
    final pointerDownEvent = _pointerDownEvent;
    if (startEvent == null || pointerDownEvent == null) return;
    final doubleTapDown = _doubleTapDownDetails;
    final lastEvent = _lastScaleUpdateDetails;
    _secondToLastScaleUpdateDetails = _lastScaleUpdateDetails;
    _lastScaleUpdateDetails = details;
    final ctrlPressed = HardwareKeyboard.instance.isControlPressed;
    final buttons = pointerDownEvent.buttons;
    final lastPointerOffset = lastEvent?.focalPoint ?? startEvent.focalPoint;

    if (doubleTapDown != null && options.gestures.zoom) {
      // double tap drag: zoom
      // debugPrint('Double tap drag zoom detected $doubleTapDown');
      final lastY = lastEvent?.focalPoint.dy ?? startEvent.focalPoint.dy;
      final iOS = Theme.of(context).platform == TargetPlatform.iOS;
      var deltaY = details.focalPoint.dy - lastY;
      if (iOS) deltaY = -deltaY;
      final newZoom = camera.zoom + deltaY * 0.01; // sensitivity
      moveCamera(zoom: newZoom.clamp(options.minZoom, options.maxZoom));
    } else if ((buttons & kSecondaryMouseButton) != 0 || ctrlPressed) {
      // secondary button: pitch and bearing
      final delta = details.focalPoint - lastPointerOffset;
      var newBearing = camera.bearing;
      if (options.gestures.rotate) {
        newBearing = camera.bearing + delta.dx * 0.5; // sensitivity
      }
      var newPitch = camera.pitch;
      if (options.gestures.pitch) {
        newPitch = camera.pitch - delta.dy * 0.5; // sensitivity;
      }
      final newZoom = camera.zoom;
      if (options.gestures.zoom) {
        // TODO adjust newZoom for globe projection
      }
      moveCamera(bearing: newBearing, pitch: newPitch, zoom: newZoom);
    } else if ((buttons & kPrimaryMouseButton) != 0) {
      // primary button: pan, zoom, bearing, pinch
      if (_isTwoPointerPitch == null) {
        if (options.gestures.pitch && _pointers.length == 2) {
          final pointers = _pointers.values.toList(growable: false);
          final delta = pointers.first - pointers.last;
          _isTwoPointerPitch = delta.dy.abs() < delta.dx.abs();
        } else {
          _isTwoPointerPitch = false;
        }
      }
      final pitch = _isTwoPointerPitch!;

      // zoom
      var newZoom = camera.zoom;
      final lastScale = lastEvent?.scale ?? 1.0;
      const scaleSensitivity = 1.0;
      final scaleDelta = (details.scale - lastScale) * scaleSensitivity;
      if (scaleDelta != 0 && options.gestures.zoom && !pitch) {
        newZoom = camera.zoom + scaleDelta;
      }

      // center
      var newCenter = camera.center;
      if (options.gestures.pan && !pitch) {
        final delta = details.focalPoint - lastPointerOffset;
        final centerOffset = toScreenLocation(camera.center);
        final newCenterOffset = centerOffset - delta;
        newCenter = toLngLat(newCenterOffset).intermediatePointTo(
          toLngLat(details.focalPoint),
          fraction: scaleDelta,
        );
      }

      // bearing
      var newBearing = camera.bearing;
      if (options.gestures.rotate && details.rotation != 0.0 && !pitch) {
        final lastRotation = lastEvent?.rotation ?? 0.0;
        final rotationDelta = details.rotation - lastRotation;
        newBearing = camera.bearing - rotationDelta * radian2Degree;
      }

      // pitch
      var newPitch = camera.pitch;
      if (options.gestures.pitch && pitch) {
        final delta = details.focalPoint - lastPointerOffset;
        newPitch = camera.pitch - delta.dy * 0.5; // sensitivity;
      }

      moveCamera(
        zoom: newZoom,
        center: newCenter,
        bearing: newBearing,
        pitch: newPitch,
      );
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    // debugPrint('Scale end: $details');
    final camera = this.camera!;
    final firstEvent = _onScaleStartEvent;
    final secondToLastEvent = _secondToLastScaleUpdateDetails;
    final lastEvent = _lastScaleUpdateDetails;
    if (firstEvent == null) return;

    // zoom out
    if (lastEvent == null &&
        options.gestures.zoom &&
        firstEvent.pointerCount == 2) {
      var newCenter = camera.center;
      if (options.gestures.pan) {
        newCenter = toLngLat(
          firstEvent.focalPoint,
        ).intermediatePointTo(camera.center, fraction: 0.2);
      }
      animateCamera(zoom: camera.zoom - 1, center: newCenter);
    } else if (secondToLastEvent != null &&
        lastEvent != null &&
        options.gestures.pan) {
      // fling animation
      final velocity = details.velocity.pixelsPerSecond.distance;
      if (velocity >= 800) {
        final offset = secondToLastEvent.focalPoint - lastEvent.focalPoint;
        final distance = offset.distance;
        final direction =
            offset.direction * radian2Degree + 90 + camera.bearing;
        final tweens = _MapCameraTween(
          begin: camera,
          end: camera.copyWith(
            center: camera.center.destinationPoint2D(
              distance: distance,
              bearing: direction,
            ),
          ),
        );
        _animation = tweens.animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
        _animationController
          ..duration = Duration(
            milliseconds: (distance / velocity * 1000).round(),
          )
          ..value = 0
          ..fling(
            velocity: velocity / 1000,
            springDescription: SpringDescription.withDampingRatio(
              mass: 1,
              stiffness: 1000,
              ratio: 5,
            ),
          );
      }
    }

    _onScaleStartEvent = null;
    _lastScaleUpdateDetails = null;
    _secondToLastScaleUpdateDetails = null;
    _doubleTapDownDetails = null;
    _isTwoPointerPitch = null;
  }

  bool _keyboardHandler(KeyEvent event) {
    // debugPrint('Keyboard event: $event');
    final direction = switch (event.physicalKey) {
      PhysicalKeyboardKey.arrowUp => const Offset(0, -1),
      PhysicalKeyboardKey.arrowDown => const Offset(0, 1),
      PhysicalKeyboardKey.arrowLeft => const Offset(-1, 0),
      PhysicalKeyboardKey.arrowRight => const Offset(1, 0),
      _ => null,
    };
    if (direction == null) return false;
    switch (event) {
      case KeyDownEvent():
        _updateKeyboardAnimation();
        return true;
      case KeyUpEvent():
        _updateKeyboardAnimation();
        return true;
    }
    return false;
  }

  void _updateKeyboardAnimation() {
    var direction = Offset.zero;
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowUp,
    )) {
      direction += const Offset(0, -1);
    }
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowDown,
    )) {
      direction += const Offset(0, 1);
    }
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowLeft,
    )) {
      direction += const Offset(-1, 0);
    }
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowRight,
    )) {
      direction += const Offset(1, 0);
    }
    if (direction == Offset.zero) {
      _animation = null;
      _animationController.stop();
      return;
    }

    // normalize direction
    direction = Offset.fromDirection(direction.direction);
    final camera = this.camera!;
    _animation =
        _MapCameraTween(
          begin: camera,
          end: camera.copyWith(
            center: toLngLat(
              toScreenLocation(camera.center) + direction * 300,
            ),
          ),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.linear,
          ),
        );
    _animationController
      ..duration = const Duration(seconds: 1)
      ..forward(from: 0);
  }

  void _onAnimationStatus(AnimationStatus status) {
    // debugPrint('Animation status: $status');
    if (status == AnimationStatus.completed && _animation != null) {
      // restart animation if arrow keys are still pressed
      _updateKeyboardAnimation();
    }
  }
}

class _MapCameraTween extends Tween<MapCamera> {
  _MapCameraTween({required MapCamera begin, required MapCamera end})
    : super(begin: begin, end: end);

  @override
  MapCamera lerp(double t) {
    return MapCamera(
      center: begin!.center.intermediatePointTo(end!.center, fraction: t),
      zoom: lerpDouble(begin!.zoom, end!.zoom, t)!,
      bearing: lerpDouble(begin!.bearing, end!.bearing, t)!,
      pitch: lerpDouble(begin!.pitch, end!.pitch, t)!,
    );
  }
}

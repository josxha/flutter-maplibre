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

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  )..addListener(_onAnimation);
  Animation<MapCamera>? _animation;
  ScaleStartDetails? _onScaleStartEvent;
  TapDownDetails? _doubleTapDownDetails;
  ScaleUpdateDetails? _lastScaleUpdateDetails;
  ScaleUpdateDetails? _secondToLastScaleUpdateDetails;
  PointerDownEvent? _pointerDownEvent;
  MapCamera? _targetCamera;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPlatformWidget(context),
        PointerInterceptor(
          child: Listener(
            onPointerDown: (event) {
              /*web.document.addEventListener(
                'contextmenu',
                (interop.PointerEvent event) {
                  event.preventDefault();
                }.toJS,
              );*/
              _pointerDownEvent = event;
              _stopAnimation();
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
    final camera = this.camera!;

    // zoom in on double tap
    final tweens = _MapCameraTween(
      begin: camera,
      end: camera.copyWith(
        zoom: camera.zoom + 1,
        center: (_targetCamera?.center ?? camera.center).intermediatePointTo(
          toLngLat(details.localPosition),
          fraction: 0.5,
        ),
      ),
    );
    _animation = tweens.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward(from: 0);
  }

  void _onAnimation() => moveCamera(
    zoom: _animation!.value.zoom,
    center: _animation!.value.center,
    bearing: _animation!.value.bearing,
    pitch: _animation!.value.pitch,
  );

  @override
  void dispose() {
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
    final camera = this.camera!;
    final zoomChange = -event.scrollDelta.dy / 300; // sensitivity

    final target = _targetCamera = camera.copyWith(
      zoom: (_targetCamera?.zoom ?? camera.zoom) + zoomChange,
      center: (_targetCamera?.center ?? camera.center).intermediatePointTo(
        toLngLat(event.localPosition),
        fraction: zoomChange > 0 ? 0.2 : -0.2,
      ),
    );
    final tweens = _MapCameraTween(begin: camera, end: target);
    _animation = tweens.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward(from: 0);
  }

  void _onScaleStart(ScaleStartDetails details) {
    debugPrint('Scale start: $details');
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

    if (doubleTapDown != null) {
      // double tap drag: zoom
      debugPrint('Double tap drag zoom detected $doubleTapDown');
      final lastY = lastEvent?.focalPoint.dy ?? startEvent.focalPoint.dy;
      final iOS = Theme.of(context).platform == TargetPlatform.iOS;
      var deltaY = details.focalPoint.dy - lastY;
      if (iOS) deltaY = -deltaY;
      final newZoom = camera.zoom + deltaY * 0.01; // sensitivity
      moveCamera(
        zoom: newZoom.clamp(options.minZoom, options.maxZoom),
      );
      return;
    }

    final ctrlPressed = HardwareKeyboard.instance.isControlPressed;
    final buttons = pointerDownEvent.buttons;
    if ((buttons & kSecondaryMouseButton) != 0 || ctrlPressed) {
      // secondary button: pitch and bearing
      final lastPointerOffset = lastEvent?.focalPoint ?? startEvent.focalPoint;
      final delta = details.focalPoint - lastPointerOffset;

      moveCamera(
        bearing: camera.bearing + delta.dx * 0.5, // sensitivity
        pitch: camera.pitch - delta.dy * 0.5, // sensitivity
        zoom: camera.zoom, // TODO adjust for globe projection
      );
    } else if ((buttons & kPrimaryMouseButton) != 0) {
      // primary button: pan and zoom

      // zoom
      final lastScale = lastEvent?.scale ?? 1.0;
      final scaleDelta = details.scale - lastScale;
      final targetZoom = switch (scaleDelta) {
        0.0 => camera.zoom,
        _ => camera.zoom + scaleDelta * 5, // sensitivity
      };

      // center
      final lastPointerOffset = lastEvent?.focalPoint ?? startEvent.focalPoint;
      final delta = details.focalPoint - lastPointerOffset;
      final centerOffset = toScreenLocation(camera.center);
      final newCenterOffset = centerOffset - delta;
      final newCenter = toLngLat(newCenterOffset);

      // bearing
      final rotationDelta = details.rotation - (lastEvent?.rotation ?? 0.0);
      final newBearing = camera.bearing - rotationDelta * radian2Degree;

      moveCamera(
        zoom: targetZoom.clamp(options.minZoom, options.maxZoom),
        center: newCenter,
        bearing: newBearing,
      );
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    debugPrint('Scale end: $details');
    final camera = this.camera!;
    final firstEvent = _onScaleStartEvent;
    final secondToLastEvent = _secondToLastScaleUpdateDetails;
    final lastEvent = _lastScaleUpdateDetails;
    if (lastEvent == null || firstEvent == null || secondToLastEvent == null) {
      return;
    }
    // fling animation
    final velocity = details.velocity.pixelsPerSecond.distance;
    if (velocity >= 800) {
      final offset = secondToLastEvent.focalPoint - lastEvent.focalPoint;
      final distance = offset.distance;
      final direction = offset.direction * radian2Degree + 90 + camera.bearing;
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
            ratio: 3,
          ),
        );
    }

    _onScaleStartEvent = null;
    _lastScaleUpdateDetails = null;
    _secondToLastScaleUpdateDetails = null;
    _doubleTapDownDetails = null;
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

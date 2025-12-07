import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/inherited_model.dart';
import 'package:maplibre/src/interaction/double_tap_handler.dart';
import 'package:maplibre/src/interaction/keyboard_handler.dart';
import 'package:maplibre/src/interaction/pointer_handler.dart';
import 'package:maplibre/src/interaction/scroll_wheel_zoom_handler.dart';
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
  late final _scrollWheelZoomHandler = ScrollWheelZoomHandler(this);
  late final _pointerHandler = PointerHandler(this);
  late final _keyboardHandler = KeyboardHandler(this);
  late final _doubleTapHandler = DoubleTapHandler(this);

  /// The [TapDownDetails] of the last double tap down event.
  TapDownDetails? doubleTapDownDetails;

  /// The [PointerDownEvent] of the first active pointer on the map.
  PointerDownEvent? pointerDownEvent;

  /// Get the [MapOptions] from [MapLibreMap.options].
  @override
  MapOptions get options => widget.options;

  @override
  MapCamera? camera;

  /// Set to true once the map is initialized and a [MapController.camera]
  /// is set.
  bool isInitialized = false;

  /// Currently active pointers on the map.
  final Map<int, Offset> pointers = {};

  /// Animation controller for camera animations.
  late final animationController =
      AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        )
        ..addListener(_onAnimation)
        ..addStatusListener(_onAnimationStatus);

  /// Current camera animation, if any.
  Animation<MapCamera>? animation;

  /// Target camera for ongoing interactions.
  MapCamera? targetCamera;

  @override
  void initState() {
    _keyboardHandler.initState();
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
              pointerDownEvent = event;
              pointers[event.pointer] = event.position;
              _stopAnimation();
            },
            onPointerMove: (event) {
              pointers[event.pointer] = event.position;
            },
            onPointerUp: (event) {
              pointers.remove(event.pointer);
              if (pointers.isEmpty) pointerDownEvent = null;
            },
            onPointerCancel: (event) {
              pointers.remove(event.pointer);
              if (pointers.isEmpty) pointerDownEvent = null;
            },
            onPointerSignal: (event) {
              switch (event) {
                case final PointerScrollEvent event:
                  _scrollWheelZoomHandler.onPointerScrollSignal(event);
              }
            },
            child: GestureDetector(
              onDoubleTapDown: _doubleTapHandler.onDoubleTapDown,
              onDoubleTapCancel: _doubleTapHandler.onDoubleTapCancel,
              onDoubleTap: _doubleTapHandler.onDoubleTap,
              // pan and scale, scale is a superset of the pan gesture
              onScaleStart: _pointerHandler.onScaleStart,
              onScaleUpdate: _pointerHandler.onScaleUpdate,
              onScaleEnd: _pointerHandler.onScaleEnd,
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

  void _onAnimation() => moveCamera(
    zoom: animation!.value.zoom,
    center: animation!.value.center,
    bearing: animation!.value.bearing,
    pitch: animation!.value.pitch,
  );

  @override
  void dispose() {
    _keyboardHandler.dispose();
    animation?.removeListener(_onAnimation);
    animationController.dispose();
    super.dispose();
  }

  void _stopAnimation() {
    animationController.stop();
    animation = null;
    targetCamera = null;
  }

  void _onAnimationStatus(AnimationStatus status) {
    // debugPrint('Animation status: $status');
    if (status == AnimationStatus.completed && animation != null) {
      _keyboardHandler.onAnimationStatusCompleted();
    }
  }
}

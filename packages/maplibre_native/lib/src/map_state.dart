import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_native/src/command.dart';
import 'package:maplibre_native/src/map_renderer.dart';
import 'package:maplibre_native/src/style_controller.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
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

/// MapLibre Native, rendered through its C API into a Flutter texture.
class MapLibreMapStateNative extends MapLibreMapState {
  MapRenderer? _renderer;
  Future<void>? _creating;
  var _disposed = false;

  @override
  StyleControllerNative? style;

  LayerManager? _layerManager;

  /// A projection of the latest published camera. Closed whenever the camera
  /// or extent changes, because a projection never sees later map changes.
  mln.MapProjectionHandle? _projection;

  /// The projection of the map frame on screen. The map image trails the
  /// latest camera by a frame or two, so [camera] and screen locations follow
  /// this one, and widgets over the map stay on what they mark.
  mln.MapProjectionHandle? _shownProjection;

  /// The session extent generation of the frame on screen. Screen locations
  /// move with the extent even while the camera stays.
  BigInt? _shownExtentGeneration;

  /// Frames that drew an older map update than this are not shown as the
  /// camera: they still travel to Flutter after the initial camera was set.
  BigInt _firstShownUpdate = BigInt.zero;

  /// The camera of the last camera event, to report each change once.
  MapCamera? _eventCamera;

  var _gestureActive = false;
  var _nextChangeByController = false;
  var _cameraMoving = false;

  // Scale gesture state, relative to the previous update.
  var _lastScale = 1.0;
  var _lastRotation = 0.0;

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

  // Two-finger tilt ("shove"): where each of the two fingers was when the
  // second went down, where it is now, and whether the gesture tilts, or was
  // found to be a pinch or rotation instead.
  final _shoveStart = <int, Offset>{};
  final _shovePosition = <int, Offset>{};
  var _shoving = false;
  var _shoveRejected = false;

  mln.MapHandle? get _map => _renderer?.map;

  @override
  Widget buildPlatformWidget(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final extent = mln.LogicalExtent(
          width: constraints.maxWidth.isFinite
              ? constraints.maxWidth.floor().clamp(1, 16384)
              : 256,
          height: constraints.maxHeight.isFinite
              ? constraints.maxHeight.floor().clamp(1, 16384)
              : 256,
          scaleFactor: pixelRatio,
        );
        final renderer = _renderer;
        if (renderer == null) {
          _creating ??= _create(extent, pixelRatio);
          return const SizedBox.expand();
        }
        if (renderer.extent != extent) {
          renderer.resize(extent);
          _invalidateProjection();
        }
        return _gestureDetector(Texture(textureId: renderer.textureId));
      },
    );
  }

  Future<void> _create(mln.LogicalExtent extent, double pixelRatio) async {
    try {
      final renderer = await MapRenderer.create(
        extent: extent,
        onEvent: _onRuntimeEvent,
        onFrameShown: _onFrameShown,
      );
      if (_disposed) {
        await renderer.dispose();
        return;
      }
      _renderer = renderer;
      await _applyOptions();
      final options = this.options;
      await checkCommand(
        renderer.map.updateCamera(
          mln.CameraUpdate(
            camera: mln.CameraOptions(
              center: switch (options.initCenter) {
                final center? => mln.LatLng(center.lat, center.lon),
                null => null,
              },
              zoom: options.initZoom,
              bearing: options.initBearing,
              pitch: options.initPitch,
            ),
          ),
        ),
      );
      await setStyle(options.initStyle);
      if (_disposed) return;
      setState(() {
        // The initial camera is set, but the frame that shows it may not have
        // reached Flutter yet, and onMapCreated callers expect it.
        camera = _readCamera();
        _firstShownUpdate = renderer.map
            .getSnapshot()
            .latestRenderUpdateGeneration;
        // Screen locations follow the latest camera until such a frame.
        _shownProjection?.close();
        _shownProjection = null;
        isInitialized = true;
      });
      widget.onEvent?.call(MapEventMapCreated(mapController: this));
      widget.onMapCreated?.call(this);
    } on Object catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'maplibre_native',
          context: ErrorDescription('while creating the map'),
        ),
      );
    }
  }

  /// Applies the camera constraints of [MapOptions].
  Future<void> _applyOptions() async {
    final map = _map;
    if (map == null) return;
    final options = this.options;
    await checkCommand(
      map.setBounds(
        mln.BoundOptions(
          bounds: switch (options.maxBounds) {
            final bounds? => mln.LatLngBounds(
              southwest: mln.LatLng(bounds.latitudeSouth, bounds.longitudeWest),
              northeast: mln.LatLng(bounds.latitudeNorth, bounds.longitudeEast),
            ),
            null => null,
          },
          unbounded: options.maxBounds == null,
          minZoom: options.minZoom,
          maxZoom: options.maxZoom,
          minPitch: options.minPitch,
          maxPitch: options.maxPitch,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    if (oldWidget.options != widget.options) unawaited(_applyOptions());
    _layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _disposed = true;
    style?.dispose();
    _invalidateProjection();
    _shownProjection?.close();
    _shownProjection = null;
    unawaited(_renderer?.dispose());
    super.dispose();
  }

  // Events

  void _onRuntimeEvent(mln.RuntimeEvent event) {
    if (_disposed) return;
    switch (event.type) {
      case mln.RuntimeEventType.mapCameraWillChange:
        if (_cameraMoving) return;
        _cameraMoving = true;
        final CameraChangeReason reason;
        if (_gestureActive) {
          reason = CameraChangeReason.apiGesture;
        } else if (_nextChangeByController) {
          reason = CameraChangeReason.developerAnimation;
        } else {
          reason = CameraChangeReason.apiAnimation;
        }
        _nextChangeByController = false;
        widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
      case mln.RuntimeEventType.mapCameraIsChanging:
        _onCameraChanged();
      case mln.RuntimeEventType.mapCameraDidChange:
        _onCameraChanged();
        // A gesture publishes one change per pointer update; it ends with the
        // gesture instead.
        if (!_gestureActive) _onCameraIdle();
      case mln.RuntimeEventType.mapStyleLoaded:
        unawaited(_onStyleLoaded());
      case mln.RuntimeEventType.mapIdle:
        widget.onEvent?.call(const MapEventIdle());
      default:
        break;
    }
  }

  /// Reports the map's latest camera. [camera] instead follows the frame on
  /// screen, see [_onFrameShown].
  void _onCameraChanged() {
    _invalidateProjection();
    final newCamera = _readCamera();
    if (newCamera == null || newCamera == _eventCamera) return;
    _eventCamera = newCamera;
    widget.onEvent?.call(MapEventMoveCamera(camera: newCamera));
  }

  /// Moves [camera] and screen locations to the frame that Flutter shows
  /// next, so widgets over the map rebuild in the same frame as the map.
  void _onFrameShown(
    mln.MapProjectionHandle projection,
    mln.RenderFrameResult frame,
  ) {
    if (_disposed || frame.mapUpdateGeneration < _firstShownUpdate) {
      projection.close();
      return;
    }
    _shownProjection?.close();
    _shownProjection = projection;
    final shown = _toMapCamera(projection.getCamera());
    final resized = frame.extentGeneration != _shownExtentGeneration;
    _shownExtentGeneration = frame.extentGeneration;
    if (shown == camera && !resized) return;
    setState(() => camera = shown);
  }

  void _onCameraIdle() {
    if (!_cameraMoving) return;
    _cameraMoving = false;
    widget.onEvent?.call(const MapEventCameraIdle());
  }

  Future<void> _onStyleLoaded() async {
    final map = _map;
    if (map == null) return;
    style?.dispose();
    final styleController = StyleControllerNative(
      map,
      MediaQuery.devicePixelRatioOf(context),
    );
    style = styleController;
    await styleController.refresh();
    if (_disposed || style != styleController) return;
    widget.onEvent?.call(MapEventStyleLoaded(styleController));
    widget.onStyleLoaded?.call(styleController);
    _layerManager = LayerManager(styleController, widget.layers);
    // Refresh the widgets in MapLibreMap.children.
    setState(() {});
  }

  MapCamera? _readCamera() {
    final map = _map;
    if (map == null || map.isClosed) return null;
    return _toMapCamera(map.getSnapshot().camera);
  }

  static MapCamera _toMapCamera(mln.CameraOptions native) {
    final center = native.center;
    return MapCamera(
      center: center == null
          ? const Geographic(lon: 0, lat: 0)
          : Geographic(lon: center.longitude, lat: center.latitude),
      zoom: native.zoom ?? 0,
      bearing: native.bearing ?? 0,
      pitch: native.pitch ?? 0,
    );
  }

  // Gestures

  Widget _gestureDetector(Widget child) {
    final gestures = options.gestures;
    return Listener(
      onPointerSignal: _onPointerSignal,
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerEnd,
      onPointerCancel: _onPointerEnd,
      child: GestureDetector(
        onTapUp: (details) => _emitUserInput(details.localPosition, _click),
        onSecondaryTapUp: (details) =>
            _emitUserInput(details.localPosition, _secondaryClick),
        onLongPressStart: (details) =>
            _emitUserInput(details.localPosition, _longClick),
        onDoubleTapDown: _onDoubleTapDown,
        onDoubleTap: _onDoubleTap,
        onScaleStart: gestures.pan || gestures.zoom || gestures.rotate
            ? _onScaleStart
            : null,
        onScaleUpdate: gestures.pan || gestures.zoom || gestures.rotate
            ? _onScaleUpdate
            : null,
        onScaleEnd: gestures.pan || gestures.zoom || gestures.rotate
            ? _onScaleEnd
            : null,
        child: child,
      ),
    );
  }

  static MapEventUserInput _click(Geographic point, Offset screenPoint) =>
      MapEventClick(point: point, screenPoint: screenPoint);

  static MapEventUserInput _secondaryClick(
    Geographic point,
    Offset screenPoint,
  ) => MapEventSecondaryClick(point: point, screenPoint: screenPoint);

  static MapEventUserInput _longClick(Geographic point, Offset screenPoint) =>
      MapEventLongClick(point: point, screenPoint: screenPoint);

  void _emitUserInput(
    Offset position,
    MapEventUserInput Function(Geographic point, Offset screenPoint) create,
  ) {
    if (_map == null) return;
    widget.onEvent?.call(create(toLngLat(position), position));
  }

  void _onDoubleTapDown(TapDownDetails details) {
    _doubleTapPosition = details.localPosition;
    _emitUserInput(
      details.localPosition,
      (point, screenPoint) =>
          MapEventDoubleClick(point: point, screenPoint: screenPoint),
    );
  }

  /// Zooms in on the second release of a double tap. A second tap that drags
  /// instead is a quick zoom, which the double tap recognizer rejects.
  void _onDoubleTap() {
    final position = _doubleTapPosition;
    _doubleTapPosition = null;
    if (position == null || !options.gestures.zoom) return;
    _applyDelta(
      mln.CameraDelta(
        scale: 2,
        anchor: _screenPoint(position),
        animation: mln.AnimationOptions(
          durationMs: _doubleTapZoomDuration.inMilliseconds.toDouble(),
        ),
      ),
    );
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent || !options.gestures.zoom) return;
    final zoomDelta = -event.scrollDelta.dy * _wheelZoomRate;
    if (zoomDelta == 0) return;
    _applyDelta(
      mln.CameraDelta(
        scale: pow(2, zoomDelta).toDouble(),
        anchor: _screenPoint(event.localPosition),
      ),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    // Rotate and tilt with the right button or Ctrl and the left button, as in
    // MapLibre GL JS.
    if (event.kind == PointerDeviceKind.mouse &&
        (event.buttons & kSecondaryMouseButton != 0 ||
            (event.buttons & kPrimaryMouseButton != 0 &&
                HardwareKeyboard.instance.isControlPressed)) &&
        (options.gestures.rotate || options.gestures.pitch)) {
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
    if (options.gestures.zoom &&
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
    final gestures = options.gestures;
    final center = context.size?.center(Offset.zero);
    // Dragging right raises the bearing below the center and lowers it above,
    // so the map follows the pointer around the center like a wheel.
    var bearing = event.delta.dx * _rotateDegreesPerPixel;
    if (center != null && event.localPosition.dy < center.dy) {
      bearing = -bearing;
    }
    _applyDelta(
      mln.CameraDelta(
        bearing: gestures.rotate ? bearing : null,
        // Dragging up tilts further.
        pitch: gestures.pitch ? -event.delta.dy * _pitchDegreesPerPixel : null,
        anchor: center == null ? null : _screenPoint(center),
        gesturePhase: mln.GesturePhase.update,
      ),
    );
  }

  void _onPointerEnd(PointerEvent event) {
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
    _touchDownPosition = null;
    if (event.pointer == _quickZoomPointer) _stopQuickZoom();
  }

  /// Zooms by the vertical drag of a double tap's second touch: down zooms
  /// in and up zooms out, around where that touch went down.
  void _onQuickZoomMove(PointerMoveEvent event) {
    final anchor = _quickZoomAnchor!;
    if (!_quickZooming) {
      if ((event.localPosition - anchor).distance <= kTouchSlop) return;
      _quickZooming = true;
      _doubleTapPosition = null;
      if (!_gestureActive) _beginGesture();
    }
    if (event.delta.dy == 0) return;
    _applyDelta(
      mln.CameraDelta(
        scale: pow(2, event.delta.dy / _quickZoomPixelsPerLevel).toDouble(),
        anchor: _screenPoint(anchor),
        gesturePhase: mln.GesturePhase.update,
      ),
    );
  }

  void _stopQuickZoom() {
    final zoomed = _quickZooming;
    _quickZoomPointer = null;
    _quickZoomAnchor = null;
    _quickZooming = false;
    if (zoomed) _endGesture();
  }

  /// Watches a two-finger touch for a tilt, as long as exactly two fingers
  /// are down.
  void _startShove() {
    _stopShove();
    if (_touchPointers.length != 2 || !options.gestures.pitch) return;
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
        if (!_gestureActive) _beginGesture();
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
    _applyDelta(
      mln.CameraDelta(
        pitch: -event.delta.dy / 2 * _shoveDegreesPerPixel,
        gesturePhase: mln.GesturePhase.update,
      ),
    );
  }

  void _stopShove() {
    final tilted = _shoving;
    _shoveStart.clear();
    _shoving = false;
    _shoveRejected = false;
    if (tilted) _endGesture();
  }

  void _onScaleStart(ScaleStartDetails details) {
    _lastScale = 1;
    _lastRotation = 0;
    if (!_gestureActive) _beginGesture();
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scale = details.scale / _lastScale;
    final rotation = details.rotation - _lastRotation;
    _lastScale = details.scale;
    _lastRotation = details.rotation;
    // A quick zoom, tilt, or mouse rotation drives the camera while its
    // pointers also reach the scale recognizer.
    if (_quickZooming || _shoving || _secondaryPointer != null) return;
    final gestures = options.gestures;

    final pan = details.focalPointDelta;
    final zooms = gestures.zoom && scale != 1 && scale.isFinite && scale > 0;
    final rotates = gestures.rotate && rotation != 0;
    _applyDelta(
      mln.CameraDelta(
        offset: gestures.pan && pan != Offset.zero ? _screenPoint(pan) : null,
        scale: zooms ? scale : null,
        // A clockwise twist is a positive rotation in Flutter and turns the
        // map clockwise, which lowers the bearing.
        bearing: rotates ? -rotation * 180 / pi : null,
        anchor: zooms || rotates ? _screenPoint(details.localFocalPoint) : null,
        gesturePhase: mln.GesturePhase.update,
      ),
    );
  }

  void _onScaleEnd(ScaleEndDetails details) => _endGesture();

  void _beginGesture() {
    _gestureActive = true;
    _applyDelta(const mln.CameraDelta(gesturePhase: mln.GesturePhase.begin));
  }

  void _endGesture() {
    if (!_gestureActive) return;
    _gestureActive = false;
    _applyDelta(const mln.CameraDelta(gesturePhase: mln.GesturePhase.end));
    _onCameraIdle();
  }

  void _applyDelta(mln.CameraDelta delta) {
    final map = _map;
    if (map == null) return;
    unawaited(checkCommand(map.applyCameraDelta(delta)));
  }

  static mln.ScreenPoint _screenPoint(Offset offset) =>
      mln.ScreenPoint(offset.dx, offset.dy);

  // MapController

  /// The projection of the frame on screen, so that screen locations match
  /// the map image, or of the latest camera before the first frame.
  mln.MapProjectionHandle _currentProjection() {
    final map = _map;
    if (map == null) {
      throw StateError('The map has not been created yet.');
    }
    return _shownProjection ?? (_projection ??= map.createProjection());
  }

  void _invalidateProjection() {
    _projection?.close();
    _projection = null;
  }

  @override
  MapCamera getCamera() =>
      camera ??
      _readCamera() ??
      (throw StateError('The map has not been created yet.'));

  @override
  Offset toScreenLocation(Geographic lngLat) =>
      toScreenLocations([lngLat]).single;

  @override
  Geographic toLngLat(Offset screenLocation) =>
      toLngLats([screenLocation]).single;

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) =>
      _currentProjection()
          .pixelsForLatLngs([
            for (final lngLat in lngLats) mln.LatLng(lngLat.lat, lngLat.lon),
          ])
          .map((point) => Offset(point.x, point.y))
          .toList(growable: false);

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) =>
      _currentProjection()
          .latLngsForPixels(screenLocations.map(_screenPoint).toList())
          .map(
            (latLng) => Geographic(lon: latLng.longitude, lat: latLng.latitude),
          )
          .toList(growable: false);

  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      _currentProjection().metersPerPixelAtLatitude(latitude);

  @override
  LngLatBounds getVisibleRegion() {
    final size = context.size ?? Size.zero;
    final corners = toLngLats([
      Offset.zero,
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ]);
    return LngLatBounds(
      longitudeWest: corners.map((c) => c.lon).reduce(min),
      longitudeEast: corners.map((c) => c.lon).reduce(max),
      latitudeSouth: corners.map((c) => c.lat).reduce(min),
      latitudeNorth: corners.map((c) => c.lat).reduce(max),
    );
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
    EdgeInsets padding = EdgeInsets.zero,
  }) => _updateCamera(
    mln.CameraUpdateMode.jump,
    center: center,
    zoom: zoom,
    bearing: bearing,
    pitch: pitch,
    padding: padding,
  );

  @override
  Future<void> animateCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
    EdgeInsets padding = EdgeInsets.zero,
  }) => _updateCamera(
    mln.CameraUpdateMode.fly,
    center: center,
    zoom: zoom,
    bearing: bearing,
    pitch: pitch,
    padding: padding,
    duration: nativeDuration,
  );

  @override
  Future<void> fitBounds({
    required LngLatBounds bounds,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
    Offset offset = Offset.zero,
    double webMaxZoom = double.maxFinite,
    bool webLinear = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) async {
    final map = _map;
    if (map == null) return;
    final target = await map.cameraForLatLngBounds(
      mln.LatLngBounds(
        southwest: mln.LatLng(bounds.latitudeSouth, bounds.longitudeWest),
        northeast: mln.LatLng(bounds.latitudeNorth, bounds.longitudeEast),
      ),
      fitOptions: mln.CameraFitOptions(
        padding: _edgeInsets(padding),
        bearing: bearing,
        pitch: pitch,
      ),
    );
    _nextChangeByController = true;
    await checkCommand(
      map.updateCamera(
        mln.CameraUpdate(
          mode: mln.CameraUpdateMode.fly,
          camera: target,
          animation: mln.AnimationOptions(
            durationMs: nativeDuration.inMilliseconds.toDouble(),
          ),
        ),
      ),
    );
  }

  Future<void> _updateCamera(
    mln.CameraUpdateMode mode, {
    required Geographic? center,
    required double? zoom,
    required double? bearing,
    required double? pitch,
    required EdgeInsets padding,
    Duration? duration,
  }) async {
    final map = _map;
    if (map == null) return;
    _nextChangeByController = true;
    await checkCommand(
      map.updateCamera(
        mln.CameraUpdate(
          mode: mode,
          camera: mln.CameraOptions(
            center: center == null ? null : mln.LatLng(center.lat, center.lon),
            zoom: zoom,
            bearing: bearing,
            pitch: pitch,
            padding: padding == EdgeInsets.zero ? null : _edgeInsets(padding),
          ),
          animation: mln.AnimationOptions(
            durationMs: duration?.inMilliseconds.toDouble(),
          ),
        ),
      ),
    );
  }

  static mln.EdgeInsets _edgeInsets(EdgeInsets padding) => mln.EdgeInsets(
    top: padding.top,
    left: padding.left,
    bottom: padding.bottom,
    right: padding.right,
  );

  @override
  Future<void> setStyle(String style) async {
    final map = _map;
    if (map == null) return;
    final trimmed = style.trim();
    if (trimmed.startsWith('{')) {
      await checkCommand(map.setStyleJson(_utf8(trimmed)));
    } else if (trimmed.startsWith('http://') ||
        trimmed.startsWith('https://') ||
        trimmed.startsWith('mapbox://') ||
        trimmed.startsWith('file://') ||
        trimmed.startsWith('asset://')) {
      await checkCommand(map.setStyleUrl(trimmed));
    } else if (trimmed.startsWith('/') ||
        RegExp(r'^[a-zA-Z]:[/\\]').hasMatch(trimmed)) {
      await checkCommand(map.setStyleUrl(Uri.file(trimmed).toString()));
    } else {
      // A Flutter asset.
      final json = await DefaultAssetBundle.of(context).loadString(trimmed);
      await checkCommand(map.setStyleJson(_utf8(json)));
    }
  }

  @override
  Future<List<RenderedFeature>> featuresAtPoint(
    Offset point, {
    List<String>? layerIds,
  }) => _queryRenderedFeatures(
    mln.renderedQueryGeometryPoint(_screenPoint(point)),
    layerIds,
  );

  @override
  Future<List<RenderedFeature>> featuresInRect(
    Rect rect, {
    List<String>? layerIds,
  }) => _queryRenderedFeatures(
    mln.renderedQueryGeometryBox(
      mln.ScreenBox(
        min: _screenPoint(rect.topLeft),
        max: _screenPoint(rect.bottomRight),
      ),
    ),
    layerIds,
  );

  Future<List<RenderedFeature>> _queryRenderedFeatures(
    mln.RenderedQueryGeometry geometry,
    List<String>? layerIds,
  ) async {
    final renderer = _renderer;
    // No layers to query matches nothing, as on web.
    if (renderer == null || (layerIds != null && layerIds.isEmpty)) {
      return const [];
    }
    final features = await renderer.queryRenderedFeatures(
      geometry,
      layerIds: layerIds,
    );
    return [
      for (final queried in features)
        if (jsonDecode(utf8.decode(queried.feature))
            case final Map<String, Object?> feature)
          RenderedFeature(
            id: feature['id'],
            properties: switch (feature['properties']) {
              final Map<String, Object?> properties => properties,
              _ => const {},
            },
            geometry: switch (feature['geometry']) {
              final Map<String, Object?> geometry => geometry,
              _ => null,
            },
            sourceId: queried.sourceId,
            sourceLayer: queried.sourceLayerId,
          ),
    ];
  }

  @override
  Future<void> enableLocation({
    Duration fastestInterval = const Duration(milliseconds: 750),
    Duration maxWaitTime = const Duration(seconds: 1),
    bool pulseFade = true,
    bool accuracyAnimation = true,
    bool compassAnimation = true,
    bool pulse = true,
    BearingRenderMode bearingRenderMode = BearingRenderMode.gps,
  }) => throw UnimplementedError(
    'The user location is not supported by maplibre_native yet.',
  );

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) => throw UnimplementedError(
    'The user location is not supported by maplibre_native yet.',
  );
}

Uint8List _utf8(String value) => Uint8List.fromList(utf8.encode(value));

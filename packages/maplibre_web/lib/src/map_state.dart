import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:math';
import 'dart:ui';
import 'dart:ui_web';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/camera_padding_reset.dart';
import 'package:maplibre_web/src/extensions.dart';
import 'package:maplibre_web/src/interop/interop.dart' as interop;
import 'package:maplibre_web/src/interop/json.dart';
import 'package:maplibre_web/src/interop/pmtiles.dart' as pmtiles;
import 'package:web/web.dart' hide PointerEvent;

part 'style_controller.dart';

/// The web specific implementation of the [MapLibreMap] widget.
final class MapLibreMapStateWeb extends MapLibreMapState {
  late HTMLDivElement _htmlElement;
  late interop.JsMap _map;
  Completer<interop.MapLibreEvent>? _movementCompleter;
  final _cameraPaddingReset = CameraPaddingReset();
  bool _nextGestureCausedByController = false;
  LayerManager? _layerManager;

  /// A gesture or its fling moves the camera; [_gestureMoveStarted] once it
  /// has reported the start of the move.
  var _gestureMoving = false;
  var _gestureMoveStarted = false;

  /// The next camera move comes from a scroll wheel or double tap.
  var _nextMoveByUser = false;

  /// Camera writes that only work out a gesture's target camera, and that
  /// the camera events don't report.
  var _silentCamera = false;

  /// A pointer that may open the browser's context menu went down on the
  /// map, which rotates and tilts with it instead.
  var _suppressContextMenu = false;
  Timer? _contextMenuTimer;
  late final JSFunction _onContextMenu = ((Event event) {
    if (!_suppressContextMenu) return;
    _suppressContextMenu = false;
    event.preventDefault();
  }).toJS;

  @override
  late final GestureCameraSink gestureCamera = _WebGestureCamera(this);

  /// Get the [MapOptions] from [MapLibreMap.options].
  @override
  MapOptions get options => widget.options;

  @override
  StyleControllerWeb? style;

  @override
  void initState() {
    platformViewRegistry.registerViewFactory(viewName, (
      int viewId, [
      dynamic params,
    ]) {
      _htmlElement = HTMLDivElement()
        ..style.padding = '0'
        ..style.margin = '0'
        ..style.height = '100%'
        ..style.width = '100%'
        // Flutter hit-tests every pointer and recognizes the gestures, so
        // widgets over the map keep theirs.
        ..style.pointerEvents = 'none';

      // add pmtiles support
      try {
        final pmtilesProtocol = pmtiles.Protocol();
        interop.addProtocol('pmtiles', pmtilesProtocol.tile);
      } catch (e) {
        debugPrint('[MapLibre] PMTiles support could not be loaded. $e');
      }

      _map = interop.JsMap(
        interop.MapOptions(
          container: _htmlElement,
          style: _prepareStyleString(options.initStyle),
          zoom: options.initZoom,
          center: options.initCenter?.toLngLat(),
          bearing: options.initBearing,
          pitch: options.initPitch,
          attributionControl: false,
          // MapGestureDetector handles the input.
          interactive: false,
        ),
      );

      document.body?.appendChild(_htmlElement);
      // Invoke the onMapCreated callback async to avoid getting it called
      // during the widget build.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onEvent?.call(MapEventMapCreated(mapController: this));
        widget.onMapCreated?.call(this);
        setState(() => isInitialized = true);
      });
      _resizeMap();

      // set options
      _map.setMinZoom(options.minZoom);
      _map.setMaxZoom(options.maxZoom);
      _map.setMinPitch(options.minPitch);
      _map.setMaxPitch(options.maxPitch);
      _map.setMaxBounds(options.maxBounds?.toJsLngLatBounds());

      // add callbacks
      _map.on(
        interop.MapEventType.load,
        (interop.MapMouseEvent event) {
          _onStyleLoaded();
        }.toJS,
      );
      _map.on(
        interop.MapEventType.idle,
        (interop.MapMouseEvent event) {
          widget.onEvent?.call(const MapEventIdle());
        }.toJS,
      );
      _map.on(
        interop.MapEventType.moveStart,
        (interop.MapLibreEvent event) {
          if (!_cameraPaddingReset.shouldForward(event)) return;
          if (_silentCamera) return;
          // A gesture moves the camera in many steps but reports one move.
          if (_gestureMoving) {
            if (_gestureMoveStarted) return;
            _gestureMoveStarted = true;
          }
          final CameraChangeReason reason;
          if (_gestureMoving || _nextMoveByUser) {
            _nextMoveByUser = false;
            reason = CameraChangeReason.apiGesture;
          } else if (_nextGestureCausedByController) {
            _nextGestureCausedByController = false;
            reason = CameraChangeReason.developerAnimation;
          } else {
            reason = CameraChangeReason.apiAnimation;
          }
          widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
        }.toJS,
      );
      _map.on(
        interop.MapEventType.move,
        (interop.MapLibreEvent event) {
          if (!_cameraPaddingReset.shouldForward(event)) return;
          if (_silentCamera) return;
          final mapCamera = MapCamera(
            center: _map.getCenter().toGeographic(),
            zoom: _map.getZoom().toDouble(),
            pitch: _map.getPitch().toDouble(),
            bearing: _map.getBearing().toDouble(),
          );
          setState(() => camera = mapCamera);
          widget.onEvent?.call(MapEventMoveCamera(camera: mapCamera));
        }.toJS,
      );
      _map.on(
        interop.MapEventType.moveEnd,
        (interop.MapLibreEvent event) {
          if (!_cameraPaddingReset.shouldForward(event)) return;
          if (_silentCamera || _gestureMoving) return;
          widget.onEvent?.call(const MapEventCameraIdle());
          if (!(_movementCompleter?.isCompleted ?? true)) {
            _movementCompleter?.complete(event);
          }
        }.toJS,
      );

      return _htmlElement;
    });
    document.addEventListener('contextmenu', _onContextMenu);
    super.initState();
  }

  @override
  Widget buildPlatformWidget(BuildContext context) => Listener(
    onPointerDown: _onPointerDown,
    onPointerUp: _onPointerEnd,
    onPointerCancel: _onPointerEnd,
    child: HtmlElementView(viewType: viewName),
  );

  /// The browser opens its context menu for a right click, or Ctrl + click
  /// on macOS, which rotate and tilt the map instead.
  void _onPointerDown(PointerDownEvent event) {
    _contextMenuTimer?.cancel();
    _suppressContextMenu =
        event.kind == PointerDeviceKind.mouse &&
        (event.buttons & kSecondaryMouseButton != 0 ||
            HardwareKeyboard.instance.isControlPressed);
  }

  /// Some platforms open the context menu on the release.
  void _onPointerEnd(PointerEvent _) {
    _contextMenuTimer?.cancel();
    _contextMenuTimer = Timer(
      const Duration(milliseconds: 500),
      () => _suppressContextMenu = false,
    );
  }

  void _resizeMap() {
    final jsContainer = _map.getContainer();
    final jsCanvas = _map.getCanvas();
    final matchWidth = jsCanvas.clientWidth == jsContainer.clientWidth;
    final matchHeight = jsCanvas.clientHeight == jsContainer.clientHeight;
    if (matchWidth && matchHeight) return;
    _map.resize();
  }

  @override
  void dispose() {
    document.removeEventListener('contextmenu', _onContextMenu);
    _contextMenuTimer?.cancel();
    style?.dispose();
    _map.remove();
    _htmlElement.remove();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    if (options.minZoom != oldWidget.options.minZoom) {
      _map.setMinZoom(options.minZoom);
    }
    if (options.maxZoom != oldWidget.options.maxZoom) {
      _map.setMaxZoom(options.maxZoom);
    }
    if (options.minPitch != oldWidget.options.minPitch) {
      _map.setMinPitch(options.minPitch);
    }
    if (options.maxPitch != oldWidget.options.maxPitch) {
      _map.setMaxPitch(options.maxPitch);
    }
    if (options.maxBounds != oldWidget.options.maxBounds) {
      _map.setMaxBounds(options.maxBounds?.toJsLngLatBounds());
    }
    _layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Geographic toLngLat(Offset screenLocation) =>
      _map.unproject(screenLocation.toJsPoint()).toGeographic();

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) => screenLocations
      .map((offset) => _map.unproject(offset.toJsPoint()).toGeographic())
      .toList(growable: false);

  @override
  Offset toScreenLocation(Geographic lngLat) =>
      _map.project(lngLat.toLngLat()).toOffset();

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) => lngLats
      .map((lngLat) => _map.project(lngLat.toLngLat()).toOffset())
      .toList(growable: false);

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
    EdgeInsets padding = EdgeInsets.zero,
  }) async {
    _nextGestureCausedByController = true;
    final camera = getCamera();
    _map.jumpTo(
      interop.JumpToOptions(
        center: center?.toLngLat() ?? camera.center.toLngLat(),
        zoom: zoom ?? camera.zoom,
        bearing: bearing ?? camera.bearing,
        pitch: pitch ?? camera.pitch,
        padding: padding.toPaddingOptions(),
      ),
    );
  }

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
  }) async {
    final destination = center?.toLngLat();
    _nextGestureCausedByController = true;
    final camera = getCamera();
    // flyTo ends synchronously when it jumps, for example if the browser
    // prefers reduced motion, so wait for the end before starting it.
    final completer = _movementCompleter = Completer<interop.MapLibreEvent>();
    _map.flyTo(
      interop.FlyToOptions(
        center: destination,
        zoom: zoom ?? camera.zoom,
        bearing: bearing ?? camera.bearing,
        pitch: pitch ?? camera.pitch,
        speed: webSpeed,
        maxDuration: webMaxDuration?.inMilliseconds,
        padding: padding.toPaddingOptions(),
      ),
    );
    final _ = await completer.future;
    _movementCompleter = null;

    // check if the targeted values were reached or if the flight was cancelled
    final newCenter = _map.getCenter();
    bool reachedCenter;
    if (destination == null) {
      reachedCenter = true;
    } else {
      final reachedLng = (destination.lng - newCenter.lng).abs() < 0.0000001;
      final reachedLat = (destination.lat - newCenter.lat).abs() < 0.0000001;
      reachedCenter = reachedLat && reachedLng;
    }
    final reachedZoom = zoom == null || zoom == _map.getZoom();
    final reachedBearing = bearing == null || bearing == _map.getBearing();
    final reachedPitch = pitch == null || pitch == _map.getPitch();

    if (reachedCenter && reachedZoom && reachedBearing && reachedPitch) return;

    throw PlatformException(
      code: 'CancellationException',
      message: 'Animation cancelled.',
    );
  }

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
    // MapLibre GL JS calculates bounds using the transform's current padding
    // and then discards the padding option before moving the camera. Reset the
    // transform first so padding from an earlier camera move is not reused.
    final container = _map.getContainer();
    if (!_cameraPaddingReset.runBeforeFitBounds(
      camera: _map,
      viewportWidth: container.clientWidth,
      viewportHeight: container.clientHeight,
      fitPadding: padding.toPaddingOptions(),
    )) {
      return;
    }
    final camera = getCamera();
    _map.fitBounds(
      bounds.toJsLngLatBounds(),
      interop.FitBoundsOptions(
        offset: offset.toJsPoint(),
        maxZoom: webMaxZoom,
        linear: webLinear,
        maxDuration: webMaxDuration?.inMilliseconds,
        padding: padding.toPaddingOptions(),
        speed: webSpeed,
        pitch: pitch ?? camera.pitch,
        bearing: bearing ?? camera.bearing,
      ),
    );
  }

  @override
  MapCamera getCamera() => MapCamera(
    center: _map.getCenter().toGeographic(),
    zoom: _map.getZoom().toDouble(),
    pitch: _map.getPitch().toDouble(),
    bearing: _map.getBearing().toDouble(),
  );

  /// https://wiki.openstreetmap.org/wiki/Zoom_levels
  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      earthCircumferenceWgs84 *
      cos(latitude * degree2Radian) /
      pow(2, _map.getZoom() + 9);

  @override
  LngLatBounds getVisibleRegion() {
    final bounds = _map.getBounds();
    return LngLatBounds(
      longitudeWest: bounds.getWest().toDouble(),
      longitudeEast: bounds.getEast().toDouble(),
      latitudeSouth: bounds.getSouth().toDouble(),
      latitudeNorth: bounds.getNorth().toDouble(),
    );
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
  }) async {
    debugPrint("Can't enable the user location on web programmatically.");
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    debugPrint("Can't track the user location on web.");
  }

  @override
  Future<List<RenderedFeature>> featuresAtPoint(
    Offset point, {
    List<String>? layerIds,
  }) async => _renderedFeatures(
    _map.queryRenderedFeatures(point.toJsPoint(), _queryOptions(layerIds)),
  );

  @override
  Future<List<RenderedFeature>> featuresInRect(
    Rect rect, {
    List<String>? layerIds,
  }) async => _renderedFeatures(
    _map.queryRenderedFeaturesRect(
      [rect.bottomLeft.toJsPoint(), rect.topRight.toJsPoint()].toJS,
      _queryOptions(layerIds),
    ),
  );

  static interop.QueryRenderedFeaturesOptions _queryOptions(
    List<String>? layerIds,
  ) => interop.QueryRenderedFeaturesOptions(
    layers: layerIds?.map((l) => l.toJS).toList(growable: false).toJS,
  );

  static List<RenderedFeature> _renderedFeatures(
    JSArray<interop.MapGeoJSONFeature> features,
  ) => features.toDart
      .map(
        (f) => RenderedFeature(
          id: f.id.dartify(),
          properties: f.properties.asStringMap() ?? {},
          geometry: f.geometry.asStringMap(),
          sourceId: f.source,
          sourceLayer: f.sourceLayer,
        ),
      )
      .toList(growable: false);

  JSAny _prepareStyleString(String style) {
    final trimmed = style.trim();
    if (trimmed.startsWith('{')) {
      // Raw JSON
      final json = jsonDecode(trimmed) as Map<String, dynamic>;
      final jsified = json.jsify();
      if (jsified == null) {
        throw StateError('Failed to convert style JSON to JS object.');
      }
      return jsified;
    } else if (trimmed.startsWith('/')) {
      // path
      return trimmed.toJS;
    } else if (!trimmed.startsWith('http://') &&
        !trimmed.startsWith('https://') &&
        !trimmed.startsWith('mapbox://')) {
      // flutter asset
      return AssetManager().getAssetUrl(trimmed).toJS;
    } else {
      // URI
      return trimmed.toJS;
    }
  }

  @override
  void setStyle(String style) {
    _map.once(
      interop.MapEventType.styleLoad,
      (JSAny _) {
        _onStyleLoaded();
      }.toJS,
    );
    _map.setStyle(_prepareStyleString(style));
  }

  void _onStyleLoaded() {
    style?.dispose();
    final styleCtrl = StyleControllerWeb(_map);
    style = styleCtrl;
    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    _layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }
}

/// Applies gestures with MapLibre GL JS camera methods. Its own handlers are
/// off, as Flutter recognizes the gestures.
class _WebGestureCamera implements GestureCameraSink {
  _WebGestureCamera(this._state);

  final MapLibreMapStateWeb _state;

  interop.JsMap get _map => _state._map;

  @override
  void gestureStart() {
    // Catches a fling, whose end then reports the end of its move.
    _map.stop();
    _state
      .._gestureMoving = true
      .._gestureMoveStarted = false;
  }

  @override
  void gestureUpdate(GestureCameraUpdate update) {
    if (update.pans) {
      // Puts the location under the pointer where the pointer is now, which
      // keeps it under the pointer in every projection.
      _map.easeTo(
        interop.EaseToOptions(
          center: _map.unproject(update.panFrom!.toJsPoint()),
          offset: (update.panTo! - _mapCenter).toJsPoint(),
          duration: 0,
        ),
      );
    }
    if (update.zoomBy == 0 && update.rotateBy == 0 && update.pitchBy == 0) {
      return;
    }
    final around = update.around;
    if (around == null) {
      _map.jumpTo(
        interop.JumpToOptions(
          zoom: _map.getZoom() + update.zoomBy,
          bearing: _map.getBearing() + update.rotateBy,
          pitch: _map.getPitch() + update.pitchBy,
        ),
      );
      return;
    }
    _map.jumpTo(
      _cameraAround(
        around,
        zoomBy: update.zoomBy,
        rotateBy: update.rotateBy,
        pitchBy: update.pitchBy,
      ).options,
    );
  }

  /// The camera after zooming, rotating and tilting by the given amounts
  /// while the location at [around] stays there.
  ///
  /// GL JS's `around` drifts by hundreds of pixels on the globe. Changing the
  /// camera first and then putting the location back with the pan step stays
  /// exact in every projection. Those writes only work out the target and
  /// are undone, so a step is one camera write and can be animated.
  _WebCamera _cameraAround(
    Offset around, {
    double zoomBy = 0,
    double rotateBy = 0,
    double pitchBy = 0,
  }) {
    final location = _map.unproject(around.toJsPoint());
    final before = _camera();
    _state._silentCamera = true;
    try {
      _map
        ..jumpTo(
          interop.JumpToOptions(
            zoom: before.zoom + zoomBy,
            bearing: before.bearing + rotateBy,
            pitch: before.pitch + pitchBy,
          ),
        )
        ..easeTo(
          interop.EaseToOptions(
            center: location,
            offset: (around - _mapCenter).toJsPoint(),
            duration: 0,
          ),
        );
      return _camera();
    } finally {
      _map.jumpTo(before.options);
      _state._silentCamera = false;
    }
  }

  _WebCamera _camera() => (
    center: _map.getCenter(),
    zoom: _map.getZoom(),
    bearing: _map.getBearing(),
    pitch: _map.getPitch(),
  );

  @override
  void gestureEnd({Velocity velocity = Velocity.zero}) {
    if (!_state._gestureMoving) return;
    _state._gestureMoving = false;
    if (!_state._gestureMoveStarted) return;
    if (!_fling(velocity.pixelsPerSecond)) {
      _state.widget.onEvent?.call(const MapEventCameraIdle());
    }
  }

  /// Pans on after a release at [velocity] as GL JS does, slowing down. The
  /// fling's end reports the end of the move.
  bool _fling(Offset velocity) {
    final speed = min(velocity.distance * _flingLinearity, _flingMaxSpeed);
    if (speed == 0) return false;
    final seconds = speed / (_flingDeceleration * _flingLinearity);
    final distance = speed * seconds / 2;
    // The move already started with the gesture.
    _state
      .._gestureMoving = true
      .._gestureMoveStarted = true;
    _map.easeTo(
      interop.EaseToOptions(
        center: _map.getCenter(),
        offset: (velocity / velocity.distance * distance).toJsPoint(),
        duration: seconds * 1000,
        easing: _flingCurve.transform.toJS,
        essential: true,
      ),
    );
    _state._gestureMoving = false;
    return true;
  }

  @override
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  }) {
    // Ends a running animation before working out the target, so that its
    // end is reported.
    _map.stop();
    final target = _cameraAround(around, zoomBy: levels);
    _state._nextMoveByUser = true;
    _map.easeTo(
      interop.EaseToOptions(
        center: target.center,
        zoom: target.zoom,
        duration: duration.inMilliseconds,
        essential: true,
      ),
    );
  }

  Offset get _mapCenter {
    final canvas = _map.getCanvas();
    return Offset(canvas.clientWidth / 2, canvas.clientHeight / 2);
  }
}

typedef _WebCamera = ({
  interop.LngLat center,
  num zoom,
  num bearing,
  num pitch,
});

extension on _WebCamera {
  interop.JumpToOptions get options => interop.JumpToOptions(
    center: center,
    zoom: zoom,
    bearing: bearing,
    pitch: pitch,
  );
}

// The pan inertia of MapLibre GL JS.
const _flingLinearity = 0.3;
const _flingMaxSpeed = 1400.0;
const _flingDeceleration = 2500.0;
const _flingCurve = Cubic(0, 0, 0.3, 1);

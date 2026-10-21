import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_native/src/command.dart';
import 'package:maplibre_native/src/map_renderer.dart';
import 'package:maplibre_native/src/style_controller.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

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

  @override
  late final GestureCameraSink gestureCamera = _NativeGestureCamera(this);

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
        return Texture(textureId: renderer.textureId);
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
                final center? => mln.LatLng(
                  latitude: center.lat,
                  longitude: center.lon,
                ),
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
              southwest: mln.LatLng(
                latitude: bounds.latitudeSouth,
                longitude: bounds.longitudeWest,
              ),
              northeast: mln.LatLng(
                latitude: bounds.latitudeNorth,
                longitude: bounds.longitudeEast,
              ),
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
    final resized = frame.generation != _shownExtentGeneration;
    _shownExtentGeneration = frame.generation;
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
    if (map == null || _renderer!.disposed) return null;
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

  void _applyDelta(mln.CameraDelta delta) {
    final map = _map;
    if (map == null) return;
    unawaited(checkCommand(map.applyCameraDelta(delta)));
  }

  static mln.ScreenPoint _screenPoint(Offset offset) =>
      mln.ScreenPoint(x: offset.dx, y: offset.dy);

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

  // The map's latest camera, so it reflects a completed moveCamera. [camera]
  // instead follows the frame on screen, for widgets over the map.
  @override
  MapCamera getCamera() =>
      _readCamera() ??
      camera ??
      (throw StateError('The map has not been created yet.'));

  @override
  Offset toScreenLocation(Geographic lngLat) =>
      toScreenLocations([lngLat]).single;

  @override
  Geographic toLngLat(Offset screenLocation) =>
      toLngLats([screenLocation]).single;

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) {
    final projection = _currentProjection();
    return [
      for (final lngLat in lngLats)
        _offset(
          projection.pixelForLatLng(
            mln.LatLng(latitude: lngLat.lat, longitude: lngLat.lon),
          ),
        ),
    ];
  }

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) {
    final projection = _currentProjection();
    return [
      for (final screenLocation in screenLocations)
        _geographic(projection.latLngForPixel(_screenPoint(screenLocation))),
    ];
  }

  static Offset _offset(mln.ScreenPoint point) => Offset(point.x, point.y);

  static Geographic _geographic(mln.LatLng latLng) =>
      Geographic(lon: latLng.longitude, lat: latLng.latitude);

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
        southwest: mln.LatLng(
          latitude: bounds.latitudeSouth,
          longitude: bounds.longitudeWest,
        ),
        northeast: mln.LatLng(
          latitude: bounds.latitudeNorth,
          longitude: bounds.longitudeEast,
        ),
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
            center: center == null
                ? null
                : mln.LatLng(latitude: center.lat, longitude: center.lon),
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
    mln.RenderedQueryGeometry.point(_screenPoint(point)),
    layerIds,
  );

  @override
  Future<List<RenderedFeature>> featuresInRect(
    Rect rect, {
    List<String>? layerIds,
  }) => _queryRenderedFeatures(
    mln.RenderedQueryGeometry.box(
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

/// Applies gestures with the map's projection-aware camera deltas, which
/// move, scale, rotate and tilt around a screen point.
class _NativeGestureCamera implements GestureCameraSink {
  _NativeGestureCamera(this._state);

  final MapLibreMapStateNative _state;

  @override
  void gestureStart() {
    _state._gestureActive = true;
    _state._applyDelta(mln.CameraDelta(gesturePhase: mln.GesturePhase.begin));
  }

  @override
  void gestureUpdate(GestureCameraUpdate update) {
    final scales = update.zoomBy != 0;
    final rotates = update.rotateBy != 0;
    final tilts = update.pitchBy != 0;
    final around = update.around;
    _state._applyDelta(
      mln.CameraDelta(
        offset: update.pans
            ? MapLibreMapStateNative._screenPoint(
                update.panTo! - update.panFrom!,
              )
            : null,
        scale: scales ? pow(2, update.zoomBy).toDouble() : null,
        bearing: rotates ? update.rotateBy : null,
        pitch: tilts ? update.pitchBy : null,
        // The C API rejects an anchor without a scale, bearing or pitch.
        anchor: around != null && (scales || rotates || tilts)
            ? MapLibreMapStateNative._screenPoint(around)
            : null,
        gesturePhase: mln.GesturePhase.update,
      ),
    );
  }

  /// Ends the gesture. Native maps don't fling yet, so [velocity] is unused.
  @override
  void gestureEnd({Velocity velocity = Velocity.zero}) {
    if (!_state._gestureActive) return;
    _state
      .._gestureActive = false
      .._applyDelta(mln.CameraDelta(gesturePhase: mln.GesturePhase.end))
      .._onCameraIdle();
  }

  @override
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  }) {
    _state._applyDelta(
      mln.CameraDelta(
        scale: pow(2, levels).toDouble(),
        anchor: MapLibreMapStateNative._screenPoint(around),
        animation: duration == Duration.zero
            ? mln.AnimationOptions()
            : mln.AnimationOptions(
                durationMs: duration.inMilliseconds.toDouble(),
              ),
      ),
    );
  }
}

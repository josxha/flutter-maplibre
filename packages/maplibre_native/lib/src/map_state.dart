import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:maplibre_native/src/map_renderer.dart';
import 'package:maplibre_native/src/style_controller.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The map events that the state handles. Others, such as the render events
/// of every frame, are not queued at all.
final mln.RuntimeEventFlag _eventMask =
    mln.RuntimeEventFlag.mapCameraWillChange |
    mln.RuntimeEventFlag.mapCameraIsChanging |
    mln.RuntimeEventFlag.mapCameraDidChange |
    mln.RuntimeEventFlag.mapStyleLoaded |
    mln.RuntimeEventFlag.mapIdle |
    mln.RuntimeEventFlag.mapSourceChanged |
    mln.RuntimeEventFlag.mapLoadingFailed |
    mln.RuntimeEventFlag.mapRenderError |
    mln.RuntimeEventFlag.mapGlyphsError |
    mln.RuntimeEventFlag.mapSpriteError;

/// MapLibre Native, rendered through its C API into a Flutter texture.
class MapLibreMapStateNative extends MapLibreMapState {
  MapRenderer? _renderer;

  /// The map, from its creation on, before [_renderer] exists.
  mln.MapHandle? _map;
  Future<void>? _creating;
  var _disposed = false;

  @override
  StyleControllerNative? style;

  /// The JSON of the style the map loads, when it is at hand.
  String? _styleJson;

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
  int? _shownExtentGeneration;

  /// The camera of the last camera event, to report each change once.
  MapCamera? _eventCamera;

  var _gestureActive = false;
  var _cameraMoving = false;

  /// The camera that the running camera animation ends at, to jump there
  /// when the map pauses.
  mln.CameraOptions? _animationTarget;

  /// Why the camera changes next. Runtime events arrive after the change was
  /// submitted, possibly after a short gesture already ended, so the reason
  /// is taken when the change is made.
  CameraChangeReason? _nextChangeReason;

  @override
  late final GestureCameraSink gestureCamera = _NativeGestureCamera(this);

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
      // The map takes its options, camera, and style before the session
      // renders, so its first frame shows them.
      final renderer = await MapRenderer.create(
        extent: extent,
        eventMask: _eventMask,
        setUp: _setUp,
        onEvent: _onRuntimeEvent,
        onFrameShown: _onFrameShown,
      );
      if (_disposed) {
        await renderer.dispose();
        return;
      }
      _renderer = renderer..paused = isRenderingPaused;
      setState(() {
        camera = _readCamera();
        isInitialized = true;
      });
      widget.onEvent?.call(MapEventMapCreated(mapController: this));
      widget.onMapCreated?.call(this);
      // Events that arrived meanwhile, such as the style load, follow
      // onMapCreated.
      renderer.start();
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

  /// Submits the options, initial camera, and style of a new [map].
  Future<void> _setUp(mln.MapHandle map) async {
    _map = map;
    final options = this.options;
    await Future.wait([
      _applyOptions(),
      map.updateCamera(
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
      setStyle(options.initStyle),
    ]);
  }

  /// Applies the camera constraints of [MapOptions].
  Future<void> _applyOptions() async {
    final map = _map;
    if (map == null) return;
    final options = this.options;
    await map.setBounds(
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
    );
  }

  @override
  void setRenderingPaused({required bool paused}) {
    _renderer?.paused = paused;
    // Camera animations advance only while the map renders. One that runs
    // now ends at its target, so its caller does not wait for the resume.
    final target = _animationTarget;
    final map = _map;
    if (!paused || target == null || map == null) return;
    _animationTarget = null;
    unawaited(map.updateCamera(mln.CameraUpdate(camera: target)));
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
    _map = null;
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
        final reason =
            _nextChangeReason ??
            (_gestureActive
                ? CameraChangeReason.apiGesture
                : CameraChangeReason.apiAnimation);
        _nextChangeReason = null;
        widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
      case mln.RuntimeEventType.mapCameraIsChanging:
        _onCameraChanged();
      case mln.RuntimeEventType.mapCameraDidChange:
        _onCameraChanged();
        // A gesture publishes one change per pointer update and ends with
        // the gesture instead, and an animation changes the camera once per
        // transition until its last one ended.
        final snapshot = _map?.getSnapshot();
        if (!_gestureActive &&
            snapshot != null &&
            !snapshot.transitionInProgress) {
          _onCameraIdle();
        }
      case mln.RuntimeEventType.mapStyleLoaded:
        unawaited(_onStyleLoaded());
      case mln.RuntimeEventType.mapIdle:
        widget.onEvent?.call(const MapEventIdle());
      case mln.RuntimeEventType.mapSourceChanged:
        // A source learns its attribution once its tile set loads.
        unawaited(style?.getAttributions());
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
    if (_disposed) {
      projection.close();
      return;
    }
    _shownProjection?.close();
    _shownProjection = projection;
    final shown = _toMapCamera(frame.view.camera);
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

  /// Submits [update] and waits until its transitions end: they complete,
  /// another change cancels them, or the map closes.
  Future<void> _submitCamera(mln.MapHandle map, mln.CameraUpdate update) async {
    _nextChangeReason = CameraChangeReason.developerAnimation;
    final target = update.camera;
    final animates =
        update.mode != mln.CameraUpdateMode.jump && !isRenderingPaused;
    // A later camera write replaces the animation, whether or not it animates.
    _animationTarget = animates ? target : null;
    final ended = Completer<void>();
    await map.updateCamera(
      update.copyWith(
        // A paused map does not advance animations, so it jumps.
        mode: isRenderingPaused ? mln.CameraUpdateMode.jump : null,
        animation: update.animation.copyWith(
          endHandler: (_) {
            if (identical(_animationTarget, target)) _animationTarget = null;
            if (!ended.isCompleted) ended.complete();
          },
        ),
      ),
    );
    await ended.future;
  }

  Future<void> _onStyleLoaded() async {
    final map = _map;
    if (map == null) return;
    style?.dispose();
    final styleController = StyleControllerNative(map, styleJson: _styleJson);
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
    if (map == null || _disposed) return null;
    return _toMapCamera(map.getSnapshot().view.camera);
  }

  /// The native center is unwrapped to the visible world copy; the public
  /// camera wraps its longitude into [-180, 180).
  static MapCamera _toMapCamera(mln.Camera native) => MapCamera(
    center: Geographic(
      lon: (native.center.longitude + 180) % 360 - 180,
      lat: native.center.latitude,
    ),
    zoom: native.zoom,
    bearing: native.bearing,
    pitch: native.pitch,
  );

  // Gestures

  /// Applies [delta] without waiting for it, in order with later commands.
  void _applyDelta(mln.CameraDelta delta) =>
      _map?.discarding.applyCameraDelta(delta);

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
    return _shownProjection ??
        (_projection ??= mln.MapProjectionHandle.create(
          map.getSnapshot().view,
        ));
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
    await _submitCamera(
      map,
      mln.CameraUpdate(
        mode: mln.CameraUpdateMode.fly,
        camera: target,
        animation: mln.AnimationOptions(
          durationMs: nativeDuration.inMilliseconds.toDouble(),
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
    await _submitCamera(
      map,
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
    // The style JSON where it is at hand, for the attributions that MapLibre
    // Native drops.
    _styleJson = null;
    if (trimmed.startsWith('{')) {
      _styleJson = trimmed;
      await map.setStyleJson(jsonDecode(trimmed));
    } else if (trimmed.startsWith('http://') ||
        trimmed.startsWith('https://') ||
        trimmed.startsWith('mapbox://') ||
        trimmed.startsWith('file://') ||
        trimmed.startsWith('asset://')) {
      if (trimmed.startsWith('file://')) {
        _styleJson = await _readStyleFile(Uri.parse(trimmed).toFilePath());
      }
      await map.setStyleUrl(trimmed);
    } else if (trimmed.startsWith('/') ||
        RegExp(r'^[a-zA-Z]:[/\\]').hasMatch(trimmed)) {
      _styleJson = await _readStyleFile(trimmed);
      await map.setStyleUrl(Uri.file(trimmed).toString());
    } else {
      // A Flutter asset.
      final json = await DefaultAssetBundle.of(context).loadString(trimmed);
      _styleJson = json;
      await map.setStyleJson(jsonDecode(json));
    }
  }

  /// The style JSON in the file at [path], or null if it can't be read.
  static Future<String?> _readStyleFile(String path) async {
    try {
      return await File(path).readAsString();
    } on Object {
      return null;
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
        if (queried.feature case final Map<String, Object?> feature)
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
            sourceId: _nonEmpty(queried.sourceId),
            sourceLayer: _nonEmpty(queried.sourceLayerId),
            layerId: _nonEmpty(queried.layerId),
          ),
    ];
  }
}

/// [value], or null for the empty string that the C API reports as absent.
String? _nonEmpty(String value) => value.isEmpty ? null : value;

/// Applies gestures with the map's projection-aware camera deltas, which
/// move, scale, rotate and tilt around a screen point.
class _NativeGestureCamera implements GestureCameraSink {
  _NativeGestureCamera(this._state);

  final MapLibreMapStateNative _state;

  @override
  void gestureStart() {
    _state
      .._gestureActive = true
      .._nextChangeReason = CameraChangeReason.apiGesture;
    _state._applyDelta(
      const mln.CameraDelta(gesturePhase: mln.GesturePhase.begin),
    );
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
      .._applyDelta(const mln.CameraDelta(gesturePhase: mln.GesturePhase.end))
      .._onCameraIdle();
  }

  @override
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  }) {
    _state._nextChangeReason = CameraChangeReason.apiGesture;
    _state._applyDelta(
      mln.CameraDelta(
        scale: pow(2, levels).toDouble(),
        anchor: MapLibreMapStateNative._screenPoint(around),
        animation: duration == Duration.zero
            ? const mln.AnimationOptions()
            : mln.AnimationOptions(
                durationMs: duration.inMilliseconds.toDouble(),
              ),
      ),
    );
  }
}

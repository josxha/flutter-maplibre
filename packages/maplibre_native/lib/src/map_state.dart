import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:maplibre_native/src/map_renderer.dart';
import 'package:maplibre_native/src/style_controller.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The map events that the state always handles. Others, such as the render
/// events of every frame, are only queued while [MapLibreMap] has a callback
/// for them, see [_eventMaskOf].
final mln.RuntimeEventFlag _baseEventMask =
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

/// The events that the callbacks of [map] need.
mln.RuntimeEventFlag _eventMaskOf(MapLibreMap map) =>
    _baseEventMask |
    (map.onLoadingStarted != null
        ? mln.RuntimeEventFlag.mapLoadingStarted
        : mln.RuntimeEventFlag.none) |
    (map.onLoadingFinished != null
        ? mln.RuntimeEventFlag.mapLoadingFinished
        : mln.RuntimeEventFlag.none) |
    (map.onStyleImageMissing != null
        ? mln.RuntimeEventFlag.mapStyleImageMissing
        : mln.RuntimeEventFlag.none) |
    (map.onTile != null
        ? mln.RuntimeEventFlag.mapTileAction
        : mln.RuntimeEventFlag.none) |
    (map.onRenderFrame != null
        ? mln.RuntimeEventFlag.mapRenderFrameFinished
        : mln.RuntimeEventFlag.none) |
    (map.onRenderMap != null
        ? mln.RuntimeEventFlag.mapRenderMapFinished
        : mln.RuntimeEventFlag.none) |
    (map.onGlyphs != null
        ? mln.RuntimeEventFlag.mapGlyphsRequested |
              mln.RuntimeEventFlag.mapGlyphsLoaded
        : mln.RuntimeEventFlag.none) |
    (map.onSprite != null
        ? mln.RuntimeEventFlag.mapSpriteRequested |
              mln.RuntimeEventFlag.mapSpriteLoaded
        : mln.RuntimeEventFlag.none);

/// MapLibre Native, rendered through its C API into a Flutter texture.
class MapLibreMapStateNative extends MapLibreMapState {
  MapRenderer? _renderer;

  /// The events that the map queues, see [_eventMaskOf].
  mln.RuntimeEventFlag? _eventMask;

  /// The map, from its creation on, before [_renderer] exists.
  mln.MapHandle? _map;
  Future<void>? _creating;
  var _disposed = false;

  @override
  StyleControllerNative? style;

  /// Whether the camera constraints of [MapOptions] wait for the first
  /// style, see [_setUp].
  var _constraintsAfterStyle = false;

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
  CameraPosition? _eventCamera;

  var _gestureActive = false;
  var _cameraMoving = false;

  /// The running camera animation, to jump to its target when the map
  /// pauses and to report whether it was cancelled.
  _CameraAnimationRun? _animation;

  /// Why the camera moves, from the start of the move on.
  CameraChangeReason _moveReason = CameraChangeReason.map;

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
        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (_) => _map?.discarding.cancelTransitions(),
          child: Texture(textureId: renderer.textureId),
        );
      },
    );
  }

  Future<void> _create(mln.LogicalExtent extent, double pixelRatio) async {
    try {
      // The map takes its options, camera, and style before the session
      // renders, so its first frame shows them.
      final renderer = await MapRenderer.create(
        extent: extent,
        eventMask: _eventMask = _eventMaskOf(widget),
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
    // The callbacks may have changed while the map was being created.
    final eventMask = _eventMaskOf(widget);
    if (eventMask != _eventMask) {
      _eventMask = eventMask;
      map.discarding.setEventMask(eventMask);
    }
    final options = this.options;
    final initCamera = options.initCamera;
    // Without an initial camera, MapLibre Native moves to the camera of the
    // style once it loads, but only while no camera change happened. Setting
    // camera constraints is one, so they follow the first style.
    _constraintsAfterStyle = initCamera == null;
    await Future.wait([
      if (initCamera != null) ...[
        _applyOptions(),
        _applyInitialCamera(map, initCamera),
      ],
      _setStyle(options.style),
    ]);
  }

  Future<void> _applyInitialCamera(
    mln.MapHandle map,
    CameraUpdate initCamera,
  ) async {
    final camera = await _cameraOptions(map, initCamera);
    await map.updateCamera(mln.CameraUpdate(camera: camera));
  }

  /// Applies the camera constraints of [MapOptions].
  Future<void> _applyOptions() async {
    final map = _map;
    if (map == null || _constraintsAfterStyle) return;
    final options = this.options;
    await map.setBounds(
      mln.BoundOptions(
        bounds: switch (options.maxBounds) {
          final bounds? => _latLngBounds(bounds),
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
    final animation = _animation;
    final map = _map;
    if (!paused || animation == null || map == null) return;
    _animation = null;
    unawaited(map.updateCamera(mln.CameraUpdate(camera: animation.target)));
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    final options = widget.options;
    if (oldWidget.options != options) unawaited(_applyOptions());
    if (oldWidget.options.style != options.style) {
      unawaited(_setStyle(options.style));
    }
    _layerManager?.updateLayers(widget.layers);
    final eventMask = _eventMaskOf(widget);
    final map = _map;
    if (eventMask != _eventMask && map != null) {
      _eventMask = eventMask;
      map.discarding.setEventMask(eventMask);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _disposed = true;
    _animation?.end(CameraAnimationResult.cancelled);
    _animation = null;
    style?.dispose();
    _loadingStyle?.dispose();
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
                ? CameraChangeReason.gesture
                : CameraChangeReason.map);
        _nextChangeReason = null;
        _moveReason = reason;
        widget.onCameraMoveStart?.call(MapEventCameraMoveStart(reason: reason));
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
        widget.onIdle?.call(const MapEventIdle());
      case mln.RuntimeEventType.mapSourceChanged:
        // A source learns its attribution once its tile set loads.
        unawaited(style?.refreshAttributions());
        widget.onSourceChanged?.call(
          MapEventSourceChanged(sourceId: event.message),
        );
      case mln.RuntimeEventType.mapLoadingFailed:
        _onError(MapErrorKind.style, event.message);
      case mln.RuntimeEventType.mapRenderError:
        _onError(MapErrorKind.render, event.message);
      case mln.RuntimeEventType.mapGlyphsError:
        _onError(MapErrorKind.glyphs, event.message);
      case mln.RuntimeEventType.mapSpriteError:
        _onError(MapErrorKind.sprite, event.message);
      case mln.RuntimeEventType.mapLoadingStarted:
        widget.onLoadingStarted?.call(const MapEventLoadingStarted());
      case mln.RuntimeEventType.mapLoadingFinished:
        widget.onLoadingFinished?.call(const MapEventLoadingFinished());
      case mln.RuntimeEventType.mapStyleImageMissing:
        widget.onStyleImageMissing?.call(
          MapEventStyleImageMissing(id: event.message),
        );
      case mln.RuntimeEventType.mapTileAction:
        final onTile = widget.onTile;
        final action = switch (event.payload) {
          mln.RuntimeEventPayloadTileAction(:final value) => value,
          _ => null,
        };
        final operation = _tileOperations[action?.operation];
        if (onTile == null || action == null || operation == null) return;
        final tile = action.tileId;
        onTile(
          MapEventTile(
            operation: operation,
            sourceId: event.message,
            z: tile.canonicalZ,
            x: tile.canonicalX,
            y: tile.canonicalY,
            overscaledZ: tile.overscaledZ,
            wrap: tile.wrap,
          ),
        );
      case mln.RuntimeEventType.mapRenderFrameFinished:
        final onRenderFrame = widget.onRenderFrame;
        final frame = switch (event.payload) {
          mln.RuntimeEventPayloadRenderFrame(:final value) => value,
          _ => null,
        };
        if (onRenderFrame == null || frame == null) return;
        final stats = frame.stats;
        onRenderFrame(
          MapEventRenderFrame(
            fullyRendered: frame.mode == mln.RenderMode.full,
            stats: MapRenderingStats(
              encodingTime: _seconds(stats.encodingTime),
              renderingTime: _seconds(stats.renderingTime),
              drawCalls: stats.drawCallCount,
            ),
          ),
        );
      case mln.RuntimeEventType.mapRenderMapFinished:
        final onRenderMap = widget.onRenderMap;
        final map = switch (event.payload) {
          mln.RuntimeEventPayloadRenderMap(:final value) => value,
          _ => null,
        };
        if (onRenderMap == null || map == null) return;
        onRenderMap(
          MapEventRenderMap(fullyRendered: map.mode == mln.RenderMode.full),
        );
      case mln.RuntimeEventType.mapGlyphsRequested ||
          mln.RuntimeEventType.mapGlyphsLoaded:
        final onGlyphs = widget.onGlyphs;
        final glyphs = switch (event.payload) {
          mln.RuntimeEventPayloadGlyphs(:final value) => value,
          _ => null,
        };
        if (onGlyphs == null || glyphs == null) return;
        onGlyphs(
          MapEventGlyphs(
            state: event.type == mln.RuntimeEventType.mapGlyphsLoaded
                ? MapResourceState.loaded
                : MapResourceState.requested,
            fontStack: glyphs.fontStack,
            first: glyphs.first,
            last: glyphs.last,
          ),
        );
      case mln.RuntimeEventType.mapSpriteRequested ||
          mln.RuntimeEventType.mapSpriteLoaded:
        final onSprite = widget.onSprite;
        final sprite = switch (event.payload) {
          mln.RuntimeEventPayloadSprite(:final value) => value,
          _ => null,
        };
        if (onSprite == null || sprite == null) return;
        onSprite(
          MapEventSprite(
            state: event.type == mln.RuntimeEventType.mapSpriteLoaded
                ? MapResourceState.loaded
                : MapResourceState.requested,
            id: sprite.id,
            url: sprite.url,
          ),
        );
      default:
        break;
    }
  }

  /// Reports an error to [MapLibreMap.onError], or prints it while no
  /// callback is set, so it is never lost.
  void _onError(MapErrorKind kind, String message) {
    final onError = widget.onError;
    if (onError == null) {
      debugPrint('maplibre_native: $message');
      return;
    }
    onError(MapEventError(kind: kind, message: message));
  }

  static Duration _seconds(double seconds) => Duration(
    microseconds: (seconds * Duration.microsecondsPerSecond).round(),
  );

  static final Map<mln.TileOperation, MapTileOperation> _tileOperations = {
    mln.TileOperation.requestedFromCache: MapTileOperation.requestedFromCache,
    mln.TileOperation.requestedFromNetwork:
        MapTileOperation.requestedFromNetwork,
    mln.TileOperation.loadFromNetwork: MapTileOperation.loadFromNetwork,
    mln.TileOperation.loadFromCache: MapTileOperation.loadFromCache,
    mln.TileOperation.startParse: MapTileOperation.startParse,
    mln.TileOperation.endParse: MapTileOperation.endParse,
    mln.TileOperation.error: MapTileOperation.error,
    mln.TileOperation.cancelled: MapTileOperation.cancelled,
  };

  /// Reports the map's latest camera. [camera] instead follows the frame on
  /// screen, see [_onFrameShown].
  void _onCameraChanged() {
    _invalidateProjection();
    final newCamera = _readCamera();
    if (newCamera == null || newCamera == _eventCamera) return;
    _eventCamera = newCamera;
    widget.onCameraMove?.call(
      MapEventCameraMove(camera: newCamera, reason: _moveReason),
    );
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
    final shown = _toCameraPosition(frame.view.camera);
    final resized = frame.generation != _shownExtentGeneration;
    _shownExtentGeneration = frame.generation;
    if (shown == camera && !resized) return;
    setState(() => camera = shown);
  }

  void _onCameraIdle() {
    if (!_cameraMoving) return;
    _cameraMoving = false;
    final onCameraMoveEnd = widget.onCameraMoveEnd;
    final camera = _readCamera();
    if (onCameraMoveEnd == null || camera == null) return;
    onCameraMoveEnd(MapEventCameraMoveEnd(camera: camera, reason: _moveReason));
  }

  /// Submits [update] and waits until its transitions end: they complete,
  /// another change replaces or cancels them, or the map closes.
  Future<CameraAnimationResult> _submitCamera(
    mln.MapHandle map,
    mln.CameraUpdate update,
  ) async {
    _nextChangeReason = CameraChangeReason.programmatic;
    final animates =
        update.mode != mln.CameraUpdateMode.jump && !isRenderingPaused;
    // A later camera write replaces the animation, whether or not it animates.
    final run = _CameraAnimationRun(update.camera);
    _animation = animates ? run : null;
    await map.updateCamera(
      update.copyWith(
        // A paused map does not advance animations, so it jumps.
        mode: isRenderingPaused ? mln.CameraUpdateMode.jump : null,
        animation: update.animation.copyWith(
          endHandler: (end) {
            if (identical(_animation, run)) _animation = null;
            run.end(
              end.outcome == mln.CameraTransitionOutcome.completed
                  ? CameraAnimationResult.completed
                  : CameraAnimationResult.cancelled,
            );
          },
        ),
      ),
    );
    return run.result;
  }

  /// Cancels the running camera animation, for a gesture or [stopCamera].
  void _cancelAnimation() {
    final animation = _animation;
    if (animation == null) return;
    _animation = null;
    animation.cancelled = true;
    _map?.discarding.cancelTransitions();
  }

  /// The style controller that [_onStyleLoaded] is filling, until it becomes
  /// [style].
  StyleControllerNative? _loadingStyle;

  Future<void> _onStyleLoaded() async {
    final map = _map;
    if (map == null) return;
    if (_constraintsAfterStyle) {
      _constraintsAfterStyle = false;
      await _applyOptions();
    }
    // Only the next LayerManager sees MapLibreMap.layers: the layers of the
    // old one are gone.
    _layerManager = null;
    style?.dispose();
    style = null;
    late final StyleControllerNative styleController;
    styleController = StyleControllerNative(
      map,
      // Rebuilds the widgets in MapLibreMap.children, such as
      // SourceAttribution.
      onAttributionsChanged: () {
        if (mounted && style == styleController) setState(() {});
      },
    );
    _loadingStyle = styleController;
    // The style is only handed out once its layers and sources are known.
    await styleController.load();
    if (_disposed || _loadingStyle != styleController) {
      styleController.dispose();
      return;
    }
    _loadingStyle = null;
    style = styleController;
    widget.onStyleLoaded?.call(styleController);
    _layerManager = LayerManager(styleController, widget.layers);
    // Refresh the widgets in MapLibreMap.children.
    setState(() {});
  }

  CameraPosition? _readCamera() {
    final map = _map;
    if (map == null || _disposed) return null;
    return _toCameraPosition(map.getSnapshot().view.camera);
  }

  /// The native center is unwrapped to the visible world copy; the public
  /// camera wraps its longitude into [-180, 180).
  static CameraPosition _toCameraPosition(mln.Camera native) => CameraPosition(
    center: Geographic(
      lon: (native.center.longitude + 180) % 360 - 180,
      lat: native.center.latitude,
    ),
    zoom: native.zoom,
    bearing: native.bearing,
    pitch: native.pitch,
    roll: native.roll,
    padding: EdgeInsets.fromLTRB(
      native.padding.left,
      native.padding.top,
      native.padding.right,
      native.padding.bottom,
    ),
  );

  // Gestures

  /// Applies [delta] without waiting for it, in order with later commands.
  void _applyDelta(mln.CameraDelta delta) =>
      _map?.discarding.applyCameraDelta(delta);

  @override
  Future<List<SourceFeature>> querySourceFeatures(
    String sourceId, {
    String? sourceLayer,
    Expression<bool>? filter,
  }) async {
    final renderer = _renderer;
    if (renderer == null) return const [];
    final features = await renderer.querySourceFeatures(
      sourceId,
      sourceLayerIds: sourceLayer == null ? null : [sourceLayer],
      filter: filter?.toJson(),
    );
    return [
      for (final queried in features)
        if (queried.feature case final Map<String, Object?> feature)
          SourceFeature(
            id: feature['id'],
            properties: _properties(feature),
            geometry: RenderedFeature.geometryFromJson(feature['geometry']),
            sourceLayer: _nonEmpty(queried.sourceLayerId),
          ),
    ];
  }

  static mln.RenderedQueryGeometry _box(Rect rect) =>
      mln.RenderedQueryGeometry.box(
        mln.ScreenBox(
          min: _screenPoint(rect.topLeft),
          max: _screenPoint(rect.bottomRight),
        ),
      );

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
  CameraPosition getCamera() =>
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
  GeoBox getVisibleBounds() {
    final size = context.size ?? Size.zero;
    final corners = toLngLats([
      Offset.zero,
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ]);
    return GeoBox(
      west: corners.map((c) => c.lon).reduce(min),
      east: corners.map((c) => c.lon).reduce(max),
      south: corners.map((c) => c.lat).reduce(min),
      north: corners.map((c) => c.lat).reduce(max),
    );
  }

  @override
  Future<void> moveCamera(CameraUpdate update) async {
    final map = _map;
    if (map == null) return;
    final camera = await _cameraOptions(map, update);
    if (_map != map) return;
    // A jump would replace a running animation, which then counts as
    // completed, so it is cancelled first.
    _cancelAnimation();
    await _submitCamera(map, mln.CameraUpdate(camera: camera));
  }

  @override
  Future<CameraAnimationResult> animateCamera(
    CameraUpdate update, {
    CameraAnimation animation = const CameraAnimation.ease(),
  }) async {
    final map = _map;
    if (map == null) return CameraAnimationResult.cancelled;
    final camera = await _cameraOptions(map, update);
    if (_map != map) return CameraAnimationResult.cancelled;
    return _submitCamera(
      map,
      mln.CameraUpdate(
        mode: switch (animation) {
          CameraAnimationEase() => mln.CameraUpdateMode.ease,
          CameraAnimationFly() => mln.CameraUpdateMode.fly,
        },
        camera: camera,
        animation: _animationOptions(animation),
      ),
    );
  }

  @override
  Future<void> stopCamera() async => _cancelAnimation();

  @override
  Future<CameraPosition> cameraFor(CameraUpdate update) async {
    final map = _map;
    if (map == null) {
      throw StateError('The map has not been created yet.');
    }
    final current = getCamera();
    final camera = await _cameraOptions(map, update);
    final center = camera.center;
    final padding = camera.padding;
    return CameraPosition(
      center: center == null ? current.center : _geographic(center),
      zoom: camera.zoom ?? current.zoom,
      bearing: camera.bearing ?? current.bearing,
      pitch: camera.pitch ?? current.pitch,
      roll: camera.roll ?? current.roll,
      padding: padding == null
          ? current.padding
          : EdgeInsets.fromLTRB(
              padding.left,
              padding.top,
              padding.right,
              padding.bottom,
            ),
    );
  }

  /// The native camera that [update] moves [map] to.
  static Future<mln.CameraOptions> _cameraOptions(
    mln.MapHandle map,
    CameraUpdate update,
  ) async {
    switch (update) {
      case CameraUpdatePosition(:final center, :final padding, :final anchor):
        return mln.CameraOptions(
          center: center == null ? null : _latLng(center),
          zoom: update.zoom,
          bearing: update.bearing,
          pitch: update.pitch,
          roll: update.roll,
          padding: padding == null ? null : _edgeInsets(padding),
          anchor: anchor == null ? null : _screenPoint(anchor),
        );
      case CameraUpdateFit():
        final fitOptions = mln.CameraFitOptions(
          padding: _edgeInsets(update.padding),
          bearing: update.bearing,
          pitch: update.pitch,
        );
        final camera = await switch (update) {
          CameraUpdateBounds(:final bounds) => map.cameraForLatLngBounds(
            _latLngBounds(bounds),
            fitOptions: fitOptions,
          ),
          CameraUpdatePoints(:final points) =>
            points.isEmpty
                ? throw ArgumentError.value(
                    points,
                    'points',
                    'must not be empty',
                  )
                : map.cameraForLatLngs([
                    for (final point in points) _latLng(point),
                  ], fitOptions: fitOptions),
          CameraUpdateGeometry(:final geometry) => map.cameraForGeometry(
            jsonDecode(geometry.toText()),
            fitOptions: fitOptions,
          ),
        };
        final maxZoom = update.maxZoom;
        final zoom = camera.zoom;
        if (maxZoom != null && zoom != null && zoom > maxZoom) {
          return camera.copyWith(zoom: maxZoom);
        }
        return camera;
    }
  }

  static mln.AnimationOptions _animationOptions(CameraAnimation animation) {
    final curve = animation.curve;
    final easing = mln.UnitBezier(
      x1: curve.a,
      y1: curve.b,
      x2: curve.c,
      y2: curve.d,
    );
    return switch (animation) {
      CameraAnimationEase(:final duration) => mln.AnimationOptions(
        durationMs: duration.inMicroseconds / 1000,
        easing: easing,
      ),
      CameraAnimationFly(:final duration) => mln.AnimationOptions(
        durationMs: duration == null ? null : duration.inMicroseconds / 1000,
        velocity: duration == null ? animation.speed : null,
        minZoom: animation.peakZoom,
        easing: easing,
      ),
    };
  }

  static mln.LatLng _latLng(Geographic position) =>
      mln.LatLng(latitude: position.lat, longitude: position.lon);

  static mln.LatLngBounds _latLngBounds(GeoBox bounds) => mln.LatLngBounds(
    southwest: mln.LatLng(latitude: bounds.south, longitude: bounds.west),
    northeast: mln.LatLng(latitude: bounds.north, longitude: bounds.east),
  );

  static mln.EdgeInsets _edgeInsets(EdgeInsets padding) => mln.EdgeInsets(
    top: padding.top,
    left: padding.left,
    bottom: padding.bottom,
    right: padding.right,
  );

  /// Counts [_setStyle] calls, so a style that loads after a newer one was
  /// set is dropped.
  var _styleRequest = 0;

  /// Loads [style], see [MapOptions.style].
  Future<void> _setStyle(MapStyle style) async {
    final map = _map;
    if (map == null) return;
    final request = ++_styleRequest;
    bool stale() => _map != map || request != _styleRequest;
    _layerManager = null;
    switch (style) {
      case MapStyleJson(:final json):
        await map.setStyleJson(jsonDecode(json));
      case MapStyleUrl(:final url):
        await map.setStyleUrl(url);
      case MapStyleFile(:final path):
        await map.setStyleUrl(Uri.file(path).toString());
      case MapStyleAsset(:final asset):
        final json = await DefaultAssetBundle.of(context).loadString(asset);
        if (stale()) return;
        await map.setStyleJson(jsonDecode(json));
    }
  }

  @override
  Future<List<RenderedFeature>> queryRenderedFeatures(
    QueryGeometry geometry, {
    List<String>? layerIds,
    Expression<bool>? filter,
  }) async {
    final renderer = _renderer;
    // No layers to query matches nothing, as on web.
    if (renderer == null || (layerIds != null && layerIds.isEmpty)) {
      return const [];
    }
    final features = await renderer.queryRenderedFeatures(
      switch (geometry) {
        QueryGeometryPoint(:final point) => mln.RenderedQueryGeometry.point(
          _screenPoint(point),
        ),
        QueryGeometryRect(:final rect) => _box(rect),
        QueryGeometryViewport() => _box(
          Offset.zero &
              Size(
                renderer.extent.width.toDouble(),
                renderer.extent.height.toDouble(),
              ),
        ),
      },
      layerIds: layerIds,
      filter: filter?.toJson(),
    );
    return [
      for (final queried in features)
        if (queried.feature case final Map<String, Object?> feature)
          RenderedFeature(
            id: feature['id'],
            properties: _properties(feature),
            geometry: RenderedFeature.geometryFromJson(feature['geometry']),
            sourceId: _nonEmpty(queried.sourceId),
            sourceLayer: _nonEmpty(queried.sourceLayerId),
            layerId: _nonEmpty(queried.layerId),
          ),
    ];
  }
}

/// The properties of a GeoJSON [feature], or none.
Map<String, Object?> _properties(Map<String, Object?> feature) =>
    switch (feature['properties']) {
      final Map<String, Object?> properties => properties,
      _ => const {},
    };

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
      .._cancelAnimation()
      .._gestureActive = true
      .._nextChangeReason = CameraChangeReason.gesture;
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

  /// Continues a flick with the same pan inertia as web, in logical pixels.
  @override
  void gestureEnd({Velocity velocity = Velocity.zero}) {
    if (!_state._gestureActive) return;
    _state
      .._gestureActive = false
      .._applyDelta(const mln.CameraDelta(gesturePhase: mln.GesturePhase.end));
    const minFlingSpeed = 100.0;
    const linearity = 0.3;
    const maxFlingSpeed = 1400.0;
    const deceleration = 2500.0;
    final speed = velocity.pixelsPerSecond.distance;
    if (!speed.isFinite || speed < minFlingSpeed) {
      _state._onCameraIdle();
      return;
    }
    final flingSpeed = min(speed * linearity, maxFlingSpeed);
    final seconds = flingSpeed / (deceleration * linearity);
    final offset =
        velocity.pixelsPerSecond / speed * (flingSpeed * seconds / 2);
    _state._applyDelta(
      mln.CameraDelta(
        offset: MapLibreMapStateNative._screenPoint(offset),
        animation: mln.AnimationOptions(
          durationMs: seconds * 1000,
          easing: const mln.UnitBezier(x2: 0.3, y2: 1),
        ),
      ),
    );
  }

  @override
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  }) {
    _state
      .._cancelAnimation()
      .._nextChangeReason = CameraChangeReason.gesture;
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

/// A camera animation of [MapLibreMapStateNative.animateCamera].
class _CameraAnimationRun {
  _CameraAnimationRun(this.target);

  /// The camera that the animation ends at.
  final mln.CameraOptions target;

  /// Whether a gesture or [MapController.stopCamera] cancelled it, which the
  /// map may report as completed.
  bool cancelled = false;

  final _result = Completer<CameraAnimationResult>();

  Future<CameraAnimationResult> get result => _result.future;

  void end(CameraAnimationResult result) {
    if (_result.isCompleted) return;
    _result.complete(cancelled ? CameraAnimationResult.cancelled : result);
  }
}

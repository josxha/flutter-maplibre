import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'dart:ui_web';

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/camera_padding_reset.dart';
import 'package:maplibre_web/src/extensions.dart';
import 'package:maplibre_web/src/frame_sync.dart';
import 'package:maplibre_web/src/interop/interop.dart' as interop;
import 'package:maplibre_web/src/interop/json.dart';
import 'package:maplibre_web/src/loader.dart';
import 'package:web/web.dart' hide PointerEvent;

part 'style_controller.dart';

/// The web specific implementation of the [MapLibreMap] widget.
final class MapLibreMapStateWeb extends MapLibreMapState {
  late HTMLDivElement _htmlElement;
  late interop.JsMap _map;

  /// maplibre-gl-js is loaded, so the platform view can create [_map].
  var _jsLoaded = false;

  /// The platform view created [_map].
  var _mapCreated = false;

  /// The running [animateCamera], whose moves carry its id.
  _WebCameraAnimation? _animation;
  var _animationIds = 0;
  final _cameraPaddingReset = CameraPaddingReset();
  bool _nextGestureCausedByController = false;
  LayerManager? _layerManager;

  /// The attributions that the widgets in [MapLibreMap.children] last saw.
  List<String> _attributions = const [];

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
  late final GestureCameraSink gestureCamera =
      FrameAlignedGestureCamera.isNeeded
      ? FrameAlignedGestureCamera(_WebGestureCamera(this))
      : _WebGestureCamera(this);

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

      _map = interop.JsMap(
        interop.MapOptions(
          container: _htmlElement,
          style: _jsStyle(options.style),
          attributionControl: false,
          // MapGestureDetector handles the input.
          interactive: false,
        ),
      );
      _mapCreated = true;

      document.body?.appendChild(_htmlElement);
      // Invoke the onMapCreated callback async to avoid getting it called
      // during the widget build.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // The map has the size of its platform view only now, so bounds are
        // fitted again for it.
        if (options.initCamera case final CameraUpdateFit initCamera) {
          _resizeMap();
          _applyInitialCamera(initCamera);
        }
        widget.onMapCreated?.call(this);
        _onLoadingStarted();
        setState(() => isInitialized = true);
      });
      _resizeMap();

      // set options
      _map.setMinZoom(options.minZoom);
      _map.setMaxZoom(options.maxZoom);
      _map.setMinPitch(options.minPitch);
      _map.setMaxPitch(options.maxPitch);
      _map.setMaxBounds(options.maxBounds?.toJs());
      // Without an initial camera, the map takes the style's camera once it
      // loads.
      if (options.initCamera case final initCamera?) {
        _applyInitialCamera(initCamera);
      }

      // add callbacks
      _map.on(
        interop.MapEventType.load,
        (interop.MapMouseEvent event) {
          _onStyleLoaded();
        }.toJS,
      );
      _map.on(
        interop.MapEventType.data,
        (interop.MapDataEvent event) {
          if (event.dataType == 'source' &&
              event.sourceDataType == 'metadata') {
            if (event.sourceId case final sourceId?) {
              widget.onSourceChanged?.call(
                MapEventSourceChanged(sourceId: sourceId),
              );
            }
          }
          // The events on which the gl-js attribution control updates.
          if (event.dataType == 'style' ||
              event.sourceDataType == 'metadata' ||
              event.sourceDataType == 'visibility') {
            _onAttributionsMaybeChanged();
          }
          if (event.sourceDataType == 'metadata') style?.refreshTileJson();
        }.toJS,
      );
      _map.on(
        interop.MapEventType.idle,
        (interop.MapMouseEvent event) {
          widget.onIdle?.call(const MapEventIdle());
          if (_loading) {
            _loading = false;
            widget.onLoadingFinished?.call(const MapEventLoadingFinished());
          }
        }.toJS,
      );
      _map.on(
        interop.MapEventType.error,
        (interop.MapErrorEvent event) {
          final error = event.error;
          final message = switch (error) {
            final error? => (error as interop.JsError).message ?? '$error',
            null => 'Unknown error',
          };
          final sourceId = event.sourceId;
          final onError = widget.onError;
          if (onError == null) {
            debugPrint('maplibre_web: $message');
            return;
          }
          onError(
            MapEventError(
              kind: sourceId == null ? MapErrorKind.other : MapErrorKind.source,
              message: message,
              sourceId: sourceId,
            ),
          );
        }.toJS,
      );
      _map.on(
        interop.MapEventType.styleImageMissing,
        (interop.MapStyleImageMissingEvent event) {
          widget.onStyleImageMissing?.call(
            MapEventStyleImageMissing(id: event.id),
          );
        }.toJS,
      );
      _map.on(
        interop.MapEventType.webglContextLost,
        (interop.MapLibreEvent event) {
          widget.onContextLost?.call(const MapEventContextLost());
        }.toJS,
      );
      _map.on(
        interop.MapEventType.webglContextRestored,
        (interop.MapLibreEvent event) {
          widget.onContextRestored?.call(const MapEventContextRestored());
        }.toJS,
      );
      _map.on(
        interop.MapEventType.projectionTransition,
        (interop.MapProjectionEvent event) {
          final projection = event.newProjection.dartify();
          widget.onProjectionChanged?.call(
            MapEventProjectionChanged(
              // gl-js reports a globe that shows Mercator at the current
              // zoom level as `globe-mercator`.
              projection: switch (projection) {
                'globe' => MapProjection.globe,
                'vertical-perspective' => MapProjection.verticalPerspective,
                _ => MapProjection.mercator,
              },
            ),
          );
        }.toJS,
      );
      _updateRenderListener();
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
            reason = CameraChangeReason.gesture;
          } else if (_nextGestureCausedByController) {
            _nextGestureCausedByController = false;
            reason = CameraChangeReason.programmatic;
          } else {
            reason = CameraChangeReason.map;
          }
          _moveReason = reason;
          widget.onCameraMoveStart?.call(
            MapEventCameraMoveStart(reason: reason),
          );
        }.toJS,
      );
      _map.on(
        interop.MapEventType.move,
        (interop.MapLibreEvent event) {
          if (!_cameraPaddingReset.shouldForward(event)) return;
          if (_silentCamera) return;
          final mapCamera = getCamera();
          setState(() => camera = mapCamera);
          widget.onCameraMove?.call(
            MapEventCameraMove(camera: mapCamera, reason: _moveReason),
          );
        }.toJS,
      );
      _map.on(
        interop.MapEventType.moveEnd,
        (interop.MapLibreEvent event) {
          if (!_cameraPaddingReset.shouldForward(event)) return;
          final animation = _animation;
          if (animation != null &&
              _CameraAnimationEventData._(event).flutterMapLibreAnimation ==
                  animation.id) {
            _endAnimation(CameraAnimationResult.completed);
          }
          if (_silentCamera || _gestureMoving) return;
          _onCameraMoveEnd();
        }.toJS,
      );

      return _htmlElement;
    });
    document.addEventListener('contextmenu', _onContextMenu);
    super.initState();
    _jsLoaded = isMapLibreGlJsLoaded;
    if (_jsLoaded) return;
    loadMapLibreGlJs().then(
      (_) {
        if (mounted) setState(() => _jsLoaded = true);
      },
      onError: (Object error, StackTrace stackTrace) =>
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: error,
              stack: stackTrace,
              library: 'maplibre_web',
              context: ErrorDescription('while loading maplibre-gl-js'),
            ),
          ),
    );
  }

  @override
  Widget buildPlatformWidget(BuildContext context) => Listener(
    behavior: HitTestBehavior.opaque,
    onPointerDown: _onPointerDown,
    onPointerUp: _onPointerEnd,
    onPointerCancel: _onPointerEnd,
    // An opaque platform view joins the gesture arena first and wins every
    // pointer the arena sweeps, as a single tap is, so taps would never reach
    // the map's gesture detector.
    // The platform view creates the map, which needs maplibre-gl-js.
    child: _jsLoaded
        ? HtmlElementView(
            viewType: viewName,
            hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          )
        : const SizedBox.expand(),
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
    _endAnimation(CameraAnimationResult.cancelled);
    document.removeEventListener('contextmenu', _onContextMenu);
    _contextMenuTimer?.cancel();
    style?.dispose();
    if (_mapCreated) {
      _map.remove();
      _htmlElement.remove();
    }
    super.dispose();
  }

  /// maplibre-gl-js renders only when the map changes, and the browser skips
  /// hidden elements, so a hidden map costs little.
  @override
  bool get canPauseRendering => false;

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    // The map takes the options of the widget once it is created.
    if (!_mapCreated) return super.didUpdateWidget(oldWidget);
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
      _map.setMaxBounds(options.maxBounds?.toJs());
    }
    if (options.style != oldWidget.options.style) _setStyle(options.style);
    _layerManager?.updateLayers(widget.layers);
    _updateRenderListener();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Geographic toLngLat(Offset screenLocation) =>
      _map.unproject(screenLocation.toJs()).toGeographic();

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) => screenLocations
      .map((offset) => _map.unproject(offset.toJs()).toGeographic())
      .toList(growable: false);

  @override
  Offset toScreenLocation(Geographic lngLat) =>
      _map.project(lngLat.toJs()).toOffset();

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) => lngLats
      .map((lngLat) => _map.project(lngLat.toJs()).toOffset())
      .toList(growable: false);

  @override
  Future<void> moveCamera(CameraUpdate update) async {
    final target = _targetReplacing(update, CameraAnimationResult.cancelled);
    // A move stops a running animation, even if there is nowhere to move.
    if (target == null) return stopCamera();
    _nextGestureCausedByController = true;
    _map.jumpTo(target as interop.JumpToOptions);
  }

  @override
  Future<CameraAnimationResult> animateCamera(
    CameraUpdate update, {
    CameraAnimation animation = const CameraAnimation.ease(),
  }) async {
    // A later animation takes over, which completes the running one.
    final target = _targetReplacing(update, CameraAnimationResult.completed);
    if (target == null) return CameraAnimationResult.cancelled;
    target['easing'] = animation.curve.transform.toJS;
    switch (animation) {
      case CameraAnimationEase(:final duration):
        target['duration'] = (duration.inMicroseconds / 1000).toJS;
      case CameraAnimationFly(:final duration, :final speed, :final peakZoom):
        if (duration != null) {
          target['duration'] = (duration.inMicroseconds / 1000).toJS;
        }
        target['speed'] = speed.toJS;
        if (peakZoom != null) target['minZoom'] = peakZoom.toJS;
    }
    final run = _animation = _WebCameraAnimation(++_animationIds);
    final eventData = _CameraAnimationEventData(
      flutterMapLibreAnimation: run.id,
    );
    _nextGestureCausedByController = true;
    // The animation ends synchronously when it jumps, for example if the
    // browser prefers reduced motion, so [run] is set before it starts.
    switch (animation) {
      case CameraAnimationEase():
        _map.easeTo(target as interop.EaseToOptions, eventData);
      case CameraAnimationFly():
        _map.flyTo(target as interop.FlyToOptions, eventData);
    }
    return run.result;
  }

  @override
  Future<void> stopCamera() async {
    if (_animation == null) return;
    _endAnimation(CameraAnimationResult.cancelled);
    _map.stop();
  }

  @override
  Future<CameraPosition> cameraFor(CameraUpdate update) async {
    final current = getCamera();
    final target = _target(update, resetPadding: false);
    if (target == null) return current;
    T? field<T extends JSAny>(String name) =>
        target.has(name) ? target[name] as T? : null;
    final padding = field<interop.PaddingOptions>('padding');
    return CameraPosition(
      center: field<interop.LngLat>('center')?.toGeographic() ?? current.center,
      zoom: field<JSNumber>('zoom')?.toDartDouble ?? current.zoom,
      bearing: field<JSNumber>('bearing')?.toDartDouble ?? current.bearing,
      pitch: field<JSNumber>('pitch')?.toDartDouble ?? current.pitch,
      roll: field<JSNumber>('roll')?.toDartDouble ?? current.roll,
      padding: padding?.toEdgeInsets() ?? current.padding,
    );
  }

  /// The [_target] of [update], which ends the running animation with
  /// [result]. If there is no target, the animation keeps running, unless
  /// working out the target stopped it.
  JSObject? _targetReplacing(
    CameraUpdate update,
    CameraAnimationResult result,
  ) {
    final previous = _animation;
    // Moves that stop the running animation don't complete it as reaching
    // its target.
    _animation = null;
    _targetStoppedCamera = false;
    final target = _target(update);
    if (target == null && !_targetStoppedCamera) {
      _animation = previous;
    } else {
      // Nothing takes over when the padding reset stopped the camera but
      // there is no target, so the running animation was cancelled.
      previous?.end(target == null ? CameraAnimationResult.cancelled : result);
    }
    return target;
  }

  /// Whether the last [_target] reset the padding, which stops the camera.
  var _targetStoppedCamera = false;

  /// The gl-js camera options that move the map to [update], with only the
  /// fields that change, or null if a fit target doesn't fit the map.
  ///
  /// With [resetPadding], the padding of earlier camera moves is reset
  /// before a target is fitted, which stops a running animation.
  JSObject? _target(CameraUpdate update, {bool resetPadding = true}) {
    final options = JSObject();
    switch (update) {
      case CameraUpdatePosition(:final center, :final padding, :final anchor):
        if (center != null) options['center'] = center.toJs();
        if (update.zoom case final zoom?) options['zoom'] = zoom.toJS;
        if (update.bearing case final bearing?) {
          options['bearing'] = bearing.toJS;
        }
        if (update.pitch case final pitch?) options['pitch'] = pitch.toJS;
        if (update.roll case final roll?) options['roll'] = roll.toJS;
        if (padding != null) options['padding'] = padding.toJs();
        if (anchor != null) {
          options['around'] = _map.unproject(anchor.toJs());
        }
      case CameraUpdateFit():
        final padding = update.padding.toJs();
        if (resetPadding) {
          // MapLibre GL JS fits bounds into the padding of earlier camera
          // moves as well, so that padding is reset first.
          final container = _map.getContainer();
          if (!_cameraPaddingReset.runBeforeFitBounds(
            camera: _map,
            viewportWidth: container.clientWidth,
            viewportHeight: container.clientHeight,
            fitPadding: padding,
          )) {
            return null;
          }
          _targetStoppedCamera = true;
        }
        final pitch = update.pitch ?? _map.getPitch();
        final camera = _map.cameraForBounds(
          update.bounds.toJs(),
          interop.FitBoundsOptions(
            padding: padding,
            bearing: update.bearing ?? _map.getBearing(),
            pitch: pitch,
            // An explicit null would reach gl-js as a max zoom of 0.
            maxZoom: update.maxZoom ?? double.maxFinite,
          ),
        );
        if (camera == null) return null;
        options['center'] = camera.center;
        options['zoom'] = camera.zoom.toJS;
        options['bearing'] = camera.bearing.toJS;
        options['pitch'] = (camera.pitch ?? pitch).toJS;
    }
    return options;
  }

  /// Ends the running [animateCamera] with [result].
  void _endAnimation(CameraAnimationResult result) {
    final animation = _animation;
    _animation = null;
    animation?.end(result);
  }

  @override
  CameraPosition getCamera() => CameraPosition(
    center: _map.getCenter().toGeographic(),
    zoom: _map.getZoom().toDouble(),
    pitch: _map.getPitch().toDouble(),
    bearing: _map.getBearing().toDouble(),
    roll: _map.getRoll().toDouble(),
    padding: _map.getPadding().toEdgeInsets(),
  );

  /// https://wiki.openstreetmap.org/wiki/Zoom_levels
  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      earthCircumferenceWgs84 *
      cos(latitude * degree2Radian) /
      pow(2, _map.getZoom() + 9);

  @override
  GeoBox getVisibleBounds() {
    final bounds = _map.getBounds();
    return GeoBox(
      west: bounds.getWest().toDouble(),
      south: bounds.getSouth().toDouble(),
      east: bounds.getEast().toDouble(),
      north: bounds.getNorth().toDouble(),
    );
  }

  @override
  Future<List<RenderedFeature>> queryRenderedFeatures(
    QueryGeometry geometry, {
    List<String>? layerIds,
    Expression<bool>? filter,
  }) async {
    if (!mounted) return const [];
    // Only set fields go into the options, since gl-js reads an explicit
    // null as a value.
    final options = JSObject();
    if (layerIds != null) {
      options['layers'] = layerIds.map((l) => l.toJS).toList().toJS;
    }
    if (filter != null) options['filter'] = filter.toJson().jsify();
    final features = switch (geometry) {
      QueryGeometryPoint(:final point) => _map.queryRenderedFeatures(
        point.toJs(),
        options,
      ),
      QueryGeometryRect(:final rect) => _map.queryRenderedFeaturesRect(
        [rect.bottomLeft.toJs(), rect.topRight.toJs()].toJS,
        options,
      ),
      QueryGeometryViewport() => _map.queryRenderedFeaturesAll(options),
    };
    return [for (final f in features.toDart) f.toRenderedFeature()];
  }

  @override
  Future<List<SourceFeature>> querySourceFeatures(
    String sourceId, {
    String? sourceLayer,
    Expression<bool>? filter,
  }) async {
    // gl-js throws for a source that the style doesn't have.
    if (!mounted || _map.getSource(sourceId) == null) return const [];
    final options = JSObject();
    if (sourceLayer != null) options['sourceLayer'] = sourceLayer.toJS;
    if (filter != null) options['filter'] = filter.toJson().jsify();
    return _map
        .querySourceFeatures(sourceId, options)
        .toDart
        // gl-js leaves the source layer of source features unset, and all of
        // them come from the queried one.
        .map(
          (f) => f.toSourceFeature(sourceLayer: f.sourceLayer ?? sourceLayer),
        )
        .toList(growable: false);
  }

  @override
  Future<double> getClusterExpansionZoom(String sourceId, int clusterId) async {
    final source = _clusterSource(sourceId);
    if (source == null) {
      throw StateError('The map has no GeoJSON source "$sourceId".');
    }
    return (await source.getClusterExpansionZoom(clusterId).toDart)
        .toDartDouble;
  }

  @override
  Future<List<SourceFeature>> getClusterChildren(
    String sourceId,
    int clusterId,
  ) async {
    final source = _clusterSource(sourceId);
    if (source == null) return const [];
    return [
      for (final f
          in (await source.getClusterChildren(clusterId).toDart).toDart)
        f.toSourceFeature(),
    ];
  }

  @override
  Future<List<SourceFeature>> getClusterLeaves(
    String sourceId,
    int clusterId, {
    int limit = 10,
    int offset = 0,
  }) async {
    final source = _clusterSource(sourceId);
    if (source == null) return const [];
    final leaves = await source
        .getClusterLeaves(clusterId, limit, offset)
        .toDart;
    return [for (final f in leaves.toDart) f.toSourceFeature()];
  }

  /// The GeoJSON source [sourceId], or null if the map is gone or has none.
  interop.SourceSpecification? _clusterSource(String sourceId) {
    if (!mounted) return null;
    final source = _map.getSource(sourceId);
    if (source == null || source.type != 'geojson') return null;
    return source;
  }

  /// Moves the camera of the new map to [initCamera] before its first frame.
  void _applyInitialCamera(CameraUpdate initCamera) {
    final target = _target(initCamera, resetPadding: false);
    if (target != null) _map.jumpTo(target as interop.JumpToOptions);
  }

  JSAny _jsStyle(MapStyle style) => switch (style) {
    MapStyleJson(:final json) =>
      (jsonDecode(json) as Map<String, dynamic>).jsify() ??
          (throw StateError('Failed to convert style JSON to JS object.')),
    MapStyleUrl(:final url) => url.toJS,
    MapStyleAsset(:final asset) => AssetManager().getAssetUrl(asset).toJS,
    MapStyleFile() => throw UnsupportedError(
      'MapStyle.file is not supported on web, use MapStyle.url or '
      'MapStyle.asset.',
    ),
  };

  /// Loads [style], see [MapOptions.style].
  void _setStyle(MapStyle style) {
    // Only the next LayerManager sees MapLibreMap.layers: the layers of the
    // old one go with the old style.
    _layerManager = null;
    _map.once(
      interop.MapEventType.styleLoad,
      (JSAny _) {
        _onStyleLoaded();
      }.toJS,
    );
    _map.setStyle(_jsStyle(style));
    _onLoadingStarted();
  }

  /// Whether a style loads, until the next idle event, see
  /// [MapLibreMap.onLoadingFinished].
  var _loading = false;

  void _onLoadingStarted() {
    _loading = true;
    widget.onLoadingStarted?.call(const MapEventLoadingStarted());
  }

  /// Why the camera moves, from the start of the move on.
  CameraChangeReason _moveReason = CameraChangeReason.map;

  void _onCameraMoveEnd() {
    widget.onCameraMoveEnd?.call(
      MapEventCameraMoveEnd(camera: getCamera(), reason: _moveReason),
    );
  }

  /// The listener of the render event, which fires for every frame, so it
  /// is only registered while [MapLibreMap.onRenderFrame] is set.
  JSExportedDartFunction? _renderListener;

  void _updateRenderListener() {
    final listens = widget.onRenderFrame != null;
    if (listens == (_renderListener != null)) return;
    if (listens) {
      final listener = (interop.MapLibreEvent event) {
        widget.onRenderFrame?.call(const MapEventRenderFrame());
      }.toJS;
      _renderListener = listener;
      _map.on(interop.MapEventType.render, listener);
    } else {
      _map.off(interop.MapEventType.render, _renderListener!);
      _renderListener = null;
    }
  }

  void _onStyleLoaded() {
    _layerManager = null;
    style?.dispose();
    final styleCtrl = StyleControllerWeb(_map)..load();
    style = styleCtrl;
    widget.onStyleLoaded?.call(styleCtrl);
    _layerManager = LayerManager(styleCtrl, widget.layers);
    _attributions = styleCtrl.attributions;
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  /// Rebuilds the widgets in [MapLibreMap.children], such as
  /// `SourceAttribution`, when the attributions of the style changed.
  void _onAttributionsMaybeChanged() {
    final style = this.style;
    if (style == null || !mounted) return;
    final attributions = style.attributions;
    if (listEquals(attributions, _attributions)) return;
    setState(() => _attributions = attributions);
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
    if (!_state._mapCreated) return;
    _state._endAnimation(CameraAnimationResult.cancelled);
    // Catches a fling, whose end then reports the end of its move.
    _map.stop();
    _state
      .._gestureMoving = true
      .._gestureMoveStarted = false;
  }

  @override
  void gestureUpdate(GestureCameraUpdate update) {
    if (!_state._mapCreated) return;
    if (update.pans) {
      // Puts the location under the pointer where the pointer is now, which
      // keeps it under the pointer in every projection.
      _map.easeTo(
        interop.EaseToOptions(
          center: _map.unproject(update.panFrom!.toJs()),
          offset: (update.panTo! - _mapCenter).toJs(),
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
    final location = _map.unproject(around.toJs());
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
            offset: (around - _mapCenter).toJs(),
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
      _state._onCameraMoveEnd();
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
        offset: (velocity / velocity.distance * distance).toJs(),
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
    if (!_state._mapCreated) return;
    // Ends a running animation before working out the target, so that its
    // end is reported.
    _state._endAnimation(CameraAnimationResult.cancelled);
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

/// A running [MapLibreMapStateWeb.animateCamera], whose moves carry [id] in
/// their event data.
class _WebCameraAnimation {
  _WebCameraAnimation(this.id);

  final int id;
  final _result = Completer<CameraAnimationResult>();

  Future<CameraAnimationResult> get result => _result.future;

  void end(CameraAnimationResult result) {
    if (!_result.isCompleted) _result.complete(result);
  }
}

/// The event data that tags the moves of an animation.
@anonymous
@JS()
extension type _CameraAnimationEventData._(JSObject _) implements JSObject {
  external factory _CameraAnimationEventData({
    required int flutterMapLibreAnimation,
  });

  external int? get flutterMapLibreAnimation;
}

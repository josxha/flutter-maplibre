import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' hide Layer;
import 'package:flutter/services.dart';
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/jni/jni.dart' as jni;
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateAndroid extends MapLibreMapState
    implements pigeon.MapLibreFlutterApi {
  late final pigeon.MapLibreHostApi _hostApi;
  late final int _viewId;
  jni.MapLibreMap? _cachedJniMapLibreMap;
  jni.Projection? _cachedJniProjection;
  jni.LocationComponent? _cachedLocationComponent;
  jni.Style? _cachedJniStyle;
  LayerManager? _annotationManager;

  MapOptions get _options => widget.options;

  jni.MapLibreMap get _jniMapLibreMap =>
      _cachedJniMapLibreMap ??= jni.MapLibreRegistry.INSTANCE.getMap(_viewId);

  jni.Projection get _jniProjection =>
      _cachedJniProjection ??= _jniMapLibreMap.getProjection();

  jni.Style? get _jniStyle {
    if (_cachedJniStyle != null) return _cachedJniStyle;
    final style = _jniMapLibreMap.getStyle$1();
    if (style.isNull) return null;
    return _cachedJniStyle ??= style;
  }

  jni.LocationComponent get _locationComponent =>
      _cachedLocationComponent ??= _jniMapLibreMap.getLocationComponent();

  @override
  Widget buildPlatformWidget(BuildContext context) {
    const viewType = 'plugins.flutter.io/maplibre';
    final mode = _options.androidMode;
    if (mode == AndroidPlatformViewMode.tlhc_vd) {
      return AndroidView(
        viewType: viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
      );
    }
    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: widget.gestureRecognizers ??
              const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        final viewController = switch (mode) {
          // This attempts to use the newest and most efficient platform view
          // implementation when possible. In cases where that is not
          // supported, it falls back to using Hybrid Composition, which is
          // the mode used by initExpensiveAndroidView.
          // https://api.flutter.dev/flutter/services/PlatformViewsService/initSurfaceAndroidView.html
          // https://github.com/flutter/flutter/blob/master/docs/platforms/android/Android-Platform-Views.md#selecting-a-mode
          AndroidPlatformViewMode.tlhc_hc =>
            PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              onFocus: () => params.onFocusChanged(true),
            ),
          AndroidPlatformViewMode.tlhc_vd =>
            PlatformViewsService.initAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              onFocus: () => params.onFocusChanged(true),
            ),
          AndroidPlatformViewMode.hc =>
            PlatformViewsService.initExpensiveAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              onFocus: () => params.onFocusChanged(true),
            ),
          // https://github.com/flutter/flutter/blob/master/docs/platforms/android/Virtual-Display.md
          AndroidPlatformViewMode.vd => PlatformViewsService.initAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              onFocus: () => params.onFocusChanged(true),
            ),
        };
        return viewController
          ..addOnPlatformViewCreatedListener((id) {
            params.onPlatformViewCreated(id);
            _onPlatformViewCreated(id);
          })
          ..create();
      },
    );
  }

  /// This method gets called when the platform view is created. It is not
  /// guaranteed that the map is ready.
  void _onPlatformViewCreated(int viewId) {
    final channelSuffix = viewId.toString();
    _hostApi = pigeon.MapLibreHostApi(messageChannelSuffix: channelSuffix);
    pigeon.MapLibreFlutterApi.setUp(this, messageChannelSuffix: channelSuffix);
    _viewId = viewId;
    jni.Logger.setVerbosity(jni.Logger.WARN);
  }

  @override
  void onMapReady() {
    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
    setState(() {
      camera = getCamera();
      isInitialized = true;
    });
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _updateOptions(oldWidget);
    _annotationManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cachedJniStyle?.release();
    _cachedJniProjection?.release();
    _cachedJniMapLibreMap?.release();
    _cachedLocationComponent?.release();
    super.dispose();
  }

  Future<void> _updateOptions(MapLibreMap oldWidget) async {
    final jniMap = _jniMapLibreMap;
    // jniMap can be null if the widget rebuilds while the map hasn't been initialized.
    if (jniMap.isNull) return;

    final oldOptions = oldWidget.options;
    final options = _options;
    await runOnPlatformThread(() {
      jniMap.setMinZoomPreference(options.minZoom);
      jniMap.setMaxZoomPreference(options.maxZoom);
      jniMap.setMinPitchPreference(options.minPitch);
      jniMap.setMaxPitchPreference(options.maxPitch);

      // map bounds
      final oldBounds = oldOptions.maxBounds;
      final newBounds = options.maxBounds;
      if (oldBounds != null && newBounds == null) {
        // TODO @Nullable latLngBounds, https://github.com/dart-lang/native/issues/1644
        // _jniMapLibreMap.setLatLngBoundsForCameraTarget(null);
      } else if ((oldBounds == null && newBounds != null) ||
          (newBounds != null && oldBounds != newBounds)) {
        final bounds = newBounds.toLatLngBounds();
        jniMap.setLatLngBoundsForCameraTarget(bounds);
      }

      // gestures
      final uiSettings = jniMap.getUiSettings();
      if (options.gestures.rotate != oldOptions.gestures.rotate) {
        uiSettings.setRotateGesturesEnabled(options.gestures.rotate);
      }
      // TODO: pan is not handled, there is no setPanGestureEnabled on Android.
      /*if (options.gestures.pan != oldOptions.gestures.pan) {
        uiSettings.setRotateGesturesEnabled(options.gestures.pan);
      }*/
      if (options.gestures.zoom != oldOptions.gestures.zoom) {
        uiSettings.setZoomGesturesEnabled(options.gestures.zoom);
        uiSettings.setDoubleTapGesturesEnabled(options.gestures.zoom);
        uiSettings.setScrollGesturesEnabled(options.gestures.zoom);
        uiSettings.setQuickZoomGesturesEnabled(options.gestures.zoom);
      }
      if (options.gestures.pitch != oldOptions.gestures.pitch) {
        uiSettings.setTiltGesturesEnabled(options.gestures.pitch);
      }
      uiSettings.release();
    });
  }

  @override
  pigeon.MapOptions getOptions() => pigeon.MapOptions(
        style: _options.initStyle,
        bearing: _options.initBearing,
        zoom: _options.initZoom,
        pitch: _options.initPitch,
        center: _options.initCenter == null
            ? null
            : pigeon.LngLat(
                lng: _options.initCenter!.lng.toDouble(),
                lat: _options.initCenter!.lat.toDouble(),
              ),
        minZoom: _options.minZoom,
        maxZoom: _options.maxZoom,
        minPitch: _options.minPitch,
        maxPitch: _options.maxPitch,
        maxBounds: _options.maxBounds?.toLngLatBounds(),
        gestures: pigeon.MapGestures(
          rotate: _options.gestures.rotate,
          pan: _options.gestures.pan,
          zoom: _options.gestures.zoom,
          tilt: _options.gestures.pitch,
        ),
        compass: _options.nativeCompass,
        logo: _options.nativeLogo,
        attribution: _options.attribution,
        androidTextureMode: _options.androidTextureMode,
      );

  @override
  Future<Position> toLngLat(Offset screenLocation) async {
    final jniProjection = _jniProjection;
    return runOnPlatformThread<Position>(() {
      return jniProjection
          .fromScreenLocation(screenLocation.toPointF())
          .toPosition(releaseOriginal: true);
    });
  }

  @override
  Future<Offset> toScreenLocation(Position lngLat) async {
    final jniProjection = _jniProjection;
    return runOnPlatformThread<Offset>(() {
      return jniProjection
          .toScreenLocation(lngLat.toLatLng())
          .toOffset(releaseOriginal: true);
    });
  }

  @override
  Future<List<Position>> toLngLats(List<Offset> screenLocations) async {
    final jniProjection = _jniProjection;
    return runOnPlatformThread<List<Position>>(() {
      return screenLocations.map((screenLocation) {
        return jniProjection
            .fromScreenLocation(screenLocation.toPointF())
            .toPosition(releaseOriginal: true);
      }).toList(growable: false);
    });
  }

  @override
  Future<List<Offset>> toScreenLocations(List<Position> lngLats) async {
    final jniProjection = _jniProjection;
    return runOnPlatformThread<List<Offset>>(() {
      return lngLats.map((lngLat) {
        return jniProjection
            .toScreenLocation(lngLat.toLatLng())
            .toOffset(releaseOriginal: true);
      }).toList(growable: false);
    });
  }

  @override
  Future<void> moveCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    final jniMap = _jniMapLibreMap;
    final cameraPositionBuilder = jni.CameraPosition_Builder();
    if (center != null) cameraPositionBuilder.target(center.toLatLng());
    if (zoom != null) cameraPositionBuilder.zoom(zoom);
    if (pitch != null) cameraPositionBuilder.tilt(pitch);
    if (bearing != null) cameraPositionBuilder.bearing(bearing);

    final cameraPosition = cameraPositionBuilder.build();
    cameraPositionBuilder.release();
    final cameraUpdate =
        jni.CameraUpdateFactory.newCameraPosition(cameraPosition);
    await runOnPlatformThread(() {
      final completer = Completer<void>();
      jniMap.moveCamera(cameraUpdate);
      // TODO: jni causes sometimes a deadlock, complete immediately for now
      completer.complete();
      /*jniMap.moveCamera$1(
        cameraUpdate,
        jni.MapLibreMap_CancelableCallback.implement(
          jni.$MapLibreMap_CancelableCallback(
            onCancel: () =>
                completer.completeError(Exception('Animation cancelled.')),
            onFinish: completer.complete,
            onFinish$async: true,
            onCancel$async: true,
          ),
        ),
      );*/
      return completer.future;
    });
    cameraUpdate.release();
  }

  @override
  Future<void> animateCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  }) async {
    final jniMap = _jniMapLibreMap;
    final cameraPositionBuilder = jni.CameraPosition_Builder();
    if (center != null) cameraPositionBuilder.target(center.toLatLng());
    if (zoom != null) cameraPositionBuilder.zoom(zoom);
    if (pitch != null) cameraPositionBuilder.tilt(pitch);
    if (bearing != null) cameraPositionBuilder.bearing(bearing);

    final cameraPosition = cameraPositionBuilder.build();
    cameraPositionBuilder.release();
    final cameraUpdate =
        jni.CameraUpdateFactory.newCameraPosition(cameraPosition);

    await runOnPlatformThread(() async {
      final completer = Completer<void>();
      jniMap.animateCamera$2(cameraUpdate, nativeDuration.inMilliseconds);
      // TODO: jni causes sometimes a deadlock, complete immediately for now
      completer.complete();
      /*jniMap.animateCamera$3(
        cameraUpdate,
        nativeDuration.inMilliseconds,
        jni.MapLibreMap_CancelableCallback.implement(
          jni.$MapLibreMap_CancelableCallback(
            onCancel: () =>
                completer.completeError(Exception('Animation cancelled.')),
            onFinish: completer.complete,
            onFinish$async: true,
            onCancel$async: true,
          ),
        ),
      );*/
      return completer.future;
    });
    cameraUpdate.release();
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
    final jniMap = _jniMapLibreMap;
    final latLngBounds = bounds.toLatLngBounds();
    final cameraUpdate = jni.CameraUpdateFactory.newLatLngBounds$3(
      latLngBounds,
      bearing ?? -1.0,
      pitch ?? -1.0,
      padding.left.toInt(),
      padding.top.toInt(),
      padding.right.toInt(),
      padding.bottom.toInt(),
    );
    latLngBounds.release();

    await runOnPlatformThread(() {
      final completer = Completer<void>();
      jniMap.animateCamera$2(cameraUpdate, nativeDuration.inMilliseconds);
      // TODO: jni causes sometimes a deadlock, complete immediately for now
      completer.complete();
      /*jniMap.animateCamera$3(
        cameraUpdate,
        nativeDuration.inMilliseconds,
        jni.MapLibreMap_CancelableCallback.implement(
          jni.$MapLibreMap_CancelableCallback(
            onCancel: () =>
                completer.completeError(Exception('Animation cancelled.')),
            onFinish: completer.complete,
            onCancel$async: true,
            onFinish$async: true,
          ),
        ),
      );*/
      return completer.future;
    });
    cameraUpdate.release();
  }

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    // TODO: use JNI for this method
    await switch (layer) {
      FillStyleLayer() => _hostApi.addFillLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      CircleStyleLayer() => _hostApi.addCircleLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      BackgroundStyleLayer() => _hostApi.addBackgroundLayer(
          id: layer.id,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      FillExtrusionStyleLayer() => _hostApi.addFillExtrusionLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      HeatmapStyleLayer() => _hostApi.addHeatmapLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      HillshadeStyleLayer() => _hostApi.addHillshadeLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      LineStyleLayer() => _hostApi.addLineLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      RasterStyleLayer() => _hostApi.addRasterLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      SymbolStyleLayer() => _hostApi.addSymbolLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      _ => throw UnimplementedError(
          'The Layer is not supported: ${layer.runtimeType}',
        ),
    };
  }

  @override
  Future<void> addSource(Source source) async {
    final jniStyle = _jniStyle;
    final jniId = source.id.toJString();
    await runOnPlatformThread(() {
      final jni.Source jniSource;
      switch (source) {
        case GeoJsonSource():
          final jniOptions = jni.GeoJsonOptions();
          final jniData = source.data.toJString();
          if (source.data.startsWith('{')) {
            jniSource = jni.GeoJsonSource.new$4(jniId, jniData, jniOptions);
          } else {
            final jniUri = jni.URI.create(jniData);
            jniSource = jni.GeoJsonSource.new$8(jniId, jniUri, jniOptions);
            jniUri.release();
          }
          jniOptions.release();
        case RasterDemSource():
          jniSource = jni.RasterDemSource.new$4(
            jniId,
            source.url!.toJString(),
            source.tileSize,
          );
          // TODO apply other properties
          jniSource.setVolatile(source.volatile.toJBoolean());
        case RasterSource():
          if (source.url case final String url) {
            jniSource =
                jni.RasterSource.new$4(jniId, url.toJString(), source.tileSize);
          } else {
            final tilesArray = JArray(JString.type, source.tiles!.length);
            for (var i = 0; i < source.tiles!.length; i++) {
              tilesArray[i] = source.tiles![i].toJString();
            }
            final tileSet = jni.TileSet('{}'.toJString(), tilesArray)
              ..setMaxZoom(source.maxZoom)
              ..setMinZoom(source.minZoom);
            jniSource = jni.RasterSource.new$6(jniId, tileSet, source.tileSize);
            tilesArray.release();
            tileSet.release();
          }
          // TODO apply other properties
          jniSource.setVolatile(source.volatile.toJBoolean());
        case VectorSource():
          jniSource = jni.VectorSource.new$3(jniId, source.url!.toJString());
          // TODO apply other properties
          jniSource.setVolatile(source.volatile.toJBoolean());
        case ImageSource():
          final jniQuad = jni.LatLngQuad(
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
          );
          final jniUri = jni.URI(source.url.toJString());
          jniSource = jni.ImageSource.new$2(jniId, jniQuad, jniUri);
          jniUri.release();
          jniQuad.release();
        case VideoSource():
          throw UnimplementedError('Video source is only supported on web.');
        default:
          throw UnimplementedError(
            'The Source is not supported: ${source.runtimeType}',
          );
      }
      jniStyle?.addSource(jniSource);
      jniSource.release();
    });
  }

  @override
  void onStyleLoaded() {
    // We need to refresh the cached style for when the style reloads.
    if (_cachedJniStyle?.isNull ?? false) _cachedJniStyle?.release();
    _cachedJniStyle = _jniMapLibreMap.getStyle$1();

    widget.onEvent?.call(const MapEventStyleLoaded());
    widget.onStyleLoaded?.call();
    _annotationManager = LayerManager(this, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  @override
  void onMoveCamera(pigeon.MapCamera camera) {
    final mapCamera = MapCamera(
      center: camera.center.toPosition(),
      zoom: camera.zoom,
      pitch: camera.pitch,
      bearing: camera.bearing,
    );
    setState(() => this.camera = mapCamera);
    widget.onEvent?.call(MapEventMoveCamera(camera: mapCamera));
  }

  @override
  void onStartMoveCamera(pigeon.CameraChangeReason reason) {
    final changeReason = switch (reason) {
      pigeon.CameraChangeReason.apiAnimation => CameraChangeReason.apiAnimation,
      pigeon.CameraChangeReason.apiGesture => CameraChangeReason.apiGesture,
      pigeon.CameraChangeReason.developerAnimation =>
        CameraChangeReason.developerAnimation,
    };
    widget.onEvent?.call(MapEventStartMoveCamera(reason: changeReason));
  }

  @override
  void onIdle() => widget.onEvent?.call(const MapEventIdle());

  @override
  void onCameraIdle() => widget.onEvent?.call(const MapEventCameraIdle());

  @override
  void onDoubleClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
  }

  @override
  void onSecondaryClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
  }

  @override
  void onClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
  }

  @override
  void onLongClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventLongClick(point: position));
  }

  @override
  MapCamera getCamera() {
    final jniCamera = _jniMapLibreMap.getCameraPosition();
    final jniTarget = jniCamera.target;
    final mapCamera = MapCamera(
      center: Position(jniTarget.getLongitude(), jniTarget.getLatitude()),
      zoom: jniCamera.zoom,
      pitch: jniCamera.tilt,
      bearing: jniCamera.bearing,
    );
    // camera = mapCamera;
    jniTarget.release();
    jniCamera.release();
    return mapCamera;
  }

  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async {
    final jniProjection = _jniProjection;
    return runOnPlatformThread(() {
      return jniProjection.getMetersPerPixelAtLatitude(latitude);
    });
  }

  @override
  Future<LngLatBounds> getVisibleRegion() async {
    final projection = _jniProjection; // necessary to use it in platform thread
    final jniBounds = await runOnPlatformThread<jni.LatLngBounds>(() {
      final region = projection.getVisibleRegion();
      final bounds = region.latLngBounds;
      region.release();
      return bounds;
    });
    final bounds = jniBounds.toLngLatBounds(releaseOriginal: true);
    return bounds;
  }

  @override
  Future<void> removeLayer(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle?.removeLayer(id.toJString());
    });
  }

  @override
  Future<void> removeSource(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle?.removeSource(id.toJString());
    });
  }

  @override
  Future<void> addImage(String id, Uint8List bytes) =>
      // TODO: use JNI for this method
      _hostApi.addImage(id, bytes);

  @override
  Future<void> removeImage(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle?.removeImage(id.toJString());
    });
  }

  @override
  Future<List<QueriedLayer>> queryLayers(Offset screenLocation) async {
    // https://maplibre.org/maplibre-gl-js/docs/examples/queryQueriedLayers/
    final jniMapLibreMap = _jniMapLibreMap;
    final jniStyle = _jniStyle;
    if (jniStyle == null) return [];

    final result = await runOnPlatformThread<List<QueriedLayer>>(() {
      final jniLayers = jniStyle.getLayers();
      final queriedLayers = <QueriedLayer>[];
      for (var i = jniLayers.length - 1; i >= 0; i--) {
        final jniLayer = jniLayers[i];
        JString? jLayerId;
        late final JString jSourceId;
        late final JString jSourceLayer;
        switch (jniLayer.jClass.toString()) {
          case 'class org.maplibre.android.style.layers.LineLayer':
            final layer = jniLayer.as(jni.LineLayer.type);
            jLayerId = layer.getId();
            jSourceId = layer.getSourceId();
            jSourceLayer = layer.getSourceLayer();
            layer.release();
          case 'class org.maplibre.android.style.layers.FillLayer':
            final layer = jniLayer.as(jni.FillLayer.type);
            jLayerId = layer.getId();
            jSourceId = layer.getSourceId();
            jSourceLayer = layer.getSourceLayer();
            layer.release();
          case 'class org.maplibre.android.style.layers.SymbolLayer':
            final layer = jniLayer.as(jni.SymbolLayer.type);
            jLayerId = layer.getId();
            jSourceId = layer.getSourceId();
            jSourceLayer = layer.getSourceLayer();
            layer.release();
        }
        jniLayer.release();
        if (jLayerId == null) continue; // ignore all other layers

        final queryLayerIds = JArray(JString.type, 1)..[0] = jLayerId;
        final jniFeatures = jniMapLibreMap.queryRenderedFeatures(
          jni.PointF.new$1(screenLocation.dx, screenLocation.dy),
          queryLayerIds, // query one layer at a time
        );
        queryLayerIds.release();
        if (jniFeatures.isEmpty) continue; // layer hasn't been clicked if empty
        jniFeatures.release();
        final sourceLayer = jSourceLayer.toDartString(releaseOriginal: true);
        final queriedLayer = QueriedLayer(
          layerId: jLayerId.toDartString(releaseOriginal: true),
          sourceId: jSourceId.toDartString(releaseOriginal: true),
          sourceLayer: sourceLayer.isEmpty ? null : sourceLayer,
        );
        queriedLayers.add(queriedLayer);
      }
      return queriedLayers;
    });
    return result;
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final jniStyle = _jniStyle;
    if (jniStyle == null) return;
    await runOnPlatformThread(() {
      final source =
          jniStyle.getSourceAs(id.toJString(), T: jni.GeoJsonSource.type);
      source.setGeoJson$3(data.toJString());
    });
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
    // https://maplibre.org/maplibre-native/docs/book/android/location-component-guide.html
    final locationComponent = _locationComponent;
    final jniStyle = _jniStyle;
    if (jniStyle == null) return;

    final bearing = switch (bearingRenderMode) {
      BearingRenderMode.none => jni.RenderMode.NORMAL,
      BearingRenderMode.compass => jni.RenderMode.COMPASS,
      BearingRenderMode.gps => jni.RenderMode.GPS,
    };
    final jniContext = jni.MapLibreRegistry.INSTANCE.getContext();
    final locationComponentOptionsBuilder =
        jni.LocationComponentOptions.builder(jniContext)
            .pulseFadeEnabled(pulseFade)
            .accuracyAnimationEnabled(accuracyAnimation)
            .compassAnimationEnabled(compassAnimation.toJBoolean())
            .pulseEnabled(pulse);
    final locationComponentOptions = locationComponentOptionsBuilder.build();
    final locationEngineRequestBuilder =
        jni.LocationEngineRequest_Builder(750) // TODO integrate as parameter
            .setFastestInterval(fastestInterval.inMilliseconds)
            .setMaxWaitTime(maxWaitTime.inMilliseconds)
            .setPriority(jni.LocationEngineRequest.PRIORITY_HIGH_ACCURACY);
    final locationEngineRequest = locationEngineRequestBuilder.build();
    final activationOptions =
        jni.LocationComponentActivationOptions.builder(jniContext, jniStyle)
            .locationComponentOptions(locationComponentOptions)
            .useDefaultLocationEngine(true)
            .locationEngineRequest(locationEngineRequest)
            .build();

    await runOnPlatformThread(() {
      locationComponent.activateLocationComponent(activationOptions);
      locationComponent.setRenderMode(bearing);
      locationComponent.setLocationComponentEnabled(true);
    });

    locationComponentOptionsBuilder.release();
    locationComponentOptions.release();
    locationEngineRequestBuilder.release();
    locationEngineRequest.release();
    activationOptions.release();
    jniContext.release();
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    final locationComponent = _locationComponent;
    final mode = switch (trackBearing) {
      BearingTrackMode.none => trackLocation
          ? jni.CameraMode.TRACKING // only location
          : jni.CameraMode.NONE, // neither location nor bearing
      BearingTrackMode.compass => trackLocation
          ? jni.CameraMode.TRACKING_COMPASS // location with compass bearing
          : jni.CameraMode.NONE_COMPASS, // only compass bearing
      BearingTrackMode.gps => trackLocation
          ? jni.CameraMode.TRACKING_GPS // location with gps bearing
          : jni.CameraMode.NONE_GPS, // only gps bearing
    };
    await runOnPlatformThread(() {
      locationComponent.setCameraMode(mode);
    });
  }

  @override
  Future<List<String>> getAttributions() async {
    // style can be null when the map hasn't finished initializing.
    final style = _jniStyle;
    if (style == null) return const [];

    return runOnPlatformThread<List<String>>(() {
      final jSources = style.getSources();
      final attributions = <String>[];
      for (final jSource in jSources) {
        final jniAttribution = jSource.getAttribution();
        if (jniAttribution.isNull) continue;
        final attribution = jniAttribution.toDartString(releaseOriginal: true);
        if (attribution.trim().isEmpty) continue;
        attributions.add(attribution);
      }
      jSources.release();
      return attributions;
    });
  }

  @override
  Position toLngLatSync(Offset screenLocation) =>
      throw UnimplementedError('toLngLatSync is only supported on web');

  @override
  List<Position> toLngLatsSync(List<Offset> screenLocations) =>
      throw UnimplementedError('toLngLatsSync is only supported on web');

  @override
  Offset toScreenLocationSync(Position lngLat) =>
      throw UnimplementedError('toScreenLocationSync is only supported on web');

  @override
  List<Offset> toScreenLocationsSync(List<Position> lngLats) =>
      throw UnimplementedError(
        'toScreenLocationsSync is only supported on web',
      );

  @override
  double getMetersPerPixelAtLatitudeSync(double latitude) =>
      throw UnimplementedError(
        'getMetersPerPixelAtLatitudeSync is only supported on web',
      );

  @override
  LngLatBounds getVisibleRegionSync() =>
      throw UnimplementedError('getVisibleRegionSync is only supported on web');
}

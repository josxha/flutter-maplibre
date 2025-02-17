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
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/jni/jni.dart' as jni;
import 'package:maplibre/src/platform/map_state_native.dart';
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;

part 'style_controller.dart';

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateAndroid extends MapLibreMapStateNative {
  late final pigeon.MapLibreHostApi _hostApi;
  late final int _viewId;
  jni.MapLibreMap? _cachedJniMapLibreMap;
  jni.Projection? _cachedJniProjection;
  jni.LocationComponent? _cachedLocationComponent;

  @override
  StyleControllerAndroid? style;

  jni.MapLibreMap? get _jniMapLibreMap =>
      _cachedJniMapLibreMap ??= jni.MapLibreRegistry.INSTANCE.getMap(_viewId);

  jni.Projection get _jniProjection =>
      _cachedJniProjection ??= _jniMapLibreMap!.getProjection();

  jni.LocationComponent get _locationComponent =>
      _cachedLocationComponent ??= _jniMapLibreMap!.getLocationComponent();

  @override
  Widget buildPlatformWidget(BuildContext context) {
    const viewType = 'plugins.flutter.io/maplibre';
    final mode = options.androidMode;
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
          gestureRecognizers:
              widget.gestureRecognizers ??
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
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _updateOptions(oldWidget);
    layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cachedJniProjection?.release();
    _cachedJniMapLibreMap?.release();
    _cachedLocationComponent?.release();
    super.dispose();
  }

  Future<void> _updateOptions(MapLibreMap oldWidget) async {
    final jniMap = _jniMapLibreMap;
    // jniMap can be null if the widget rebuilds while the map hasn't been initialized.
    if (jniMap == null) return;

    final oldOptions = oldWidget.options;
    final options = this.options;
    if (this.options == oldOptions) return;

    if (options.gestures.drag != oldOptions.gestures.drag) {
      await _hostApi.toggleLongPressMove(enabled: options.gestures.drag);
    }

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
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) async =>
      toLngLatSync(screenLocation);

  @override
  Future<Offset> toScreenLocation(Position lngLat) async =>
      toScreenLocationSync(lngLat);

  @override
  Future<List<Position>> toLngLats(List<Offset> screenLocations) async =>
      toLngLatsSync(screenLocations);

  @override
  Future<List<Offset>> toScreenLocations(List<Position> lngLats) async =>
      toScreenLocationsSync(lngLats);

  @override
  Future<void> moveCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    assert(_jniMapLibreMap != null, '_jniMapLibreMap needs to be not null.');
    final cameraPositionBuilder = jni.CameraPosition$Builder();
    if (center != null) cameraPositionBuilder.target(center.toLatLng());
    if (zoom != null) cameraPositionBuilder.zoom(zoom);
    if (pitch != null) cameraPositionBuilder.tilt(pitch);
    if (bearing != null) cameraPositionBuilder.bearing(bearing);

    final cameraPosition = cameraPositionBuilder.build();
    cameraPositionBuilder.release();
    final cameraUpdate = jni.CameraUpdateFactory.newCameraPosition(
      cameraPosition,
    );
    final completer = Completer<void>();
    _jniMapLibreMap?.moveCamera$1(
      cameraUpdate,
      jni.MapLibreMap$CancelableCallback.implement(
        jni.$MapLibreMap$CancelableCallback(
          onCancel:
              () => completer.completeError(Exception('Animation cancelled.')),
          onFinish: completer.complete,
          onCancel$async: true,
          onFinish$async: true,
        ),
      ),
    );
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
    final jniMap = _jniMapLibreMap!;
    final cameraPositionBuilder = jni.CameraPosition$Builder();
    if (center != null) cameraPositionBuilder.target(center.toLatLng());
    if (zoom != null) cameraPositionBuilder.zoom(zoom);
    if (pitch != null) cameraPositionBuilder.tilt(pitch);
    if (bearing != null) cameraPositionBuilder.bearing(bearing);

    final cameraPosition = cameraPositionBuilder.build();
    cameraPositionBuilder.release();
    final cameraUpdate = jni.CameraUpdateFactory.newCameraPosition(
      cameraPosition,
    );

    final completer = Completer<void>();
    jniMap.animateCamera$3(
      cameraUpdate,
      nativeDuration.inMilliseconds,
      jni.MapLibreMap$CancelableCallback.implement(
        jni.$MapLibreMap$CancelableCallback(
          onCancel:
              () => completer.completeError(Exception('Animation cancelled.')),
          onFinish: completer.complete,
          onFinish$async: true,
          onCancel$async: true,
        ),
      ),
    );
    final result = await completer.future;
    cameraUpdate.release();
    return result;
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
    final jniMap = _jniMapLibreMap!;
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

    final completer = Completer<void>();
    jniMap.animateCamera$3(
      cameraUpdate,
      nativeDuration.inMilliseconds,
      jni.MapLibreMap$CancelableCallback.implement(
        jni.$MapLibreMap$CancelableCallback(
          onCancel:
              () => completer.completeError(Exception('Animation cancelled.')),
          onFinish: completer.complete,
          onCancel$async: true,
          onFinish$async: true,
        ),
      ),
    );
    final result = await completer.future;
    cameraUpdate.release();
    return result;
  }

  @override
  void onStyleLoaded() {
    // We need to refresh the cached style for when the style reloads.
    style?.dispose();
    final styleCtrl = StyleControllerAndroid._(
      _jniMapLibreMap!.getStyle$1()!,
      _hostApi,
    );
    style = styleCtrl;

    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  @override
  MapCamera getCamera() {
    final jniCamera = _jniMapLibreMap!.getCameraPosition();
    final jniTarget = jniCamera.target!;
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
  Future<double> getMetersPerPixelAtLatitude(double latitude) async =>
      getMetersPerPixelAtLatitudeSync(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async => getVisibleRegionSync();

  @override
  Future<List<QueriedLayer>> queryLayers(Offset screenLocation) async {
    if (_jniMapLibreMap == null) {
      throw Exception(
        "queryLayers can't be called before the map is initialized.",
      );
    }
    final style = this.style;
    // there are no sources without a loaded style.
    if (style == null) return [];

    final jniLayers = style._getLayers();
    final queriedLayers = <QueriedLayer>[];
    for (var i = jniLayers.length - 1; i >= 0; i--) {
      final jniLayer = jniLayers[i]!;
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

      final queryLayerIds = JArray<JString?>(JString.nullableType, 1)
        ..[0] = jLayerId;
      // query one layer at a time
      final jniFeatures = _jniMapLibreMap!.queryRenderedFeatures(
        jni.PointF.new$1(screenLocation.dx, screenLocation.dy),
        queryLayerIds,
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
  }

  @override
  Future<List<Feature>> queryRenderedFeatures(
    Offset screenLocation, {
    List<String>? layerIdsFilter,
  }) async {
    final jniMapLibreMap = _jniMapLibreMap!;
    final style = this.style;
    if (style == null) return [];

    final result = await runOnPlatformThread<List<Feature>>(() {
      final JArray<JString?> queryLayerIds;

      if (layerIdsFilter != null) {
        queryLayerIds = JArray(JString.nullableType, layerIdsFilter.length);

        for (final (i, layer) in layerIdsFilter.indexed) {
          queryLayerIds[i] = layer.toJString();
        }
      } else {
        queryLayerIds = style._getLayersIds();
      }

      final queryResultsFeatures = jniMapLibreMap.queryRenderedFeatures(
        jni.PointF.new$1(screenLocation.dx, screenLocation.dy),
        queryLayerIds,
      );
      queryLayerIds.release();

      final features =
          queryResultsFeatures.nonNulls.map((f) => f.toFeature()).toList();
      queryResultsFeatures.release();

      return features;
    });
    return result;
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
    final style = this.style;
    if (style == null) return;

    final bearing = switch (bearingRenderMode) {
      BearingRenderMode.none => jni.RenderMode.NORMAL,
      BearingRenderMode.compass => jni.RenderMode.COMPASS,
      BearingRenderMode.gps => jni.RenderMode.GPS,
    };
    final jniContext = jni.MapLibreRegistry.INSTANCE.getContext()!;
    final locOptionsBuilder =
        jni.LocationComponentOptions.builder(jniContext)
            .pulseFadeEnabled(pulseFade)!
            .accuracyAnimationEnabled(accuracyAnimation)!
            .compassAnimationEnabled(compassAnimation.toJBoolean())!
            .pulseEnabled(pulse)!;
    final locOptions = locOptionsBuilder.build();
    final locationEngineRequestBuilder =
        jni.LocationEngineRequest$Builder(750) // TODO integrate as parameter
            .setFastestInterval(fastestInterval.inMilliseconds)!
            .setMaxWaitTime(maxWaitTime.inMilliseconds)!
            .setPriority(jni.LocationEngineRequest.PRIORITY_HIGH_ACCURACY)!;
    final locationEngineRequest = locationEngineRequestBuilder.build();
    final activationOptionsBuilder =
        jni.LocationComponentActivationOptions.builder(
              jniContext,
              style._jniStyle,
            )
            .locationComponentOptions(locOptions)!
            .useDefaultLocationEngine(true)!
            .locationEngineRequest(locationEngineRequest)!;
    final activationOptions = activationOptionsBuilder.build()!;

    _locationComponent.activateLocationComponent(activationOptions);
    _locationComponent.setRenderMode(bearing);
    _locationComponent.setLocationComponentEnabled(true);

    activationOptionsBuilder.release();
    locOptionsBuilder.release();
    locOptions.release();
    locationEngineRequestBuilder.release();
    locationEngineRequest?.release();
    activationOptions.release();
    jniContext.release();
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    final mode = switch (trackBearing) {
      BearingTrackMode.none =>
        trackLocation
            ? jni
                .CameraMode
                .TRACKING // only location
            : jni.CameraMode.NONE, // neither location nor bearing
      BearingTrackMode.compass =>
        trackLocation
            ? jni
                .CameraMode
                .TRACKING_COMPASS // location with compass bearing
            : jni.CameraMode.NONE_COMPASS, // only compass bearing
      BearingTrackMode.gps =>
        trackLocation
            ? jni
                .CameraMode
                .TRACKING_GPS // location with gps bearing
            : jni.CameraMode.NONE_GPS, // only gps bearing
    };
    _locationComponent.setCameraMode(mode);
  }

  @override
  Position toLngLatSync(Offset screenLocation) => _jniProjection
      .fromScreenLocation(screenLocation.toPointF())
      .toPosition(releaseOriginal: true);

  @override
  List<Position> toLngLatsSync(List<Offset> screenLocations) =>
      screenLocations.map(toLngLatSync).toList(growable: false);

  @override
  Offset toScreenLocationSync(Position lngLat) => _jniProjection
      .toScreenLocation(lngLat.toLatLng())
      .toOffset(releaseOriginal: true);

  @override
  List<Offset> toScreenLocationsSync(List<Position> lngLats) =>
      lngLats.map(toScreenLocationSync).toList(growable: false);

  @override
  double getMetersPerPixelAtLatitudeSync(double latitude) =>
      _jniProjection.getMetersPerPixelAtLatitude(latitude);

  @override
  LngLatBounds getVisibleRegionSync() {
    final region = _jniProjection.getVisibleRegion();
    final jniBounds = region.latLngBounds;
    region.release();
    final bounds = jniBounds.toLngLatBounds(releaseOriginal: true);
    return bounds;
  }
}

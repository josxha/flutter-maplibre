import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' hide Layer;
import 'package:flutter/services.dart';
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/flutter_api.dart';
import 'package:maplibre/src/platform/android/functions.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;
import 'package:maplibre/src/platform/android/registry.dart';
import 'package:maplibre/src/platform/map_state_native.dart';

part 'style_controller.dart';

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateAndroid extends MapLibreMapStateNative
    with jni.$OnMapReadyCallback, jni.$Style$OnStyleLoaded {
  late final int _viewId;
  late final jni.MapView _mapView;
  jni.MapLibreMap? _jMap;
  jni.Projection? _cachedJProjection;
  jni.LocationComponent? _cachedJLocationComponent;

  @override
  StyleControllerAndroid? style;

  jni.FrameLayout get _platformView => Registry.platformViews[_viewId]!;

  jni.Projection get _jProjection =>
      _cachedJProjection ??= _jMap!.getProjection();

  jni.LocationComponent get _jLocationComponent =>
      _cachedJLocationComponent ??= _jMap!.getLocationComponent();

  @override
  Widget buildPlatformWidget(BuildContext context) {
    const viewType = 'plugins.flutter.io/maplibre';
    jni.MapLibreRegistry.INSTANCE.setFlutterApi(
      jni.FlutterApi.implement(const FlutterApi()),
    );

    if (options.androidMode == AndroidPlatformViewMode.tlhc_vd) {
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
        final viewController = switch (options.androidMode) {
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
  void _onPlatformViewCreated(int viewId) => using((arena) {
    _viewId = viewId;
    final jContext = getJContext();
    final cameraBuilder = jni.CameraPosition$Builder()
      ..releasedBy(arena)
      ..zoom(options.initZoom)
      ..bearing(options.initBearing)
      ..tilt(options.initPitch);
    if (options.initCenter case final Geographic center) {
      cameraBuilder.target(center.toLatLng()..releasedBy(arena));
    }
    final jMapOptions = jni.MapLibreMapOptions.createFromAttributes(jContext)
      ..releasedBy(arena)
      ..attributionEnabled(false)
      ..logoEnabled(false)
      ..compassEnabled(false)
      // TODO: textureMode comes at a significant performance penalty, https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.maps/-map-libre-map-options/texture-mode.html
      ..textureMode(options.androidTextureMode)
      ..foregroundLoadColor(options.androidForegroundLoadColor.toARGB32())
      ..translucentTextureSurface(options.androidTranslucentTextureSurface)
      ..minZoomPreference(options.minZoom)
      ..maxZoomPreference(options.maxZoom)
      ..minPitchPreference(options.minPitch)
      ..maxPitchPreference(options.maxPitch)
      ..rotateGesturesEnabled(options.gestures.rotate)
      ..zoomGesturesEnabled(options.gestures.zoom)
      ..doubleTapGesturesEnabled(options.gestures.zoom)
      ..scrollGesturesEnabled(options.gestures.zoom)
      ..quickZoomGesturesEnabled(options.gestures.zoom)
      ..tiltGesturesEnabled(options.gestures.pitch)
      ..camera(cameraBuilder.build()..releasedBy(arena));
    _mapView = jni.MapView.new$4(jContext, jMapOptions)
      ..getMapAsync(jni.OnMapReadyCallback.implement(this));
    _platformView.addView(_mapView);
  });

  @override
  void onMapReady(jni.MapLibreMap jMap) => using((arena) {
    _jMap = jMap
      ..addOnMapClickListener(
        jni.MapLibreMap$OnMapClickListener.implement(
          jni.$MapLibreMap$OnMapClickListener(
            onMapClick: (latLng) => using((arena) {
              latLng.releasedBy(arena);
              final screenLocation = _jProjection.toScreenLocation(latLng)
                ..releasedBy(arena);
              final pixelRatio = 1 / MediaQuery.devicePixelRatioOf(context);
              widget.onEvent?.call(
                MapEventClick(
                  point: latLng.toGeographic(),
                  screenPoint: screenLocation.toOffset() / pixelRatio,
                ),
              );
              return true;
            }),
          ),
        ),
      )
      ..addOnMapLongClickListener(
        jni.MapLibreMap$OnMapLongClickListener.implement(
          jni.$MapLibreMap$OnMapLongClickListener(
            onMapLongClick: (latLng) => using((arena) {
              latLng.releasedBy(arena);
              final screenLocation = _jProjection.toScreenLocation(latLng)
                ..releasedBy(arena);
              final pixelRatio = 1 / MediaQuery.devicePixelRatioOf(context);
              widget.onEvent?.call(
                MapEventLongClick(
                  point: latLng.toGeographic(),
                  screenPoint: screenLocation.toOffset() / pixelRatio,
                ),
              );
              return true;
            }),
          ),
        ),
      )
      ..addOnCameraMoveListener(
        jni.MapLibreMap$OnCameraMoveListener.implement(
          jni.$MapLibreMap$OnCameraMoveListener(
            onCameraMove: () => using((arena) {
              final mapCamera = getCamera();
              setState(() => camera = mapCamera);
              widget.onEvent?.call(MapEventMoveCamera(camera: mapCamera));
            }),
          ),
        ),
      )
      ..addOnCameraIdleListener(
        jni.MapLibreMap$OnCameraIdleListener.implement(
          jni.$MapLibreMap$OnCameraIdleListener(
            onCameraIdle: () => using((arena) {
              widget.onEvent?.call(const MapEventCameraIdle());
            }),
          ),
        ),
      )
      ..addOnCameraMoveStartedListener(
        jni.MapLibreMap$OnCameraMoveStartedListener.implement(
          jni.$MapLibreMap$OnCameraMoveStartedListener(
            onCameraMoveStarted: (reason) => using((arena) {
              final moveReason = switch (reason) {
                jni
                    .MapLibreMap$OnCameraMoveStartedListener
                    .REASON_API_GESTURE =>
                  CameraChangeReason.apiGesture,
                jni
                    .MapLibreMap$OnCameraMoveStartedListener
                    .REASON_API_ANIMATION =>
                  CameraChangeReason.apiAnimation,
                jni
                    .MapLibreMap$OnCameraMoveStartedListener
                    .REASON_DEVELOPER_ANIMATION =>
                  CameraChangeReason.developerAnimation,
                _ => null,
              };
              if (moveReason == null) return;
              widget.onEvent?.call(
                MapEventStartMoveCamera(reason: moveReason),
              );
            }),
          ),
        ),
      )
      ..setLatLngBoundsForCameraTarget(
        options.maxBounds?.toJLatLngBounds(arena: arena),
      );
    setStyle(options.initStyle);
    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
    setState(() {
      camera = getCamera();
      isInitialized = true;
    });
  });

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _updateOptions(oldWidget);
    layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _jMap?.release();
    _cachedJProjection?.release();
    _cachedJLocationComponent?.release();
    super.dispose();
  }

  Future<void> _updateOptions(MapLibreMap oldWidget) async => using((arena) {
    final jMap = _jMap;
    // jMap can be null if the widget rebuilds while the map hasn't been initialized.
    if (jMap == null) return;

    final oldOptions = oldWidget.options;
    final options = this.options;
    if (this.options == oldOptions) return;

    jMap.setMinZoomPreference(options.minZoom);
    jMap.setMaxZoomPreference(options.maxZoom);
    jMap.setMinPitchPreference(options.minPitch);
    jMap.setMaxPitchPreference(options.maxPitch);

    // map bounds
    final oldBounds = oldOptions.maxBounds;
    final newBounds = options.maxBounds;
    if (oldBounds != null && newBounds == null) {
      jMap.setLatLngBoundsForCameraTarget(null);
    } else if ((oldBounds == null && newBounds != null) ||
        (newBounds != null && oldBounds != newBounds)) {
      final bounds = newBounds.toJLatLngBounds(arena: arena);
      jMap.setLatLngBoundsForCameraTarget(bounds);
    }

    // gestures
    final uiSettings = jMap.getUiSettings()..releasedBy(arena);
    if (options.gestures.rotate != oldOptions.gestures.rotate) {
      uiSettings.setRotateGesturesEnabled(options.gestures.rotate);
    }
    // TODO: pan is not handled, there is no setPanGestureEnabled on Android.
    /*if (options.gestures.pan != oldOptions.gestures.pan) {
        uiSettings.setPanGesturesEnabled(options.gestures.pan);
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
  });

  @override
  void moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) => using((arena) {
    assert(_jMap != null, '_jMapLibreMap needs to be not null.');
    final cameraPosBuilder = jni.CameraPosition$Builder()..releasedBy(arena);
    if (center != null) cameraPosBuilder.target(center.toLatLng());
    if (zoom != null) cameraPosBuilder.zoom(zoom);
    if (pitch != null) cameraPosBuilder.tilt(pitch);
    if (bearing != null) cameraPosBuilder.bearing(bearing);

    final cameraPosition = cameraPosBuilder.build()..releasedBy(arena);
    final cameraUpdate = jni.CameraUpdateFactory.newCameraPosition(
      cameraPosition,
    )..releasedBy(arena);
    _jMap?.moveCamera(cameraUpdate);
    _jMap?.triggerRepaint();
  });

  @override
  Future<void> animateCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  }) async => using((arena) async {
    final jMap = _jMap!;
    final cameraPosBuilder = jni.CameraPosition$Builder()..releasedBy(arena);
    if (center != null) cameraPosBuilder.target(center.toLatLng());
    if (zoom != null) cameraPosBuilder.zoom(zoom);
    if (pitch != null) cameraPosBuilder.tilt(pitch);
    if (bearing != null) cameraPosBuilder.bearing(bearing);

    final cameraUpdate = jni.CameraUpdateFactory.newCameraPosition(
      cameraPosBuilder.build()..releasedBy(arena),
    )..releasedBy(arena);

    final completer = Completer<void>();
    jMap.animateCamera$3(
      cameraUpdate,
      nativeDuration.inMilliseconds,
      jni.MapLibreMap$CancelableCallback.implement(
        _CameraMovementCallback(WeakReference(completer)),
      )..releasedBy(arena),
    );
    return completer.future;
  });

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
  }) async => using((arena) async {
    final jMap = _jMap!;
    final cameraUpdate = jni.CameraUpdateFactory.newLatLngBounds$3(
      bounds.toJLatLngBounds(arena: arena),
      bearing ?? -1.0,
      pitch ?? -1.0,
      padding.left.toInt(),
      padding.top.toInt(),
      padding.right.toInt(),
      padding.bottom.toInt(),
    )..releasedBy(arena);

    final completer = Completer<void>();
    jMap.animateCamera$3(
      cameraUpdate,
      nativeDuration.inMilliseconds,
      jni.MapLibreMap$CancelableCallback.implement(
        _CameraMovementCallback(WeakReference(completer)),
      )..releasedBy(arena),
    );
    return completer.future;
  });

  @override
  void onStyleLoaded(jni.Style jStyle) {
    // We need to refresh the cached style for when the style reloads.
    style?.dispose();
    final styleCtrl = StyleControllerAndroid._(jStyle);
    style = styleCtrl;

    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  @override
  MapCamera getCamera() => using((arena) {
    final jniCamera = _jMap!.getCameraPosition()..releasedBy(arena);
    final jniTarget = jniCamera.target!..releasedBy(arena);
    return MapCamera(
      center: Geographic(
        lon: jniTarget.getLongitude(),
        lat: jniTarget.getLatitude(),
      ),
      zoom: jniCamera.zoom,
      pitch: jniCamera.tilt,
      bearing: jniCamera.bearing,
    );
    // camera = mapCamera;
  });

  List<RenderedFeature> _nativeQueryToRenderedFeatures(
    JList<jni.Feature?> query,
  ) {
    final features = query.where((f) => f != null).map((f) => f!);

    final gson = jni.Gson();
    return features
        .map(
          (feature) => RenderedFeature(
            id: feature.id()?.toDartString(releaseOriginal: true),
            properties:
                jsonDecode(
                      gson.toJson(feature.properties())?.toString() ?? '{}',
                    )
                    as Map<String, Object?>,
          ),
        )
        .toList(growable: false);
  }

  @override
  List<RenderedFeature> featuresAtPoint(
    Offset point, {
    List<String>? layerIds,
  }) {
    final style = this.style;
    final map = _jMap;
    if (style == null || map == null) {
      return [];
    }
    if (layerIds?.isEmpty ?? false) {
      // https://github.com/maplibre/maplibre-native/issues/2828
      return [];
    }

    final scaledPoint = point * MediaQuery.devicePixelRatioOf(context);

    final query = map.queryRenderedFeatures(
      jni.PointF.new$3(scaledPoint.dx, scaledPoint.dy),
      layerIds != null
          ? JArray.of(
              JString.nullableType,
              layerIds.map((s) => s.toJString()),
            )
          : null,
    );

    return _nativeQueryToRenderedFeatures(query);
  }

  @override
  List<RenderedFeature> featuresInRect(
    Rect rect, {
    List<String>? layerIds,
  }) {
    final style = this.style;
    final map = _jMap;
    if (style == null || map == null) {
      return [];
    }
    if (layerIds?.isEmpty ?? false) {
      // https://github.com/maplibre/maplibre-native/issues/2828
      return [];
    }

    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final scaledRect = Rect.fromLTRB(
      rect.left * devicePixelRatio,
      rect.top * devicePixelRatio,
      rect.right * devicePixelRatio,
      rect.bottom * devicePixelRatio,
    );

    final query = map.queryRenderedFeatures$2(
      jni.RectF.new$3(
        scaledRect.left,
        scaledRect.top,
        scaledRect.right,
        scaledRect.bottom,
      ),
      layerIds != null
          ? JArray.of(
              JString.nullableType,
              layerIds.map((s) => s.toJString()),
            )
          : null,
    );

    return _nativeQueryToRenderedFeatures(query);
  }

  @override
  List<QueriedLayer> queryLayers(Offset screenLocation) => using((arena) {
    if (_jMap == null) {
      throw Exception(
        "queryLayers can't be called before the map is initialized.",
      );
    }
    final style = this.style;
    // there are no sources without a loaded style.
    if (style == null) return [];

    final jniLayers = style._getLayers()..releasedBy(arena);
    final queriedLayers = <QueriedLayer>[];
    for (var i = jniLayers.length - 1; i >= 0; i--) {
      final jniLayer = jniLayers[i]!..releasedBy(arena);
      JString? jLayerId;
      late final JString jSourceId;
      late final JString jSourceLayer;
      if (jniLayer.isA(jni.LineLayer.type)) {
        final layer = jniLayer.as(jni.LineLayer.type)..releasedBy(arena);
        jLayerId = layer.getId();
        jSourceId = layer.getSourceId();
        jSourceLayer = layer.getSourceLayer();
      } else if (jniLayer.isA(jni.FillLayer.type)) {
        final layer = jniLayer.as(jni.FillLayer.type)..releasedBy(arena);
        jLayerId = layer.getId();
        jSourceId = layer.getSourceId();
        jSourceLayer = layer.getSourceLayer();
      } else if (jniLayer.isA(jni.FillExtrusionLayer.type)) {
        final layer = jniLayer.as(jni.FillExtrusionLayer.type)
          ..releasedBy(arena);
        jLayerId = layer.getId();
        jSourceId = layer.getSourceId();
        jSourceLayer = layer.getSourceLayer();
      } else if (jniLayer.isA(jni.SymbolLayer.type)) {
        final layer = jniLayer.as(jni.SymbolLayer.type)..releasedBy(arena);
        jLayerId = layer.getId();
        jSourceId = layer.getSourceId();
        jSourceLayer = layer.getSourceLayer();
      } else if (jniLayer.isA(jni.CircleLayer.type)) {
        final layer = jniLayer.as(jni.CircleLayer.type)..releasedBy(arena);
        jLayerId = layer.getId();
        jSourceId = layer.getSourceId();
        jSourceLayer = layer.getSourceLayer();
      }
      if (jLayerId == null) continue; // ignore all other layers
      jLayerId.releasedBy(arena);
      jSourceId.releasedBy(arena);
      jSourceLayer.releasedBy(arena);

      final queryLayerIds = JArray<JString?>(JString.nullableType, 1)
        ..releasedBy(arena)
        ..[0] = jLayerId;
      // query one layer at a time
      final pixelRatio = MediaQuery.devicePixelRatioOf(context);
      final scaledPoint = (screenLocation * pixelRatio).toJPointF(arena: arena);
      final jniFeatures = _jMap!.queryRenderedFeatures(
        scaledPoint,
        queryLayerIds,
      )..releasedBy(arena);
      if (jniFeatures.isEmpty) continue; // layer hasn't been clicked if empty
      final sourceLayer = jSourceLayer.toDartString();
      final queriedLayer = QueriedLayer(
        layerId: jLayerId.toDartString(),
        sourceId: jSourceId.toDartString(),
        sourceLayer: sourceLayer.isEmpty ? null : sourceLayer,
      );
      queriedLayers.add(queriedLayer);
    }
    return queriedLayers;
  });

  @override
  Future<void> enableLocation({
    Duration fastestInterval = const Duration(milliseconds: 750),
    Duration maxWaitTime = const Duration(seconds: 1),
    bool pulseFade = true,
    bool accuracyAnimation = true,
    bool compassAnimation = true,
    bool pulse = true,
    BearingRenderMode bearingRenderMode = BearingRenderMode.gps,
  }) async => using((arena) {
    // https://maplibre.org/maplibre-native/docs/book/android/location-component-guide.html
    final style = this.style;
    if (style == null) return;

    final bearing = switch (bearingRenderMode) {
      BearingRenderMode.none => jni.RenderMode.NORMAL,
      BearingRenderMode.compass => jni.RenderMode.COMPASS,
      BearingRenderMode.gps => jni.RenderMode.GPS,
    };
    final jniContext = getJContext();
    final locOptionsBuilder =
        jni.LocationComponentOptions.builder(jniContext)
              .pulseFadeEnabled(pulseFade)!
              .accuracyAnimationEnabled(accuracyAnimation)!
              .compassAnimationEnabled(compassAnimation.toJBoolean())!
              .pulseEnabled(pulse)!
          ..releasedBy(arena);
    final locOptions = locOptionsBuilder.build()..releasedBy(arena);
    final locationEngineRequestBuilder =
        jni.LocationEngineRequest$Builder(750) // TODO integrate as parameter
              .setFastestInterval(fastestInterval.inMilliseconds)!
              .setMaxWaitTime(maxWaitTime.inMilliseconds)!
              .setPriority(jni.LocationEngineRequest.PRIORITY_HIGH_ACCURACY)!
          ..releasedBy(arena);
    final locationEngineRequest = locationEngineRequestBuilder.build()
      ?..releasedBy(arena);
    final activationOptionsBuilder =
        jni.LocationComponentActivationOptions.builder(
                jniContext,
                style._jStyle,
              )
              .locationComponentOptions(locOptions)!
              .useDefaultLocationEngine(true)!
              .locationEngineRequest(locationEngineRequest)!
          ..releasedBy(arena);
    final activationOptions = activationOptionsBuilder.build()!
      ..releasedBy(arena);

    _jLocationComponent.activateLocationComponent(activationOptions);
    _jLocationComponent.setRenderMode(bearing);
    _jLocationComponent.setLocationComponentEnabled(true);
  });

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    final mode = switch (trackBearing) {
      BearingTrackMode.none =>
        trackLocation
            // only location
            ? jni.CameraMode.TRACKING
            // neither location nor bearing
            : jni.CameraMode.NONE,

      BearingTrackMode.compass =>
        trackLocation
            // location with compass bearing
            ? jni.CameraMode.TRACKING_COMPASS
            // only compass bearing
            : jni.CameraMode.NONE_COMPASS,

      BearingTrackMode.gps =>
        trackLocation
            // location with gps bearing
            ? jni.CameraMode.TRACKING_GPS
            // only gps bearing
            : jni.CameraMode.NONE_GPS,
    };
    _jLocationComponent.setCameraMode(mode);
  }

  @override
  Geographic toLngLat(Offset screenLocation) => using(
    (arena) => _jProjection
        .fromScreenLocation(
          (screenLocation * MediaQuery.devicePixelRatioOf(context)).toJPointF(
            arena: arena,
          ),
        )
        .toGeographic(),
  );

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) =>
      screenLocations.map(toLngLat).toList(growable: false);

  @override
  Offset toScreenLocation(Geographic lngLat) => using((arena) {
    final screenLocation = _jProjection.toScreenLocation(
      lngLat.toLatLng()..releasedBy(arena),
    )..releasedBy(arena);
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return screenLocation.toOffset() / pixelRatio;
  });

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) =>
      lngLats.map(toScreenLocation).toList(growable: false);

  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      _jProjection.getMetersPerPixelAtLatitude(latitude);

  @override
  LngLatBounds getVisibleRegion() => using((arena) {
    final region = _jProjection.getVisibleRegion()..releasedBy(arena);
    final jniBounds = region.latLngBounds..releasedBy(arena);
    return jniBounds.toLngLatBounds();
  });

  /// Note, that [MapController.setStyle] is synchronous.
  @override
  Future<void> setStyle(String style) async => using((arena) async {
    final trimmed = style.trim();
    final builder = jni.Style$Builder()..releasedBy(arena);
    if (trimmed.startsWith('{')) {
      // Raw JSON
      builder.fromJson(trimmed.toJString()..releasedBy(arena));
    } else if (trimmed.startsWith('/')) {
      builder.fromUri('file://$trimmed'.toJString()..releasedBy(arena));
    } else if (!trimmed.startsWith('http://') &&
        !trimmed.startsWith('https://') &&
        !trimmed.startsWith('mapbox://')) {
      // flutter asset
      final content = await rootBundle.loadString(trimmed);
      builder.fromJson(content.toJString()..releasedBy(arena));
    } else {
      // URI
      builder.fromUri(trimmed.toJString()..releasedBy(arena));
    }
    _jMap?.setStyle$3(
      builder,
      jni.Style$OnStyleLoaded.implement(
        _StyleLoadedCallback(WeakReference(onStyleLoaded)),
      )..releasedBy(arena),
    );
  });
}

final class _CameraMovementCallback with jni.$MapLibreMap$CancelableCallback {
  const _CameraMovementCallback(this.weakCompleter);

  final WeakReference<Completer<void>> weakCompleter;

  @override
  void onCancel() => weakCompleter.target?.completeError(
    Exception('Map camera movement cancelled.'),
  );

  @override
  void onFinish() => weakCompleter.target?.complete();

  @override
  bool get onCancel$async => true;

  @override
  bool get onFinish$async => true;
}

final class _StyleLoadedCallback with jni.$Style$OnStyleLoaded {
  const _StyleLoadedCallback(this.weakCallback);

  final WeakReference<void Function(jni.Style jStyle)> weakCallback;

  @override
  void onStyleLoaded(jni.Style style) {
    weakCallback.target?.call(style);
  }
}

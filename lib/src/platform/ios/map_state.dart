import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/ios/extensions.dart';
import 'package:maplibre/src/platform/ios/flutter_api.dart';
import 'package:maplibre/src/platform/map_state_native.dart';
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;
import 'package:maplibre_ios/maplibre_ffi.dart' as ffi;
import 'package:objective_c/objective_c.dart';

part 'style_controller.dart';

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateIos extends MapLibreMapStateNative
    implements pigeon.MapLibreFlutterApi {
  late final pigeon.MapLibreHostApi _hostApi;
  late final int _viewId;
  ffi.MLNMapView? _ffiMap;

  @override
  StyleControllerIos? style;

  @override
  Widget buildPlatformWidget(BuildContext context) {
    const viewType = 'plugins.flutter.io/maplibre';
    ffi.MapLibreRegistry.setFlutterApi(createFlutterApi());

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      gestureRecognizers: widget.gestureRecognizers,
      onPlatformViewCreated: _onPlatformViewCreated,
    );
  }

  /// This method gets called when the platform view is created. It is not
  /// guaranteed that the map is ready.
  void _onPlatformViewCreated(int viewId) {
    _viewId = viewId;
    final ffiMap = _ffiMap = ffi.MLNMapView();

    final channelSuffix = viewId.toString();
    _hostApi = pigeon.MapLibreHostApi(messageChannelSuffix: channelSuffix);
    pigeon.MapLibreFlutterApi.setUp(this, messageChannelSuffix: channelSuffix);
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
  }) async {
    if (zoom != null) _ffiMap?.zoomLevel = zoom;
    final ffiCamera = _ffiMap!.camera;
    if (pitch != null) ffiCamera.pitch = pitch;
    if (bearing != null) ffiCamera.heading = bearing;
    if (center != null) {
      ffiCamera.centerCoordinate = center.toCLLocationCoordinate2D();
    }
    _ffiMap?.flyToCamera$1(
      ffiCamera,
      withDuration: nativeDuration.inMicroseconds / 1000000,
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
    _ffiMap?.showsUserLocation = true;
    // TODO: apply bearingRenderMode
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
    final ffiBounds = bounds.toMLNCoordinateBounds();
    // TODO support padding with Struct UIEdgeInsets
    _ffiMap?.setVisibleCoordinateBounds(ffiBounds, animated: true);
  }

  @override
  MapCamera getCamera() {
    final ffiCamera = _ffiMap!.camera;
    return MapCamera(
      center: ffiCamera.centerCoordinate.toGeographic(),
      zoom: _ffiMap!.zoomLevel,
      bearing: ffiCamera.heading,
      pitch: ffiCamera.pitch,
    );
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    if (zoom != null) _ffiMap?.zoomLevel = zoom;
    final ffiCamera = _ffiMap!.camera;
    if (pitch != null) ffiCamera.pitch = pitch;
    if (bearing != null) ffiCamera.heading = bearing;
    if (center != null) {
      ffiCamera.centerCoordinate = center.toCLLocationCoordinate2D();
    }
    _ffiMap?.setCamera(ffiCamera, animated: false);
  }

  @override
  void onStyleLoaded() {
    // We need to refresh the cached style for when the style reloads.
    style?.dispose();
    final styleCtrl = style = StyleControllerIos._(_ffiMap!.style!, _hostApi);

    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  @override
  void dispose() {
    style?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _updateOptions(oldWidget);
    layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _updateOptions(MapLibreMap oldWidget) async {
    final oldOptions = oldWidget.options;
    final options = this.options;
    _ffiMap?.minimumZoomLevel = options.minZoom;
    _ffiMap?.maximumZoomLevel = options.maxZoom;
    _ffiMap?.minimumPitch = options.minPitch;
    _ffiMap?.maximumPitch = options.maxPitch;

    // map bounds
    final oldBounds = oldOptions.maxBounds;
    final newBounds = options.maxBounds;
    if (oldBounds != null && newBounds == null) {
      _ffiMap?.maximumScreenBounds = Struct.create<ffi.MLNCoordinateBounds>();
    } else if ((oldBounds == null && newBounds != null) ||
        (newBounds != null && oldBounds != newBounds)) {
      final bounds = newBounds.toMLNCoordinateBounds();
      _ffiMap?.maximumScreenBounds = bounds;
    }

    // gestures
    if (options.gestures.rotate != oldOptions.gestures.rotate) {
      _ffiMap?.rotateEnabled = options.gestures.rotate;
    }
    if (options.gestures.pan != oldOptions.gestures.pan) {
      _ffiMap?.scrollEnabled = options.gestures.pan;
    }
    if (options.gestures.zoom != oldOptions.gestures.zoom) {
      _ffiMap?.zoomEnabled = options.gestures.zoom;
    }
    if (options.gestures.pitch != oldOptions.gestures.pitch) {
      _ffiMap?.pitchEnabled = options.gestures.pitch;
    }
  }

  Object? _featureIdFrom(ObjCObjectBase? object) {
    if (object == null) {
      return null;
    } else if (NSString.isInstance(object)) {
      return NSString.castFrom(object).toDartString();
    } else if (NSNumber.isInstance(object)) {
      return NSNumber.castFrom(object).intValue;
    }
    return null;
  }

  List<RenderedFeature> _nativeQueryToRenderedFeatures(NSArray query) {
    final features = query.map(ffi.MLNFeatureWrapper.castFrom);
    return features
        .map(
          (f) => RenderedFeature(
            id: _featureIdFrom(f.identifier),
            properties: f.attributes.toDartMap().map(
              (k, v) => MapEntry(k.toString(), v),
            ),
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
    if (style == null) {
      return [];
    }
    if (layerIds?.isEmpty ?? false) {
      // https://github.com/maplibre/maplibre-native/issues/2828
      return [];
    }

    final query = _ffiMap!.visibleFeaturesAtPoint$1(
      point.toCGPoint(),
      inStyleLayersWithIdentifiers: layerIds == null
          ? null
          : NSSet.of(layerIds.map((s) => s.toNSString())),
    );

    return _nativeQueryToRenderedFeatures(query);
  }

  @override
  List<RenderedFeature> featuresInRect(
    Rect rect, {
    List<String>? layerIds,
  }) {
    final style = this.style;
    if (style == null) {
      return [];
    }
    if (layerIds?.isEmpty ?? false) {
      // https://github.com/maplibre/maplibre-native/issues/2828
      return [];
    }

    final query = _ffiMap!.visibleFeaturesInRect$1(
      rect.toCGRect(),
      inStyleLayersWithIdentifiers: layerIds == null
          ? null
          : NSSet.of(layerIds.map((s) => s.toNSString())),
    );

    return _nativeQueryToRenderedFeatures(query);
  }

  @override
  List<QueriedLayer> queryLayers(Offset screenLocation) {
    final style = this.style;
    if (style == null) return [];
    final layers = style._getLayers();

    final point = screenLocation.toCGPoint();
    final queriedLayers = <QueriedLayer>[];
    for (var i = layers.length - 1; i >= 0; i--) {
      final layer = layers[i];
      final features = _ffiMap!.visibleFeaturesAtPoint$1(
        point,
        inStyleLayersWithIdentifiers: NSSet.setWithObject(layer.identifier),
      );
      if (features.count == 0) continue;
      if (features.isNotEmpty && ffi.MLNVectorStyleLayer.isInstance(layer)) {
        final vectorLayer = ffi.MLNVectorStyleLayer.castFrom(layer);
        final queriedLayer = QueriedLayer(
          layerId: layer.identifier.toDartString(),
          sourceId: vectorLayer.sourceIdentifier?.toDartString(),
          sourceLayer: vectorLayer.sourceLayerIdentifier?.toDartString(),
        );
        queriedLayers.add(queriedLayer);
      }
    }
    return queriedLayers;
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    if (!trackLocation) {
      _ffiMap?.userTrackingMode =
          ffi.MLNUserTrackingMode.MLNUserTrackingModeNone;
      return;
    }
    _ffiMap?.userTrackingMode = switch (trackBearing) {
      BearingTrackMode.none =>
        ffi.MLNUserTrackingMode.MLNUserTrackingModeFollow,
      BearingTrackMode.compass =>
        ffi.MLNUserTrackingMode.MLNUserTrackingModeFollowWithHeading,
      BearingTrackMode.gps =>
        ffi.MLNUserTrackingMode.MLNUserTrackingModeFollowWithCourse,
    };
  }

  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      _ffiMap!.metersPerPointAtLatitude(latitude);

  @override
  LngLatBounds getVisibleRegion() {
    final bounds = _ffiMap!.visibleCoordinateBounds;
    return LngLatBounds(
      longitudeWest: bounds.sw.longitude,
      longitudeEast: bounds.ne.longitude,
      latitudeSouth: bounds.sw.latitude,
      latitudeNorth: bounds.ne.latitude,
    );
  }

  @override
  Geographic toLngLat(Offset screenLocation) => _ffiMap!
      .convertPoint_(screenLocation.toCGPoint(), view: _ffiMap)
      .toGeographic();

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) =>
      screenLocations.map(toLngLat).toList(growable: false);

  @override
  Offset toScreenLocation(Geographic lngLat) => _ffiMap!
      .convertCoordinate(
        lngLat.toCLLocationCoordinate2D(),
        toPointToView: _ffiMap,
      )
      .toOffset();

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) =>
      lngLats.map(toScreenLocation).toList(growable: false);

  @override
  Future<void> setStyle(String style) async {
    final trimmed = style.trim();
    if (trimmed.startsWith('{')) {
      // Raw JSON
      _ffiMap?.styleJSON = trimmed.toNSString();
    } else if (trimmed.startsWith('/')) {
      _ffiMap?.styleURL = 'file://$trimmed'.toNSURL()!;
    } else if (!trimmed.startsWith('http://') &&
        !trimmed.startsWith('https://') &&
        !trimmed.startsWith('mapbox://')) {
      // flutter asset
      final content = await rootBundle.loadString(trimmed);
      _ffiMap?.styleJSON = content.toNSString();
    } else {
      // URI
      _ffiMap?.styleURL = trimmed.toNSURL()!;
    }
  }

  @override
  void onMoveCamera(pigeon.MapCamera camera) {
    final mapCamera = MapCamera(
      center: camera.center.toGeographic(),
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
  void onDoubleClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventClick(point: position, screenPoint: screenOffset),
    );
  }

  @override
  void onSecondaryClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventClick(point: position, screenPoint: screenOffset),
    );
  }

  @override
  void onClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventClick(point: position, screenPoint: screenOffset),
    );
  }

  @override
  void onLongClick(pigeon.LngLat point, pigeon.Offset screenPoint) {
    final position = point.toGeographic();
    final screenOffset = screenPoint.toOffset();
    widget.onEvent?.call(
      MapEventLongClick(point: position, screenPoint: screenOffset),
    );
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
  pigeon.MapOptions getOptions() => pigeon.MapOptions(
    style: options.initStyle,
    bearing: options.initBearing,
    zoom: options.initZoom,
    pitch: options.initPitch,
    center: options.initCenter == null
        ? null
        : pigeon.LngLat(
            lng: options.initCenter!.lon,
            lat: options.initCenter!.lat,
          ),
    minZoom: options.minZoom,
    maxZoom: options.maxZoom,
    minPitch: options.minPitch,
    maxPitch: options.maxPitch,
    maxBounds: options.maxBounds?.toLngLatBounds(),
    gestures: pigeon.MapGestures(
      rotate: options.gestures.rotate,
      pan: options.gestures.pan,
      zoom: options.gestures.zoom,
      tilt: options.gestures.pitch,
    ),
    androidTextureMode: options.androidTextureMode,
    androidTranslucentTextureSurface: options.androidTranslucentTextureSurface,
    androidForegroundLoadColor: options.androidForegroundLoadColor.toARGB32(),
  );
}

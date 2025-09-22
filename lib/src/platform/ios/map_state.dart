import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/extensions.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/platform/ios/extensions.dart';
import 'package:maplibre/src/platform/map_state_native.dart';
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;
import 'package:maplibre_ios/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart';

part 'style_controller.dart';

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateIos extends MapLibreMapStateNative
    implements pigeon.MapLibreFlutterApi {
  late final pigeon.MapLibreHostApi _hostApi;
  late final int _viewId;
  MLNMapView? _cachedMapView;

  MLNMapView get _mapView => _cachedMapView ??= MLNMapView.castFrom(
    MapLibreRegistry.getMapWithViewId(_viewId)!,
  );

  @override
  StyleControllerIos? style;

  @override
  Widget buildPlatformWidget(BuildContext context) {
    // print('buildPlatformWidget');
    const viewType = 'plugins.flutter.io/maplibre';
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
    final channelSuffix = viewId.toString();
    _hostApi = pigeon.MapLibreHostApi(messageChannelSuffix: channelSuffix);
    pigeon.MapLibreFlutterApi.setUp(this, messageChannelSuffix: channelSuffix);
    _viewId = viewId;
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
    if (zoom != null) _mapView.zoomLevel = zoom;
    final ffiCamera = _mapView.camera;
    if (pitch != null) ffiCamera.pitch = pitch;
    if (bearing != null) ffiCamera.heading = bearing;
    if (center != null) {
      ffiCamera.centerCoordinate = center.toCLLocationCoordinate2D();
    }
    _mapView.flyToCamera$1(
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
    _mapView.showsUserLocation = true;
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
    final sw = Struct.create<CLLocationCoordinate2D>()
      ..longitude = bounds.longitudeWest
      ..latitude = bounds.latitudeSouth;
    final ne = Struct.create<CLLocationCoordinate2D>()
      ..longitude = bounds.longitudeEast
      ..latitude = bounds.latitudeNorth;
    final ffiBounds = Struct.create<MLNCoordinateBounds>()
      ..sw = sw
      ..ne = ne;
    // TODO support padding with Struct UIEdgeInsets
    _mapView.setVisibleCoordinateBounds(ffiBounds, animated: true);
  }

  @override
  MapCamera getCamera() {
    final ffiCamera = _mapView.camera;
    return MapCamera(
      center: ffiCamera.centerCoordinate.toGeographic(),
      zoom: _mapView.zoomLevel,
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
    if (zoom != null) _mapView.zoomLevel = zoom;
    final ffiCamera = _mapView.camera;
    if (pitch != null) ffiCamera.pitch = pitch;
    if (bearing != null) ffiCamera.heading = bearing;
    if (center != null) {
      ffiCamera.centerCoordinate = center.toCLLocationCoordinate2D();
    }
    _mapView.setCamera(ffiCamera, animated: false);
  }

  @override
  void onStyleLoaded() {
    // We need to refresh the cached style for when the style reloads.
    style?.dispose();
    final styleCtrl = style = StyleControllerIos._(_mapView.style!, _hostApi);

    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  @override
  void dispose() {
    style?.dispose();
    unawaited(_hostApi.dispose());
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
    _mapView.minimumZoomLevel = options.minZoom;
    _mapView.maximumZoomLevel = options.maxZoom;
    _mapView.minimumPitch = options.minPitch;
    _mapView.maximumPitch = options.maxPitch;

    // map bounds
    final oldBounds = oldOptions.maxBounds;
    final newBounds = options.maxBounds;
    if (oldBounds != null && newBounds == null) {
      _mapView.maximumScreenBounds = Struct.create<MLNCoordinateBounds>();
    } else if ((oldBounds == null && newBounds != null) ||
        (newBounds != null && oldBounds != newBounds)) {
      final bounds = newBounds.toMLNCoordinateBounds();
      _mapView.maximumScreenBounds = bounds;
    }

    // gestures
    if (options.gestures.rotate != oldOptions.gestures.rotate) {
      _mapView.rotateEnabled = options.gestures.rotate;
    }
    if (options.gestures.pan != oldOptions.gestures.pan) {
      _mapView.scrollEnabled = options.gestures.pan;
    }
    if (options.gestures.zoom != oldOptions.gestures.zoom) {
      _mapView.zoomEnabled = options.gestures.zoom;
    }
    if (options.gestures.pitch != oldOptions.gestures.pitch) {
      _mapView.pitchEnabled = options.gestures.pitch;
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
    final features = query.map(MLNFeatureWrapper.castFrom);
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

    final query = _mapView.visibleFeaturesAtPoint$1(
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

    final query = _mapView.visibleFeaturesInRect$1(
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
      final features = _mapView.visibleFeaturesAtPoint$1(
        point,
        inStyleLayersWithIdentifiers: NSSet.setWithObject(layer.identifier),
      );
      if (features.count == 0) continue;
      if (features.isNotEmpty && MLNVectorStyleLayer.isInstance(layer)) {
        final vectorLayer = MLNVectorStyleLayer.castFrom(layer);
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
      _mapView.userTrackingMode = MLNUserTrackingMode.MLNUserTrackingModeNone;
      return;
    }
    _mapView.userTrackingMode = switch (trackBearing) {
      BearingTrackMode.none => MLNUserTrackingMode.MLNUserTrackingModeFollow,
      BearingTrackMode.compass =>
        MLNUserTrackingMode.MLNUserTrackingModeFollowWithHeading,
      BearingTrackMode.gps =>
        MLNUserTrackingMode.MLNUserTrackingModeFollowWithCourse,
    };
  }

  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      _mapView.metersPerPointAtLatitude(latitude);

  @override
  LngLatBounds getVisibleRegion() {
    final bounds = _mapView.visibleCoordinateBounds;
    return LngLatBounds(
      longitudeWest: bounds.sw.longitude,
      longitudeEast: bounds.ne.longitude,
      latitudeSouth: bounds.sw.latitude,
      latitudeNorth: bounds.ne.latitude,
    );
  }

  @override
  Geographic toLngLat(Offset screenLocation) => _mapView
      .convertPoint_(screenLocation.toCGPoint(), view: _mapView)
      .toGeographic();

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) =>
      screenLocations.map(toLngLat).toList(growable: false);

  @override
  Offset toScreenLocation(Geographic lngLat) => _mapView
      .convertCoordinate(
        lngLat.toCLLocationCoordinate2D(),
        toPointToView: _mapView,
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
      _mapView.styleJSON = trimmed.toNSString();
    } else if (trimmed.startsWith('/')) {
      _mapView.styleURL = 'file://$trimmed'.toNSURL()!;
    } else if (!trimmed.startsWith('http://') &&
        !trimmed.startsWith('https://') &&
        !trimmed.startsWith('mapbox://')) {
      // flutter asset
      final content = await rootBundle.loadString(trimmed);
      _mapView.styleJSON = content.toNSString();
    } else {
      // URI
      _mapView.styleURL = trimmed.toNSURL()!;
    }
  }
}

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
    Position? center,
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
      center: ffiCamera.centerCoordinate.toPosition(),
      zoom: _mapView.zoomLevel,
      bearing: ffiCamera.heading,
      pitch: ffiCamera.pitch,
    );
  }

  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async =>
      getMetersPerPixelAtLatitudeSync(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async => getVisibleRegionSync();

  @override
  Future<void> moveCamera({
    Position? center,
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

  @override
  Future<List<QueriedLayer>> queryLayers(Offset screenLocation) async {
    final style = this.style;
    if (style == null) return [];
    final layers = style._getLayers();

    final point = screenLocation.toCGPoint();
    final queriedLayers = <QueriedLayer>[];
    for (var i = layers.count - 1; i >= 0; i--) {
      final layer = layers[i];
      final features = _mapView.visibleFeaturesAtPoint$1(
        point,
        // TODO use layer.id
        inStyleLayersWithIdentifiers: NSSet.setWithObject(layer),
      );
      if (features.count == 0) continue;
      /* TODO final queriedLayer = QueriedLayer(
        layerId: jLayerId.toDartString(releaseOriginal: true),
        sourceId: jSourceId.toDartString(releaseOriginal: true),
        sourceLayer: sourceLayer.isEmpty ? null : sourceLayer,
      );
      queriedLayers.add(queriedLayer);*/
    }
    return queriedLayers;
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) async =>
      toLngLatSync(screenLocation);

  @override
  Future<List<Position>> toLngLats(List<Offset> screenLocations) async =>
      toLngLatsSync(screenLocations);

  @override
  Future<Offset> toScreenLocation(Position lngLat) async =>
      toScreenLocationSync(lngLat);

  @override
  Future<List<Offset>> toScreenLocations(List<Position> lngLats) async =>
      toScreenLocationsSync(lngLats);

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
  double getMetersPerPixelAtLatitudeSync(double latitude) =>
      _mapView.metersPerPointAtLatitude(latitude);

  @override
  LngLatBounds getVisibleRegionSync() {
    final bounds = _mapView.visibleCoordinateBounds;
    return LngLatBounds(
      longitudeWest: bounds.sw.longitude,
      longitudeEast: bounds.ne.longitude,
      latitudeSouth: bounds.sw.latitude,
      latitudeNorth: bounds.ne.latitude,
    );
  }

  @override
  Position toLngLatSync(Offset screenLocation) => _mapView
      .convertPoint(screenLocation.toCGPoint(), toCoordinateFromView: _mapView)
      .toPosition();

  @override
  List<Position> toLngLatsSync(List<Offset> screenLocations) =>
      screenLocations.map(toLngLatSync).toList(growable: false);

  @override
  Offset toScreenLocationSync(Position lngLat) => _mapView
      .convertCoordinate(
        lngLat.toCLLocationCoordinate2D(),
        toPointToView: _mapView,
      )
      .toOffset();

  @override
  List<Offset> toScreenLocationsSync(List<Position> lngLats) =>
      lngLats.map(toScreenLocationSync).toList(growable: false);

  // TODO(mhernz)
  @override
  Future<void> setStyle(String style) async {
    throw UnimplementedError();
  }
}

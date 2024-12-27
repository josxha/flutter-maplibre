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

  MLNMapView get _mapView => _cachedMapView ??=
      MLNMapView.castFrom(MapLibreRegistry.getMapWithViewId_(_viewId)!);

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
    _mapView.flyToCamera_withDuration_completionHandler_(
      ffiCamera,
      nativeDuration.inMicroseconds / 1000000,
      null,
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
  }) async {
    _mapView.showsUserLocation = true;
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
    _mapView.setVisibleCoordinateBounds_animated_(ffiBounds, true);
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
      _mapView.metersPerPointAtLatitude_(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async {
    final bounds = _mapView.visibleCoordinateBounds;
    return LngLatBounds(
      longitudeWest: bounds.sw.longitude,
      longitudeEast: bounds.ne.longitude,
      latitudeSouth: bounds.sw.latitude,
      latitudeNorth: bounds.ne.latitude,
    );
  }

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
    _mapView.setCamera_animated_(ffiCamera, false);
  }

  @override
  void onStyleLoaded() {
    print('onStyleLoaded: ${_mapView.styleURL.absoluteString}');
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
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    //_updateOptions(oldWidget);
    layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Future<List<QueriedLayer>> queryLayers(Offset screenLocation) async {
    final style = this.style;
    if (style == null) return [];
    final layers = style._getLayers();

    final point = screenLocation.toCGPoint();
    final queriedLayers = <QueriedLayer>[];
    for (var i = layers.count - 1; i >= 0; i--) {
      final layer = layers.objectAtIndex_(i);
      print(layer.ref.runtimeType);
      final features =
          _mapView.visibleFeaturesAtPoint_inStyleLayersWithIdentifiers_(
        point,
        NSSet.setWithObject_(layer), // TODO use layer.id
      );
      if (features.count == 0) continue;
      /*final queriedLayer = QueriedLayer(
        layerId: jLayerId.toDartString(releaseOriginal: true),
        sourceId: jSourceId.toDartString(releaseOriginal: true),
        sourceLayer: sourceLayer.isEmpty ? null : sourceLayer,
      );
      queriedLayers.add(queriedLayer);*/
    }
    return queriedLayers;
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) async {
    final coords = _mapView.convertPoint_toCoordinateFromView_(
      screenLocation.toCGPoint(),
      _mapView,
    );
    return coords.toPosition();
  }

  @override
  Future<List<Position>> toLngLats(List<Offset> screenLocations) async =>
      screenLocations
          .map(
            (e) => _mapView
                .convertPoint_toCoordinateFromView_(e.toCGPoint(), _mapView)
                .toPosition(),
          )
          .toList(growable: false);

  @override
  Future<Offset> toScreenLocation(Position lngLat) async {
    final coords = _mapView.convertCoordinate_toPointToView_(
      lngLat.toCLLocationCoordinate2D(),
      _mapView,
    );
    return coords.toOffset();
  }

  @override
  Future<List<Offset>> toScreenLocations(List<Position> lngLats) async =>
      lngLats
          .map(
            (e) => _mapView
                .convertCoordinate_toPointToView_(
                  e.toCLLocationCoordinate2D(),
                  _mapView,
                )
                .toOffset(),
          )
          .toList(growable: false);

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
}

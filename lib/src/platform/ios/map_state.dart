import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' hide Layer;
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;

part 'style_controller.dart';

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateIos extends MapLibreMapState
    implements pigeon.MapLibreFlutterApi {
  late final pigeon.MapLibreHostApi _hostApi;
  late final int _viewId;
  LayerManager? _annotationManager;

  MapOptions get _options => widget.options;

  @override
  StyleControllerIos? style;

  @override
  Future<void> animateCamera({Position? center, double? zoom, double? bearing, double? pitch, Duration nativeDuration = const Duration(seconds: 2), double webSpeed = 1.2, Duration? webMaxDuration}) {
    // TODO: implement animateCamera
    throw UnimplementedError();
  }

  @override
  Widget buildPlatformWidget(BuildContext context) {
    const viewType = 'plugins.flutter.io/maplibre';
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      gestureRecognizers: widget.gestureRecognizers,
    );
  }

  @override
  Future<void> enableLocation({Duration fastestInterval = const Duration(milliseconds: 750), Duration maxWaitTime = const Duration(seconds: 1), bool pulseFade = true, bool accuracyAnimation = true, bool compassAnimation = true, bool pulse = true}) {
    // TODO: implement enableLocation
    throw UnimplementedError();
  }

  @override
  Future<void> fitBounds({required LngLatBounds bounds, double? bearing, double? pitch, Duration nativeDuration = const Duration(seconds: 2), double webSpeed = 1.2, Duration? webMaxDuration, Offset offset = Offset.zero, double webMaxZoom = double.maxFinite, bool webLinear = false, EdgeInsets padding = EdgeInsets.zero}) {
    // TODO: implement fitBounds
    throw UnimplementedError();
  }

  @override
  MapCamera getCamera() {
    // TODO: implement getCamera
    throw UnimplementedError();
  }

  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) {
    // TODO: implement getMetersPerPixelAtLatitude
    throw UnimplementedError();
  }

  @override
  double getMetersPerPixelAtLatitudeSync(double latitude) {
    // TODO: implement getMetersPerPixelAtLatitudeSync
    throw UnimplementedError();
  }

  @override
  pigeon.MapOptions getOptions() {
    // TODO: implement getOptions
    throw UnimplementedError();
  }

  @override
  Future<LngLatBounds> getVisibleRegion() {
    // TODO: implement getVisibleRegion
    throw UnimplementedError();
  }

  @override
  LngLatBounds getVisibleRegionSync() {
    // TODO: implement getVisibleRegionSync
    throw UnimplementedError();
  }

  @override
  Future<void> moveCamera({Position? center, double? zoom, double? bearing, double? pitch}) {
    // TODO: implement moveCamera
    throw UnimplementedError();
  }

  @override
  void onCameraIdle() {
    // TODO: implement onCameraIdle
  }

  @override
  void onClick(pigeon.LngLat point) {
    // TODO: implement onClick
  }

  @override
  void onDoubleClick(pigeon.LngLat point) {
    // TODO: implement onDoubleClick
  }

  @override
  void onIdle() {
    // TODO: implement onIdle
  }

  @override
  void onLongClick(pigeon.LngLat point) {
    // TODO: implement onLongClick
  }

  @override
  void onMapReady() {
    // TODO: implement onMapReady
  }

  @override
  void onMoveCamera(pigeon.MapCamera camera) {
    // TODO: implement onMoveCamera
  }

  @override
  void onSecondaryClick(pigeon.LngLat point) {
    // TODO: implement onSecondaryClick
  }

  @override
  void onStartMoveCamera(pigeon.CameraChangeReason reason) {
    // TODO: implement onStartMoveCamera
  }

  @override
  void onStyleLoaded() {
    // TODO: implement onStyleLoaded
  }

  @override
  Future<List<QueriedLayer>> queryLayers(Offset screenLocation) {
    // TODO: implement queryLayers
    throw UnimplementedError();
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) {
    // TODO: implement toLngLat
    throw UnimplementedError();
  }

  @override
  Position toLngLatSync(Offset screenLocation) {
    // TODO: implement toLngLatSync
    throw UnimplementedError();
  }

  @override
  Future<List<Position>> toLngLats(List<Offset> screenLocations) {
    // TODO: implement toLngLats
    throw UnimplementedError();
  }

  @override
  List<Position> toLngLatsSync(List<Offset> screenLocations) {
    // TODO: implement toLngLatsSync
    throw UnimplementedError();
  }

  @override
  Future<Offset> toScreenLocation(Position lngLat) {
    // TODO: implement toScreenLocation
    throw UnimplementedError();
  }

  @override
  Offset toScreenLocationSync(Position lngLat) {
    // TODO: implement toScreenLocationSync
    throw UnimplementedError();
  }

  @override
  Future<List<Offset>> toScreenLocations(List<Position> lngLats) {
    // TODO: implement toScreenLocations
    throw UnimplementedError();
  }

  @override
  List<Offset> toScreenLocationsSync(List<Position> lngLats) {
    // TODO: implement toScreenLocationsSync
    throw UnimplementedError();
  }

  @override
  Future<void> trackLocation({bool trackLocation = true, BearingTrackMode trackBearing = BearingTrackMode.gps}) {
    // TODO: implement trackLocation
    throw UnimplementedError();
  }
}

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/extensions.dart';
import 'package:maplibre/src/native/pigeon.g.dart';

final class MapLibreMapStateNative extends State<MapLibreMap>
    implements MapController {
  final _pigeon = MapLibrePigeon();

  MapOptions get options => widget.options;

  @override
  void initState() {
    // TODO
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final creationParams = options.toJson();
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: (int viewId) => widget.onMapCreated?.call(this),
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: (int viewId) => widget.onMapCreated?.call(this),
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    throw UnsupportedError('Unsupported Platform');
  }

  @override
  Future<Marker> addMarker(Marker marker) async {
    // TODO: implement addMarker
    throw UnimplementedError();
  }

  @override
  Future<void> addGeoJsonSource({
    required String id,
    required Map<String, Object?> geoJson,
  }) {
    // TODO: implement addGeoJsonSource
    throw UnimplementedError();
  }

  @override
  Future<void> addLayer({
    required String id,
    required String type,
    required String source,
  }) {
    // TODO: implement addLayer
    throw UnimplementedError();
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) async {
    final lngLat = await _pigeon.toLngLat(screenLocation.dx, screenLocation.dy);
    return lngLat.toPosition();
  }

  @override
  Future<Offset> toScreenLocation(Position lngLat) async {
    final screenLocation = await _pigeon.toScreenLocation(
      lngLat.lng.toDouble(),
      lngLat.lat.toDouble(),
    );
    return Offset(screenLocation.x, screenLocation.y);
  }

  @override
  Future<void> jumpTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) =>
      _pigeon.jumpTo(
        center: center.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      );

  @override
  Future<void> flyTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) =>
      _pigeon.flyTo(
        center: center.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      );

  @override
  Future<void> addGeoJson({
    required String id,
    required Map<String, Object?> geoJson,
  }) {
    // TODO: implement addGeoJson
    throw UnimplementedError();
  }
}

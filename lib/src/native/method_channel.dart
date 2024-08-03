import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform_interface.dart';

/// An implementation of [MapLibrePlatform] that uses method channels.
class MapLibreNative extends MapLibrePlatform {
  @override
  Widget buildWidget({
    required MapOptions options,
    required PlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) {
    final creationParams = options.toJson();
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    throw UnsupportedError('Unsupported Platform');
  }

  @override
  Future<void> initPlatform(int id) async {
    // TODO implement initPlatform
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
  Future<Position> toLngLat(Offset screenLocation) {
    // TODO: implement toLngLat
    throw UnimplementedError();
  }

  @override
  Future<Offset> toScreenLocation(Position lngLat) {
    // TODO: implement toScreenLocation
    throw UnimplementedError();
  }
}

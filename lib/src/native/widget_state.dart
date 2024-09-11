import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/extensions.dart';
import 'package:maplibre/src/native/pigeon.g.dart';

final class MapLibreMapStateNative extends State<MapLibreMap>
    implements MapController {
  late final MapLibrePigeon _pigeon;

  MapOptions get options => widget.options;

  @override
  Widget build(BuildContext context) {
    final creationParams = options.toJson();
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    throw UnsupportedError('[MapLibreMap] Unsupported Platform');
  }

  void _onPlatformViewCreated(int viewId) {
    _pigeon = MapLibrePigeon(messageChannelSuffix: viewId.toString());
    widget.onMapCreated?.call(this);
  }

  @override
  Future<Marker> addMarker(Marker marker) async {
    throw UnimplementedError('addMarker() is only supported on web.');
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
  Future<void> addLayer(Layer layer) async {
    await switch (layer) {
      FillLayer() =>
          _pigeon.addFillLayer(
            id: layer.id,
            sourceId: layer.sourceId,
          ),
      CircleLayer() =>
          _pigeon.addCircleLayer(
            id: layer.id,
            sourceId: layer.sourceId,
          ),
    };
  }

  @override
  Future<void> addSource(Source source) async {
    await switch (source) {
      GeoJsonSource() =>
          _pigeon.addGeoJsonSource(
            id: source.id,
            data: source.data,
          ),
    };
  }
}

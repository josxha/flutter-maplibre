import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/extensions.dart';
import 'package:maplibre/src/native/pigeon.g.dart';

final class MapLibreMapStateNative extends State<MapLibreMap>
    implements MapController, MapLibreFlutterApi {
  late final MapLibreHostApi _hostApi;

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
    final channelSuffix = viewId.toString();
    _hostApi = MapLibreHostApi(messageChannelSuffix: channelSuffix);
    MapLibreFlutterApi.setUp(this, messageChannelSuffix: channelSuffix);

    widget.onMapCreated?.call(this);
  }

  @override
  Future<Marker> addMarker(Marker marker) async {
    throw UnimplementedError('addMarker() is only supported on web.');
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) async {
    final lngLat =
        await _hostApi.toLngLat(screenLocation.dx, screenLocation.dy);
    return lngLat.toPosition();
  }

  @override
  Future<Offset> toScreenLocation(Position lngLat) async {
    final screenLocation = await _hostApi.toScreenLocation(
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
      _hostApi.jumpTo(
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
      _hostApi.flyTo(
        center: center.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      );

  @override
  Future<void> addLayer(Layer layer) async {
    await switch (layer) {
      FillLayer() =>
        _hostApi.addFillLayer(id: layer.id, sourceId: layer.sourceId),
      CircleLayer() =>
        _hostApi.addCircleLayer(id: layer.id, sourceId: layer.sourceId),
    };
  }

  @override
  Future<void> addSource(Source source) async {
    await switch (source) {
      GeoJsonSource() =>
        _hostApi.addGeoJsonSource(id: source.id, data: source.data),
    };
  }

  @override
  void onStyleLoaded() => widget.onStyleLoaded?.call();

  @override
  void onDoubleClick(LngLat point) =>
      options.onDoubleClick?.call(Position(point.lng, point.lat));

  @override
  void onSecondaryClick(LngLat point) =>
      options.onSecondaryClick?.call(Position(point.lng, point.lat));

  @override
  void onClick(LngLat point) =>
      options.onClick?.call(Position(point.lng, point.lat));

  @override
  void onLongClick(LngLat point) =>
      options.onLongClick?.call(Position(point.lng, point.lat));
}

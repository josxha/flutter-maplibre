import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/extensions.dart';
import 'package:maplibre/src/native/pigeon.g.dart' as pigeon;

final class MapLibreMapStateNative extends State<MapLibreMap>
    implements MapController, pigeon.MapLibreFlutterApi {
  late final pigeon.MapLibreHostApi _hostApi;

  MapOptions get options => widget.options;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'plugins.flutter.io/maplibre',
        onPlatformViewCreated: _onPlatformViewCreated,
        gestureRecognizers: widget.gestureRecognizers,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    throw UnsupportedError('[MapLibreMap] Unsupported Platform');
  }

  void _onPlatformViewCreated(int viewId) {
    final channelSuffix = viewId.toString();
    _hostApi = pigeon.MapLibreHostApi(messageChannelSuffix: channelSuffix);
    pigeon.MapLibreFlutterApi.setUp(this, messageChannelSuffix: channelSuffix);

    widget.onMapCreated?.call(this);
  }

  @override
  pigeon.MapOptions getOptions() => pigeon.MapOptions(
        style: options.style,
        bearing: options.bearing,
        zoom: options.zoom,
        tilt: options.tilt,
        center: options.center == null
            ? null
            : pigeon.LngLat(
                lng: options.center!.lng.toDouble(),
                lat: options.center!.lat.toDouble(),
              ),
        listensOnClick: options.onClick != null,
        listensOnLongClick: options.onLongClick != null,
      );

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
    double? tilt,
  }) =>
      _hostApi.jumpTo(
        center: center.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: tilt,
      );

  @override
  Future<void> flyTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? tilt,
  }) =>
      _hostApi.flyTo(
        center: center.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: tilt,
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
  void onDoubleClick(pigeon.LngLat point) =>
      options.onDoubleClick?.call(Position(point.lng, point.lat));

  @override
  void onSecondaryClick(pigeon.LngLat point) =>
      options.onSecondaryClick?.call(Position(point.lng, point.lat));

  @override
  void onClick(pigeon.LngLat point) =>
      options.onClick?.call(Position(point.lng, point.lat));

  @override
  void onLongClick(pigeon.LngLat point) =>
      options.onLongClick?.call(Position(point.lng, point.lat));
}

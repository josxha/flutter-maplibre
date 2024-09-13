import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/extensions.dart';
import 'package:maplibre/src/native/pigeon.g.dart' as pigeon;

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// non-web platforms like android or ios.
final class MapLibreMapStateNative extends State<MapLibreMap>
    implements MapController, pigeon.MapLibreFlutterApi {
  late final pigeon.MapLibreHostApi _hostApi;

  MapOptions get _options => widget.options;

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
        style: _options.style,
        bearing: _options.bearing,
        zoom: _options.zoom,
        tilt: _options.tilt,
        center: _options.center == null
            ? null
            : pigeon.LngLat(
                lng: _options.center!.lng.toDouble(),
                lat: _options.center!.lat.toDouble(),
              ),
        listensOnClick: _options.onClick != null,
        listensOnLongClick: _options.onLongClick != null,
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
    Position? center,
    double? zoom,
    double? bearing,
    double? tilt,
  }) =>
      _hostApi.jumpTo(
        center: center?.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: tilt,
      );

  @override
  Future<void> flyTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? tilt,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? maxDuration,
  }) =>
      _hostApi.flyTo(
        center: center?.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: tilt,
        durationMs: nativeDuration.inMilliseconds,
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
      _options.onDoubleClick?.call(Position(point.lng, point.lat));

  @override
  void onSecondaryClick(pigeon.LngLat point) =>
      _options.onSecondaryClick?.call(Position(point.lng, point.lat));

  @override
  void onClick(pigeon.LngLat point) =>
      _options.onClick?.call(Position(point.lng, point.lat));

  @override
  void onLongClick(pigeon.LngLat point) =>
      _options.onLongClick?.call(Position(point.lng, point.lat));
}

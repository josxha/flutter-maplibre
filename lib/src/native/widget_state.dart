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
      // Texture Layer (or Texture Layer Hybrid Composition)
      // Platform Views are rendered into a texture. Flutter draws the
      // platform views (via the texture). Flutter content is rendered
      // directly into a Surface.
      // + good performance for Android Views
      // + best performance for Flutter rendering.
      // + all transformations work correctly.
      // - quick scrolling (e.g. a web view) will be janky
      // - SurfaceViews are problematic in this mode and will be moved into a
      //   virtual display (breaking a11y)
      // - Text magnifier will break unless Flutter is rendered into a
      //   TextureView.
      // https://docs.flutter.dev/platform-integration/android/platform-views#texturelayerhybridcompisition
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

    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _hostApi.updateOptions(getOptions());
    super.didUpdateWidget(oldWidget);
  }

  @override
  pigeon.MapOptions getOptions() => pigeon.MapOptions(
        style: _options.style,
        bearing: _options.bearing,
        zoom: _options.zoom,
        pitch: _options.pitch,
        center: _options.center == null
            ? null
            : pigeon.LngLat(
                lng: _options.center!.lng.toDouble(),
                lat: _options.center!.lat.toDouble(),
              ),
        minZoom: _options.minZoom,
        maxZoom: _options.maxZoom,
        minPitch: _options.minPitch,
        maxPitch: _options.maxPitch,
        maxBounds: _options.maxBounds?.toLngLatBounds(),
        listensOnClick: widget.onEvent != null,
        listensOnLongClick: widget.onEvent != null,
        gestures: pigeon.MapGestures(
          rotate: _options.gestures.rotate,
          pan: _options.gestures.pan,
          zoom: _options.gestures.zoom,
          tilt: _options.gestures.pitch,
        ),
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
    @Deprecated('Renamed to pitch') double? tilt,
    double? pitch,
  }) =>
      moveCamera(
        center: center,
        zoom: zoom,
        bearing: bearing,
        pitch: pitch ?? tilt,
      );

  @override
  Future<void> flyTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    @Deprecated('Renamed to pitch') double? tilt,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  }) =>
      animateCamera(
        center: center,
        zoom: zoom,
        bearing: bearing,
        pitch: tilt ?? pitch,
        nativeDuration: nativeDuration,
        webSpeed: webSpeed,
        webMaxDuration: webMaxDuration,
      );

  @override
  Future<void> moveCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) =>
      _hostApi.moveCamera(
        center: center?.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      );

  @override
  Future<void> animateCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  }) =>
      _hostApi.animateCamera(
        center: center?.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
        durationMs: nativeDuration.inMilliseconds,
      );

  @override
  Future<void> addLayer(Layer layer, {String? belowLayerId}) async {
    await switch (layer) {
      FillLayer() => _hostApi.addFillLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      CircleLayer() => _hostApi.addCircleLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      BackgroundLayer() => _hostApi.addBackgroundLayer(
          id: layer.id,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      FillExtrusionLayer() => _hostApi.addFillExtrusionLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      HeatmapLayer() => _hostApi.addHeatmapLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      HillshadeLayer() => _hostApi.addHillshadeLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      LineLayer() => _hostApi.addLineLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      RasterLayer() => _hostApi.addRasterLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
      SymbolLayer() => _hostApi.addSymbolLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        ),
    };
  }

  @override
  Future<void> addSource(Source source) async {
    await switch (source) {
      GeoJsonSource() =>
        _hostApi.addGeoJsonSource(id: source.id, data: source.data),
      RasterDemSource() => switch (source.encoding) {
          final RasterDemCustomEncoding encoding => _hostApi.addRasterDemSource(
              id: source.id,
              attribution: source.attribution,
              bounds: source.bounds,
              volatile: source.volatile,
              url: source.url,
              tiles: source.tiles,
              minZoom: source.minZoom,
              maxZoom: source.maxZoom,
              tileSize: source.tileSize,
              encoding: pigeon.RasterDemEncoding.custom,
              greenFactor: encoding.greenFactor,
              blueFactor: encoding.blueFactor,
              redFactor: encoding.redFactor,
              baseShift: encoding.baseShift,
            ),
          _ => _hostApi.addRasterDemSource(
              id: source.id,
              attribution: source.attribution,
              bounds: source.bounds,
              volatile: source.volatile,
              url: source.url,
              tiles: source.tiles,
              minZoom: source.minZoom,
              maxZoom: source.maxZoom,
              tileSize: source.tileSize,
              encoding: switch (source.encoding) {
                RasterDemTerrariumEncoding() =>
                  pigeon.RasterDemEncoding.terrarium,
                RasterDemMapboxEncoding() => pigeon.RasterDemEncoding.mapbox,
                RasterDemCustomEncoding() => pigeon.RasterDemEncoding.custom,
              },
            ),
        },
      RasterSource() => _hostApi.addRasterSource(
          id: source.id,
          bounds: source.bounds,
          url: source.url,
          tiles: source.tiles,
          minZoom: source.minZoom,
          maxZoom: source.maxZoom,
          attribution: source.attribution,
          tileSize: source.tileSize,
          volatile: source.volatile,
          scheme: switch (source.scheme) {
            TileScheme.xyz => pigeon.TileScheme.xyz,
            TileScheme.tms => pigeon.TileScheme.tms,
          },
        ),
      VectorSource() => _hostApi.addVectorSource(
          id: source.id,
          bounds: source.bounds,
          attribution: source.attribution,
          maxZoom: source.maxZoom,
          minZoom: source.minZoom,
          scheme: switch (source.scheme) {
            TileScheme.xyz => pigeon.TileScheme.xyz,
            TileScheme.tms => pigeon.TileScheme.tms,
          },
          sourceLayer: source.sourceLayer,
          tiles: source.tiles,
          url: source.url,
          volatile: source.volatile,
        ),
      ImageSource() => _hostApi.addImageSource(
          id: source.id,
          url: source.url,
          coordinates: source.coordinates
              .map((e) => e.toLngLat())
              .toList(growable: false),
        ),
      VideoSource() =>
        throw UnimplementedError('Video source is only supported on web.'),
    };
  }

  @override
  void onStyleLoaded() {
    widget.onEvent?.call(const MapEventStyleLoaded());
    widget.onStyleLoaded?.call();
  }

  @override
  void onMoveCamera(pigeon.MapCamera camera) {
    final mapCamera = MapCamera(
      center: camera.center.toPosition(),
      zoom: camera.zoom,
      pitch: camera.pitch,
      bearing: camera.bearing,
    );
    widget.onEvent?.call(MapEventMoveCamera(camera: mapCamera));
  }

  @override
  void onStartMoveCamera(pigeon.CameraChangeReason reason) {
    final changeReason = switch (reason) {
      pigeon.CameraChangeReason.apiAnimation => CameraChangeReason.apiAnimation,
      pigeon.CameraChangeReason.apiGesture => CameraChangeReason.apiGesture,
      pigeon.CameraChangeReason.developerAnimation =>
        CameraChangeReason.developerAnimation,
    };
    widget.onEvent?.call(MapEventStartMoveCamera(reason: changeReason));
  }

  @override
  void onIdle() => widget.onEvent?.call(const MapEventIdle());

  @override
  void onCameraIdle() => widget.onEvent?.call(const MapEventCameraIdle());

  @override
  void onDoubleClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
    // ignore: deprecated_member_use_from_same_package
    _options.onDoubleClick?.call(position);
  }

  @override
  void onSecondaryClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
    // ignore: deprecated_member_use_from_same_package
    _options.onSecondaryClick?.call(position);
  }

  @override
  void onClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
    // ignore: deprecated_member_use_from_same_package
    _options.onClick?.call(position);
  }

  @override
  void onLongClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventLongClick(point: position));
    // ignore: deprecated_member_use_from_same_package
    _options.onLongClick?.call(position);
  }

  @override
  Future<MapCamera> getCamera() async {
    final camera = await _hostApi.getCamera();
    return MapCamera(
      center: camera.center.toPosition(),
      zoom: camera.zoom,
      pitch: camera.pitch,
      bearing: camera.bearing,
    );
  }

  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async =>
      _hostApi.getMetersPerPixelAtLatitude(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async {
    final bounds = await _hostApi.getVisibleRegion();
    return LngLatBounds(
      longitudeWest: bounds.longitudeWest,
      longitudeEast: bounds.longitudeEast,
      latitudeSouth: bounds.latitudeSouth,
      latitudeNorth: bounds.latitudeNorth,
    );
  }

  @override
  Future<void> removeLayer(String id) async => _hostApi.removeLayer(id);

  @override
  Future<void> removeSource(String id) => _hostApi.removeSource(id);

  @override
  Future<void> addImage(String id, Uint8List bytes) =>
      _hostApi.addImage(id, bytes);

  @override
  Future<void> removeImage(String id) => _hostApi.removeImage(id);

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) =>
      _hostApi.updateGeoJsonSource(id: id, data: data);
}

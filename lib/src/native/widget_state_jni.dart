import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/jni/jni.dart' as jni;
import 'package:maplibre/src/native/extensions.dart';
import 'package:maplibre/src/native/pigeon.g.dart' as pigeon;

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
final class MapLibreMapStateJni extends State<MapLibreMap>
    implements MapController, pigeon.MapLibreFlutterApi {
  late final pigeon.MapLibreHostApi _hostApi;
  late final int _viewId;
  jni.MapLibreMap? _cachedJniMapLibreMap;
  jni.Projection? _cachedJniProjection;
  jni.Style? _cachedJniStyle;

  MapOptions get _options => widget.options;

  jni.MapLibreMap get _jniMapLibreMap =>
      _cachedJniMapLibreMap ??= jni.MapLibreRegistry.INSTANCE.getMap(_viewId);

  // ignore: unused_element
  jni.Projection get _jniProjection =>
      _cachedJniProjection ??= _jniMapLibreMap.getProjection();

  // ignore: unused_element
  jni.Style get _jniStyle => _cachedJniStyle ??= _jniMapLibreMap.getStyle$1();

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
    _viewId = viewId;
    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _hostApi.updateOptions(getOptions());
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cachedJniStyle?.release();
    _cachedJniProjection?.release();
    _cachedJniMapLibreMap?.release();
    super.dispose();
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
  }) async {
    return _hostApi.animateCamera(
      center: center?.toLngLat(),
      zoom: zoom,
      bearing: bearing,
      pitch: pitch,
      durationMs: nativeDuration.inMilliseconds,
    );
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
  }) =>
      _hostApi.fitBounds(
        bounds: bounds.toLngLatBounds(),
        bearing: bearing,
        pitch: pitch,
        durationMs: nativeDuration.inMilliseconds,
        offset: offset.toOffset(),
        padding: padding.toPadding(),
      );

  @override
  Future<void> trackUserLocation() async {
    final jniMapLibreMap = _jniMapLibreMap;
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      final locationComponent = jniMapLibreMap.getLocationComponent();
      final jniContext = jni.MapLibreRegistry.INSTANCE.getContext();
      final locationComponentOptions =
          jni.LocationComponentOptions.builder(jniContext)
              .pulseFadeEnabled(true)
              .accuracyAnimationEnabled(true)
              .compassAnimationEnabled(true.toJBoolean())
              .pulseEnabled(true)
              .build();
      final locationEngineRequest = jni.LocationEngineRequest_Builder(750)
          .setFastestInterval(750)
          .setMaxWaitTime(1)
          .setPriority(jni.LocationEngineRequest.PRIORITY_HIGH_ACCURACY)
          .build();
      final activationOptions =
          jni.LocationComponentActivationOptions.builder(jniContext, jniStyle)
              .locationComponentOptions(locationComponentOptions)
              .useDefaultLocationEngine(true)
              .locationEngineRequest(locationEngineRequest)
              .build();
      locationComponent.activateLocationComponent(activationOptions);

      locationComponent.isLocationComponentEnabled();
      locationComponent.setCameraMode(jni.CameraMode.TRACKING);
      // locationComponent.forceLocationUpdate(null);

      locationComponent.release();
      locationComponentOptions.release();
      locationEngineRequest.release();
      activationOptions.release();
      jniContext.release();
    });
  }

  @override
  Future<void> addLayer(Layer layer, {String? belowLayerId}) async {
    // TODO: evaluate if jni would improve this function
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
    // TODO: evaluate if jni would improve this function
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
  }

  @override
  void onSecondaryClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
  }

  @override
  void onClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventClick(point: position));
  }

  @override
  void onLongClick(pigeon.LngLat point) {
    final position = point.toPosition();
    widget.onEvent?.call(MapEventLongClick(point: position));
  }

  @override
  Future<MapCamera> getCamera() async {
    final jniCamera = _jniMapLibreMap.getCameraPosition();
    final camera = MapCamera(
      center: Position(
        jniCamera.target.getLongitude(),
        jniCamera.target.getLatitude(),
      ),
      zoom: jniCamera.zoom,
      pitch: jniCamera.tilt,
      bearing: jniCamera.bearing,
    );
    jniCamera.release();
    return camera;
  }

  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async =>
      _hostApi.getMetersPerPixelAtLatitude(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async {
    final projection = _jniProjection; // necessary to use it in platform thread
    final jniBounds = await runOnPlatformThread<jni.LatLngBounds>(() {
      final region = projection.getVisibleRegion();
      final bounds = region.latLngBounds;
      region.release();
      return bounds;
    });
    final bounds = LngLatBounds(
      longitudeWest: jniBounds.longitudeWest,
      longitudeEast: jniBounds.longitudeEast,
      latitudeSouth: jniBounds.latitudeSouth,
      latitudeNorth: jniBounds.latitudeNorth,
    );
    jniBounds.release();
    return bounds;
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

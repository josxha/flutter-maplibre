import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/annotation/annotation_manager.dart';
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
  jni.LocationComponent? _cachedLocationComponent;
  jni.Style? _cachedJniStyle;
  AnnotationManager? _annotationManager;

  MapOptions get _options => widget.options;

  jni.MapLibreMap get _jniMapLibreMap =>
      _cachedJniMapLibreMap ??= jni.MapLibreRegistry.INSTANCE.getMap(_viewId);

  jni.Projection get _jniProjection =>
      _cachedJniProjection ??= _jniMapLibreMap.getProjection();

  jni.Style get _jniStyle => _cachedJniStyle ??= _jniMapLibreMap.getStyle$1();

  jni.LocationComponent get _locationComponent =>
      _cachedLocationComponent ??= _jniMapLibreMap.getLocationComponent();

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
    _updateOptions(oldWidget);
    _annotationManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _cachedJniStyle?.release();
    _cachedJniProjection?.release();
    _cachedJniMapLibreMap?.release();
    _cachedLocationComponent?.release();
    super.dispose();
  }

  Future<void> _updateOptions(MapLibreMap oldWidget) async {
    final jniMap = _jniMapLibreMap;
    final oldOptions = oldWidget.options;
    final options = _options;
    await runOnPlatformThread(() {
      jniMap.setMinZoomPreference(options.minZoom);
      jniMap.setMaxZoomPreference(options.maxZoom);
      jniMap.setMinPitchPreference(options.minPitch);
      jniMap.setMaxPitchPreference(options.maxPitch);


      // map bounds
      final oldBounds = oldOptions.maxBounds;
      final newBounds = options.maxBounds;
      if (oldBounds != null && newBounds == null) {
        // TODO @Nullable latLngBounds, https://github.com/dart-lang/native/issues/1644
        // _jniMapLibreMap.setLatLngBoundsForCameraTarget(null);
      } else if ((oldBounds == null && newBounds != null) ||
          (newBounds != null && oldBounds != newBounds)) {
        final bounds = newBounds.toLatLngBounds();
        jniMap.setLatLngBoundsForCameraTarget(bounds);
      }

      // gestures
      final uiSettings = jniMap.getUiSettings();
      if (options.gestures.rotate != oldOptions.gestures.rotate) {
        uiSettings.setRotateGesturesEnabled(options.gestures.rotate);
      }
      /*if (options.gestures.pan != oldOptions.gestures.pan) {
        uiSettings.setRotateGesturesEnabled(options.gestures.pan);
      }*/
      if (options.gestures.zoom != oldOptions.gestures.zoom) {
        uiSettings.setZoomGesturesEnabled(options.gestures.zoom);
        uiSettings.setDoubleTapGesturesEnabled(options.gestures.zoom);
        uiSettings.setScrollGesturesEnabled(options.gestures.zoom);
        uiSettings.setQuickZoomGesturesEnabled(options.gestures.zoom);
      }
      if (options.gestures.pitch != oldOptions.gestures.pitch) {
        uiSettings.setTiltGesturesEnabled(options.gestures.pitch);
      }
      uiSettings.release();
    });
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
        gestures: pigeon.MapGestures(
          rotate: _options.gestures.rotate,
          pan: _options.gestures.pan,
          zoom: _options.gestures.zoom,
          tilt: _options.gestures.pitch,
        ),
      );

  @override
  Future<Position> toLngLat(Offset screenLocation) async {
    final jniProjection = _jniProjection;
    final jniLatLng = await runOnPlatformThread<jni.LatLng>(() {
      return jniProjection.fromScreenLocation(screenLocation.toPointF());
    });
    final position = jniLatLng.toPosition();
    jniLatLng.release();
    return position;
  }

  @override
  Future<Offset> toScreenLocation(Position lngLat) async {
    final jniProjection = _jniProjection;
    final jniPoint = await runOnPlatformThread<jni.PointF>(() {
      return jniProjection.toScreenLocation(lngLat.toLatLng());
    });
    final position = jniPoint.toOffset();
    jniPoint.release();
    return position;
  }

  @override
  Future<void> moveCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    final cameraPositionBuilder = jni.CameraPosition_Builder();
    if (center != null) cameraPositionBuilder.target(center.toLatLng());
    if (zoom != null) cameraPositionBuilder.zoom(zoom);
    if (pitch != null) cameraPositionBuilder.tilt(pitch);
    if (bearing != null) cameraPositionBuilder.bearing(bearing);

    final cameraPosition = cameraPositionBuilder.build();
    cameraPositionBuilder.release();
    final cameraUpdate =
        jni.CameraUpdateFactory.newCameraPosition(cameraPosition);

    final jniMapLibreMap = _jniMapLibreMap;
    final completer = Completer<void>();
    await runOnPlatformThread(() {
      jniMapLibreMap.moveCamera$1(
        cameraUpdate,
        jni.MapLibreMap_CancelableCallback.implement(
          jni.$MapLibreMap_CancelableCallback(
            onCancel: () => completer.completeError(
              Exception('Animation cancelled.'),
            ),
            onFinish: completer.complete,
          ),
        ),
      );
      return completer.future;
    });
    cameraUpdate.release();
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
    final cameraPositionBuilder = jni.CameraPosition_Builder();
    if (center != null) cameraPositionBuilder.target(center.toLatLng());
    if (zoom != null) cameraPositionBuilder.zoom(zoom);
    if (pitch != null) cameraPositionBuilder.tilt(pitch);
    if (bearing != null) cameraPositionBuilder.bearing(bearing);

    final cameraPosition = cameraPositionBuilder.build();
    cameraPositionBuilder.release();
    final cameraUpdate =
        jni.CameraUpdateFactory.newCameraPosition(cameraPosition);

    final jniMapLibreMap = _jniMapLibreMap;
    final completer = Completer<void>();
    await runOnPlatformThread(() {
      jniMapLibreMap.animateCamera$3(
        cameraUpdate,
        nativeDuration.inMilliseconds,
        jni.MapLibreMap_CancelableCallback.implement(
          jni.$MapLibreMap_CancelableCallback(
            onCancel: () => completer.completeError(
              Exception('Animation cancelled.'),
            ),
            onFinish: completer.complete,
          ),
        ),
      );
      return completer.future;
    });
    cameraUpdate.release();
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
    final latLngBounds = jni.LatLngBounds.from(
      bounds.latitudeNorth,
      bounds.longitudeEast,
      bounds.latitudeSouth,
      bounds.longitudeWest,
    );
    final cameraUpdate = jni.CameraUpdateFactory.newLatLngBounds$3(
      latLngBounds,
      bearing ?? -1.0,
      pitch ?? -1.0,
      padding.left.toInt(),
      padding.top.toInt(),
      padding.right.toInt(),
      padding.bottom.toInt(),
    );
    latLngBounds.release();

    final jniMapLibreMap = _jniMapLibreMap;
    final completer = Completer<void>();
    await runOnPlatformThread(() {
      jniMapLibreMap.animateCamera$3(
        cameraUpdate,
        nativeDuration.inMilliseconds,
        jni.MapLibreMap_CancelableCallback.implement(
          jni.$MapLibreMap_CancelableCallback(
            onCancel: () => completer.completeError(
              Exception('Animation cancelled.'),
            ),
            onFinish: completer.complete,
          ),
        ),
      );
      return completer.future;
    });
    cameraUpdate.release();
  }

  @override
  Future<void> addLayer(Layer layer, {String? belowLayerId}) async {
    // TODO: use JNI for this method
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
    final jniStyle = _jniStyle;
    final jniId = source.id.toJString();
    await runOnPlatformThread(() {
      final jni.Source jniSource;
      switch (source) {
        case GeoJsonSource():
          final jniOptions = jni.GeoJsonOptions();
          final jniData = source.data.toJString();
          if (source.data.startsWith('{')) {
            jniSource = jni.GeoJsonSource.new$4(jniId, jniData, jniOptions);
          } else {
            final jniUri = jni.URI.create(jniData);
            jniSource = jni.GeoJsonSource.new$8(jniId, jniUri, jniOptions);
            jniUri.release();
          }
          jniOptions.release();
        case RasterDemSource():
          jniSource = jni.RasterDemSource.new$4(
            jniId,
            source.url!.toJString(),
            source.tileSize,
          );
          // TODO apply other properties
          jniSource.setVolatile(source.volatile.toJBoolean());
        case RasterSource():
          if (source.url case final String url) {
            jniSource =
                jni.RasterSource.new$4(jniId, url.toJString(), source.tileSize);
          } else {
            final tilesArray = JArray(JString.type, source.tiles!.length);
            for (var i = 0; i < source.tiles!.length; i++) {
              tilesArray[i] = source.tiles![i].toJString();
            }
            final tileSet = jni.TileSet('{}'.toJString(), tilesArray)
              ..setMaxZoom(source.maxZoom)
              ..setMinZoom(source.minZoom);
            jniSource = jni.RasterSource.new$6(jniId, tileSet, source.tileSize);
            tilesArray.release();
            tileSet.release();
          }
          // TODO apply other properties
          jniSource.setVolatile(source.volatile.toJBoolean());
        case VectorSource():
          jniSource = jni.VectorSource.new$3(jniId, source.url!.toJString());
          // TODO apply other properties
          jniSource.setVolatile(source.volatile.toJBoolean());
        case ImageSource():
          final jniQuad = jni.LatLngQuad(
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
          );
          final jniUri = jni.URI(source.url.toJString());
          jniSource = jni.ImageSource.new$2(jniId, jniQuad, jniUri);
          jniUri.release();
          jniQuad.release();
        case VideoSource():
          throw UnimplementedError('Video source is only supported on web.');
      }
      jniStyle.addSource(jniSource);
      jniSource.release();
    });
  }

  @override
  void onStyleLoaded() {
    widget.onEvent?.call(const MapEventStyleLoaded());
    widget.onStyleLoaded?.call();
    _annotationManager = AnnotationManager(this, widget.layers);
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
  MapCamera getCamera() {
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
    jniCamera.target.release();
    jniCamera.release();
    return camera;
  }

  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async =>
      _jniProjection.getMetersPerPixelAtLatitude(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async {
    final projection = _jniProjection; // necessary to use it in platform thread
    final jniBounds = await runOnPlatformThread<jni.LatLngBounds>(() {
      final region = projection.getVisibleRegion();
      final bounds = region.latLngBounds;
      region.latLngBounds.release();
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
  Future<void> removeLayer(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle.removeLayer(id.toJString());
    });
  }

  @override
  Future<void> removeSource(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle.removeSource(id.toJString());
    });
  }

  @override
  Future<void> addImage(String id, Uint8List bytes) =>
      // TODO: use JNI for this method
      _hostApi.addImage(id, bytes);

  @override
  Future<void> removeImage(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle.removeImage(id.toJString());
    });
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      final source =
          jniStyle.getSourceAs(id.toJString(), T: jni.GeoJsonSource.type);
      source.setGeoJson$3(data.toJString());
    });
  }

  @override
  Future<void> enableLocation({
    Duration fastestInterval = const Duration(milliseconds: 750),
    Duration maxWaitTime = const Duration(seconds: 1),
    bool pulseFade = true,
    bool accuracyAnimation = true,
    bool compassAnimation = true,
    bool pulse = true,
    BearingRenderMode bearingRenderMode = BearingRenderMode.gps,
  }) async {
    // https://maplibre.org/maplibre-native/docs/book/android/location-component-guide.html
    final locationComponent = _locationComponent;
    final jniStyle = _jniStyle;
    final bearing = switch (bearingRenderMode) {
      BearingRenderMode.none => jni.RenderMode.NORMAL,
      BearingRenderMode.compass => jni.RenderMode.COMPASS,
      BearingRenderMode.gps => jni.RenderMode.GPS,
    };
    final jniContext = jni.MapLibreRegistry.INSTANCE.getContext();
    final locationComponentOptionsBuilder =
        jni.LocationComponentOptions.builder(jniContext)
            .pulseFadeEnabled(pulseFade)
            .accuracyAnimationEnabled(accuracyAnimation)
            .compassAnimationEnabled(compassAnimation.toJBoolean())
            .pulseEnabled(pulse);
    final locationComponentOptions = locationComponentOptionsBuilder.build();
    final locationEngineRequestBuilder =
        jni.LocationEngineRequest_Builder(750) // TODO integrate as parameter
            .setFastestInterval(fastestInterval.inMilliseconds)
            .setMaxWaitTime(maxWaitTime.inMilliseconds)
            .setPriority(jni.LocationEngineRequest.PRIORITY_HIGH_ACCURACY);
    final locationEngineRequest = locationEngineRequestBuilder.build();
    final activationOptions =
        jni.LocationComponentActivationOptions.builder(jniContext, jniStyle)
            .locationComponentOptions(locationComponentOptions)
            .useDefaultLocationEngine(true)
            .locationEngineRequest(locationEngineRequest)
            .build();

    await runOnPlatformThread(() {
      locationComponent.activateLocationComponent(activationOptions);
      locationComponent.setRenderMode(bearing);
      locationComponent.setLocationComponentEnabled(true);
    });

    locationComponentOptionsBuilder.release();
    locationComponentOptions.release();
    locationEngineRequestBuilder.release();
    locationEngineRequest.release();
    activationOptions.release();
    jniContext.release();
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    final locationComponent = _locationComponent;
    final mode = switch (trackBearing) {
      BearingTrackMode.none => trackLocation
          ? jni.CameraMode.TRACKING // only location
          : jni.CameraMode.NONE, // neither location nor bearing
      BearingTrackMode.compass => trackLocation
          ? jni.CameraMode.TRACKING_COMPASS // location with compass bearing
          : jni.CameraMode.NONE_COMPASS, // only compass bearing
      BearingTrackMode.gps => trackLocation
          ? jni.CameraMode.TRACKING_GPS // location with gps bearing
          : jni.CameraMode.NONE_GPS, // only gps bearing
    };
    await runOnPlatformThread(() {
      locationComponent.setCameraMode(mode);
    });
  }
}

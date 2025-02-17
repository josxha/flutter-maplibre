import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;

/// The implementation that gets used for state of the [MapLibreMap] widget on
/// android using JNI and Pigeon as a fallback.
abstract class MapLibreMapStateNative extends MapLibreMapState
    implements pigeon.MapLibreFlutterApi {
  @override
  void onMapReady() {
    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
    setState(() {
      camera = getCamera();
      isInitialized = true;
    });
  }

  @override
  void dispose() {
    style?.dispose();
    super.dispose();
  }

  @override
  pigeon.MapOptions getOptions() => pigeon.MapOptions(
    style: options.initStyle,
    bearing: options.initBearing,
    zoom: options.initZoom,
    pitch: options.initPitch,
    center:
        options.initCenter == null
            ? null
            : pigeon.LngLat(
                lng: options.initCenter!.lng.toDouble(),
                lat: options.initCenter!.lat.toDouble(),
              ),
        minZoom: options.minZoom,
        maxZoom: options.maxZoom,
        minPitch: options.minPitch,
        maxPitch: options.maxPitch,
        maxBounds: options.maxBounds?.toLngLatBounds(),
        gestures: pigeon.MapGestures(
          rotate: options.gestures.rotate,
          pan: options.gestures.pan,
          zoom: options.gestures.zoom,
          tilt: options.gestures.pitch,
          drag: options.gestures.drag,
        ),
        androidTextureMode: options.androidTextureMode,
      );

  @override
  void onMoveCamera(pigeon.MapCamera camera) {
    final mapCamera = MapCamera(
      center: camera.center.toPosition(),
      zoom: camera.zoom,
      pitch: camera.pitch,
      bearing: camera.bearing,
    );
    setState(() => this.camera = mapCamera);
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
  Future<void> onLongPress(
    pigeon.LongPressEventType event,
    pigeon.LngLat point,
  ) async {
    final position = point.toPosition();
    widget.onEvent?.call(
      event.toMapEventLongPress(point: position),
    );

    // ignore: no_leading_underscores_for_local_identifiers
    final _layerManager = layerManager;

    // If the layer manager is null, we can't handle any feature drag events.
    if (_layerManager == null) return;

    final isDragging = _layerManager.dragFeature != null;
    Feature? feature;

    if (event == pigeon.LongPressEventType.begin && !isDragging) {
      final screenLoc = await toScreenLocation(position);
      final draggableLayers =
          style?.getDraggableLayers().map((layer) => layer.id).toList() ?? [];
      if (draggableLayers.isEmpty) return;

      final features = await queryRenderedFeatures(
        screenLoc,
        layerIdsFilter: draggableLayers,
      );
      if (features.isEmpty) return;
      feature = features.first;

      final featureDragEvent = MapEventFeatureDrag(
        event: event.toMapEventLongPress(point: position),
        feature: feature,
      );

      await _layerManager.onFeatureDrag(featureDragEvent);
      widget.onEvent?.call(featureDragEvent);
    }

    if (isDragging) {
      final featureDragEvent = MapEventFeatureDrag(
        event: event.toMapEventLongPress(point: position),
        feature: _layerManager.dragFeature!,
      );

      await _layerManager.onFeatureDrag(featureDragEvent);
      widget.onEvent?.call(featureDragEvent);
    }
  }
}

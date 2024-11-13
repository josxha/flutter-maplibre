import 'dart:async';
import 'dart:js_interop';
import 'dart:math';
import 'dart:ui_web';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/web/extensions.dart';
import 'package:maplibre/src/platform/web/interop/interop.dart' as interop;
import 'package:maplibre/src/platform/web/interop/json.dart';
import 'package:web/web.dart';

/// The web specific implementation of the [MapLibreMap] widget.
final class MapLibreMapStateWeb extends MapLibreMapState {
  late HTMLDivElement _htmlElement;
  late interop.JsMap _map;
  Completer<interop.MapLibreEvent>? _movementCompleter;
  bool _nextGestureCausedByController = false;
  LayerManager? _layerManager;

  /// Get the [MapOptions] from [MapLibreMap.options].
  @override
  MapOptions get options => widget.options;

  @override
  void initState() {
    platformViewRegistry.registerViewFactory(
      viewName,
      (int viewId, [dynamic params]) {
        _htmlElement = HTMLDivElement()
          ..style.padding = '0'
          ..style.margin = '0'
          ..style.height = '100%'
          ..style.width = '100%';

        _map = interop.JsMap(
          interop.MapOptions(
            container: _htmlElement,
            style: options.initStyle,
            zoom: options.initZoom,
            center: options.initCenter?.toLngLat(),
            bearing: options.initBearing,
            pitch: options.initPitch,
            attributionControl: options.attribution,
          ),
        );

        document.body?.appendChild(_htmlElement);
        // Invoke the onMapCreated callback async to avoid getting it called
        // during the widget build.
        Future.delayed(Duration.zero, () {
          widget.onEvent?.call(MapEventMapCreated(mapController: this));
          widget.onMapCreated?.call(this);
          setState(() => isInitialized = true);
        });
        _resizeMap();

        // set options
        _map.setMinZoom(options.minZoom);
        _map.setMaxZoom(options.maxZoom);
        _map.setMinPitch(options.minPitch);
        _map.setMaxPitch(options.maxPitch);
        _map.setMaxBounds(options.maxBounds?.toJsLngLatBounds());
        _updateGestures(options.gestures);

        // add controls
        for (final control in options.webControls) {
          final jsControl = switch (control) {
            final WebScaleControl control => interop.ScaleControl(
                interop.ScaleControlOptions(
                  maxWidth: control.maxWidth,
                  unit: control.unit.name,
                ),
              ),
            final WebGeolocateControl control => interop.GeolocateControl(
                interop.GeolocateControlOptions(
                  positionOptions: interop.PositionOptions(
                    enableHighAccuracy:
                        control.positionOptions.enableHighAccuracy,
                    maximumAge:
                        control.positionOptions.maximumAge.inMilliseconds,
                    timeout: control.positionOptions.timeout.inMilliseconds,
                  ),
                ),
              ),
            final WebAttributionControl control => interop.AttributionControl(
                interop.AttributionControlOptions(
                  compact: control.compact,
                  customAttribution: control.customAttribution,
                ),
              ),
            final WebFullscreenControl _ => interop.FullscreenControl(
                interop.FullscreenControlOptions(),
              ),
            final WebLogoControl control => interop.LogoControl(
                interop.LogoControlOptions(compact: control.compact),
              ),
            final WebNavigationControl control => interop.NavigationControl(
                interop.NavigationControlOptions(
                  showCompass: control.showCompass,
                  showZoom: control.showZoom,
                  visualizePitch: control.visualizePitch,
                ),
              ),
            final WebTerrainControl control => interop.TerrainControl(
                interop.TerrainControlOptions(source: control.source),
              ),
          };
          _map.addControl(jsControl);
        }

        // add callbacks
        _map.on(
          interop.MapEventType.load,
          (interop.MapMouseEvent event) {
            widget.onEvent?.call(const MapEventStyleLoaded());
            widget.onStyleLoaded?.call();
            _layerManager = LayerManager(this, widget.layers);
            // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
            setState(() {});
          }.toJS,
        );
        _map.on(
          interop.MapEventType.click,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventClick(point: point));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.dblclick,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventDoubleClick(point: point));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.contextmenu,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventSecondaryClick(point: point));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.idle,
          (interop.MapMouseEvent event) {
            widget.onEvent?.call(const MapEventIdle());
          }.toJS,
        );
        _map.on(
          interop.MapEventType.moveStart,
          (interop.MapLibreEvent event) {
            final CameraChangeReason reason;
            if (_nextGestureCausedByController) {
              _nextGestureCausedByController = false;
              reason = CameraChangeReason.developerAnimation;
            } else if (event.originalEvent != null) {
              reason = CameraChangeReason.apiGesture;
            } else {
              reason = CameraChangeReason.apiAnimation;
            }
            widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.move,
          (interop.MapLibreEvent event) {
            final mapCamera = MapCamera(
              center: _map.getCenter().toPosition(),
              zoom: _map.getZoom().toDouble(),
              pitch: _map.getPitch().toDouble(),
              bearing: _map.getBearing().toDouble(),
            );
            setState(() => camera = mapCamera);
            widget.onEvent?.call(MapEventMoveCamera(camera: mapCamera));
          }.toJS,
        );
        _map.on(
          interop.MapEventType.moveEnd,
          (interop.MapLibreEvent event) {
            widget.onEvent?.call(const MapEventCameraIdle());
            if (!(_movementCompleter?.isCompleted ?? true)) {
              _movementCompleter?.complete(event);
            }
          }.toJS,
        );

        return _htmlElement;
      },
    );
    super.initState();
  }

  @override
  Widget buildPlatformWidget(BuildContext context) =>
      HtmlElementView(viewType: viewName);

  void _resizeMap() {
    final jsContainer = _map.getContainer();
    final jsCanvas = _map.getCanvas();
    final matchWidth = jsCanvas.clientWidth == jsContainer.clientWidth;
    final matchHeight = jsCanvas.clientHeight == jsContainer.clientHeight;
    if (matchWidth && matchHeight) return;
    _map.resize();
  }

  @override
  void dispose() {
    _map.remove();
    _htmlElement.remove();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    if (options.minZoom != oldWidget.options.minZoom) {
      _map.setMinZoom(options.minZoom);
    }
    if (options.maxZoom != oldWidget.options.maxZoom) {
      _map.setMaxZoom(options.maxZoom);
    }
    if (options.minPitch != oldWidget.options.minPitch) {
      _map.setMinPitch(options.minPitch);
    }
    if (options.maxPitch != oldWidget.options.maxPitch) {
      _map.setMaxPitch(options.maxPitch);
    }
    if (options.maxBounds != oldWidget.options.maxBounds) {
      _map.setMaxBounds(options.maxBounds?.toJsLngLatBounds());
    }
    if (options.gestures != oldWidget.options.gestures) {
      _updateGestures(options.gestures);
    }
    _layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Position toLngLatSync(Offset screenLocation) =>
      _map.unproject(screenLocation.toJsPoint()).toPosition();

  @override
  List<Position> toLngLatsSync(List<Offset> screenLocations) => screenLocations
      .map((offset) => _map.unproject(offset.toJsPoint()).toPosition())
      .toList(growable: false);

  @override
  Offset toScreenLocationSync(Position lngLat) =>
      _map.project(lngLat.toLngLat()).toOffset();

  @override
  List<Offset> toScreenLocationsSync(List<Position> lngLats) => lngLats
      .map((lngLat) => _map.project(lngLat.toLngLat()).toOffset())
      .toList(growable: false);

  @override
  Future<Position> toLngLat(Offset screenLocation) async =>
      toLngLatSync(screenLocation);

  @override
  Future<Offset> toScreenLocation(Position lngLat) async =>
      toScreenLocationSync(lngLat);

  @override
  Future<List<Position>> toLngLats(List<Offset> screenLocations) async =>
      toLngLatsSync(screenLocations);

  @override
  Future<List<Offset>> toScreenLocations(List<Position> lngLats) async =>
      toScreenLocationsSync(lngLats);

  @override
  Future<void> moveCamera({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    _nextGestureCausedByController = true;
    _map.jumpTo(
      interop.JumpToOptions(
        center: center?.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
      ),
    );
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
    final destination = center?.toLngLat();
    _nextGestureCausedByController = true;
    _map.flyTo(
      interop.FlyToOptions(
        center: destination,
        zoom: zoom,
        bearing: bearing,
        pitch: pitch,
        speed: webSpeed,
        maxDuration: webMaxDuration?.inMilliseconds,
      ),
    );
    final completer = _movementCompleter = Completer<interop.MapLibreEvent>();
    final _ = await completer.future;
    _movementCompleter = null;

    // check if the targeted values were reached or if the flight was cancelled
    final newCenter = _map.getCenter();
    bool reachedCenter;
    if (destination == null) {
      reachedCenter = true;
    } else {
      final reachedLng = (destination.lng - newCenter.lng).abs() < 0.0000001;
      final reachedLat = (destination.lat - newCenter.lat).abs() < 0.0000001;
      reachedCenter = reachedLat && reachedLng;
    }
    final reachedZoom = zoom == null || zoom == _map.getZoom();
    final reachedBearing = bearing == null || bearing == _map.getBearing();
    final reachedPitch = pitch == null || pitch == _map.getPitch();

    if (reachedCenter && reachedZoom && reachedBearing && reachedPitch) return;

    throw PlatformException(
      code: 'CancellationException',
      message: 'Animation cancelled.',
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
  }) async =>
      _map.fitBounds(
        bounds.toJsLngLatBounds(),
        interop.FitBoundsOptions(
          offset: offset.toJsPoint(),
          maxZoom: webMaxZoom,
          linear: webLinear,
          maxDuration: webMaxDuration?.inMilliseconds,
          padding: padding.toPaddingOptions(),
          speed: webSpeed,
          pitch: pitch,
          bearing: bearing,
        ),
      );

  @override
  Future<void> addSource(Source source) async {
    switch (source) {
      case GeoJsonSource():
        JSAny data;
        if (source.data[0] == '{') {
          data = parse(source.data);
        } else {
          data = source.data.jsify()!;
        }
        _map.addSource(
          source.id,
          interop.SourceSpecification.geoJson(
            type: 'geojson',
            data: data,
          ),
        );
      case RasterDemSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.rasterDem(
            type: 'raster-dem',
            tileSize: source.tileSize,
            attribution: source.attribution,
            url: source.url,
          ),
        );
      case RasterSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.raster(
            type: 'raster',
            attribution: source.attribution,
            tileSize: source.tileSize,
            tiles: source.tiles.jsify(),
          ),
        );
      case VectorSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.vector(
            type: 'vector',
            url: source.url,
          ),
        );
      case ImageSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.image(
            type: 'image',
            url: source.url,
            coordinates: source.coordinates
                .map(
                  (e) => [e.lng, e.lat],
                )
                .toList(growable: false)
                .jsify()!,
          ),
        );
      case VideoSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.video(
            type: 'video',
            urls: source.urls.jsify()!,
            coordinates: source.coordinates
                .map(
                  (e) => [e.lng, e.lat],
                )
                .toList(growable: false)
                .jsify()!,
          ),
        );
    }
  }

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    switch (layer) {
      case FillStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'fill',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case CircleStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'circle',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case BackgroundStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'background',
            source: null,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case FillExtrusionStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'fill-extrusion',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case HeatmapStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'heatmap',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case HillshadeStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'hillshade',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case LineStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'line',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case RasterStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'raster',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case SymbolStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'symbol',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
    }
  }

  @override
  MapCamera getCamera() => MapCamera(
        center: _map.getCenter().toPosition(),
        zoom: _map.getZoom().toDouble(),
        pitch: _map.getPitch().toDouble(),
        bearing: _map.getBearing().toDouble(),
      );

  /// https://wiki.openstreetmap.org/wiki/Zoom_levels
  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async =>
      getMetersPerPixelAtLatitudeSync(latitude);

  @override
  Future<LngLatBounds> getVisibleRegion() async => getVisibleRegionSync();

  @override
  double getMetersPerPixelAtLatitudeSync(double latitude) =>
      circumferenceOfEarth *
      cos(latitude * degree2Radian) /
      pow(2, _map.getZoom() + 9);

  @override
  LngLatBounds getVisibleRegionSync() {
    final bounds = _map.getBounds();
    return LngLatBounds(
      longitudeWest: bounds.getWest().toDouble(),
      longitudeEast: bounds.getEast().toDouble(),
      latitudeSouth: bounds.getSouth().toDouble(),
      latitudeNorth: bounds.getNorth().toDouble(),
    );
  }

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    final image = await decodeImageFromList(bytes);
    final byteData = await image.toByteData();
    _map.addImage(
      id,
      interop.ImageSpecification(
        width: image.width,
        height: image.height,
        data: byteData!.buffer.asUint8List().toJS,
      ),
    );
  }

  @override
  Future<void> removeImage(String id) async => _map.removeImage(id);

  @override
  Future<void> removeLayer(String id) async => _map.removeLayer(id);

  @override
  Future<void> removeSource(String id) async => _map.removeSource(id);

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final source = _map.getSource(id);
    if (source == null) throw Exception('Source with id "$id" does not exist.');
    source.setData(parse(data));
  }

  void _updateGestures(MapGestures gestures) {
    if (gestures.pan) {
      _map.dragPan.enable();
    } else {
      _map.dragPan.disable();
    }
    if (gestures.zoom) {
      _map.touchZoomRotate.enable();
      _map.doubleClickZoom.enable();
      _map.scrollZoom.enable();
      _map.boxZoom.enable();
    } else {
      _map.touchZoomRotate.disable(); // this disables rotation as well
      _map.doubleClickZoom.disable();
      _map.scrollZoom.disable();
      _map.boxZoom.disable();
    }
    if (gestures.rotate) {
      _map.dragRotate.enable();
      _map.touchZoomRotate.disableRotation();
    } else {
      _map.touchZoomRotate.enableRotation();
      _map.dragRotate.disable();
    }
    if (gestures.pitch) {
      // TODO dragRotate allows to pitch too but has no option to disable pitch.
      _map.touchPitch.enable();
    } else {
      _map.touchPitch.disable();
    }
    // It's not possible to disable just some gestures for the KeyboardHandler.
    // That's why we disable it completely if not all gestures are enabled.
    if (gestures.allEnabled) {
      _map.keyboard.enable();
    } else {
      _map.keyboard.disable();
    }
  }

  @override
  Future<void> enableLocation({
    Duration fastestInterval = const Duration(milliseconds: 750),
    Duration maxWaitTime = const Duration(seconds: 1),
    bool pulseFade = true,
    bool accuracyAnimation = true,
    bool compassAnimation = true,
    bool pulse = true,
  }) async {
    debugPrint("Can't enable the user location on web programmatically.");
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    debugPrint("Can't track the user location on web.");
  }

  @override
  Future<List<QueriedLayer>> queryLayers(
    Offset screenLocation,
  ) async {
    final features =
        _map.queryRenderedFeatures(screenLocation.toJsPoint(), null);
    return features.toDart
        .map(
          (e) => QueriedLayer(
            layerId: e.layer.id,
            sourceId: e.source,
            sourceLayer: e.sourceLayer,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<String>> getAttributions() async {
    final jsStyle = _map.getStyle();
    final sources = jsStyle?.sources.dartify() as Map<Object?, Object?>?;
    if (sources == null) return const [];
    final attributions = <String>[];
    for (final value in sources.values) {
      final source = value! as Map<Object?, Object?>;
      final attribution = source['attribution'];
      if (attribution == null) continue;
      if (attribution is String && attribution.isEmpty) continue;
      attributions.add(attribution.toString());
    }
    return attributions;
  }
}

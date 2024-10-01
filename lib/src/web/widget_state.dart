import 'dart:async';
import 'dart:js_interop';
import 'dart:math';
import 'dart:ui_web';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/web/extensions.dart';
import 'package:maplibre/src/web/interop/interop.dart' as interop;
import 'package:maplibre/src/web/interop/json.dart';
import 'package:web/web.dart';

/// The web specific implementation of the [MapLibreMap] widget.
final class MapLibreMapStateWeb extends State<MapLibreMap>
    implements MapController {
  static int _counter = 0;
  final _viewName = 'plugins.flutter.io/maplibre${_counter++}';
  late HTMLDivElement _htmlElement;
  late interop.JsMap _map;
  Completer<interop.MapLibreEvent>? _movementCompleter;
  bool _nextGestureCausedByController = false;

  MapOptions get _options => widget.options;

  @override
  void initState() {
    platformViewRegistry.registerViewFactory(
      _viewName,
      (int viewId, [dynamic params]) {
        _htmlElement = HTMLDivElement()
          ..style.padding = '0'
          ..style.margin = '0'
          ..style.height = '100%'
          ..style.width = '100%';

        _map = interop.JsMap(
          interop.MapOptions(
            container: _htmlElement,
            style: _options.style,
            zoom: _options.zoom,
            center: _options.center?.toLngLat(),
            bearing: _options.bearing,
            pitch: _options.pitch,
          ),
        );

        document.body?.appendChild(_htmlElement);
        // Invoke the onMapCreated callback async to avoid getting it called
        // during the widget build.
        Future.delayed(
          Duration.zero,
          () => widget.onEvent?.call(MapEventMapCreated(mapController: this)),
        );
        Future.delayed(Duration.zero, () => widget.onMapCreated?.call(this));
        _resizeMap();

        // set options
        _map.setMinZoom(_options.minZoom);
        _map.setMaxZoom(_options.maxZoom);
        _map.setMinPitch(_options.minPitch);
        _map.setMaxPitch(_options.maxPitch);
        _map.setMaxBounds(_options.maxBounds?.toJsLngLatBounds());
        _updateGestures(_options.gestures);

        // add controls
        for (final control in _options.webControls) {
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
            final LogoControl control => interop.LogoControl(
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
            for (final layer in widget.layers) {
              layer.registerController(this);
            }
          }.toJS,
        );
        _map.on(
          interop.MapEventType.click,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventClick(point: point));
            // ignore: deprecated_member_use_from_same_package
            _options.onClick?.call(point);
          }.toJS,
        );
        _map.on(
          interop.MapEventType.dblclick,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventDoubleClick(point: point));
            // ignore: deprecated_member_use_from_same_package
            _options.onDoubleClick?.call(point);
          }.toJS,
        );
        _map.on(
          interop.MapEventType.contextmenu,
          (interop.MapMouseEvent event) {
            final point = event.lngLat.toPosition();
            widget.onEvent?.call(MapEventSecondaryClick(point: point));
            // ignore: deprecated_member_use_from_same_package
            _options.onSecondaryClick?.call(point);
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
            final camera = MapCamera(
              center: _map.getCenter().toPosition(),
              zoom: _map.getZoom().toDouble(),
              pitch: _map.getPitch().toDouble(),
              bearing: _map.getBearing().toDouble(),
            );
            widget.onEvent?.call(MapEventMoveCamera(camera: camera));
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
  Widget build(BuildContext context) => HtmlElementView(viewType: _viewName);

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
    if (_options.minZoom != oldWidget.options.minZoom) {
      _map.setMinZoom(_options.minZoom);
    }
    if (_options.maxZoom != oldWidget.options.maxZoom) {
      _map.setMaxZoom(_options.maxZoom);
    }
    if (_options.minPitch != oldWidget.options.minPitch) {
      _map.setMinPitch(_options.minPitch);
    }
    if (_options.maxPitch != oldWidget.options.maxPitch) {
      _map.setMaxPitch(_options.maxPitch);
    }
    if (_options.maxBounds != oldWidget.options.maxBounds) {
      _map.setMaxBounds(_options.maxBounds?.toJsLngLatBounds());
    }
    if (_options.gestures != oldWidget.options.gestures) {
      _updateGestures(_options.gestures);
    }
    for (final layer in widget.layers) {
      layer.updateOnMap(this);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) async =>
      _map.unproject(screenLocation.toJsPoint()).toPosition();

  @override
  Future<Offset> toScreenLocation(Position lngLat) async =>
      _map.project(lngLat.toLngLat()).toOffset();

  @override
  Future<void> jumpTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? pitch,
    @Deprecated('Renamed to pitch') double? tilt,
  }) async {
    _nextGestureCausedByController = true;
    _map.jumpTo(
      interop.JumpToOptions(
        center: center?.toLngLat(),
        zoom: zoom,
        bearing: bearing,
        pitch: pitch ?? tilt,
      ),
    );
  }

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
  }) async {
    final destination = center?.toLngLat();
    _nextGestureCausedByController = true;
    _map.flyTo(
      interop.FlyToOptions(
        center: destination,
        zoom: zoom,
        bearing: bearing,
        pitch: pitch ?? tilt,
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
  Future<void> addLayer(Layer layer, {String? belowLayerId}) async {
    switch (layer) {
      case FillLayer():
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
      case CircleLayer():
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
      case BackgroundLayer():
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
      case FillExtrusionLayer():
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
      case HeatmapLayer():
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
      case HillshadeLayer():
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
      case LineLayer():
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
      case RasterLayer():
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
      case SymbolLayer():
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
  Future<MapCamera> getCamera() async => MapCamera(
        center: _map.getCenter().toPosition(),
        zoom: _map.getZoom().toDouble(),
        pitch: _map.getPitch().toDouble(),
        bearing: _map.getBearing().toDouble(),
      );

  @override
  Future<double> getMetersPerPixelAtLatitude(double latitude) async {
    final zoom = _map.getZoom();
    // https://wiki.openstreetmap.org/wiki/Zoom_levels
    return circumferenceOfEarth *
        cos(latitude * radian2degree) /
        pow(2, zoom + 9);
  }

  @override
  Future<LngLatBounds> getVisibleRegion() async {
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
}

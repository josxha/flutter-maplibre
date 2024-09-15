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
  late interop.Map _map;
  Completer<interop.MapLibreEvent>? _moveCompleter;

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

        _map = interop.Map(
          interop.MapOptions(
            container: _htmlElement,
            style: _options.style,
            zoom: _options.zoom,
            center: _options.center?.toLngLat(),
            bearing: _options.bearing,
            pitch: _options.tilt,
          ),
        );

        document.body?.appendChild(_htmlElement);
        // Invoke the onMapCreated callback async to avoid getting it called
        // during the widget build.
        Future.delayed(Duration.zero, () => widget.onMapCreated?.call(this));
        _resizeMap();

        // add controls
        for (final control in _options.controls) {
          final jsControl = switch (control) {
            final ScaleControl control => interop.ScaleControl(
                interop.ScaleControlOptions(
                  maxWidth: control.maxWidth,
                  unit: control.unit.name,
                ),
              ),
            final GeolocateControl control => interop.GeolocateControl(
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
            final AttributionControl control => interop.AttributionControl(
                interop.AttributionControlOptions(
                  compact: control.compact,
                  customAttribution: control.customAttribution,
                ),
              ),
            final FullscreenControl _ => interop.FullscreenControl(
                interop.FullscreenControlOptions(),
              ),
            final LogoControl control => interop.LogoControl(
                interop.LogoControlOptions(compact: control.compact),
              ),
            final NavigationControl control => interop.NavigationControl(
                interop.NavigationControlOptions(
                  showCompass: control.showCompass,
                  showZoom: control.showZoom,
                  visualizePitch: control.visualizePitch,
                ),
              ),
            final TerrainControl control => interop.TerrainControl(
                interop.TerrainControlOptions(source: control.source),
              ),
          };
          _map.addControl(jsControl);
        }
        // add callbacks
        if (widget.onStyleLoaded case final VoidCallback callback) {
          _map.on(
            interop.MapEventType.load,
            (interop.MapMouseEvent event) {
              callback();
            }.toJS,
          );
        }
        if (_options.onClick case final OnClickCallback callback) {
          _map.on(
            interop.MapEventType.click,
            (interop.MapMouseEvent event) {
              callback(event.lngLat.toPosition());
            }.toJS,
          );
        }
        if (_options.onDoubleClick case final OnClickCallback callback) {
          _map.on(
            interop.MapEventType.dblclick,
            (interop.MapMouseEvent event) {
              callback(event.lngLat.toPosition());
            }.toJS,
          );
        }
        if (_options.onSecondaryClick case final OnClickCallback callback) {
          _map.on(
            interop.MapEventType.contextmenu,
            (interop.MapMouseEvent event) {
              callback(event.lngLat.toPosition());
            }.toJS,
          );
        }
        _map.on(
          interop.MapEventType.moveEnd,
          (interop.MapLibreEvent event) {
            if (_moveCompleter?.isCompleted ?? true) return;
            _moveCompleter?.complete(event);
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
  Future<Marker> addMarker(Marker marker) async {
    final lngLat = interop.LngLat(
      lng: marker.point.lng,
      lat: marker.point.lat,
    );
    final _ = interop.Marker(
      interop.MarkerOptions(
        color: marker.color == null
            ? null
            : '#${marker.color!.value.toRadixString(16)}',
        draggable: marker.draggable,
      ),
    ).setLngLat(lngLat).addTo(_map);
    return marker;
  }

  @override
  Future<Position> toLngLat(Offset screenLocation) async {
    final lngLat = _map.unproject(
      interop.Point(screenLocation.dx, screenLocation.dy),
    );
    return lngLat.toPosition();
  }

  @override
  Future<Offset> toScreenLocation(Position lngLat) async {
    final screenPosition = _map.project(lngLat.toLngLat());
    return Offset(screenPosition.x.toDouble(), screenPosition.y.toDouble());
  }

  @override
  Future<void> jumpTo({
    Position? center,
    double? zoom,
    double? bearing,
    double? tilt,
  }) async =>
      _map.jumpTo(
        interop.JumpToOptions(
          center: center?.toLngLat(),
          zoom: zoom,
          bearing: bearing,
          pitch: tilt,
        ),
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
  }) async {
    final destination = center?.toLngLat();
    _map.flyTo(
      interop.FlyToOptions(
        center: destination,
        zoom: zoom,
        bearing: bearing,
        pitch: tilt,
        speed: webSpeed,
        maxDuration: maxDuration?.inMilliseconds,
      ),
    );
    final completer = _moveCompleter = Completer<interop.MapLibreEvent>();
    final _ = await completer.future;
    _moveCompleter = null;

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
    final reachedTilt = tilt == null || tilt == _map.getPitch();

    if (reachedCenter && reachedZoom && reachedBearing && reachedTilt) return;

    throw PlatformException(
      code: 'CancellationException',
      message: 'Animation cancelled.',
    );
  }

  @override
  Future<void> addSource(Source source) async {
    switch (source) {
      case GeoJsonSource():
        final data = parse(source.data);
        _map.addSource(
          source.id,
          interop.SourceSpecification.geoJson(type: 'geojson', data: data),
        );
    }
  }

  @override
  Future<void> addLayer(Layer layer) async {
    switch (layer) {
      case FillLayer():
        _map.addLayer(
          interop.AddLayerObject(
            id: layer.id,
            type: 'fill',
            source: layer.sourceId,
          ),
        );
      case CircleLayer():
        _map.addLayer(
          interop.AddLayerObject(
            id: layer.id,
            type: 'circle',
            source: layer.sourceId,
          ),
        );
    }
  }

  @override
  Future<MapCamera> getCamera() async => MapCamera(
        center: _map.getCenter().toPosition(),
        zoom: _map.getZoom().toDouble(),
        tilt: _map.getPitch().toDouble(),
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
}

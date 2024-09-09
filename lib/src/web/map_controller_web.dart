import 'dart:js_interop';
import 'dart:ui_web';

import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/web/extensions.dart';
import 'package:maplibre/src/web/interop/interop.dart' as interop;
import 'package:web/web.dart';

class MapControllerWeb extends MapControllerInternal {
  MapControllerWeb(super.mapWidget) {
    platformViewRegistry.registerViewFactory(
      _viewName,
      (int viewId) {
        _htmlElement = HTMLDivElement()
          ..style.padding = '0'
          ..style.margin = '0'
          ..style.height = '100%'
          ..style.width = '100%';
        initPlatform(viewId);
        onPlatformViewCreated(viewId);
        return _htmlElement;
      },
    );
  }

  late HTMLDivElement _htmlElement;
  late interop.Map _map;
  static const _viewName = 'plugins.flutter.io/maplibre';

  @override
  void dispose() {
    _map.remove();
    _htmlElement.remove();
  }

  @override
  Widget buildWidget() => const HtmlElementView(viewType: _viewName);

  @override
  Future<void> initPlatform(int viewId) async {
    _map = interop.Map(
      interop.MapOptions(
        container: _htmlElement,
        style: options.style,
        zoom: options.zoom,
        center: options.center?.toLngLat(),
      ),
    );
    // add controls
    for (final control in options.controls) {
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
                enableHighAccuracy: control.positionOptions.enableHighAccuracy,
                maximumAge: control.positionOptions.maximumAge.inMilliseconds,
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
    if (options.onClick case final OnClickCallback callback) {
      _map.on(
        interop.MapEventType.click,
        (interop.MapMouseEvent event) {
          callback(event.lngLat.toPosition());
        }.toJS,
      );
    }
    if (options.onDoubleClick case final OnClickCallback callback) {
      _map.on(
        interop.MapEventType.dblclick,
        (interop.MapMouseEvent event) {
          callback(event.lngLat.toPosition());
        }.toJS,
      );
    }
    if (options.onSecondaryClick case final OnClickCallback callback) {
      _map.on(
        interop.MapEventType.contextmenu,
        (interop.MapMouseEvent event) {
          callback(event.lngLat.toPosition());
        }.toJS,
      );
    }
    document.body?.appendChild(_htmlElement);
    _resizeMap();
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
  Future<void> addGeoJsonSource({
    required String id,
    required Map<String, Object?> geoJson,
  }) async {
    _map.addSource(
      id,
      interop.SourceSpecification.geoJson(
        type: 'geojson',
        data: geoJson.jsify()!,
      ),
    );
  }

  @override
  Future<void> addLayer({
    required String id,
    required String type,
    required String source,
  }) async {
    _map.addLayer(
      interop.AddLayerObject(id: id, type: type, source: source),
    );
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

  void _resizeMap() {
    final jsContainer = _map.getContainer();
    final jsCanvas = _map.getCanvas();
    final matchWidth = jsCanvas.clientWidth == jsContainer.clientWidth;
    final matchHeight = jsCanvas.clientHeight == jsContainer.clientHeight;
    if (matchWidth && matchHeight) return;
    _map.resize();
  }

  @override
  Future<void> jumpTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async =>
      _map.jumpTo(
        interop.JumpToOptions(
          center: center.toLngLat(),
          zoom: zoom,
          bearing: bearing,
          pitch: pitch,
        ),
      );

  @override
  Future<void> flyTo({
    required Position center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async =>
      _map.flyTo(
        interop.FlyToOptions(
          center: center.toLngLat(),
          zoom: zoom,
          bearing: bearing,
          pitch: pitch,
        ),
      );

  @override
  Future<void> addGeoJson({
    required String id,
    required Map<String, Object?> geoJson,
  }) async {}

  void onPlatformViewCreated(int viewId) {}
}

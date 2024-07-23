// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:js_interop';
import 'dart:ui_web';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform_interface.dart';
import 'package:maplibre/src/web/interop/interop.dart' as interop;
import 'package:web/web.dart' as web;
import 'package:web/web.dart';

/// A web implementation of the MapLibrePlatform of the MapLibre plugin.
class MapLibreWeb extends MapLibrePlatform {
  /// Constructs a MapLibreWeb
  MapLibreWeb();

  late MapOptions _options;
  late interop.Map _map;
  late web.HTMLDivElement _htmlElement;

  static void registerWith(Registrar registrar) {
    MapLibrePlatform.instance = MapLibreWeb();
  }

  @override
  Widget buildWidget({
    required MapOptions options,
    required PlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) {
    final id = hashCode;
    _options = options;
    platformViewRegistry.registerViewFactory(
      'plugins.flutter.io/maplibre_$id',
      (int viewId) {
        _htmlElement = web.HTMLDivElement()
          ..style.position = 'absolute'
          ..style.top = '0'
          ..style.bottom = '0'
          ..style.height = '100%'
          ..style.width = '100%';
        onPlatformViewCreated(viewId);
        return _htmlElement;
      },
    );
    return HtmlElementView(viewType: 'plugins.flutter.io/maplibre_$id');
  }

  @override
  Future<void> initPlatform(int id) async {
    _map = interop.Map(
      interop.MapOptions(
        container: _htmlElement,
        style: _options.style,
        zoom: _options.zoom,
        center: _options.center == null
            ? null
            : interop.LngLat(
                lng: _options.center!.lng,
                lat: _options.center!.lat,
              ),
      ),
    );
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

    document.body?.appendChild(_htmlElement);
  }

  @override
  Future<Marker> addMarker(Marker marker) async {
    final lngLat = interop.LngLat(
      lng: marker.point.lng,
      lat: marker.point.lat,
    );
    final jsMarker = interop.Marker(
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
  Future<void> addGeoJson(Map<String, Object?> geoJson) async {
    final data = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          // "properties": {},
          "geometry": {
            "coordinates": [
              [
                [9.570030804704544, 47.61463633922685],
                [9.480843256293724, 47.672241812969105],
                [9.327726499163191, 47.68863413494472],
                [9.232866820776195, 47.75728613074429],
                [9.050020668502242, 47.832048274681114],
                [9.004690998277681, 47.80849716551975],
                [9.132521291255188, 47.734252360212196],
                [9.00613066412555, 47.74963207515458],
                [8.96100396895514, 47.754374971146405],
                [8.918799471729244, 47.72937978505783],
                [8.974321577483465, 47.6952900028987],
                [8.902162397192129, 47.66615907983159],
                [8.8360194797431, 47.669795326126064],
                [8.823598733316686, 47.653926669250694],
                [8.91811582992662, 47.629099959084215],
                [9.007037673370888, 47.6603556769127],
                [9.097142093689541, 47.65424981401924],
                [9.199817806710826, 47.63024641380167],
                [9.327187221144726, 47.57345598444377],
                [9.471422735903502, 47.46273744409069],
                [9.560081882751376, 47.469093157582876],
                [9.65108729682919, 47.438666000154825],
                [9.7877547618979, 47.50228193807155],
                [9.757092924438524, 47.54579541163386],
                [9.570030804704544, 47.61463633922685]
              ]
            ],
            "type": "Polygon"
          },
          "style": {"fill": "red", "stroke-width": "3", "fill-opacity": 0.6}
        }
      ]
    };

    _map.addSource(
      'test123',
      interop.SourceSpecification.geoJson(type: 'geojson', data: data.jsify()!),
    );
    _map.addLayer(
      interop.AddLayerObject(
        id: 'test123',
        type: 'line',
        source: 'test123',
      ),
    );
  }
}

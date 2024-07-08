// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

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
      final controlInterop = switch (control) {
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
      _map.addControl(controlInterop);
    }

    final marker = interop.Marker(
      interop.MarkerOptions(
        //color: '#FFF',
        draggable: true,
      )
    )
        .setLngLat(
          interop.LngLat(
            lng: _options.center!.lng,
            lat: _options.center!.lat,
          ),
        )
        .addTo(_map);

    document.body?.appendChild(_htmlElement);
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/webview/style_controller.dart';

/// MapLibre GL JS using web views for desktop.
class MapLibreMapStateWebView extends MapLibreMapState {
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    // PlatformInAppWebViewController.debugLoggingSettings.enabled = false;
    super.initState();
  }

  @override
  Future<void> animateCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
    Duration nativeDuration = const Duration(seconds: 2),
    double webSpeed = 1.2,
    Duration? webMaxDuration,
  }) async {
    await _webViewController.evaluateJavascript(
      source: '''
  window.mapControls.flyTo(13.4050, 52.5200, 12);
''',
    );
  }

  @override
  Widget buildPlatformWidget(BuildContext context) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(
        data: '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/maplibre-gl@^5.15.0/dist/maplibre-gl.js"></script>
    <link href="https://unpkg.com/maplibre-gl@^5.15.0/dist/maplibre-gl.css" rel="stylesheet"/>
    <style>
      html, body, #map { margin: 0; height: 100%; width: 100%; }
    </style>
</head>
<body>
    <div id="map"></div>
</body>
</html>
''',
      ),
      onWebViewCreated: (controller) async {
        _webViewController = controller;
        widget.onMapCreated?.call(this);
        widget.onEvent?.call(MapEventMapCreated(mapController: this));
        controller.addJavaScriptHandler(
          handlerName: 'mapEvent',
          callback: _onMapEvent,
        );
      },
      onLoadStop: _onLoadStop,
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint(consoleMessage.message);
      },
    );
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
  }) {
    // TODO: implement enableLocation
    throw UnimplementedError();
  }

  @override
  List<RenderedFeature> featuresAtPoint(
    Offset point, {
    List<String>? layerIds,
  }) {
    // TODO: implement featuresAtPoint
    throw UnimplementedError();
  }

  @override
  List<RenderedFeature> featuresInRect(Rect rect, {List<String>? layerIds}) {
    // TODO: implement featuresInRect
    throw UnimplementedError();
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
  }) {
    // TODO: implement fitBounds
    throw UnimplementedError();
  }

  @override
  MapCamera getCamera() {
    // TODO: implement getCamera
    throw UnimplementedError();
  }

  @override
  double getMetersPerPixelAtLatitude(double latitude) {
    // TODO: implement getMetersPerPixelAtLatitude
    throw UnimplementedError();
  }

  @override
  LngLatBounds getVisibleRegion() {
    // TODO: implement getVisibleRegion
    throw UnimplementedError();
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    await _webViewController.evaluateJavascript(
      source: '''
  window.mapControls.jumpTo(13.4050, 52.5200, 12);
''',
    );
  }

  @override
  List<QueriedLayer> queryLayers(Offset screenLocation) {
    // TODO: implement queryLayers
    throw UnimplementedError();
  }

  @override
  Future<void> setStyle(String style) async {
    await _webViewController.evaluateJavascript(
      source:
          '''
  window.mapControls.setStyle('$style');
''',
    );
  }

  @override
  StyleControllerWebView? style;

  @override
  Geographic toLngLat(Offset screenLocation) {
    // TODO: implement toLngLat
    throw UnimplementedError();
  }

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) {
    // TODO: implement toLngLats
    throw UnimplementedError();
  }

  @override
  Offset toScreenLocation(Geographic lngLat) {
    // TODO: implement toScreenLocation
    throw UnimplementedError();
  }

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) {
    // TODO: implement toScreenLocations
    throw UnimplementedError();
  }

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) {
    // TODO: implement trackLocation
    throw UnimplementedError();
  }

  void _onMapEvent(List<dynamic> args) {
    final data = args[0] as Map<String, dynamic>;
    switch (data['type']) {
      case 'moveend':
        widget.onEvent?.call(const MapEventCameraIdle());
      case 'move':
        debugPrint('Move to ${data['lat']}, ${data['lng']}');
        widget.onEvent?.call(
          MapEventMoveCamera(
            camera: MapCamera(
              center: Geographic(
                lon: (data['lng'] as num).toDouble(),
                lat: (data['lat'] as num).toDouble(),
              ),
              zoom: (data['zoom'] as num).toDouble(),
              bearing: 0,
              pitch: 0,
            ),
          ),
        );
      case 'click':
        widget.onEvent?.call(
          MapEventClick(
            point: Geographic(
              lon: (data['lng'] as num).toDouble(),
              lat: (data['lat'] as num).toDouble(),
            ),
            screenPoint: Offset.zero,
          ),
        );
    }
  }

  void _onLoadStop(InAppWebViewController controller, WebUri? url) {
    debugPrint('_onLoadStop: $url');
    controller.evaluateJavascript(
      source: '''
    const map = new maplibregl.Map({
        container: 'map',
        style: '${widget.options.initStyle}',
        center: [0, 0],
        zoom: ${widget.options.initZoom}
    });
    map.on('moveend', () => {
        const center = map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            {
                type: 'moveend',
                lng: center.lng,
                lat: center.lat,
                zoom: map.getZoom()
            }
        );
    });
    map.on('move', () => {
        const center = map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            {
                type: 'move',
                lng: center.lng,
                lat: center.lat,
                zoom: map.getZoom()
            }
        );
    });
    map.on('click', (e) => {
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            {
                type: 'click',
                lng: e.lngLat.lng,
                lat: e.lngLat.lat
            }
        );
    });

    window.mapControls = {
        flyTo: (lng, lat, zoom) => {
            map.flyTo({ center: [lng, lat], zoom });
        },
        jumpTo: (lng, lat, zoom) => {
            map.jumpTo({ center: [lng, lat], zoom });
        },
        setStyle: (styleUrl) => {
            map.setStyle(styleUrl);
        }
    };  
''',
    );
  }
}

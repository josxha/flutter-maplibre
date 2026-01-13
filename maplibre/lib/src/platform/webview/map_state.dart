import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/webview/style_controller.dart';

/// MapLibre GL JS using web views for desktop.
class MapLibreMapStateWebView extends MapLibreMapState {
  late InAppWebViewController _webViewController;
  @override
  StyleControllerWebView? style;

  LayerManager? _layerManager;

  @override
  void initState() {
    PlatformInAppWebViewController.debugLoggingSettings.enabled = kDebugMode;
    super.initState();
  }

  @override
  Widget buildPlatformWidget(BuildContext context) {
    return InAppWebView(
      initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
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
        controller.addJavaScriptHandler(
          handlerName: 'mapEvent',
          callback: _onMapEvent,
        );
        widget.onEvent?.call(MapEventMapCreated(mapController: this));
        widget.onMapCreated?.call(this);
        // unawaited(_fetchCamera());
        setState(() => isInitialized = true);
      },
      onLoadStop: _onLoadStop,
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint(consoleMessage.message);
      },
    );
  }

  @override
  void didUpdateWidget(covariant MapLibreMap oldWidget) {
    _webViewController.evaluateJavascript(
      source:
          '''
    map.setMinZoom(${options.minZoom});
    map.setMaxZoom(${options.maxZoom});
    map.setMinPitch(${options.minPitch});
    map.setMaxPitch(${options.maxPitch});
   ${switch (options.maxBounds) {
            final bounds? => '''
    map.setMaxBounds([
        [${bounds.longitudeWest}, ${bounds.latitudeSouth}],
        [${bounds.longitudeEast}, ${bounds.latitudeNorth}]
    ]);
    ''',
            _ => 'map.setMaxBounds(null);',
          }}
    ${ /* TODO update LayerManager layers */ ''}
''',
    );
    _updateGestures(options.gestures);
    _layerManager?.updateLayers(widget.layers);
    super.didUpdateWidget(oldWidget);
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
    debugPrint("Can't track the user location on web.");
  }

  @override
  List<RenderedFeature> featuresAtPoint(
    Offset point, {
    List<String>? layerIds,
  }) {
    // TODO: implement featuresAtPoint
    return const [];
  }

  @override
  List<RenderedFeature> featuresInRect(Rect rect, {List<String>? layerIds}) {
    // TODO: implement featuresInRect
    return const [];
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
    await _webViewController.evaluateJavascript(
      source:
          '''
    window.map.fitBounds([
        [${bounds.longitudeWest}, ${bounds.latitudeSouth}],
        [${bounds.longitudeEast}, ${bounds.latitudeNorth}]
    ], {
        ${bearing != null ? 'bearing: $bearing,' : ''}
        ${pitch != null ? 'pitch: $pitch,' : ''}
        speed: $webSpeed,
        maxDuration: ${webMaxDuration != null ? webMaxDuration.inMilliseconds : 'undefined'},
        offset: [${offset.dx}, ${offset.dy}],
        maxZoom: ${webMaxZoom.isFinite ? webMaxZoom : 'undefined'},
        linear: $webLinear,
        padding: {
            top: ${padding.top},
            bottom: ${padding.bottom},
            left: ${padding.left},
            right: ${padding.right},
        },
    });
''',
    );
  }

  @override
  MapCamera getCamera() => camera ??= const MapCamera(
    center: Geographic(lon: 0, lat: 0),
    zoom: 0,
    bearing: 0,
    pitch: 0,
  );

  /// https://wiki.openstreetmap.org/wiki/Zoom_levels
  @override
  double getMetersPerPixelAtLatitude(double latitude) =>
      circumferenceOfEarth *
      cos(latitude * degree2Radian) /
      pow(2, (camera?.zoom ?? 0) + 9);

  @override
  LngLatBounds getVisibleRegion() {
    // TODO: implement getVisibleRegion
    throw UnimplementedError();
  }

  Future<void> _updateGestures(MapGestures gestures) async {
    await _webViewController.evaluateJavascript(
      source:
          '''
    map.scrollZoom.${gestures.zoom ? 'enable' : 'disable'}();
    map.boxZoom.${gestures.zoom ? 'enable' : 'disable'}();
    map.doubleClickZoom.${gestures.zoom ? 'enable' : 'disable'}();
    
    map.dragPan.${gestures.pan ? 'enable' : 'disable'}();
    
    map.dragRotate.${gestures.rotate ? 'enable' : 'disable'}();
    map.touchZoomRotate.${gestures.rotate ? 'enableRotation' : 'disableRotation'}();
    
    map.touchPitch.${gestures.pitch ? 'enable' : 'disable'}();
    
    map.keyboard.${gestures.allEnabled ? 'enable' : 'disable'}();
''',
    );
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
      source:
          '''
  window.map.flyTo({
    ${center != null ? 'center: [${center.lon}, ${center.lat}],' : ''}
    ${zoom != null ? 'zoom: $zoom,' : ''}
    ${bearing != null ? 'bearing: $bearing,' : ''}
    ${pitch != null ? 'pitch: $pitch,' : ''}
    speed: $webSpeed,
    maxDuration: ${webMaxDuration != null ? webMaxDuration.inMilliseconds : 'undefined'},
  });
''',
    );
    // TODO integrate a Completer to wait for the animation to finish
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    await _webViewController.evaluateJavascript(
      source:
          '''
  window.map.jumpTo({ 
    ${center != null ? 'center: [${center.lon}, ${center.lat}],' : ''}
    ${zoom != null ? 'zoom: $zoom,' : ''}
    ${bearing != null ? 'bearing: $bearing,' : ''}
    ${pitch != null ? 'pitch: $pitch,' : ''}
  });
''',
    );
  }

  @override
  List<QueriedLayer> queryLayers(Offset screenLocation) {
    // TODO: implement queryLayers
    return const [];
  }

  @override
  Future<void> setStyle(String style) async {
    await _webViewController.evaluateJavascript(
      source:
          '''
  window.map.once('style.load', () => {
      window.flutter_inappwebview.callHandler('mapEvent', { type: 'styleLoad' });
  });
  window.map.setStyle('${await _prepareStyleString(style)}');
''',
    );
  }

  void _onStyleLoaded() {
    style?.dispose();
    final styleCtrl = StyleControllerWebView(_webViewController);
    style = styleCtrl;
    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    _layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  @override
  Geographic toLngLat(Offset screenLocation) {
    // TODO: implement toLngLat
    return const Geographic(lon: 0, lat: 0);
  }

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) =>
      screenLocations.map(toLngLat).toList(growable: false);

  @override
  Offset toScreenLocation(Geographic lngLat) {
    // TODO: implement toScreenLocation
    return const Offset(200, 200);
  }

  @override
  List<Offset> toScreenLocations(List<Geographic> lngLats) =>
      lngLats.map(toScreenLocation).toList(growable: false);

  @override
  Future<void> trackLocation({
    bool trackLocation = true,
    BearingTrackMode trackBearing = BearingTrackMode.gps,
  }) async {
    debugPrint("Can't enable the user location on web programmatically.");
  }

  Future<String> _prepareStyleString(String style) async {
    final trimmed = style.trim();
    if (trimmed.startsWith('{')) {
      // Raw JSON
      return trimmed;
    } else if (trimmed.startsWith('/')) {
      // path
      return trimmed;
    } else if (!trimmed.startsWith('http://') &&
        !trimmed.startsWith('https://') &&
        !trimmed.startsWith('mapbox://')) {
      // flutter asset
      return DefaultAssetBundle.of(context).loadString(trimmed);
    } else {
      // URI
      return trimmed;
    }
  }

  Future<MapCamera> _fetchCamera() async {
    final result = await _webViewController.callAsyncJavaScript(
      functionBody: '''
    const center = window.map.getCenter();
    return {
        lon: center.lng,
        lat: center.lat,
        zoom: window.map.getZoom(),
        bearing: window.map.getBearing(),
        pitch: window.map.getPitch(),
    };
''',
    );
    final data = result!.toMap();
    debugPrint('_fetchCamera: $data');
    final newCamera = MapCamera(
      center: Geographic(
        lon: (data['lon'] as num).toDouble(),
        lat: (data['lat'] as num).toDouble(),
      ),
      zoom: (data['zoom'] as num).toDouble(),
      bearing: (data['bearing'] as num).toDouble(),
      pitch: (data['pitch'] as num).toDouble(),
    );
    setState(() => camera = newCamera);
    return newCamera;
  }

  void _onMapEvent(List<dynamic> args) {
    final data = args[0] as Map<String, dynamic>;
    switch (data['type']) {
      case 'load':
        _onStyleLoaded();
      case 'style.load':
        _onStyleLoaded();
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
      case 'dblclick':
        widget.onEvent?.call(
          MapEventDoubleClick(
            point: Geographic(
              lon: (data['lng'] as num).toDouble(),
              lat: (data['lat'] as num).toDouble(),
            ),
            screenPoint: Offset.zero,
          ),
        );
      case 'contextmenu':
        widget.onEvent?.call(
          MapEventSecondaryClick(
            point: Geographic(
              lon: (data['lng'] as num).toDouble(),
              lat: (data['lat'] as num).toDouble(),
            ),
            screenPoint: Offset.zero,
          ),
        );
      case 'idle':
        widget.onEvent?.call(const MapEventIdle());
      case 'moveStart':
        widget.onEvent?.call(
          // TODO CameraChangeReason
          const MapEventStartMoveCamera(reason: CameraChangeReason.apiGesture),
        );
      case 'move':
        final newCamera = MapCamera(
          center: Geographic(
            lon: (data['lng'] as num).toDouble(),
            lat: (data['lat'] as num).toDouble(),
          ),
          zoom: (data['zoom'] as num).toDouble(),
          bearing: (data['bearing'] as num).toDouble(),
          pitch: (data['pitch'] as num).toDouble(),
        );
        setState(() => camera = newCamera);
        widget.onEvent?.call(MapEventMoveCamera(camera: newCamera));
      case 'moveend':
        // TODO Completer
        widget.onEvent?.call(const MapEventCameraIdle());
    }
  }

  Future<void> _onLoadStop(
    InAppWebViewController controller,
    WebUri? url,
  ) async {
    debugPrint('_onLoadStop: $url');
    await controller.evaluateJavascript(
      source:
          '''
    const map = new maplibregl.Map({
        container: 'map',
        style: '${await _prepareStyleString(options.initStyle)}',
        ${switch (options.initCenter) {
            final center? => 'center: [${center.lon}, ${center.lat}],',
            _ => '',
          }}
        zoom: ${options.initZoom},
        bearing: ${options.initBearing},
        pitch: ${options.initPitch},
        attributionControl: false,
    });
    map.setMinZoom(${options.minZoom});
    map.setMaxZoom(${options.maxZoom});
    map.setMinPitch(${options.minPitch});
    map.setMaxPitch(${options.maxPitch});
   ${switch (options.maxBounds) {
            final bounds? => '''
    map.setMaxBounds([
        [${bounds.longitudeWest}, ${bounds.latitudeSouth}],
        [${bounds.longitudeEast}, ${bounds.latitudeNorth}]
    ]);
    ''',
            _ => '',
          }}
    map.on('load', () => {
        window.flutter_inappwebview.callHandler('mapEvent', { type: 'load' });
    });
    map.on('click', (e) => {
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'click', event: e }
        );
    });
    map.on('dblclick', (e) => {
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'dblclick', event: e }
        );
    });
    map.on('contextmenu', (e) => {
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'contextmenu', event: e }
        );
    });
    map.on('idle', () => {
        const center = map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'idle' }
        );
    });
    map.on('moveStart', () => {
        const center = map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'moveStart' }
            ${ /* TODO CameraChangeReason */ ''}
        );
    });
    map.on('move', (e) => {
        const center = map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            {
                type: 'move',
                lng: center.lng,
                lat: center.lat,
                zoom: map.getZoom(),
                pitch: map.getPitch(),
                bearing: map.getBearing(),
            }
        );
    });
    map.on('moveend', (e) => {
        const center = map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'moveend' }
        );
    });
    window.map = map;  
''',
    );
    await _updateGestures(options.gestures);
  }
}

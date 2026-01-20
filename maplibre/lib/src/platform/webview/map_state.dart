import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/webview/style_controller.dart';

/// MapLibre GL JS using web views for desktop.
class MapLibreMapStateWebView extends MapLibreMapState {
  late InAppWebViewController _webViewController;
  bool _nextGestureCausedByController = false;
  @override
  StyleControllerWebView? style;

  LayerManager? _layerManager;

  LngLatBounds? _cachedVisibleRegion;
  Widget? _widget;
  static const _debugMode = false;

  @override
  void initState() {
    PlatformInAppWebViewController.debugLoggingSettings.enabled = _debugMode;
    super.initState();
  }

  @override
  Widget buildPlatformWidget(BuildContext context) {
    return _widget ??= InAppWebView(
      // ignore: avoid_redundant_argument_values
      initialSettings: InAppWebViewSettings(isInspectable: _debugMode),
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
    if (oldWidget.options != widget.options) return;
    final gestures = options.gestures;
    _webViewController.evaluateJavascript(
      source:
          '''
    window.map.setMinZoom(${options.minZoom});
    window.map.setMaxZoom(${options.maxZoom});
    window.map.setMinPitch(${options.minPitch});
    window.map.setMaxPitch(${options.maxPitch});
   ${switch (options.maxBounds) {
            final bounds? => '''
    window.map.setMaxBounds([
        [${bounds.longitudeWest}, ${bounds.latitudeSouth}],
        [${bounds.longitudeEast}, ${bounds.latitudeNorth}]
    ]);
    ''',
            _ => 'map.setMaxBounds(null);',
          }}
    window.map.scrollZoom.${gestures.zoom ? 'enable' : 'disable'}();
    window.map.boxZoom.${gestures.zoom ? 'enable' : 'disable'}();
    window.map.doubleClickZoom.${gestures.zoom ? 'enable' : 'disable'}();
    
    window.map.dragPan.${gestures.pan ? 'enable' : 'disable'}();
    
    window.map.dragRotate.${gestures.rotate ? 'enable' : 'disable'}();
    window.map.touchZoomRotate.${gestures.rotate ? 'enableRotation' : 'disableRotation'}();
    
    window.map.touchPitch.${gestures.pitch ? 'enable' : 'disable'}();
    
    window.map.keyboard.${gestures.allEnabled ? 'enable' : 'disable'}();
''',
    );
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
  LngLatBounds getVisibleRegion() =>
      _cachedVisibleRegion ??
      const LngLatBounds(
        longitudeWest: -180,
        latitudeSouth: -85.0511,
        longitudeEast: 180,
        latitudeNorth: 85.0511,
      );

  Future<LngLatBounds> _fetchVisibleRegion() async {
    final result = await _webViewController.callAsyncJavaScript(
      functionBody: '''
    const bounds = window.map.getBounds();
    return {
        west: bounds.getWest(),
        south: bounds.getSouth(),
        east: bounds.getEast(),
        north: bounds.getNorth(),
    };
''',
    );
    final data = result!.toMap();
    debugPrint('_fetchVisibleRegion: $data');
    final newBounds = LngLatBounds(
      longitudeWest: (data['west'] as num).toDouble(),
      latitudeSouth: (data['south'] as num).toDouble(),
      longitudeEast: (data['east'] as num).toDouble(),
      latitudeNorth: (data['north'] as num).toDouble(),
    );
    return _cachedVisibleRegion = newBounds;
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
    _nextGestureCausedByController = true;
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
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    _nextGestureCausedByController = true;
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
    final data = result!.toMap()['value'] as Map<String, dynamic>;
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
        final reasonString = data['reason'] as String;
        final CameraChangeReason reason;
        if (_nextGestureCausedByController) {
          _nextGestureCausedByController = false;
          reason = CameraChangeReason.developerAnimation;
        } else {
          reason = switch (reasonString) {
            'apiGesture' => CameraChangeReason.apiGesture,
            'apiAnimation' => CameraChangeReason.apiAnimation,
            _ => throw Exception('Unknown moveStart reason: $reasonString'),
          };
        }
        widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
        unawaited(_fetchCamera());
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
        widget.onEvent?.call(const MapEventCameraIdle());
        unawaited(_fetchCamera());
    }
  }

  Future<void> _onLoadStop(
    InAppWebViewController controller,
    WebUri? url,
  ) async {
    debugPrint('_onLoadStop: $url');
    final gestures = options.gestures;
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
    window.map = map;
    
    window.map.setMinZoom(${options.minZoom});
    window.map.setMaxZoom(${options.maxZoom});
    window.map.setMinPitch(${options.minPitch});
    window.map.setMaxPitch(${options.maxPitch});
   ${switch (options.maxBounds) {
            final bounds? => '''
    window.map.setMaxBounds([
        [${bounds.longitudeWest}, ${bounds.latitudeSouth}],
        [${bounds.longitudeEast}, ${bounds.latitudeNorth}]
    ]);
    ''',
            _ => '',
          }}
    window.map.on('load', () => {
        window.flutter_inappwebview.callHandler('mapEvent', { type: 'load' });
    });
    window.map.on('click', (e) => {
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'click', event: e }
        );
    });
    window.map.on('dblclick', (e) => {
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'dblclick', event: e }
        );
    });
    window.map.on('contextmenu', (e) => {
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'contextmenu', event: e }
        );
    });
    window.map.on('idle', () => {
        const center = window.map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'idle' }
        );
    });
    window.map.on('moveStart', (e) => {
        const center = window.map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { 
              type: 'moveStart', 
              reason: e.originalEvent ? 'apiGesture' : 'apiAnimation' 
            }
        );
    });
    let lastMoveTimestamp = 0;
    window.map.on('move', (e) => {
        const now = Date.now();
        if (now - lastMoveTimestamp < 500) return;
        lastMoveTimestamp = now;    
    
        const center = window.map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            {
                type: 'move',
                lng: center.lng,
                lat: center.lat,
                zoom: window.map.getZoom(),
                pitch: window.map.getPitch(),
                bearing: window.map.getBearing(),
            }
        );
    });
    window.map.on('moveend', (e) => {
        const center = window.map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'moveend' }
        );
    });
    window.map.scrollZoom.${gestures.zoom ? 'enable' : 'disable'}();
    window.map.boxZoom.${gestures.zoom ? 'enable' : 'disable'}();
    window.map.doubleClickZoom.${gestures.zoom ? 'enable' : 'disable'}();
    
    window.map.dragPan.${gestures.pan ? 'enable' : 'disable'}();
    
    window.map.dragRotate.${gestures.rotate ? 'enable' : 'disable'}();
    window.map.touchZoomRotate.${gestures.rotate ? 'enableRotation' : 'disableRotation'}();
    
    window.map.touchPitch.${gestures.pitch ? 'enable' : 'disable'}();
    
    window.map.keyboard.${gestures.allEnabled ? 'enable' : 'disable'}();
''',
    );
  }
}

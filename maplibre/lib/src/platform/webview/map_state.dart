import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/webview/style_controller.dart';
import 'package:maplibre/src/platform/webview/websocket.dart';

/// MapLibre GL JS using web views for desktop.
class MapLibreMapStateWebView extends MapLibreMapState {
  late InAppWebViewController _webViewController;
  late final Future<Websocket> _websocket;
  bool _nextGestureCausedByController = false;
  @override
  StyleControllerWebView? style;

  LayerManager? _layerManager;

  LngLatBounds? _cachedVisibleRegion;
  Widget? _widget;
  static const _debugMode = true;
  static const _actionMoveCamera = 1;
  static const _actionAnimateCamera = 2;
  static const _actionFitBounds = 3;
  static const _eventMove = 1;
  static const _eventMoveStart = 2;
  static const _eventMoveEnd = 3;
  static const _eventLoad = 4;
  static const _eventStyleLoad = 5;
  static const _eventClick = 6;
  static const _eventDblClick = 7;
  static const _eventContextMenu = 8;

  @override
  void initState() {
    PlatformInAppWebViewController.debugLoggingSettings.enabled = _debugMode;
    _websocket = Websocket.create(onData: _onWebSocketData);
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
      onWebViewCreated: _onWebViewCreated,
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
    final currCamera = camera!;
    final data = ByteData(1 + 8 * 13);
    data.setUint8(0, _actionFitBounds);
    data.setFloat64(1, bounds.longitudeWest, Endian.little);
    data.setFloat64(9, bounds.latitudeSouth, Endian.little);
    data.setFloat64(17, bounds.longitudeEast, Endian.little);
    data.setFloat64(25, bounds.latitudeNorth, Endian.little);
    data.setFloat64(33, bearing ?? currCamera.bearing, Endian.little);
    data.setFloat64(41, pitch ?? currCamera.pitch, Endian.little);
    data.setFloat64(49, offset.dx, Endian.little);
    data.setFloat64(57, offset.dy, Endian.little);
    data.setFloat64(
      65,
      webMaxZoom.isFinite ? webMaxZoom : double.nan,
      Endian.little,
    );
    data.setFloat64(73, padding.top, Endian.little);
    data.setFloat64(81, padding.bottom, Endian.little);
    data.setFloat64(89, padding.left, Endian.little);
    data.setFloat64(97, padding.right, Endian.little);
    final ws = await _websocket;
    ws.send(data);
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
    final ws = await _websocket;
    final data = ByteData(1 + 8 * 5);
    data.setUint8(0, _actionAnimateCamera);
    final currCamera = camera!;
    final currCenter = center ?? currCamera.center;
    data.setFloat64(1, currCenter.lon, Endian.little);
    data.setFloat64(9, currCenter.lat, Endian.little);
    data.setFloat64(17, zoom ?? currCamera.zoom, Endian.little);
    data.setFloat64(25, pitch ?? currCamera.pitch, Endian.little);
    data.setFloat64(33, bearing ?? currCamera.bearing, Endian.little);
    ws.send(data);
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    _nextGestureCausedByController = true;
    final ws = await _websocket;
    final data = ByteData(1 + 8 * 5);
    data.setUint8(0, _actionMoveCamera);
    final currCamera = camera!;
    final currCenter = center ?? currCamera.center;
    data.setFloat64(1, currCenter.lon, Endian.little);
    data.setFloat64(9, currCenter.lat, Endian.little);
    data.setFloat64(17, zoom ?? currCamera.zoom, Endian.little);
    data.setFloat64(25, pitch ?? currCamera.pitch, Endian.little);
    data.setFloat64(33, bearing ?? currCamera.bearing, Endian.little);
    ws.send(data);
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
      const buf = new ArrayBuffer(1);
      const view = new DataView(buf);
      view.setUint8(0, $_eventStyleLoad);
      window.ws.send(buf);
  });
  window.map.setStyle('${await _prepareStyleString(style)}');
''',
    );
  }

  @override
  void dispose() {
    style?.dispose();
    unawaited(_websocket.then((ws) => ws.dispose()));
    super.dispose();
  }

  void _onStyleLoaded() {
    style?.dispose();
    unawaited(_fetchCamera());
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

  Future<void> _onLoadStop(
    InAppWebViewController controller,
    WebUri? url,
  ) async {
    debugPrint('_onLoadStop: $url');
    final gestures = options.gestures;
    final ws = await _websocket;
    debugPrint('WebSocket server listening on ws://localhost:${ws.port}');
    await controller.evaluateJavascript(
      source:
          '''
    window.ws = new WebSocket('ws://localhost:${ws.port}');
    window.ws.onopen = function(event) {
        console.log('WebSocket is open now.');
    };
    window.ws.onclose = function(event) {
        console.log('WebSocket is closed now.');
    };
    window.ws.onerror = function(event) {
        console.log('WebSocket error: ' + event);
    };
    window.ws.onmessage = async function(event) {
        let buffer;
        if (event.data instanceof ArrayBuffer) {
            buffer = event.data;
        } else if (event.data instanceof Blob) {
            buffer = await event.data.arrayBuffer();
        } else {
            console.warn('Unknown WS message type:', event.data);
            return;
        }
        const view = new DataView(buffer);
        const actionType = view.getUint8(0);
        switch (actionType) {
          case $_actionMoveCamera:
            window.map.jumpTo({
                center: [
                    view.getFloat64(1, true),
                    view.getFloat64(9, true)
                ],
                zoom: view.getFloat64(17, true),
                pitch: view.getFloat64(25, true),
                bearing: view.getFloat64(33, true),
            });
            break;
          case $_actionAnimateCamera:
            window.map.flyTo({
                center: [
                    view.getFloat64(1, true),
                    view.getFloat64(9, true)
                ],
                zoom: view.getFloat64(17, true),
                pitch: view.getFloat64(25, true),
                bearing: view.getFloat64(33, true),
            });
            break;
          case $_actionFitBounds:
          console.log('fitBounds action received');
          const maxZoom = view.getFloat64(65, true);
            window.map.fitBounds([
                [view.getFloat64(1, true), view.getFloat64(9, true)],
                [view.getFloat64(17, true), view.getFloat64(25, true)]
            ], {
                bearing: view.getFloat64(33, true),
                pitch: view.getFloat64(41, true),
                offset: [view.getFloat64(49, true), view.getFloat64(57, true)],
                maxZoom: Number.isNaN(maxZoom) ? undefined : maxZoom,
                padding: {
                    top: view.getFloat64(73, true),
                    bottom: view.getFloat64(81, true),
                    left: view.getFloat64(89, true),
                    right: view.getFloat64(97, true),
                },
            });
          console.log('fitBounds action applied');
            break;
          default:
            console.log(`Unknown WS binary message type: \${view.getUint8(0)}`);
        }
    };
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
    const bufLoad = new ArrayBuffer(1);
    const viewLoad = new DataView(bufLoad);
    viewLoad.setUint8(0, $_eventLoad);
    window.map.on('load', () => {
        window.ws.send(bufLoad);
    });
    const bufClick = new ArrayBuffer(1 + 8*4);
    const viewClick = new DataView(bufClick);
    viewClick.setUint8(0, $_eventClick);
    window.map.on('click', (e) => {
        viewClick.setFloat64(1, e.lngLat.lng, true);
        viewClick.setFloat64(9, e.lngLat.lat, true);
        viewClick.setFloat64(17, e.point.x, true);
        viewClick.setFloat64(25, e.point.y, true);
        window.ws.send(bufClick);
    });
    const bufDblClick = new ArrayBuffer(1 + 8*4);
    const viewDblClick = new DataView(bufDblClick);
    viewDblClick.setUint8(0, $_eventDblClick);
    window.map.on('dblclick', (e) => {
        viewDblClick.setFloat64(1, e.lngLat.lng, true);
        viewDblClick.setFloat64(9, e.lngLat.lat, true);
        viewDblClick.setFloat64(17, e.point.x, true);
        viewDblClick.setFloat64(25, e.point.y, true);
        window.ws.send(bufDblClick);
    });
    const bufContextMenu = new ArrayBuffer(1 + 8*4);
    const viewContextMenu = new DataView(bufContextMenu);
    viewContextMenu.setUint8(0, $_eventContextMenu);
    window.map.on('contextmenu', (e) => {
        viewContextMenu.setFloat64(1, e.lngLat.lng, true);
        viewContextMenu.setFloat64(9, e.lngLat.lat, true);
        viewContextMenu.setFloat64(17, e.point.x, true);
        viewContextMenu.setFloat64(25, e.point.y, true);
        window.ws.send(bufContextMenu);
    });
    /*window.map.on('idle', () => {
        const center = window.map.getCenter();
        window.flutter_inappwebview.callHandler(
            'mapEvent',
            { type: 'idle' }
        );
    });*/
    const bufMoveStart = new ArrayBuffer(1 + 1);
    const viewMoveStart = new DataView(bufMoveStart);
    viewMoveStart.setUint8(0, $_eventMoveStart);
    window.map.on('movestart', (e) => {
        viewMoveStart.setUint8(1, e.originalEvent ? 1 : 0);
        window.ws.send(bufMoveStart);
    });
    const bufMove = new ArrayBuffer(1 + 8*5);
    const viewMove = new DataView(bufMove);
    viewMove.setUint8(0, $_eventMove);
    window.map.on('move', (e) => {
        console.log('map move event');
        const center = window.map.getCenter();
        viewMove.setFloat64(1, center.lng, true);
        viewMove.setFloat64(9, center.lat, true);
        viewMove.setFloat64(17, window.map.getZoom(), true);
        viewMove.setFloat64(25, window.map.getPitch(), true);
        viewMove.setFloat64(33, window.map.getBearing(), true);
        window.ws.send(bufMove);
    });
    const bufMoveEnd = new ArrayBuffer(1);
    const viewMoveEnd = new DataView(bufMoveEnd);
    viewMoveEnd.setUint8(0, $_eventMoveEnd);
    window.map.on('moveend', (e) => {
        window.ws.send(bufMoveEnd);
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
    unawaited(_fetchCamera());
  }

  Future<void> _onWebViewCreated(InAppWebViewController controller) async {
    _webViewController = controller;
    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
    // unawaited(_fetchCamera());
    setState(() => isInitialized = true);
  }

  void _onWebSocketData(Object? data) {
    debugPrint('_onWebSocketData: $data');
    switch (data) {
      case final List<int> data:
        final b = ByteData.sublistView(Uint8List.fromList(data));
        switch (b.getUint8(0)) {
          case _eventMove:
            final newCamera = MapCamera(
              center: Geographic(
                lon: b.getFloat64(1, Endian.little),
                lat: b.getFloat64(9, Endian.little),
              ),
              zoom: b.getFloat64(17, Endian.little),
              pitch: b.getFloat64(25, Endian.little),
              bearing: b.getFloat64(33, Endian.little),
            );
            setState(() => camera = newCamera);
            widget.onEvent?.call(MapEventMoveCamera(camera: newCamera));
          case _eventMoveStart:
            final CameraChangeReason reason;
            if (_nextGestureCausedByController) {
              _nextGestureCausedByController = false;
              reason = CameraChangeReason.developerAnimation;
            } else {
              final hasOriginalEvent = b.getUint8(1) == 1;
              reason = hasOriginalEvent
                  ? CameraChangeReason.apiGesture
                  : CameraChangeReason.apiAnimation;
            }
            widget.onEvent?.call(MapEventStartMoveCamera(reason: reason));
          case _eventMoveEnd:
            widget.onEvent?.call(const MapEventCameraIdle());
            widget.onEvent?.call(const MapEventIdle());
          case _eventStyleLoad:
            _onStyleLoaded();
          case _eventLoad:
            widget.onEvent?.call(const MapEventIdle());
          case _eventClick:
            widget.onEvent?.call(
              MapEventClick(
                point: Geographic(
                  lon: b.getFloat64(1, Endian.little),
                  lat: b.getFloat64(9, Endian.little),
                ),
                screenPoint: Offset(
                  b.getFloat64(17, Endian.little),
                  b.getFloat64(25, Endian.little),
                ),
              ),
            );
          case _eventDblClick:
            widget.onEvent?.call(
              MapEventDoubleClick(
                point: Geographic(
                  lon: b.getFloat64(1, Endian.little),
                  lat: b.getFloat64(9, Endian.little),
                ),
                screenPoint: Offset(
                  b.getFloat64(17, Endian.little),
                  b.getFloat64(25, Endian.little),
                ),
              ),
            );
          case _eventContextMenu:
            widget.onEvent?.call(
              MapEventSecondaryClick(
                point: Geographic(
                  lon: b.getFloat64(1, Endian.little),
                  lat: b.getFloat64(9, Endian.little),
                ),
                screenPoint: Offset(
                  b.getFloat64(17, Endian.little),
                  b.getFloat64(25, Endian.little),
                ),
              ),
            );
          default:
            throw Exception('Unknown WS binary message type: ${b.getUint8(0)}');
        }
      default:
        throw Exception('Unknown WS message type: ${data.runtimeType}');
    }
  }
}

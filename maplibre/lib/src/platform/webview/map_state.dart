import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/layer_manager.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/platform/webview/magic_numbers.dart';
import 'package:maplibre/src/platform/webview/projection.dart';
import 'package:maplibre/src/platform/webview/style_controller.dart';
import 'package:maplibre/src/platform/webview/websocket.dart';

/// MapLibre GL JS using web views for desktop.
class MapLibreMapStateWebView extends MapLibreMapState {
  /// The web view controller.
  late InAppWebViewController webViewController;

  /// The WebSocket connection to the web view.
  late final Future<WebSocket> _futureWebSocket;
  WebSocket? _webSocket;
  int? _wsPort;
  bool _nextGestureCausedByController = false;
  @override
  StyleControllerWebView? style;

  LayerManager? _layerManager;

  LngLatBounds? _cachedVisibleRegion;
  late Size _mapSize;
  Widget? _widget;
  static const _debugMode = false;

  @override
  void initState() {
    PlatformInAppWebViewController.debugLoggingSettings.enabled = _debugMode;
    _futureWebSocket = WebSocket.create(onData: _onWebSocketData).then((ws) {
      setState(() {
        _webSocket = ws;
        _wsPort = ws.port;
      });
      return ws;
    });
    super.initState();
  }

  @override
  Widget buildPlatformWidget(BuildContext context) {
    final port = _wsPort;
    if (port == null) return const SizedBox.shrink();
    return _widget ??= InAppWebView(
      // ignore: avoid_redundant_argument_values
      initialSettings: InAppWebViewSettings(isInspectable: _debugMode),
      initialData: InAppWebViewInitialData(
        data:
            '''
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
    <script>
    window.ws = new WebSocket('ws://localhost:$port');
    window.ws.onopen = function(event) {
        console.log('WebSocket is open now.');
    };
    window.ws.onclose = function(event) {
        console.log('WebSocket is closed now.');
    };
    window.ws.onerror = function(event) {
        console.warn('WebSocket error: ' + event);
    };
    window.ws.onmessage = async function(event) {
        let buffer;
        if (event.data instanceof ArrayBuffer) {
            buffer = event.data;
        } else if (event.data instanceof Blob) {
            buffer = await event.data.arrayBuffer();
        } else {
            console.warn('WebSocket error: Unknown WS message type:', event.data);
            return;
        }
        const view = new DataView(buffer);
        const actionType = view.getUint8(0);
        switch (actionType) {
          case $actionTest:
            const ts = view.getBigInt64(1, true);
            const buffer2 = new ArrayBuffer(1+8);
            const view2 = new DataView(buffer2);
            view.setUint8(0, $eventTest);
            view2.setBigInt64(1, ts, true);
            window.ws.send(buffer2);
            break;
          case $actionMoveCamera:
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
          case $actionAnimateCamera:
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
          case $actionFitBounds:
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
            break;
          case $actionAddImage:
            const idLength = view.getUint8(1);
            let id = '';
            for (let i = 0; i < idLength; i++) {
                id += String.fromCharCode(view.getUint8(2 + i));
            }
            const imageBytes = new Uint8Array(buffer.byteLength - 2 - idLength);
            for (let i = 0; i < imageBytes.length; i++) {
                imageBytes[i] = view.getUint8(2 + idLength + i);
            }
            const blob = new Blob([imageBytes], { type: 'image/png' });
            createImageBitmap(blob).then((img) => {
                window.map.addImage(id, img);
            }).catch((err) => console.warn('addImage decode failed', err));
            break;
          default:
            console.warn(`WebSocket error: Unknown WS binary message type: \${view.getUint8(0)}`);
        }
    };
    </script>
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
    webViewController.evaluateJavascript(
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
    data.setUint8(0, actionFitBounds);
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
    _webSocket?.sendBytes(data);
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
    final data = ByteData(1 + 8 * 5);
    data.setUint8(0, actionAnimateCamera);
    final currCamera = camera!;
    final currCenter = center ?? currCamera.center;
    data.setFloat64(1, currCenter.lon, Endian.little);
    data.setFloat64(9, currCenter.lat, Endian.little);
    data.setFloat64(17, zoom ?? currCamera.zoom, Endian.little);
    data.setFloat64(25, pitch ?? currCamera.pitch, Endian.little);
    data.setFloat64(33, bearing ?? currCamera.bearing, Endian.little);
    _webSocket?.sendBytes(data);
  }

  @override
  Future<void> moveCamera({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
  }) async {
    _nextGestureCausedByController = true;
    final data = ByteData(1 + 8 * 5);
    data.setUint8(0, actionMoveCamera);
    final currCamera = camera!;
    final currCenter = center ?? currCamera.center;
    data.setFloat64(1, currCenter.lon, Endian.little);
    data.setFloat64(9, currCenter.lat, Endian.little);
    data.setFloat64(17, zoom ?? currCamera.zoom, Endian.little);
    data.setFloat64(25, pitch ?? currCamera.pitch, Endian.little);
    data.setFloat64(33, bearing ?? currCamera.bearing, Endian.little);
    _webSocket?.sendBytes(data);
  }

  // ignore: unused_element
  Future<void> _test() async {
    final data = ByteData(1 + 8);
    data.setUint8(0, actionTest);
    data.setInt64(1, DateTime.now().microsecondsSinceEpoch, Endian.little);
    _webSocket?.sendBytes(data);
  }

  @override
  List<QueriedLayer> queryLayers(Offset screenLocation) {
    // TODO: implement queryLayers
    return const [];
  }

  @override
  Future<void> setStyle(String style) async {
    await webViewController.evaluateJavascript(
      source:
          '''
  window.map.once('style.load', () => {
      const buf = new ArrayBuffer(1);
      const view = new DataView(buf);
      view.setUint8(0, $eventStyleLoad);
      window.ws.send(buf);
  });
  window.map.setStyle('${await _prepareStyleString(style)}');
''',
    );
  }

  @override
  void dispose() {
    style?.dispose();
    unawaited(_futureWebSocket.then((ws) => ws.dispose()));
    super.dispose();
  }

  void _onStyleLoaded() {
    style?.dispose();
    unawaited(_updateCache());
    final styleCtrl = StyleControllerWebView(webViewController, _webSocket!);
    style = styleCtrl;
    widget.onEvent?.call(MapEventStyleLoaded(styleCtrl));
    widget.onStyleLoaded?.call(styleCtrl);
    _layerManager = LayerManager(styleCtrl, widget.layers);
    // setState is needed to refresh the flutter widgets used in MapLibreMap.children.
    setState(() {});
  }

  @override
  Geographic toLngLat(Offset logicalScreen) {
    final cam = camera!;
    final size = _mapSize;
    return WebViewProjection.toLngLat(cam, size, logicalScreen);
  }

  @override
  Offset toScreenLocation(Geographic lngLat) {
    final cam = camera!;
    final size = _mapSize;
    return WebViewProjection.toScreenLocation(cam, size, lngLat);
  }

  @override
  List<Geographic> toLngLats(List<Offset> screenLocations) =>
      screenLocations.map(toLngLat).toList(growable: false);

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

  Future<MapCamera> _updateCache() async {
    final result = await webViewController.callAsyncJavaScript(
      functionBody: '''
    const center = window.map.getCenter();
    const bounds = window.map.getBounds();
    const canvas = window.map.getCanvas();
    const rect = canvas.getBoundingClientRect();
    return {
        lon: center.lng,
        lat: center.lat,
        zoom: window.map.getZoom(),
        bearing: window.map.getBearing(),
        pitch: window.map.getPitch(),
        west: bounds.getWest(),
        south: bounds.getSouth(),
        east: bounds.getEast(),
        north: bounds.getNorth(),
        width: rect.width,
        height: rect.height,
    };
''',
    );
    final map = result!.toMap();
    if (!map.containsKey('value')) {
      throw Exception('Failed to get camera data from web view. Result: $map');
    }
    final data = map['value'] as Map<String, dynamic>;
    final newCamera = MapCamera(
      center: Geographic(
        lon: (data['lon'] as num).toDouble(),
        lat: (data['lat'] as num).toDouble(),
      ),
      zoom: (data['zoom'] as num).toDouble(),
      bearing: (data['bearing'] as num).toDouble(),
      pitch: (data['pitch'] as num).toDouble(),
    );
    final newBounds = LngLatBounds(
      longitudeWest: (data['west'] as num).toDouble(),
      latitudeSouth: (data['south'] as num).toDouble(),
      longitudeEast: (data['east'] as num).toDouble(),
      latitudeNorth: (data['north'] as num).toDouble(),
    );
    setState(() {
      camera = newCamera;
      _cachedVisibleRegion = newBounds;
      _mapSize = Size(
        (data['width'] as num).toDouble(),
        (data['height'] as num).toDouble(),
      );
    });
    return newCamera;
  }

  Future<void> _onLoadStop(
    InAppWebViewController controller,
    WebUri? url,
  ) async {
    debugPrint('_onLoadStop: $url');
    final gestures = options.gestures;
    final ws = await _futureWebSocket;
    debugPrint('WebSocket server listening on ws://localhost:${ws.port}');
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
    const bufLoad = new ArrayBuffer(1);
    const viewLoad = new DataView(bufLoad);
    viewLoad.setUint8(0, $eventLoad);
    window.map.on('load', () => {
        window.ws.send(bufLoad);
    });
    const bufClick = new ArrayBuffer(1 + 8*4);
    const viewClick = new DataView(bufClick);
    viewClick.setUint8(0, $eventClick);
    window.map.on('click', (e) => {
        viewClick.setFloat64(1, e.lngLat.lng, true);
        viewClick.setFloat64(9, e.lngLat.lat, true);
        viewClick.setFloat64(17, e.point.x, true);
        viewClick.setFloat64(25, e.point.y, true);
        window.ws.send(bufClick);
    });
    const bufDblClick = new ArrayBuffer(1 + 8*4);
    const viewDblClick = new DataView(bufDblClick);
    viewDblClick.setUint8(0, $eventDblClick);
    window.map.on('dblclick', (e) => {
        viewDblClick.setFloat64(1, e.lngLat.lng, true);
        viewDblClick.setFloat64(9, e.lngLat.lat, true);
        viewDblClick.setFloat64(17, e.point.x, true);
        viewDblClick.setFloat64(25, e.point.y, true);
        window.ws.send(bufDblClick);
    });
    const bufContextMenu = new ArrayBuffer(1 + 8*4);
    const viewContextMenu = new DataView(bufContextMenu);
    viewContextMenu.setUint8(0, $eventContextMenu);
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
    viewMoveStart.setUint8(0, $eventMoveStart);
    window.map.on('movestart', (e) => {
        viewMoveStart.setUint8(1, e.originalEvent ? 1 : 0);
        window.ws.send(bufMoveStart);
    });
    const bufMove = new ArrayBuffer(1 + 8*11);
    const viewMove = new DataView(bufMove);
    viewMove.setUint8(0, $eventMove);
    window.map.on('move', (e) => {
        const center = window.map.getCenter();
        const bounds = window.map.getBounds();
        const canvas = window.map.getCanvas();
        const rect = canvas.getBoundingClientRect();
        viewMove.setFloat64(1, center.lng, true);
        viewMove.setFloat64(9, center.lat, true);
        viewMove.setFloat64(17, window.map.getZoom(), true);
        viewMove.setFloat64(25, window.map.getPitch(), true);
        viewMove.setFloat64(33, window.map.getBearing(), true);
        viewMove.setFloat64(41, bounds.getWest(), true);
        viewMove.setFloat64(49, bounds.getSouth(), true);
        viewMove.setFloat64(57, bounds.getEast(), true);
        viewMove.setFloat64(65, bounds.getNorth(), true);
        viewMove.setFloat64(73, rect.width, true);
        viewMove.setFloat64(81, rect.height, true);
        window.ws.send(bufMove);
    });
    const bufMoveEnd = new ArrayBuffer(1);
    const viewMoveEnd = new DataView(bufMoveEnd);
    viewMoveEnd.setUint8(0, $eventMoveEnd);
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
    unawaited(_updateCache());
  }

  Future<void> _onWebViewCreated(InAppWebViewController controller) async {
    webViewController = controller;
    widget.onEvent?.call(MapEventMapCreated(mapController: this));
    widget.onMapCreated?.call(this);
    // unawaited(_fetchCamera());
    setState(() => isInitialized = true);
  }

  void _onWebSocketData(Object? data) {
    // debugPrint('_onWebSocketData: $data');
    switch (data) {
      case final List<int> data:
        final b = ByteData.sublistView(Uint8List.fromList(data));
        switch (b.getUint8(0)) {
          case eventTest:
            final start = b.getInt64(1, Endian.little);
            final end = DateTime.now().microsecondsSinceEpoch;
            final diff = end - start;
            debugPrint('WebSocket test round-trip time: $diff µs');
          case eventMove:
            final newCamera = MapCamera(
              center: Geographic(
                lon: b.getFloat64(1, Endian.little),
                lat: b.getFloat64(9, Endian.little),
              ),
              zoom: b.getFloat64(17, Endian.little),
              pitch: b.getFloat64(25, Endian.little),
              bearing: b.getFloat64(33, Endian.little),
            );
            final newBounds = LngLatBounds(
              longitudeWest: b.getFloat64(41, Endian.little),
              latitudeSouth: b.getFloat64(49, Endian.little),
              longitudeEast: b.getFloat64(57, Endian.little),
              latitudeNorth: b.getFloat64(65, Endian.little),
            );
            final newMapSize = Size(
              b.getFloat64(73, Endian.little),
              b.getFloat64(81, Endian.little),
            );
            setState(() {
              camera = newCamera;
              _cachedVisibleRegion = newBounds;
              _mapSize = newMapSize;
            });
            widget.onEvent?.call(MapEventMoveCamera(camera: newCamera));
          case eventMoveStart:
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
          case eventMoveEnd:
            widget.onEvent?.call(const MapEventCameraIdle());
            widget.onEvent?.call(const MapEventIdle());
          // setStyle and initial loading
          case eventStyleLoad || eventLoad:
            _onStyleLoaded();
          case eventClick:
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
          case eventDblClick:
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
          case eventContextMenu:
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



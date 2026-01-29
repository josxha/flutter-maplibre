import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/webview/magic_numbers.dart';
import 'package:maplibre/src/platform/webview/websocket.dart';

/// Implementation of the [StyleController] for platforms using a web view.
class StyleControllerWebView extends StyleController {
  /// Creates a new instance of [StyleControllerWebView].
  StyleControllerWebView(this.webViewController, this.webSocket);

  /// The web view controller.
  final InAppWebViewController webViewController;

  /// The web socket used for communication with the map.
  final WebSocket webSocket;

  List<String> _cachedAttributions = const [];
  List<String> _cachedLayerIds = const [];

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    final idBytes = id.codeUnits;
    final data = ByteData(2 + idBytes.length + bytes.lengthInBytes);
    data.setUint8(0, actionAddImage);
    data.setUint8(1, idBytes.length);
    for (var i = 0; i < idBytes.length; i++) {
      data.setUint8(2 + i, idBytes[i]);
    }
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      data.setUint8(2 + idBytes.length + i, bytes[i]);
    }
    webSocket.sendBytes(data);
  }

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async {
    final sourceLayerSnippet =
        layer is StyleLayerWithSource && layer.sourceLayerId != null
        ? '"source-layer": "${layer.sourceLayerId}",'
        : '';
    final belowArg = belowLayerId != null ? "'$belowLayerId'" : 'undefined';
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      const layer = {
        id: "${layer.id}",
        type: "${switch (layer) {
            FillStyleLayer() => 'fill',
            LineStyleLayer() => 'line',
            SymbolStyleLayer() => 'symbol',
            CircleStyleLayer() => 'circle',
            HeatmapStyleLayer() => 'heatmap',
            FillExtrusionStyleLayer() => 'fill-extrusion',
            RasterStyleLayer() => 'raster',
            HillshadeStyleLayer() => 'hillshade',
            BackgroundStyleLayer() => 'background',
            _ => throw UnsupportedError('Unsupported layer type: ${layer.runtimeType}'),
          }}",
        paint: ${jsonEncode(layer.paint)},
        layout: ${jsonEncode(layer.layout)},
        ${layer.filter != null ? 'filter: ${layer.filter},' : ''}
        minzoom: ${layer.minZoom},
        maxzoom: ${layer.maxZoom},
        ${layer is StyleLayerWithSource ? 'source: "${layer.sourceId}",' : ''}
        $sourceLayerSnippet
      };
      if (${layer is StyleLayerWithSource ? 'true' : 'false'} && !window.map.getSource(layer.source)) {
        throw new Error(`Source "\${layer.source}" not found for layer "${layer.id}"`);
      }
      window.map.addLayer(layer, $belowArg);
''',
    );
    await _fetchLayerIds();
  }

  @override
  Future<void> addSource(Source source) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      if (window.map.getSource("${source.id}")) {
        throw new Error('A Source with the id "${source.id}" already exists in the map style.');
      }
      let dataVal = ${source is GeoJsonSource ? jsonEncode(source.data) : 'null'};
      if (typeof dataVal === 'string') {
        const trimmed = dataVal.trim();
        if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
          try { dataVal = JSON.parse(trimmed); } catch (e) { console.warn('GeoJSON parse failed', e); }
        }
      }
      const sourceObj = {
        ${switch (source) {
            GeoJsonSource() => '''
            type: 'geojson',
            data: dataVal,
          ''',
            RasterSource() => '''
            type: 'raster',
            ${source.tiles != null ? 'tiles: ${jsonEncode(source.tiles)},' : ''}
            ${source.url != null ? 'url: ${jsonEncode(source.url)},' : ''}
            tileSize: ${source.tileSize},
            attribution: ${jsonEncode(source.attribution)},
          ''',
            RasterDemSource() => '''
            type: 'raster-dem',
            ${source.tiles != null ? 'tiles: ${jsonEncode(source.tiles)},' : ''}
            ${source.url != null ? 'url: ${jsonEncode(source.url)},' : ''}
            tileSize: ${source.tileSize},
            attribution: ${jsonEncode(source.attribution)},
          ''',
            VectorSource() => '''
            type: 'vector',
            url: ${jsonEncode(source.url)},
          ''',
            ImageSource() => '''
            type: 'image',
            url: "${source.url}",
            coordinates: [
              [${source.coordinates.topLeft.lon}, ${source.coordinates.topLeft.lat}],
              [${source.coordinates.topRight.lon}, ${source.coordinates.topRight.lat}],
              [${source.coordinates.bottomRight.lon}, ${source.coordinates.bottomRight.lat}],
              [${source.coordinates.bottomLeft.lon}, ${source.coordinates.bottomLeft.lat}]
            ],
          ''',
            VideoSource() => '''
            type: 'video',
            urls: ${jsonEncode(source.urls)},
            coordinates: [
              [${source.coordinates[0].lon}, ${source.coordinates[0].lat}],
              [${source.coordinates[1].lon}, ${source.coordinates[1].lat}],
              [${source.coordinates[2].lon}, ${source.coordinates[2].lat}],
              [${source.coordinates[3].lon}, ${source.coordinates[3].lat}]
            ],
          ''',
            _ => throw UnsupportedError('Unsupported source type: ${source.runtimeType}'),
          }}
      };
      window.map.addSource("${source.id}", sourceObj);
''',
    );
    // it might take some time until, e.g. the TileJSON is loaded.
    Future.delayed(const Duration(seconds: 1), getAttributions);
  }

  @override
  void dispose() {}

  @override
  Future<List<String>> getAttributions() async {
    final result = await webViewController.callAsyncJavaScript(
      functionBody: r'''
      const style = window.map.getStyle();
      const sources = style && style.sources ? Object.values(style.sources) : [];
      return sources
        .map(src => src && src.attribution)
        .filter(attr => attr !== undefined && attr !== null && `${attr}`.length > 0);
''',
    );
    if (result?.value case final List<dynamic> list) {
      _cachedAttributions = list
          .map((e) => e.toString())
          .toList(growable: false);
    }
    return _cachedAttributions;
  }

  @override
  List<String> getAttributionsSync() => _cachedAttributions;

  @override
  List<String> getLayerIds() => _cachedLayerIds;

  Future<List<String>> _fetchLayerIds() async {
    final result = await webViewController.callAsyncJavaScript(
      functionBody: '''
      const layers = window.map.getStyle().layers;
      return layers.map(layer => layer.id);
''',
    );
    if (result?.value case final List<dynamic> list) {
      _cachedLayerIds = list.cast<String>();
    }
    return _cachedLayerIds;
  }

  @override
  Future<void> removeImage(String id) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeImage("${id.replaceAll('"', r'\"')}");
''',
    );
  }

  @override
  Future<void> removeLayer(String id) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeLayer("${id.replaceAll('"', r'\"')}");
''',
    );
  }

  @override
  Future<void> removeSource(String id) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeSource("${id.replaceAll('"', r'\"')}");
''',
    );
  }

  @override
  void setProjection(MapProjection projection) {
    webViewController.callAsyncJavaScript(
      functionBody:
          '''
      window.map.setProjection({type: "${projection.name}"});
''',
    );
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final dataBytes = data.codeUnits;
    final idBytes = id.codeUnits;
    final bytes = ByteData(1 + 1 + idBytes.length + dataBytes.length);
    bytes.setUint8(0, actionUpdateGeoJson);
    bytes.setUint8(1, idBytes.length);
    for (var i = 0; i < idBytes.length; i++) {
      bytes.setUint8(2 + i, idBytes[i]);
    }
    for (var i = 0; i < dataBytes.length; i++) {
      bytes.setUint8(2 + idBytes.length + i, dataBytes[i]);
    }
    webSocket.sendBytes(bytes);
  }
}

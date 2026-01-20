import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/webview/magic_numbers.dart';
import 'package:maplibre/src/platform/webview/websocket.dart';

/// Android specific implementation of the [StyleController].
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
    final idBytes = Uint8List.fromList(id.codeUnits);
    final data = ByteData(2 + idBytes.lengthInBytes + bytes.lengthInBytes);
    data.setUint8(0, actionAddImage);
    data.setUint8(1, idBytes.lengthInBytes);
    for (var i = 0; i < idBytes.lengthInBytes; i++) {
      data.setUint8(2 + i, idBytes[i]);
    }
    for (var i = 0; i < bytes.lengthInBytes; i++) {
      data.setUint8(2 + idBytes.lengthInBytes + i, bytes[i]);
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
        ${layer is StyleLayerWithSource ? 'source-layer: "${layer.sourceLayerId}",' : ''}
      };
      window.map.addLayer(layer, $belowLayerId);
''',
    );
    Future.delayed(const Duration(seconds: 1), _fetchLayerIds);
  }

  @override
  Future<void> addSource(Source source) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      const source = {
        ${switch (source) {
            GeoJsonSource() => '''
            type: 'geojson',
            data: JSON.parse(`${jsonEncode(source.data)}`),
          ''',
            RasterSource() => '''
            type: 'raster',
            tiles: ${jsonEncode(source.tiles)},
            tileSize: ${source.tileSize},
          ''',
            RasterDemSource() => '''
            type: 'raster-dem',
            tiles: ${jsonEncode(source.tiles)},
            tileSize: ${source.tileSize},
          ''',
            VectorSource() => '''
            type: 'vector',
            tiles: ${jsonEncode(source.tiles)},
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
            urls: ${source.urls},
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
      window.map.addSource("${source.id}", source);
''',
    );
    Future.delayed(const Duration(seconds: 1), getAttributions);
  }

  @override
  void dispose() {}

  @override
  Future<List<String>> getAttributions() async {
    final result = await webViewController.callAsyncJavaScript(
      functionBody: '''
      return window.map.getAttributions();
''',
    );
    if (result?.value case final List<dynamic> list) {
      _cachedAttributions = list.cast<String>();
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
      return window.map.removeImage("$id");
''',
    );
  }

  @override
  Future<void> removeLayer(String id) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeLayer("$id");
''',
    );
  }

  @override
  Future<void> removeSource(String id) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeSource("$id");
''',
    );
  }

  @override
  void setProjection(MapProjection projection) {
    webViewController.callAsyncJavaScript(
      functionBody:
          '''
      window.map.setProjection("${projection.name}");
''',
    );
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    await webViewController.callAsyncJavaScript(
      functionBody:
          '''
      const source = window.map.getSource("$id");
      if (!source) {
        throw new Error('Source with id "$id" does not exist.');
      }
      source.setData(JSON.parse(`$data`));
''',
    );
  }
}

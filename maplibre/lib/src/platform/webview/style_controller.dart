import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:maplibre/maplibre.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerWebView extends StyleController {
  /// Creates a new instance of [StyleControllerWebView].
  StyleControllerWebView(this._webViewController);

  final InAppWebViewController _webViewController;

  List<String> _cachedAttributions = const [];
  List<String> _cachedLayerIds = const [];

  @override
  Future<void> addImage(String id, Uint8List bytes) {
    // TODO: implement addImage
    throw UnimplementedError();
  }

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async {
    // TODO: implement addLayer
    unawaited(getAttributions());
    unawaited(_fetchLayerIds());
  }

  @override
  Future<void> addSource(Source source) async {
    // TODO implement
    await _webViewController.callAsyncJavaScript(
      functionBody: '''
''',
    );
  }

  @override
  void dispose() {}

  @override
  Future<List<String>> getAttributions() async {
    final result = await _webViewController.callAsyncJavaScript(
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
    final result = await _webViewController.callAsyncJavaScript(
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
    await _webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeImage("$id");
''',
    );
  }

  @override
  Future<void> removeLayer(String id) async {
    await _webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeLayer("$id");
''',
    );
  }

  @override
  Future<void> removeSource(String id) async {
    await _webViewController.callAsyncJavaScript(
      functionBody:
          '''
      return window.map.removeSource("$id");
''',
    );
  }

  @override
  void setProjection(MapProjection projection) {
    _webViewController.callAsyncJavaScript(
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
    await _webViewController.callAsyncJavaScript(
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

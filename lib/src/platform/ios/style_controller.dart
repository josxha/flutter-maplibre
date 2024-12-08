part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerIos implements StyleController {
  const StyleControllerIos._(this._ffiStyle, this._hostApi);

  final ffi.MLNStyle _ffiStyle;
  final pigeon.MapLibreHostApi _hostApi;

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    // TODO: implement addImage
    throw UnimplementedError();
  }

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    // TODO: use FFI for this method
    await switch (layer) {
      FillStyleLayer() => _hostApi.addFillLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      CircleStyleLayer() => _hostApi.addCircleLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      BackgroundStyleLayer() => _hostApi.addBackgroundLayer(
        id: layer.id,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      FillExtrusionStyleLayer() => _hostApi.addFillExtrusionLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      HeatmapStyleLayer() => _hostApi.addHeatmapLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      HillshadeStyleLayer() => _hostApi.addHillshadeLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      LineStyleLayer() => _hostApi.addLineLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      RasterStyleLayer() => _hostApi.addRasterLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      SymbolStyleLayer() => _hostApi.addSymbolLayer(
        id: layer.id,
        sourceId: layer.sourceId,
        belowLayerId: belowLayerId,
        layout: layer.layout,
        paint: layer.paint,
      ),
      _ => throw UnimplementedError(
        'The Layer is not supported: ${layer.runtimeType}',
      ),
    };
  }

  @override
  Future<void> addSource(Source source) async {
    // TODO: implement addSource
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() async {
    _ffiStyle.release();
  }

  @override
  Future<List<String>> getAttributions() async {
    // TODO: implement getAttributions
    throw UnimplementedError();
  }

  @override
  Future<void> removeImage(String id) async {
    final ffiId = NSString(id);
    _ffiStyle.removeImageForName_(ffiId);
    ffiId.release();
  }

  @override
  Future<void> removeLayer(String id) async {
    final ffiId = NSString(id);
    final ffiLayer = _ffiStyle.layerWithIdentifier_(ffiId);
    if (ffiLayer == null) return;
    _ffiStyle.removeLayer_(ffiLayer);
    ffiId.release();
  }

  @override
  Future<void> removeSource(String id) async {
    final ffiId = NSString(id);
    final ffiSource = _ffiStyle.sourceWithIdentifier_(ffiId);
    if (ffiSource == null) return;
    _ffiStyle.removeSource_(ffiSource);
    ffiId.release();
  }

  @override
  Future<void> updateGeoJsonSource({required String id, required String data}) async {
    // TODO: implement updateGeoJsonSource
    throw UnimplementedError();
  }
}

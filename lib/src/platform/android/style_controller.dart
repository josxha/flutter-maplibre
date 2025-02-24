part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerAndroid implements StyleController {
  StyleControllerAndroid._(this._jniStyle, this._hostApi);

  final jni.Style _jniStyle;
  final pigeon.MapLibreHostApi _hostApi;

  final List<StyleLayer> _draggableLayers = [];

  @override
  List<StyleLayer> getDraggableLayers() => _draggableLayers;

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    // TODO: use JNI for this method
    switch (layer) {
      case FillStyleLayer():
        await _hostApi.addFillLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
        if (layer.draggable) _draggableLayers.add(layer);
      case CircleStyleLayer():
        await _hostApi.addCircleLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
        if (layer.draggable) _draggableLayers.add(layer);
      case BackgroundStyleLayer():
        await _hostApi.addBackgroundLayer(
          id: layer.id,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
      case FillExtrusionStyleLayer():
        await _hostApi.addFillExtrusionLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
      case HeatmapStyleLayer():
        await _hostApi.addHeatmapLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
      case HillshadeStyleLayer():
        await _hostApi.addHillshadeLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
      case LineStyleLayer():
        await _hostApi.addLineLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
        if (layer.draggable) _draggableLayers.add(layer);
      case RasterStyleLayer():
        await _hostApi.addRasterLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
      case SymbolStyleLayer():
        await _hostApi.addSymbolLayer(
          id: layer.id,
          sourceId: layer.sourceId,
          belowLayerId: belowLayerId,
          layout: layer.layout,
          paint: layer.paint,
        );
        if (layer.draggable) _draggableLayers.add(layer);
      default:
        throw UnimplementedError(
          'The Layer is not supported: ${layer.runtimeType}',
        );
    }
  }

  @override
  Future<void> addSource(Source source) async {
    final jniId = source.id.toJString();
    final jni.Source jniSource;
    switch (source) {
      case GeoJsonSource():
        final jniOptions = jni.GeoJsonOptions();
        final jniData = source.data.toJString();
        if (source.data.startsWith('{')) {
          jniSource = jni.GeoJsonSource.new$4(jniId, jniData, jniOptions);
        } else {
          final jniUri = jni.URI.create(jniData);
          jniSource = jni.GeoJsonSource.new$8(jniId, jniUri!, jniOptions);
          jniUri.release();
        }
        jniOptions.release();
      case RasterDemSource():
        jniSource = jni.RasterDemSource.new$4(
          jniId,
          source.url!.toJString(),
          source.tileSize,
        );
        // TODO apply other properties
        jniSource.setVolatile(source.volatile.toJBoolean());
      case RasterSource():
        if (source.url case final String url) {
          jniSource = jni.RasterSource.new$4(
            jniId,
            url.toJString(),
            source.tileSize,
          );
        } else {
          final tiles = source.tiles!.map((e) => e.toJString());
          final tilesArray = JArray.of(JString.nullableType, tiles);
          final tileSet =
              jni.TileSet(
                  '{}'.toJString(),
                  tilesArray.as(JArray.type(JString.type)),
                )
                ..setMaxZoom(source.maxZoom)
                ..setMinZoom(source.minZoom);
          jniSource = jni.RasterSource.new$6(jniId, tileSet, source.tileSize);
          tilesArray.release();
          tileSet.release();
        }
        // TODO apply other properties
        jniSource.setVolatile(source.volatile.toJBoolean());
      case VectorSource():
        jniSource = jni.VectorSource.new$3(jniId, source.url!.toJString());
        // TODO apply other properties
        jniSource.setVolatile(source.volatile.toJBoolean());
      case ImageSource():
        // https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.geometry/-lat-lng-quad/index.html
        final jniQuad = jni.LatLngQuad(
          source.coordinates.topLeft.toLatLng(),
          source.coordinates.topRight.toLatLng(),
          source.coordinates.bottomRight.toLatLng(),
          source.coordinates.bottomLeft.toLatLng(),
        );
        final jniUri = jni.URI(source.url.toJString());
        jniSource = jni.ImageSource.new$2(jniId, jniQuad, jniUri);
        jniUri.release();
        jniQuad.release();
      case VideoSource():
        throw UnimplementedError('Video source is only supported on web.');
      default:
        throw UnimplementedError(
          'The Source is not supported: ${source.runtimeType}',
        );
    }
    _jniStyle.addSource(jniSource);
    jniSource.release();
  }

  @override
  Future<void> removeLayer(String id) async =>
      _jniStyle.removeLayer(id.toJString());

  @override
  Future<void> removeSource(String id) async =>
      _jniStyle.removeSource(id.toJString());

  @override
  Future<void> addImage(String id, Uint8List bytes) =>
  // TODO: use JNI for this method
  _hostApi.addImage(id, bytes);

  @override
  Future<void> removeImage(String id) async =>
      _jniStyle.removeImage(id.toJString());

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final source =
        _jniStyle.getSourceAs(id.toJString(), T: jni.GeoJsonSource.type)!;
    source.setGeoJson$3(data.toJString());
  }

  @override
  Future<List<String>> getAttributions() async => getAttributionsSync();

  @override
  List<String> getAttributionsSync() {
    final jSources = _jniStyle.getSources();
    final attributions = <String>[];
    for (final jSource in jSources) {
      final jniAttribution = jSource?.getAttribution();
      if (jniAttribution == null) continue;
      final attribution = jniAttribution.toDartString(releaseOriginal: true);
      if (attribution.trim().isEmpty) continue;
      attributions.add(attribution);
    }
    jSources.release();
    return attributions;
  }

  @override
  void dispose() {
    if (!_jniStyle.isReleased) {
      _jniStyle.release();
    }
  }

  JList<jni.Layer?> _getLayers() => _jniStyle.getLayers();

  @override
  void setProjection(MapProjection projection) {
    // globe is not supported on android.
  }

  JArray<JString?> _getLayersIds() => _getQueryLayerIds(_getLayers());

  JArray<JString?> _getQueryLayerIds(JList jniLayers) {
    // Use a list to temporary store the layer ids and avoid null values.
    final queryLayerIds = JList.array(JString.nullableType);

    for (var i = jniLayers.length - 1; i >= 0; i--) {
      final jniLayer = jniLayers[i]!;
      JString? jLayerId;

      switch (jniLayer.jClass.toString()) {
        case 'class org.maplibre.android.style.layers.LineLayer':
          final layer = jniLayer.as(jni.LineLayer.type);
          jLayerId = layer.getId();
          layer.release();
        case 'class org.maplibre.android.style.layers.FillLayer':
          final layer = jniLayer.as(jni.FillLayer.type);
          jLayerId = layer.getId();
          layer.release();
        case 'class org.maplibre.android.style.layers.SymbolLayer':
          final layer = jniLayer.as(jni.SymbolLayer.type);
          jLayerId = layer.getId();
          layer.release();
        case 'class org.maplibre.android.style.layers.CircleLayer':
          final layer = jniLayer.as(jni.CircleLayer.type);
          jLayerId = layer.getId();
          layer.release();
      }
      jniLayer.release();
      if (jLayerId != null) {
        queryLayerIds.add(jLayerId);
      }
    }

    final resultArray = JArray<JString?>(
      JString.nullableType,
      queryLayerIds.length,
    );
    for (var i = 0; i < queryLayerIds.length; i++) {
      if (queryLayerIds[i] != null) resultArray[i] = queryLayerIds[i];
    }
    queryLayerIds.release();

    return resultArray;
  }
}

part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerAndroid implements StyleController {
  const StyleControllerAndroid._(this._jniStyle, this._hostApi);

  final jni.Style _jniStyle;
  final pigeon.MapLibreHostApi _hostApi;

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    final jLayer = switch (layer) {
      FillStyleLayer() => jni.FillLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      CircleStyleLayer() => jni.CircleLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      BackgroundStyleLayer() => jni.BackgroundLayer(layer.id.toJString()),
      FillExtrusionStyleLayer() => jni.FillExtrusionLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      HeatmapStyleLayer() => jni.HeatmapLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      HillshadeStyleLayer() => jni.HillshadeLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      LineStyleLayer() => jni.LineLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      RasterStyleLayer() => jni.RasterLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      SymbolStyleLayer() => jni.SymbolLayer(
        layer.id.toJString(),
        layer.sourceId.toJString(),
      ),
      _ =>
        throw UnimplementedError(
          'The Layer is not supported: ${layer.runtimeType}',
        ),
    };

    // paint and layout properties
    final layoutEntries = layer.layout.entries.toList(growable: false);
    final paintEntries = layer.paint.entries.toList(growable: false);
    final props = JArray(
      jni.PropertyValue.nullableType(JObject.nullableType),
      layoutEntries.length + paintEntries.length,
    );
    for (var i = 0; i < paintEntries.length; i++) {
      final entry = paintEntries[i];
      props[i] = jni.PaintPropertyValue(
        entry.key.toJString(),
        entry.value.toJObject(),
        T: JObject.type,
      );
    }
    for (var i = 0; i < layoutEntries.length; i++) {
      final entry = layoutEntries[i];
      props[paintEntries.length + i] = jni.LayoutPropertyValue(
        entry.key.toJString(),
        entry.value.toJObject(),
        T: JObject.type,
      );
    }
    jLayer.setProperties(props);

    // add to style
    if (belowLayerId == null) {
      _jniStyle.addLayer(jLayer);
    } else {
      _jniStyle.addLayerBelow(jLayer, belowLayerId.toJString());
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
}

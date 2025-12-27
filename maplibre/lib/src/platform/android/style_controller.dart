part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerAndroid extends StyleController {
  const StyleControllerAndroid._(this._jStyle);

  final jni.Style _jStyle;

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async => using((arena) {
    final jId = layer.id.toJString()..releasedBy(arena);
    final prevLayer = _jStyle.getLayer(jId);
    if (prevLayer != null) {
      throw Exception(
        'A Layer with the id "${layer.id}" already exists in the map style.',
      );
    }

    JObject? jFilter;
    if (layer.filter case final List<Object> filter) {
      final jFilterString = jsonEncode(filter).toJString()..releasedBy(arena);
      jFilter = jni.Helpers.INSTANCE.parseExpression(jFilterString)
        ..releasedBy(arena);
    }
    final jni.Layer jLayer;
    switch (layer) {
      case StyleLayerWithSource():
        final jSourceId = layer.sourceId.toJString()..releasedBy(arena);
        switch (layer) {
          case FillStyleLayer():
            final jFillLayer = jni.FillLayer(jId, jSourceId);
            if (jFilter != null) jFillLayer.setFilter(jFilter);
            jLayer = jFillLayer;
          case CircleStyleLayer():
            final jCircleLayer = jni.CircleLayer(jId, jSourceId);
            if (jFilter != null) jCircleLayer.setFilter(jFilter);
            jLayer = jCircleLayer;
          case FillExtrusionStyleLayer():
            final jFillExtrusionLayer = jni.FillExtrusionLayer(jId, jSourceId);
            if (jFilter != null) jFillExtrusionLayer.setFilter(jFilter);
            jLayer = jFillExtrusionLayer;
          case HeatmapStyleLayer():
            final jHeatmapLayer = jni.HeatmapLayer(jId, jSourceId);
            if (jFilter != null) jHeatmapLayer.setFilter(jFilter);
            jLayer = jHeatmapLayer;
          case HillshadeStyleLayer():
            final jHillshadeLayer = jni.HillshadeLayer(jId, jSourceId);
            // TODO if (jFilter != null) jHillshadeLayer.setFilter(jFilter);
            jLayer = jHillshadeLayer;
          case LineStyleLayer():
            final jLineLayer = jni.LineLayer(jId, jSourceId);
            if (jFilter != null) jLineLayer.setFilter(jFilter);
            jLayer = jLineLayer;
          case RasterStyleLayer():
            final jRasterLayer = jni.RasterLayer(jId, jSourceId);
            // TODO if (jFilter != null) jRasterLayer.setFilter(jFilter);
            jLayer = jRasterLayer;
          case SymbolStyleLayer():
            final jSymbolLayer = jni.SymbolLayer(jId, jSourceId);
            if (jFilter != null) jSymbolLayer.setFilter(jFilter);
            jLayer = jSymbolLayer;
          default:
            throw UnimplementedError(
              'The Layer is not supported: ${layer.runtimeType}',
            );
        }
      default:
        switch (layer) {
          case BackgroundStyleLayer():
            jLayer = jni.BackgroundLayer(jId);
          default:
            throw UnimplementedError(
              'The Layer is not supported: ${layer.runtimeType}',
            );
        }
    }

    jLayer.setMinZoom(layer.minZoom);
    jLayer.setMaxZoom(layer.maxZoom);

    // paint and layout properties
    final layoutEntries = layer.layout.entries.toList(growable: false);
    final paintEntries = layer.paint.entries.toList(growable: false);
    final props = JArray(
      jni.PropertyValue.nullableType(JObject.nullableType),
      layoutEntries.length + paintEntries.length,
    )..releasedBy(arena);
    for (var i = 0; i < paintEntries.length; i++) {
      final entry = paintEntries[i];
      props[i] = jni.PaintPropertyValue(
        entry.key.toJString(),
        entry.value.toJObject(arena),
        T: JObject.type,
      )..releasedBy(arena);
    }
    for (var i = 0; i < layoutEntries.length; i++) {
      final entry = layoutEntries[i];
      props[paintEntries.length + i] = jni.LayoutPropertyValue(
        entry.key.toJString(),
        entry.value.toJObject(arena),
        T: JObject.type,
      )..releasedBy(arena);
    }
    jLayer.releasedBy(arena);
    jLayer.setProperties(props);

    // add to style
    if (belowLayerId case final String belowId) {
      _jStyle.addLayerBelow(jLayer, belowId.toJString()..releasedBy(arena));
    } else if (aboveLayerId case final String aboveId) {
      _jStyle.addLayerAbove(jLayer, aboveId.toJString()..releasedBy(arena));
    } else if (atIndex case final int index) {
      _jStyle.addLayerAt(jLayer, index);
    } else {
      _jStyle.addLayer(jLayer);
    }
  });

  @override
  Future<void> addSource(Source source) async => using((arena) {
    final jId = source.id.toJString()..releasedBy(arena);
    final prevSource = _jStyle.getSource(jId);
    if (prevSource != null) {
      throw Exception(
        'A Source with the id "${source.id}" already exists in the map style.',
      );
    }

    final jni.Source jSource;
    switch (source) {
      case GeoJsonSource():
        final jOptions = jni.GeoJsonOptions()..releasedBy(arena);
        final jData = source.data.toJString()..releasedBy(arena);
        if (source.data.startsWith('{')) {
          jSource = jni.GeoJsonSource.new$4(jId, jData, jOptions);
        } else {
          final jUri = jni.URI.create(jData)!..releasedBy(arena);
          jSource = jni.GeoJsonSource.new$8(jId, jUri, jOptions);
        }
      case RasterDemSource():
        jSource = jni.RasterDemSource.new$4(
          jId,
          source.url!.toJString()..releasedBy(arena),
          source.tileSize,
        );
        // TODO apply other properties
        jSource.setVolatile(source.volatile.toJBoolean()..releasedBy(arena));
      case RasterSource():
        if (source.url case final String url) {
          jSource = jni.RasterSource.new$4(
            jId,
            url.toJString()..releasedBy(arena),
            source.tileSize,
          );
        } else {
          final tiles = source.tiles!.map(
            (e) => e.toJString()..releasedBy(arena),
          );
          final tilesArray = JArray.of(JString.nullableType, tiles)
            ..releasedBy(arena);
          final tileSet =
              jni.TileSet(
                  '{}'.toJString()..releasedBy(arena),
                  tilesArray.as(JArray.type(JString.type))..releasedBy(arena),
                )
                ..releasedBy(arena)
                ..setMaxZoom(source.maxZoom)
                ..setMinZoom(source.minZoom);
          jSource = jni.RasterSource.new$6(jId, tileSet, source.tileSize);
        }
        // TODO apply other properties
        jSource.setVolatile(source.volatile.toJBoolean()..releasedBy(arena));
      case VectorSource():
        jSource = jni.VectorSource.new$3(
          jId,
          source.url!.toJString()..releasedBy(arena),
        );
        // TODO apply other properties
        jSource.setVolatile(source.volatile.toJBoolean()..releasedBy(arena));
      case ImageSource():
        // https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.geometry/-lat-lng-quad/index.html
        final jniQuad = jni.LatLngQuad(
          source.coordinates.topLeft.toLatLng(),
          source.coordinates.topRight.toLatLng(),
          source.coordinates.bottomRight.toLatLng(),
          source.coordinates.bottomLeft.toLatLng(),
        )..releasedBy(arena);
        final jniUri = jni.URI(source.url.toJString()..releasedBy(arena))
          ..releasedBy(arena);
        jSource = jni.ImageSource.new$2(jId, jniQuad, jniUri);
      case VideoSource():
        throw UnimplementedError('Video source is only supported on web.');
      default:
        throw UnimplementedError(
          'The Source is not supported: ${source.runtimeType}',
        );
    }
    jSource.releasedBy(arena);
    _jStyle.addSource(jSource);
  });

  @override
  Future<void> removeLayer(String id) async =>
      _jStyle.removeLayer(id.toJString());

  @override
  Future<void> removeSource(String id) async =>
      _jStyle.removeSource(id.toJString());

  @override
  Future<void> addImage(String id, Uint8List bytes) async => using((arena) {
    final jId = id.toJString()..releasedBy(arena);
    final jBitmap = jni.BitmapFactory.decodeByteArray(
      JByteArray.from(bytes)..releasedBy(arena),
      0,
      bytes.length,
    );
    if (jBitmap == null) return;
    jBitmap.releasedBy(arena);
    _jStyle.addImage(jId, jBitmap);
  });

  @override
  Future<void> removeImage(String id) async =>
      _jStyle.removeImage(id.toJString());

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final source = _jStyle.getSourceAs(
      id.toJString(),
      T: jni.GeoJsonSource.type,
    )!;
    source.setGeoJson$3(data.toJString());
  }

  @override
  Future<List<String>> getAttributions() async => getAttributionsSync();

  @override
  List<String> getAttributionsSync() => using((arena) {
    try {
      final jSources = _jStyle.getSources()..releasedBy(arena);
      final attributions = <String>[];
      for (final jSource in jSources) {
        final jAttribution = jSource?.getAttribution();
        if (jAttribution == null) continue;
        final attribution = jAttribution.toDartString(releaseOriginal: true);
        if (attribution.trim().isEmpty) continue;
        attributions.add(attribution);
      }
      return attributions;
    } catch (e) {
      // hide error during setStyle()
      return const [];
    }
  });

  @override
  List<String> getLayerIds() {
    final layers = _jStyle.getLayers();
    return layers
        .map((e) => e?.getId().toDartString(releaseOriginal: true))
        .nonNulls
        .toList(growable: false);
  }

  @override
  void dispose() {
    if (!_jStyle.isReleased) _jStyle.release();
  }

  JList<jni.Layer?> _getLayers() => _jStyle.getLayers();

  @override
  void setProjection(MapProjection projection) {
    // globe is not supported on android.
  }
}

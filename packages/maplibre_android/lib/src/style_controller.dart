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

    jni.Expression? jFilter;
    if (layer.filter case final filter?) {
      final jFilterString = jsonEncode(filter).toJString()..releasedBy(arena);
      jFilter = jni.Expression$Converter.convert$2(jFilterString)
        ?..releasedBy(arena);
    }
    JString? jSourceLayer;
    if (layer is StyleLayerWithSource) {
      if (layer.sourceLayerId case final String id) {
        jSourceLayer = id.toJString()..releasedBy(arena);
      }
    }

    final jni.Layer jLayer;
    switch (layer) {
      case StyleLayerWithSource():
        final jSourceId = layer.sourceId.toJString()..releasedBy(arena);
        switch (layer) {
          case FillStyleLayer():
            final jFillLayer = jni.FillLayer(jId, jSourceId);
            if (jFilter != null) jFillLayer.filter = jFilter;
            if (jSourceLayer != null) jFillLayer.sourceLayer = jSourceLayer;
            jLayer = jFillLayer;
          case CircleStyleLayer():
            final jCircleLayer = jni.CircleLayer(jId, jSourceId);
            if (jFilter != null) jCircleLayer.filter = jFilter;
            if (jSourceLayer != null) jCircleLayer.sourceLayer = jSourceLayer;
            jLayer = jCircleLayer;
          case FillExtrusionStyleLayer():
            final jFillExtrusionLayer = jni.FillExtrusionLayer(jId, jSourceId);
            if (jFilter != null) jFillExtrusionLayer.filter = jFilter;
            if (jSourceLayer != null) {
              jFillExtrusionLayer.sourceLayer = jSourceLayer;
            }
            jLayer = jFillExtrusionLayer;
          case HeatmapStyleLayer():
            final jHeatmapLayer = jni.HeatmapLayer(jId, jSourceId);
            if (jFilter != null) jHeatmapLayer.filter = jFilter;
            if (jSourceLayer != null) {
              jHeatmapLayer.sourceLayer = jSourceLayer;
            }
            jLayer = jHeatmapLayer;
          case HillshadeStyleLayer():
            final jHillshadeLayer = jni.HillshadeLayer(jId, jSourceId);
            if (jSourceLayer != null) {
              jHillshadeLayer.sourceLayer = jSourceLayer;
            }
            jLayer = jHillshadeLayer;
          case LineStyleLayer():
            final jLineLayer = jni.LineLayer(jId, jSourceId);
            if (jFilter != null) jLineLayer.filter = jFilter;
            if (jSourceLayer != null) jLineLayer.sourceLayer = jSourceLayer;
            jLayer = jLineLayer;
          case RasterStyleLayer():
            final jRasterLayer = jni.RasterLayer(jId, jSourceId);
            if (jSourceLayer != null) jRasterLayer.sourceLayer = jSourceLayer;
            jLayer = jRasterLayer;
          case SymbolStyleLayer():
            final jSymbolLayer = jni.SymbolLayer(jId, jSourceId);
            if (jFilter != null) jSymbolLayer.filter = jFilter;
            if (jSourceLayer != null) jSymbolLayer.sourceLayer = jSourceLayer;
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

    jLayer.minZoom = layer.minZoom;
    jLayer.maxZoom = layer.maxZoom;

    // paint and layout properties
    final layoutEntries = layer.layout.entries.toList(growable: false);
    final paintEntries = layer.paint.entries.toList(growable: false);
    final props = JArray.withLength(
      jni.PropertyValue.type,
      layoutEntries.length + paintEntries.length,
    )..releasedBy(arena);
    for (var i = 0; i < paintEntries.length; i++) {
      final entry = paintEntries[i];
      props[i] = jni.PaintPropertyValue<JObject?>(
        entry.key.toJString()..releasedBy(arena),
        entry.value.toJObject()..releasedBy(arena),
      )..releasedBy(arena);
    }
    for (var i = 0; i < layoutEntries.length; i++) {
      final entry = layoutEntries[i];
      props[paintEntries.length + i] = jni.LayoutPropertyValue<JObject?>(
        entry.key.toJString()..releasedBy(arena),
        entry.value.toJObject()..releasedBy(arena),
      )..releasedBy(arena);
    }
    jLayer.releasedBy(arena);
    jLayer.properties = props;

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
        jOptions.withTolerance(source.tolerance);
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
        jSource.volatile = (source.volatile.toJBoolean()..releasedBy(arena));
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
          final tilesArray = JArray.of(JString.type, tiles)..releasedBy(arena);
          final tileSet =
              jni.TileSet(
                  '{}'.toJString()..releasedBy(arena),
                  tilesArray.as(JArray.type(JString.type))..releasedBy(arena),
                )
                ..releasedBy(arena)
                ..maxZoom = source.maxZoom.toJFloat()
                ..minZoom = source.minZoom.toJFloat();
          jSource = jni.RasterSource.new$6(jId, tileSet, source.tileSize);
        }
        // TODO apply other properties
        jSource.volatile = (source.volatile.toJBoolean()..releasedBy(arena));
      case VectorSource():
        jSource = jni.VectorSource.new$3(
          jId,
          source.url!.toJString()..releasedBy(arena),
        );
        // TODO apply other properties
        jSource.volatile = (source.volatile.toJBoolean()..releasedBy(arena));
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
    final pixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final targetDensity = (pixelRatio * 160).round();
    final jOptions = jni.BitmapFactory$Options()
      ..releasedBy(arena)
      ..inScaled = true
      ..inDensity = 160
      ..inTargetDensity = targetDensity;

    final jBitmap = jni.BitmapFactory.decodeByteArray$1(
      JByteArray.of(bytes)..releasedBy(arena),
      0,
      bytes.length,
      jOptions,
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
    final source = _jStyle.getSourceAs<jni.GeoJsonSource>(id.toJString());
    source?.geoJson$3 = data.toJString();
  }

  @override
  Future<List<String>> getAttributions() async => getAttributionsSync();

  @override
  List<String> getAttributionsSync() => using((arena) {
    try {
      final jSources = _jStyle.sources..releasedBy(arena);
      final attributions = <String>[];
      for (var i = 0; i < jSources.size(); i++) {
        final jSource = jSources.get(i);
        final jAttribution = jSource?.attribution;
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
    final layers = _jStyle.layers;
    return layers
        .asDart()
        .map((e) => e?.id.toDartString(releaseOriginal: true))
        .nonNulls
        .toList(growable: false);
  }

  @override
  void dispose() {
    if (!_jStyle.isReleased) _jStyle.release();
  }

  JList<jni.Layer?> _getLayers() => _jStyle.layers;

  @override
  void setProjection(MapProjection projection) {
    // globe is not supported on android.
  }
}

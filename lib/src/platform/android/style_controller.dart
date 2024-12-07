part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerAndroid implements StyleController {
  const StyleControllerAndroid._(this._jniStyle, this._hostApi);

  final jni.Style _jniStyle;
  final pigeon.MapLibreHostApi _hostApi;

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    // TODO: use JNI for this method
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
    final jniStyle = _jniStyle;
    final jniId = source.id.toJString();
    await runOnPlatformThread(() {
      final jni.Source jniSource;
      switch (source) {
        case GeoJsonSource():
          final jniOptions = jni.GeoJsonOptions();
          final jniData = source.data.toJString();
          if (source.data.startsWith('{')) {
            jniSource = jni.GeoJsonSource.new$4(jniId, jniData, jniOptions);
          } else {
            final jniUri = jni.URI.create(jniData);
            jniSource = jni.GeoJsonSource.new$8(jniId, jniUri, jniOptions);
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
            jniSource =
                jni.RasterSource.new$4(jniId, url.toJString(), source.tileSize);
          } else {
            final tilesArray = JArray(JString.type, source.tiles!.length);
            for (var i = 0; i < source.tiles!.length; i++) {
              tilesArray[i] = source.tiles![i].toJString();
            }
            final tileSet = jni.TileSet('{}'.toJString(), tilesArray)
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
          final jniQuad = jni.LatLngQuad(
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
            source.coordinates[0].toLatLng(),
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
      jniStyle.addSource(jniSource);
      jniSource.release();
    });
  }

  @override
  Future<void> removeLayer(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle.removeLayer(id.toJString());
    });
  }

  @override
  Future<void> removeSource(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle.removeSource(id.toJString());
    });
  }

  @override
  Future<void> addImage(String id, Uint8List bytes) =>
      // TODO: use JNI for this method
      _hostApi.addImage(id, bytes);

  @override
  Future<void> removeImage(String id) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      jniStyle.removeImage(id.toJString());
    });
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final jniStyle = _jniStyle;
    await runOnPlatformThread(() {
      final source =
          jniStyle.getSourceAs(id.toJString(), T: jni.GeoJsonSource.type);
      source.setGeoJson$3(data.toJString());
    });
  }

  @override
  Future<List<String>> getAttributions() async {
    // style can be null when the map hasn't finished initializing.
    final style = _jniStyle;

    return runOnPlatformThread<List<String>>(() {
      final jSources = style.getSources();
      final attributions = <String>[];
      for (final jSource in jSources) {
        final jniAttribution = jSource.getAttribution();
        if (jniAttribution.isNull) continue;
        final attribution = jniAttribution.toDartString(releaseOriginal: true);
        if (attribution.trim().isEmpty) continue;
        attributions.add(attribution);
      }
      jSources.release();
      return attributions;
    });
  }

  @override
  void dispose() {
    if (!_jniStyle.isNull && !_jniStyle.isReleased) {
      _jniStyle.release();
    }
  }

  JList<jni.Layer> _getLayers() => _jniStyle.getLayers();
}
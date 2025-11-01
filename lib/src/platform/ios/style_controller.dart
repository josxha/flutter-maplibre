part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerIos implements StyleController {
  StyleControllerIos._(this._ffiStyle, this._hostApi);

  final MLNStyle _ffiStyle;
  final pigeon.MapLibreHostApi _hostApi;

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    // TODO Unhandled Exception: FailedToLoadClassException: Failed to load Objective-C class: NSImage
    // https://developer.apple.com/documentation/foundation/nsitemproviderreading/2919479-objectwithitemproviderdata
    /*_ffiStyle.setImage_forName_(
      NSImage.objectWithItemProviderData_typeIdentifier_error_(
        bytes.toNSData(),
        // The uniform type identifier (UTI) representing the data type of data.
        'public.image'.toNSString(),
        nullptr,
      )!,
      id.toNSString(),
    );*/
    await _hostApi.addImage(id, bytes);
  }

  @override
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) => using((
    arena,
  ) async {
    final ffiId = layer.id.toNSString()..releasedBy(arena);
    final prevStyleLayer = _ffiStyle.layerWithIdentifier(ffiId)
      ?..releasedBy(arena);
    if (prevStyleLayer != null) {
      throw Exception(
        'A Layer with the id "${layer.id}" already exists in the map style.',
      );
    }

    MLNStyleLayer? ffiStyleLayer;
    switch (layer) {
      case BackgroundStyleLayer():
        ffiStyleLayer = MLNBackgroundStyleLayer.new$()
          ..initWithIdentifier(ffiId)
          ..releasedBy(arena)
          ..backgroundColor = NSExpression.expressionWithFormat$1(
            layer.color.toHexString().toNSString()..releasedBy(arena),
          )
          ..releasedBy(arena);
      case StyleLayerWithSource():
        final ffiSource = _ffiStyle.sourceWithIdentifier(
          layer.sourceId.toNSString(),
        )?..releasedBy(arena);
        if (ffiSource == null) {
          throw Exception('Source "${layer.sourceId}" does not exist.');
        }
        switch (layer) {
          case FillStyleLayer():
            ffiStyleLayer = MLNFillStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
          case CircleStyleLayer():
            ffiStyleLayer = MLNCircleStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
          case FillExtrusionStyleLayer():
            ffiStyleLayer = MLNFillExtrusionStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
          case HeatmapStyleLayer():
            ffiStyleLayer = MLNHeatmapStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
          case HillshadeStyleLayer():
            ffiStyleLayer = MLNHillshadeStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
          case LineStyleLayer():
            ffiStyleLayer = MLNLineStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
          case RasterStyleLayer():
            ffiStyleLayer = MLNRasterStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
          case SymbolStyleLayer():
            ffiStyleLayer = MLNSymbolStyleLayer.new$()
              ..initWithIdentifier(ffiId, source: ffiSource);
        }
        ffiStyleLayer?.releasedBy(arena);
    }

    if (ffiStyleLayer == null) {
      throw UnimplementedError(
        'The Layer is not supported: ${layer.runtimeType}',
      );
    }
    ffiStyleLayer.minimumZoomLevel = layer.minZoom;
    ffiStyleLayer.maximumZoomLevel = layer.maxZoom;
    ffiStyleLayer.setProperties(layer.paint);
    ffiStyleLayer.setProperties(layer.layout);
    _ffiStyle.addLayer(ffiStyleLayer);
  });

  @override
  Future<void> addSource(Source source) => using((arena) async {
    final ffiId = source.id.toNSString()..releasedBy(arena);
    final prevSource = _ffiStyle.sourceWithIdentifier(ffiId)
      ?..releasedBy(arena);

    if (prevSource != null) {
      throw Exception(
        'A Source with the id "${source.id}" already exists in the map style.',
      );
    }

    final MLNSource ffiSource;
    switch (source) {
      case GeoJsonSource():
        final shapeSource = MLNShapeSource.new$();
        if (source.data.startsWith('{')) {
          shapeSource.initWithIdentifier$1(
            ffiId,
            shape: MLNShape.shapeWithData(
              source.data.toNSDataUTF8()!..releasedBy(arena),
              encoding: nsUTF8StringEncoding,
              error: nullptr,
            )?..releasedBy(arena),
            options: NSDictionary.new$()..releasedBy(arena),
          );
        } else {
          shapeSource.initWithIdentifier(
            ffiId,
            URL: source.data.toNSURL()!..releasedBy(arena),
            options: NSDictionary.new$()..releasedBy(arena),
          );
        }
        ffiSource = shapeSource;
      case RasterDemSource():
        final demSource = ffiSource = MLNRasterDEMSource.new$();
        if (source.url case final String url) {
          demSource.initWithIdentifier$1(
            ffiId,
            configurationURL: url.toNSURL()!,
            tileSize: source.tileSize.toDouble(),
          );
        } else {
          final ffiUrls = NSMutableArray.new$()..releasedBy(arena);
          for (final url in source.tiles ?? <String>[]) {
            ffiUrls.addObject(url.toNSString()..releasedBy(arena));
          }
          demSource.initWithIdentifier$2(
            ffiId,
            tileURLTemplates: ffiUrls,
            options: NSDictionary.new$()..releasedBy(arena),
          );
        }
      case RasterSource():
        final rasterSource = ffiSource = MLNRasterTileSource.new$();
        if (source.url case final String url) {
          rasterSource.initWithIdentifier$1(
            ffiId,
            configurationURL: url.toNSURL()!..releasedBy(arena),
            tileSize: source.tileSize.toDouble(),
          );
        } else {
          final ffiUrls = NSMutableArray.new$()
            ..init()
            ..releasedBy(arena);
          for (final url in source.tiles ?? <String>[]) {
            ffiUrls.addObject(url.toNSString()..releasedBy(arena));
          }
          rasterSource.initWithIdentifier$2(
            ffiId,
            tileURLTemplates: ffiUrls,
            options: NSDictionary.new$()..releasedBy(arena),
          );
        }
      case VectorSource():
        final vectorSource = ffiSource = MLNVectorTileSource.new$();
        if (source.url case final String url) {
          vectorSource.initWithIdentifier$1(
            ffiId,
            configurationURLString: url.toNSString()..releasedBy(arena),
          );
        } else {
          final ffiUrls = NSMutableArray.new$()
            ..init()
            ..releasedBy(arena);
          for (final url in source.tiles ?? <String>[]) {
            ffiUrls.addObject(url.toNSString()..releasedBy(arena));
          }
          vectorSource.initWithIdentifier$2(
            ffiId,
            tileURLTemplates: ffiUrls,
            options: NSDictionary.new$()..releasedBy(arena),
          );
        }
      case ImageSource():
        final coordinates = Struct.create<MLNCoordinateQuad>()
          ..bottomLeft = source.coordinates.bottomLeft
              .toCLLocationCoordinate2D()
          ..bottomRight = source.coordinates.bottomRight
              .toCLLocationCoordinate2D()
          ..topLeft = source.coordinates.topLeft.toCLLocationCoordinate2D()
          ..topRight = source.coordinates.topRight.toCLLocationCoordinate2D();
        final imageSource = ffiSource = MLNImageSource.new$();
        imageSource.initWithIdentifier(
          ffiId,
          coordinateQuad: coordinates,
          URL: source.url.toNSURL()!..releasedBy(arena),
        );
      case VideoSource():
        throw UnimplementedError('Video source is only supported on web.');
      default:
        throw UnimplementedError(
          'The Source is not supported: ${source.runtimeType}',
        );
    }
    _ffiStyle.addSource(ffiSource);
    ffiSource.releasedBy(arena);
  });

  @override
  Future<void> dispose() async {}

  @override
  Future<List<String>> getAttributions() async => getAttributionsSync();

  @override
  List<String> getLayerIds() => using((arena) {
    final layers = _ffiStyle.layers.map(
      (e) => MLNStyleLayer.castFrom(e)..releasedBy(arena),
    );
    return layers.map((l) => l.identifier.toDartString()).toList();
  });

  @override
  Future<void> removeImage(String id) => using((arena) async {
    final ffiId = id.toNSString()..releasedBy(arena);
    _ffiStyle.removeImageForName(ffiId);
  });

  @override
  Future<void> removeLayer(String id) => using((arena) async {
    final ffiId = id.toNSString()..releasedBy(arena);
    final ffiLayer = _ffiStyle.layerWithIdentifier(ffiId)?..releasedBy(arena);
    if (ffiLayer == null) return;
    _ffiStyle.removeLayer(ffiLayer);
  });

  @override
  Future<void> removeSource(String id) => using((arena) async {
    final ffiId = id.toNSString()..releasedBy(arena);
    final ffiSource = _ffiStyle.sourceWithIdentifier(ffiId)?..releasedBy(arena);
    if (ffiSource == null) return;
    _ffiStyle.removeSource(ffiSource);
    ffiId.release();
  });

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) => using((arena) async {
    final source = _ffiStyle.sourceWithIdentifier(
      id.toNSString()..releasedBy(arena),
    )!..releasedBy(arena);
    final shapeSource = MLNShapeSource.castFrom(source)..releasedBy(arena);
    shapeSource.shape = MLNShape.shapeWithData(
      data.toNSDataUTF8()!..releasedBy(arena),
      encoding: 4, // utf-8
      error: nullptr,
    )?..releasedBy(arena);
  });

  List<MLNStyleLayer> _getLayers() => List<MLNStyleLayer>.from(
    _ffiStyle.layers.toDartList(convertOther: MLNStyleLayer.castFrom),
  );

  @override
  void setProjection(MapProjection projection) {
    // no implementation needed, globe is not supported on web.
  }

  @override
  List<String> getAttributionsSync() => using((arena) {
    final attributions = <String>[];
    final sources = _ffiStyle.sources.allObjects..releasedBy(arena);
    for (var i = 0; i < sources.count; i++) {
      final source = sources[i];
      if (!MLNTileSource.isInstance(source)) continue;
      final tileSource = MLNTileSource.castFrom(source)..releasedBy(arena);
      final html = tileSource.attributionHTMLString?..releasedBy(arena);
      if (html == null) continue;
      attributions.add(html.toDartString());
    }
    return attributions;
  });
}

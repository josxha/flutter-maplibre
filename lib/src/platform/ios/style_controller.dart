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
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    MLNStyleLayer? ffiStyleLayer;
    switch (layer) {
      case BackgroundStyleLayer():
        ffiStyleLayer = MLNBackgroundStyleLayer.new1()
          ..initWithIdentifier_(layer.id.toNSString())
          ..backgroundColor = NSExpression.expressionWithFormat_(
            layer.color.toHexString(alpha: false).toNSString(),
          );
      case StyleLayerWithSource():
        final ffiSource =
            _ffiStyle.sourceWithIdentifier_(layer.sourceId.toNSString());
        if (ffiSource == null) {
          throw Exception('Source "${layer.sourceId}" does not exist.');
        }
        switch (layer) {
          case FillStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNFillStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
          case CircleStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNCircleStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
          case FillExtrusionStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNFillExtrusionStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
          case HeatmapStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNHeatmapStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
          case HillshadeStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNHillshadeStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
          case LineStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNLineStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
          case RasterStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNRasterStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
          case SymbolStyleLayer():
            final ffiLayer = ffiStyleLayer = MLNSymbolStyleLayer.new1()
              ..initWithIdentifier_source_(
                layer.id.toNSString(),
                ffiSource,
              );
            ffiLayer.setProperties(layer.paint);
            ffiLayer.setProperties(layer.layout);
        }
    }

    if (ffiStyleLayer == null) {
      throw UnimplementedError(
        'The Layer is not supported: ${layer.runtimeType}',
      );
    }
    if (layer.minZoom case final double minZoom) {
      ffiStyleLayer.minimumZoomLevel = minZoom;
    }
    if (layer.maxZoom case final double maxZoom) {
      ffiStyleLayer.maximumZoomLevel = maxZoom;
    }
    _ffiStyle.addLayer_(ffiStyleLayer);
  }

  @override
  Future<void> addSource(Source source) async {
    final MLNSource ffiSource;
    switch (source) {
      case GeoJsonSource():
        final shapeSource = MLNShapeSource.new1();
        if (source.data.startsWith('{')) {
          shapeSource.initWithIdentifier_shape_options_(
            source.id.toNSString(),
            MLNShape.shapeWithData_encoding_error_(
              source.data.toNSDataUTF8()!,
              nsUTF8StringEncoding,
              nullptr,
            ),
            NSDictionary.new1(),
          );
        } else {
          shapeSource.initWithIdentifier_URL_options_(
            source.id.toNSString(),
            source.data.toNSURL()!,
            NSDictionary.new1(),
          );
        }
        ffiSource = shapeSource;
      case RasterDemSource():
        final demSource = ffiSource = MLNRasterDEMSource.new1();
        if (source.url case final String url) {
          demSource.initWithIdentifier_configurationURL_tileSize_(
            source.id.toNSString(),
            url.toNSURL()!,
            source.tileSize.toDouble(),
          );
        } else {
          final ffiUrls = NSMutableArray.new1();
          for (final url in source.tiles ?? <String>[]) {
            ffiUrls.addObject_(url.toNSString());
          }
          demSource.initWithIdentifier_tileURLTemplates_options_(
            source.id.toNSString(),
            ffiUrls,
            NSDictionary.new1(),
          );
        }
      case RasterSource():
        final rasterSource = ffiSource = MLNRasterTileSource.new1();
        if (source.url case final String url) {
          rasterSource.initWithIdentifier_configurationURL_tileSize_(
            source.id.toNSString(),
            url.toNSURL()!,
            source.tileSize.toDouble(),
          );
        } else {
          final ffiUrls = NSMutableArray.new1()..init();
          for (final url in source.tiles ?? <String>[]) {
            ffiUrls.addObject_(url.toNSString());
          }
          rasterSource.initWithIdentifier_tileURLTemplates_options_(
            source.id.toNSString(),
            ffiUrls,
            NSDictionary.new1(),
          );
        }
      case VectorSource():
        final vectorSource = ffiSource = MLNVectorTileSource.new1();
        if (source.url case final String url) {
          vectorSource.initWithIdentifier_configurationURL_(
            source.id.toNSString(),
            url.toNSURL()!,
          );
        } else {
          final ffiUrls = NSMutableArray.new1()..init();
          for (final url in source.tiles ?? <String>[]) {
            ffiUrls.addObject_(url.toNSString());
          }
          vectorSource.initWithIdentifier_tileURLTemplates_options_(
            source.id.toNSString(),
            ffiUrls,
            NSDictionary.new1(),
          );
        }
      case ImageSource():
        final coordinates = Struct.create<MLNCoordinateQuad>()
          ..bottomLeft =
              source.coordinates.bottomLeft.toCLLocationCoordinate2D()
          ..bottomRight =
              source.coordinates.bottomRight.toCLLocationCoordinate2D()
          ..topLeft = source.coordinates.topLeft.toCLLocationCoordinate2D()
          ..topRight = source.coordinates.topRight.toCLLocationCoordinate2D();
        final imageSource = ffiSource = MLNImageSource.new1();
        imageSource.initWithIdentifier_coordinateQuad_URL_(
          source.id.toNSString(),
          coordinates,
          source.url.toNSURL()!,
        );
      case VideoSource():
        throw UnimplementedError('Video source is only supported on web.');
      default:
        throw UnimplementedError(
          'The Source is not supported: ${source.runtimeType}',
        );
    }
    _ffiStyle.addSource_(ffiSource);
  }

  @override
  Future<void> dispose() async {
    //_ffiStyle.release();
  }

  @override
  Future<List<String>> getAttributions() async {
    return [];
    // TODO: implement getAttributions
  }

  @override
  Future<void> removeImage(String id) async {
    final ffiId = id.toNSString();
    _ffiStyle.removeImageForName_(ffiId);
    ffiId.release();
  }

  @override
  Future<void> removeLayer(String id) async {
    final ffiId = id.toNSString();
    final ffiLayer = _ffiStyle.layerWithIdentifier_(ffiId);
    if (ffiLayer == null) return;
    _ffiStyle.removeLayer_(ffiLayer);
    ffiId.release();
  }

  @override
  Future<void> removeSource(String id) async {
    final ffiId = id.toNSString();
    final ffiSource = _ffiStyle.sourceWithIdentifier_(ffiId);
    if (ffiSource == null) return;
    _ffiStyle.removeSource_(ffiSource);
    ffiId.release();
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final source =
        _ffiStyle.sourceWithIdentifier_(id.toNSString())! as MLNShapeSource;
    source.shape = MLNShape.shapeWithData_encoding_error_(
      data.toNSDataUTF8()!,
      4, // utf-8
      nullptr,
    );
    // TODO: implement updateGeoJsonSource
    throw UnimplementedError();
  }

  NSArray _getLayers() => _ffiStyle.layers;
}

part of 'map_state.dart';

/// Android specific implementation of the [StyleController].
class StyleControllerIos implements StyleController {
  const StyleControllerIos._(this._ffiStyle, this._hostApi);

  final MLNStyle _ffiStyle;
  final pigeon.MapLibreHostApi _hostApi;

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    //_ffiStyle.setImage_forName_(ffi.NSImage(), NSString(id));
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
    final MLNSource ffiSource;
    switch (source) {
      case GeoJsonSource():
        final shapeSource = ffiSource = MLNShapeSource.new1();
        if (source.data.startsWith('{')) {
          final bytes = utf8.encoder.convert(source.data);
          final ffiBytes = malloc.allocate<Uint8>(bytes.length);
          ffiBytes.asTypedList(bytes.length).setAll(0, bytes);
          shapeSource.initWithIdentifier_shape_options_(
            source.id.toNSString(),
            MLNShape.shapeWithData_encoding_error_(
              NSData.dataWithBytesNoCopy_length_(
                Pointer.fromAddress(ffiBytes.address),
                bytes.length,
              ),
              4, // NSUTF8StringEncoding
              nullptr,
            ),
            NSDictionary.new1()..init(),
          );
          malloc.free(ffiBytes);
        } else {
          shapeSource.initWithIdentifier_URL_options_(
            source.id.toNSString(),
            source.data.toNSURL()!,
            NSDictionary.new1()..init(),
          );
        }
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
            NSDictionary.new1()..init(),
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
            NSDictionary.new1()..init(),
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
            NSDictionary.new1()..init(),
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
    _ffiStyle.release();
  }

  @override
  Future<List<String>> getAttributions() async {
    // TODO: implement getAttributions
    throw UnimplementedError();
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
    final source = _ffiStyle.sourceWithIdentifier_(id.toNSString());
    // TODO: implement updateGeoJsonSource
    throw UnimplementedError();
  }

  NSArray _getLayers() => _ffiStyle.layers;
}

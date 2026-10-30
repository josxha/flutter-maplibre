part of 'map_state.dart';

/// Web specific implementation of the [StyleController].
class StyleControllerWeb extends StyleController {
  /// Create a new [StyleControllerWeb] instance.
  StyleControllerWeb(this._map);

  final interop.JsMap _map;

  /// The blob URLs of image sources from bytes or an [ImageProvider], by
  /// source id. They are revoked when their source is removed.
  final _imageSourceUrls = <String, String>{};

  @override
  Future<void> addImage(
    String id,
    Uint8List bytes, {
    double pixelRatio = 1,
  }) async {
    // The browser decodes the image: Flutter's skwasm renderer gives decoded
    // images the size of the view.
    final blob = Blob([bytes.toJS].toJS);
    final bitmap = await window.createImageBitmap(blob).toDart;
    _map.addImage(
      id,
      bitmap,
      interop.StyleImageMetadata(pixelRatio: pixelRatio),
    );
  }

  @override
  Future<void> addImageFromUiImage({
    required String id,
    required ui.Image image,
    double pixelRatio = 1,
  }) async {
    // Raw pixels, as Flutter's skwasm renderer encodes some images to PNG at
    // the size of the view.
    final data = await image.toByteData(
      format: ImageByteFormat.rawStraightRgba,
    );
    if (data == null) {
      throw StateError('Failed to read the pixels of the image "$id".');
    }
    _map.addImage(
      id,
      interop.ImageSpecification(
        width: image.width,
        height: image.height,
        data: data.buffer.asUint8List().toJS,
      ),
      interop.StyleImageMetadata(pixelRatio: pixelRatio),
    );
  }

  @override
  Future<void> removeImage(String id) async => _map.removeImage(id);

  @override
  Future<void> removeLayer(String id) async => _map.removeLayer(id);

  @override
  Future<void> removeSource(String id) async {
    // Removing a source the style lacks is not an error on other platforms.
    if (_map.getSource(id) != null) _map.removeSource(id);
    if (_imageSourceUrls.remove(id) case final String url) {
      URL.revokeObjectURL(url);
    }
  }

  @override
  Future<LineStyleLayerController?> getLineLayer(String id) async {
    final layer = _map.getLayer(id);
    if (layer == null) return null;
    if ((layer['type'] as JSString?)?.toDart != 'line') return null;
    return LineStyleLayerController(
      id: id,
      paint: {
        for (final name in LineStyleLayerController.paintProperties)
          name: _map.getPaintProperty(id, name).dartify(),
      },
      setPaintProperty: (name, value) =>
          _map.setPaintProperty(id, name, value.jsify()),
    );
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final source = _map.getSource(id);
    if (source == null) throw Exception('Source with id "$id" does not exist.');
    source.setData(parse(data));
  }

  @override
  List<String> get attributions {
    final sources =
        _map.getStyle()?.sources.dartify() as Map<Object?, Object?>?;
    if (sources == null) return const [];
    final attributions = <String>[];
    for (final MapEntry(:key, :value) in sources.entries) {
      // The source object has the attribution of a loaded TileJSON, the
      // style only the one of the source options.
      final attribution =
          _map.getSource(key! as String)?['attribution'].dartify() ??
          (value! as Map<Object?, Object?>)['attribution'];
      if (attribution == null) continue;
      if (attribution is String && attribution.isEmpty) continue;
      attributions.add(attribution.toString());
    }
    return attributions;
  }

  @override
  List<String> getLayerIds() {
    final layers = _map.getStyle()?.layers.dartify() as List<Object?>?;
    if (layers == null) return const [];
    return layers
        .map((l) => (l as Map<Object?, Object?>?)?['id'])
        .whereType<String>()
        .toList();
  }

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async {
    if (_map.getLayer(layer.id) != null) {
      throw Exception(
        'A Layer with the id "${layer.id}" already exists in the map style.',
      );
    }

    final interop.LayerSpecification jsLayer;
    switch (layer) {
      case FillStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'fill',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case CircleStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'circle',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case BackgroundStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'background',
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case FillExtrusionStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'fill-extrusion',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case HeatmapStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'heatmap',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case HillshadeStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'hillshade',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case LineStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'line',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case RasterStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'raster',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      case SymbolStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'symbol',
          source: layer.sourceId,
          layout: layer.layout.jsify()!,
          paint: layer.paint.jsify()!,
          minzoom: layer.minZoom,
          maxzoom: layer.maxZoom,
        );
      default:
        throw UnimplementedError(
          'Layer type "${layer.runtimeType}" is not implemented for Web.',
        );
    }
    if (layer.filter case final filter?) {
      final jsFilter = filter.jsify();
      if (jsFilter != null) {
        jsLayer.filter = jsFilter;
      }
    }
    if (layer is StyleLayerWithSource && layer.sourceLayerId != null) {
      jsLayer.sourceLayer = layer.sourceLayerId;
    }
    _map.addLayer(jsLayer, belowLayerId);
  }

  @override
  Future<void> addSource(Source source) async {
    if (_map.getSource(source.id) != null) {
      throw Exception(
        'A Source with the id "${source.id}" already exists in the map style.',
      );
    }
    switch (source) {
      case GeoJsonSource():
        JSAny data;
        if (source.data[0] == '{') {
          data = parse(source.data);
        } else {
          data = source.data.jsify()!;
        }
        _map.addSource(
          source.id,
          _sourceSpecification({
            'type': 'geojson',
            'maxzoom': source.maxZoom,
            'tolerance': source.tolerance,
            'lineMetrics': source.lineMetrics,
            'attribution': source.attribution,
          }, data: data),
        );
      case RasterDemSource():
        _map.addSource(
          source.id,
          _sourceSpecification({
            'type': 'raster-dem',
            'url': source.url,
            'tiles': source.tiles,
            'bounds': source.bounds,
            'minzoom': source.minZoom,
            'maxzoom': source.maxZoom,
            'tileSize': source.tileSize,
            'attribution': source.attribution,
          }),
        );
      case RasterSource():
        _map.addSource(
          source.id,
          _sourceSpecification({
            'type': 'raster',
            'url': source.url,
            'tiles': source.tiles,
            'bounds': source.bounds,
            'minzoom': source.minZoom,
            'maxzoom': source.maxZoom,
            'tileSize': source.tileSize,
            'scheme': source.scheme.name,
            'attribution': source.attribution,
          }),
        );
      case VectorSource():
        _map.addSource(
          source.id,
          _sourceSpecification({
            'type': 'vector',
            'url': source.url,
            'tiles': source.tiles,
            'bounds': source.bounds,
            'minzoom': source.minZoom,
            'maxzoom': source.maxZoom,
            'scheme': source.scheme.name,
            'attribution': source.attribution,
          }),
        );
      case ImageSource():
        // MapLibre GL JS loads image sources only from a URL.
        final url = switch (source) {
          ImageSourceUrl(:final url) => url,
          ImageSourceBytes(:final bytes) => URL.createObjectURL(
            Blob([bytes.toJS].toJS),
          ),
          ImageSourceProvider(:final image) => await _blobUrlOfProvider(image),
        };
        if (source is! ImageSourceUrl) _imageSourceUrls[source.id] = url;
        _map.addSource(
          source.id,
          interop.SourceSpecification.image(
            type: 'image',
            url: url,
            // The coordinates start at the top left corner of the image and
            // proceed in clockwise order.
            // https://github.com/maplibre/maplibre-gl-js/blob/87486a5ef2085e600e8fa4e31252629dd8488dcd/src/source/image_source.ts#L24
            coordinates: [
              [source.coordinates.topLeft.lon, source.coordinates.topLeft.lat],
              [
                source.coordinates.topRight.lon,
                source.coordinates.topRight.lat,
              ],
              [
                source.coordinates.bottomRight.lon,
                source.coordinates.bottomRight.lat,
              ],
              [
                source.coordinates.bottomLeft.lon,
                source.coordinates.bottomLeft.lat,
              ],
            ].jsify()!,
          ),
        );
      case VideoSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.video(
            type: 'video',
            urls: source.urls.jsify()!,
            coordinates: [
              source.coordinates.topLeft,
              source.coordinates.topRight,
              source.coordinates.bottomRight,
              source.coordinates.bottomLeft,
            ].map((e) => [e.lon, e.lat]).toList(growable: false).jsify()!,
          ),
        );
    }
  }

  @override
  void dispose() {
    // Interop members can't be torn off for forEach.
    // ignore: prefer_foreach
    for (final url in _imageSourceUrls.values) {
      URL.revokeObjectURL(url);
    }
    _imageSourceUrls.clear();
  }

  /// A blob URL of a PNG of the image of [provider].
  static Future<String> _blobUrlOfProvider(ImageProvider provider) async {
    final image = await resolveImageProvider(provider);
    try {
      // Raw pixels, as Flutter's skwasm renderer encodes some images to PNG at
      // the size of the view.
      final data = await image.toByteData(
        format: ImageByteFormat.rawStraightRgba,
      );
      if (data == null) {
        throw StateError('Failed to read the pixels of the image source.');
      }
      final canvas = OffscreenCanvas(image.width, image.height);
      final context =
          canvas.getContext('2d')! as OffscreenCanvasRenderingContext2D;
      context.putImageData(
        ImageData(data.buffer.asUint8ClampedList().toJS, image.width),
        0,
        0,
      );
      final blob = await canvas.convertToBlob().toDart;
      return URL.createObjectURL(blob);
    } finally {
      image.dispose();
    }
  }

  @override
  void setProjection(MapProjection projection) => _map.setProjection(
    interop.ProjectionSpecification(type: projection.name),
  );
}

/// A source specification of the [properties] that are set. MapLibre GL JS
/// rejects a property that is present but null.
interop.SourceSpecification _sourceSpecification(
  Map<String, Object?> properties, {
  JSAny? data,
}) {
  final spec =
      ({...properties}..removeWhere((key, value) => value == null)).jsify()!
          as JSObject;
  if (data != null) spec.setProperty('data'.toJS, data);
  return spec as interop.SourceSpecification;
}

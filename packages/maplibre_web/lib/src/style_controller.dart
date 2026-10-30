part of 'map_state.dart';

/// Web specific implementation of the [StyleController].
class StyleControllerWeb extends StyleController implements StyleBackend {
  /// Create a new [StyleControllerWeb] instance.
  StyleControllerWeb(this._map);

  final interop.JsMap _map;

  @override
  late final StyleSources sources = StyleSources(this);

  @override
  late final StyleLayers layers = StyleLayers(this, sources: sources);

  /// Fills [layers] and [sources] from the style that the map loaded.
  void load() {
    final style = _map.getStyle();
    if (style == null) return;
    final json = jsonDecode(stringify(style)) as Map<String, Object?>;
    if (json case {'sources': final Map<String, Object?> styleSources}) {
      sources.load(styleSources);
    }
    if (json case {'layers': final List<Object?> styleLayers}) {
      layers.load(styleLayers.whereType<Map<String, Object?>>());
    }
  }

  /// Reads what the tile sources of the map learned from their TileJSON into
  /// [sources].
  void refreshTileJson() {
    for (final source in sources.toList()) {
      final js = _map.getSource(source.id);
      if (js == null) continue;
      sources.applyTileJson(
        source.id,
        attribution: js['attribution'].dartify()?.toString(),
        minZoom: (js['minzoom'].dartify() as num?)?.toDouble(),
        maxZoom: (js['maxzoom'].dartify() as num?)?.toDouble(),
        bounds: switch (js['bounds'].dartify()) {
          final List<Object?> bounds when bounds.length == 4 => [
            for (final value in bounds) (value! as num).toDouble(),
          ],
          _ => null,
        },
      );
    }
  }

  @override
  void batch(void Function() updates) => updates();

  /// The blob URLs of image and video sources from bytes or an
  /// [ImageProvider], by source id. They are revoked when their source is
  /// removed.
  final _blobUrls = <String, String>{};

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
  Future<void> addLayer(
    Map<String, Object?> json, {
    String? belowLayerId,
  }) async => _map.addLayer(json.jsify()!, belowLayerId);

  @override
  Future<void> removeLayer(String id) async => _map.removeLayer(id);

  @override
  void moveLayer(String id, {String? belowLayerId}) =>
      _map.moveLayer(id, belowLayerId);

  @override
  void setLayerProperty(
    String layerId,
    String name,
    Object? value, {
    required bool layout,
  }) => layout
      ? _map.setLayoutProperty(layerId, name, value.jsify())
      : _map.setPaintProperty(layerId, name, value.jsify());

  @override
  void setFilter(String layerId, Object? filter) =>
      _map.setFilter(layerId, filter.jsify());

  @override
  void setZoomRange(String layerId, double minZoom, double maxZoom) =>
      _map.setLayerZoomRange(layerId, minZoom, maxZoom);

  @override
  Future<void> removeSource(String id) async {
    // Removing a source the style lacks is not an error on other platforms.
    if (_map.getSource(id) != null) _map.removeSource(id);
    if (_blobUrls.remove(id) case final String url) {
      URL.revokeObjectURL(url);
    }
  }

  @override
  Future<void> setGeoJsonData(String id, String data) async =>
      _map.getSource(id)!.setData(parse(data));

  @override
  Future<void> setGeoJsonUrl(String id, String url) async =>
      _map.getSource(id)!.setData(url.toJS);

  @override
  Future<void> setImageCoordinates(String id, LngLatQuad coordinates) async =>
      _map.getSource(id)!.setCoordinates(coordinates.toJson().jsify()!);

  @override
  Future<void> setTiles(
    String id,
    List<String> tiles,
    Map<String, Object?> specification,
  ) async => _map.getSource(id)!.setTiles(tiles.jsify()!);

  @override
  Future<void> setTileJsonUrl(
    String id,
    String url,
    Map<String, Object?> specification,
  ) async => _map.getSource(id)!.setUrl(url);

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
  Future<void> addSource(Source source) async {
    switch (source) {
      case GeoJsonSource():
        // The browser parses the data, which is faster than Dart.
        final data = switch (source) {
          GeoJsonSourceUrl(:final url) => url.toJS,
          GeoJsonSourceData(:final data) => parse(data),
        };
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
      case RasterDemSource() || RasterSource() || VectorSource():
        // gl-js has no volatile sources.
        _map.addSource(
          source.id,
          _sourceSpecification(source.toJson()!..remove('volatile')),
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
        _addBlobSource(
          source.id,
          source is ImageSourceUrl ? null : url,
          interop.SourceSpecification.image(
            type: 'image',
            url: url,
            // The coordinates start at the top left corner of the image and
            // proceed in clockwise order.
            // https://github.com/maplibre/maplibre-gl-js/blob/87486a5ef2085e600e8fa4e31252629dd8488dcd/src/source/image_source.ts#L24
            coordinates: source.coordinates.toJson().jsify()!,
          ),
        );
      case VideoSource():
        final blobUrl = switch (source) {
          VideoSourceBytes(:final bytes) => URL.createObjectURL(
            Blob([bytes.toJS].toJS),
          ),
          _ => null,
        };
        final urls = switch (source) {
          VideoSourceUrls(:final urls) => urls,
          VideoSourceBytes() => [blobUrl!],
          VideoSourceAsset(:final asset) => [AssetManager().getAssetUrl(asset)],
        };
        _addBlobSource(
          source.id,
          blobUrl,
          interop.SourceSpecification.video(
            type: 'video',
            urls: urls.jsify()!,
            coordinates: source.coordinates.toJson().jsify()!,
          ),
        );
    }
  }

  /// Adds the source [specification], whose content comes from [blobUrl]
  /// if it isn't null. The blob URL is kept for [removeSource] once the map
  /// accepts the source, and revoked if it rejects it.
  void _addBlobSource(
    String id,
    String? blobUrl,
    interop.SourceSpecification specification,
  ) {
    try {
      _map.addSource(id, specification);
    } catch (_) {
      if (blobUrl != null) URL.revokeObjectURL(blobUrl);
      rethrow;
    }
    if (blobUrl != null) _blobUrls[id] = blobUrl;
  }

  @override
  void dispose() {
    layers.dispose();
    sources.dispose();
    // Interop members can't be torn off for forEach.
    // ignore: prefer_foreach
    for (final url in _blobUrls.values) {
      URL.revokeObjectURL(url);
    }
    _blobUrls.clear();
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

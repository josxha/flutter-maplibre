part of 'map_state.dart';

/// Web specific implementation of the [StyleController].
class StyleControllerWeb extends StyleController {
  /// Create a new [StyleControllerWeb] instance.
  const StyleControllerWeb(this._map);

  final interop.JsMap _map;

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    final image = await decodeImageFromList(bytes);
    final byteData = await image.toByteData();
    _map.addImage(
      id,
      interop.ImageSpecification(
        width: image.width,
        height: image.height,
        data: byteData!.buffer.asUint8List().toJS,
      ),
    );
  }

  @override
  Future<void> removeImage(String id) async => _map.removeImage(id);

  @override
  Future<void> removeLayer(String id) async => _map.removeLayer(id);

  @override
  Future<void> removeSource(String id) async => _map.removeSource(id);

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
  Future<List<String>> getAttributions() async => getAttributions();

  @override
  List<String> getAttributionsSync() {
    final jsStyle = _map.getStyle();
    final sources = jsStyle?.sources.dartify() as Map<Object?, Object?>?;
    if (sources == null) return const [];
    final attributions = <String>[];
    for (final value in sources.values) {
      final source = value! as Map<Object?, Object?>;
      final attribution = source['attribution'];
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

    JSAny? jsFilter;
    if (layer.filter case final filter?) {
      jsFilter = filter.jsify();
    }
    final sourceLayerId = switch (layer) {
      StyleLayerWithSource(sourceLayerId: final id) => id,
      _ => null,
    };

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
          sourceLayer: sourceLayerId,
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
          sourceLayer: sourceLayerId,
        );
      case BackgroundStyleLayer():
        jsLayer = interop.LayerSpecification(
          id: layer.id,
          type: 'background',
          source: null,
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
          sourceLayer: sourceLayerId,
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
          sourceLayer: sourceLayerId,
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
          sourceLayer: sourceLayerId,
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
          sourceLayer: sourceLayerId,
        );
      default:
        throw UnimplementedError(
          'Layer type "${layer.runtimeType}" is not supported on Web platform.',
        );
    }
    if (layer.metadata case final metadata?) {
      jsLayer.metadata = metadata.jsify()!;
    }
    if (jsFilter != null) {
      jsLayer.filter = jsFilter;
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
          interop.SourceSpecification.geoJson(type: 'geojson', data: data),
        );
      case RasterDemSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.rasterDem(
            type: 'raster-dem',
            tileSize: source.tileSize,
            attribution: source.attribution,
            url: source.url,
          ),
        );
      case RasterSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.raster(
            type: 'raster',
            attribution: source.attribution,
            tileSize: source.tileSize,
            tiles: source.tiles.jsify(),
          ),
        );
      case VectorSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.vector(type: 'vector', url: source.url),
        );
      case ImageSource():
        _map.addSource(
          source.id,
          interop.SourceSpecification.image(
            type: 'image',
            url: source.url,
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
            coordinates: source.coordinates
                .map((e) => [e.lon, e.lat])
                .toList(growable: false)
                .jsify()!,
          ),
        );
    }
  }

  @override
  void dispose() {}

  @override
  void setProjection(MapProjection projection) => _map.setProjection(
    interop.ProjectionSpecification(type: projection.name),
  );
}

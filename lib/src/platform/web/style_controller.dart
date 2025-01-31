part of 'map_state.dart';

/// Web specific implementation of the [StyleController].
class StyleControllerWeb implements StyleController {
  /// Create a new [StyleControllerWeb] instance.
  StyleControllerWeb(this._map);

  final interop.JsMap _map;

  final List<StyleLayer> _draggableLayers = [];

  @override
  List<StyleLayer> get draggableLayers => _draggableLayers;

  @override
  set draggableLayers(List<StyleLayer> layers) {
    _draggableLayers.clear();
    _draggableLayers.addAll(layers);
  }

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
  Future<List<String>> getAttributions() async {
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
  Future<void> addLayer(StyleLayer layer, {String? belowLayerId}) async {
    switch (layer) {
      case FillStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'fill',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case CircleStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'circle',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case BackgroundStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'background',
            source: null,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case FillExtrusionStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'fill-extrusion',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case HeatmapStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'heatmap',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case HillshadeStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'hillshade',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case LineStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'line',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case RasterStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'raster',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
      case SymbolStyleLayer():
        _map.addLayer(
          interop.LayerSpecification(
            id: layer.id,
            type: 'symbol',
            source: layer.sourceId,
            layout: layer.layout.jsify()!,
            paint: layer.paint.jsify()!,
          ),
          belowLayerId,
        );
    }
  }

  @override
  Future<void> addSource(Source source) async {
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
          interop.SourceSpecification.geoJson(
            type: 'geojson',
            data: data,
          ),
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
          interop.SourceSpecification.vector(
            type: 'vector',
            url: source.url,
          ),
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
              [
                source.coordinates.topLeft.lng,
                source.coordinates.topLeft.lat,
              ],
              [
                source.coordinates.topRight.lng,
                source.coordinates.topRight.lat,
              ],
              [
                source.coordinates.bottomRight.lng,
                source.coordinates.bottomRight.lat,
              ],
              [
                source.coordinates.bottomLeft.lng,
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
                .map(
                  (e) => [e.lng, e.lat],
                )
                .toList(growable: false)
                .jsify()!,
          ),
        );
    }
  }

  @override
  void dispose() {}

  @override
  void setProjection(MapProjection projection) => _map
      .setProjection(interop.ProjectionSpecification(type: projection.name));
}

part of 'map_state.dart';

/// Web specific implementation of the [StyleController].
class StyleControllerWeb extends StyleController {
  /// Create a new [StyleControllerWeb] instance.
  const StyleControllerWeb(this._map);

  final interop.JsMap _map;

  @override
  Future<void> addImage(
    String id,
    Uint8List bytes, {
    double pixelRatio = 1,
  }) async {
    final image = await decodeImageFromList(bytes);
    final byteData = await image.toByteData();
    _map.addImage(
      id,
      interop.ImageSpecification(
        width: image.width,
        height: image.height,
        data: byteData!.buffer.asUint8List().toJS,
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
  Future<List<String>> getAttributions() async => getAttributionsSync();

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

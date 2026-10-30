import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Implementation of the [StyleController] on the MapLibre Native C API.
///
/// Sources and layers reach the map as style JSON, the form the C API takes
/// them in.
class StyleControllerNative extends StyleController implements StyleBackend {
  /// Creates a style controller for a map.
  StyleControllerNative(this._map, {this.onAttributionsChanged});

  final mln.MapHandle _map;

  /// Called when [refreshAttributions] finds that the attributions changed.
  final VoidCallback? onAttributionsChanged;

  @override
  late final StyleSources sources = StyleSources(this);

  @override
  late final StyleLayers layers = StyleLayers(this, sources: sources);

  List<String> _cachedAttributions = const [];
  var _disposed = false;

  /// The options of GeoJSON sources, by id. Data for a source must be prepared
  /// with the options of the source.
  final _geoJsonOptions = <String, mln.GeoJsonSourceOptions>{};

  /// Fills [layers] and [sources] from the style that the map loaded, and
  /// reads its attributions.
  Future<void> load() async {
    final style = await _map.getLoadedStyleJson();
    if (_disposed) return;
    if (style case {'sources': final Map<String, Object?> styleSources}) {
      sources.load(styleSources);
      for (final MapEntry(:key, :value) in styleSources.entries) {
        if (value case {'type': 'geojson'}) {
          _geoJsonOptions[key] = _geoJsonOptionsOf(
            value as Map<String, Object?>,
          );
        }
      }
    }
    if (style case {'layers': final List<Object?> styleLayers}) {
      layers.load(styleLayers.whereType<Map<String, Object?>>());
    }
    await refreshAttributions();
  }

  static mln.GeoJsonSourceOptions _geoJsonOptionsOf(
    Map<String, Object?> json,
  ) => mln.GeoJsonSourceOptions(
    minZoom: (json['minzoom'] as num?)?.toDouble(),
    maxZoom: (json['maxzoom'] as num?)?.toDouble(),
    tolerance: (json['tolerance'] as num?)?.toDouble(),
    buffer: (json['buffer'] as num?)?.toInt(),
    lineMetrics: json['lineMetrics'] as bool?,
    cluster: json['cluster'] as bool?,
    clusterRadius: (json['clusterRadius'] as num?)?.toInt(),
    clusterMaxZoom: (json['clusterMaxZoom'] as num?)?.toDouble(),
    clusterMinPoints: (json['clusterMinPoints'] as num?)?.toInt(),
  );

  @override
  void batch(void Function() updates) {
    final discarding = _map.discarding;
    discarding.beginCommandGroup();
    try {
      updates();
    } finally {
      discarding.endCommandGroup();
    }
  }

  @override
  Future<void> addSource(Source source) async {
    if (source is ImageSourceBytes || source is ImageSourceProvider) {
      return _addImageSourceImage(source as ImageSource);
    }
    if (source is VideoSource) {
      throw UnsupportedError(
        'MapLibre Native has no video sources; they are only supported on '
        'web.',
      );
    }
    final json = source.toJson();
    if (json == null) {
      throw UnimplementedError(
        'The source is not supported: ${source.runtimeType}',
      );
    }
    final added = _map.addStyleSourceJson(source.id, json);
    if (source is GeoJsonSource) {
      _geoJsonOptions[source.id] = mln.GeoJsonSourceOptions(
        maxZoom: source.maxZoom,
        tolerance: source.tolerance,
        lineMetrics: source.lineMetrics,
      );
    }
    await added;
    // Sources with inline tiles know their attribution now; a TileJSON source
    // reports it with a source change once its TileJSON loads.
    await refreshAttributions();
  }

  /// Adds an image source with decoded pixels, since the style JSON of an
  /// image source only takes a URL.
  Future<void> _addImageSourceImage(ImageSource source) async {
    final image = switch (source) {
      ImageSourceBytes(:final bytes) => await _decodeImage(bytes),
      ImageSourceProvider(:final image) => await resolveImageProvider(image),
      ImageSourceUrl() => throw ArgumentError.value(source, 'source'),
    };
    try {
      final pixels = await _premultipliedImage(image, source.id);
      final quad = source.coordinates;
      await _map.addImageSourceImage(
        source.id,
        [
          quad.topLeft,
          quad.topRight,
          quad.bottomRight,
          quad.bottomLeft,
        ].map((p) => mln.LatLng(latitude: p.lat, longitude: p.lon)).toList(),
        pixels,
      );
    } finally {
      image.dispose();
    }
  }

  @override
  Future<void> addLayer(
    Map<String, Object?> json, {
    String? belowLayerId,
  }) async {
    // An empty id appends the layer.
    await _map.addStyleLayerJson(json, belowLayerId ?? '');
  }

  @override
  Future<void> removeLayer(String id) =>
      _checkUnlessMissing(_map.removeStyleLayer(id));

  @override
  void moveLayer(String id, {String? belowLayerId}) =>
      _map.discarding.moveStyleLayer(id, belowLayerId ?? '');

  // The command runs in order with later ones, so an animation doesn't wait
  // for each frame's update.
  @override
  void setPaintProperty(String layerId, String name, Object? value) =>
      _map.discarding.setStyleLayerProperty(layerId, name, value);

  @override
  void setLayoutProperty(String layerId, String name, Object? value) =>
      _map.discarding.setStyleLayerProperty(layerId, name, value);

  @override
  void setFilter(String layerId, Object? filter) =>
      _map.discarding.setStyleLayerProperty(layerId, 'filter', filter);

  @override
  void setZoomRange(String layerId, double minZoom, double maxZoom) {
    final discarding = _map.discarding;
    discarding.setStyleLayerProperty(layerId, 'minzoom', minZoom);
    discarding.setStyleLayerProperty(layerId, 'maxzoom', maxZoom);
  }

  @override
  Future<void> removeSource(String id) async {
    await _checkUnlessMissing(_map.removeStyleSource(id));
    _geoJsonOptions.remove(id);
    await refreshAttributions();
  }

  @override
  Future<void> setGeoJsonData(String id, String data) async {
    final handle = mln.GeoJsonSourceDataHandle.create(
      jsonDecode(data),
      options: _geoJsonOptions[id],
    );
    try {
      await _map.setGeoJsonSourceData(id, handle);
    } finally {
      handle.close();
    }
  }

  @override
  Future<void> setGeoJsonUrl(String id, String url) async {
    await _map.setGeoJsonSourceUrl(id, url);
  }

  @override
  Future<void> setImageCoordinates(String id, LngLatQuad coordinates) async {
    await _map.setImageSourceCoordinates(id, [
      for (final corner in [
        coordinates.topLeft,
        coordinates.topRight,
        coordinates.bottomRight,
        coordinates.bottomLeft,
      ])
        mln.LatLng(latitude: corner.lat, longitude: corner.lon),
    ]);
  }

  @override
  Future<void> setTiles(
    String id,
    List<String> tiles,
    Map<String, Object?> specification,
  ) => _replaceTileSource(id, specification);

  @override
  Future<void> setTileJsonUrl(
    String id,
    String url,
    Map<String, Object?> specification,
  ) => _replaceTileSource(id, specification);

  /// The C API can't change the tiles or URL of a source, so this removes the
  /// layers that use the source, swaps the source and adds the layers back at
  /// their positions, all in one command group. The layer objects stay
  /// attached; their JSON is what goes back to the map.
  Future<void> _replaceTileSource(
    String id,
    Map<String, Object?> specification,
  ) async {
    final all = layers.toList();
    bool usesSource(StyleLayer layer) => layer.toJson()['source'] == id;
    final discarding = _map.discarding;
    late final Future<void> added;
    batch(() {
      for (final layer in all.where(usesSource)) {
        discarding.removeStyleLayer(layer.id);
      }
      discarding.removeStyleSource(id);
      added = _map.addStyleSourceJson(id, specification);
      // From the top, so that the layer above each one is already back.
      for (var index = all.length - 1; index >= 0; index--) {
        if (!usesSource(all[index])) continue;
        discarding.addStyleLayerJson(
          all[index].toJson(),
          index + 1 < all.length ? all[index + 1].id : '',
        );
      }
    });
    await added;
    await refreshAttributions();
  }

  @override
  Future<void> addImage(
    String id,
    Uint8List bytes, {
    double pixelRatio = 1,
  }) async {
    final image = await _decodeImage(bytes);
    try {
      await addImageFromUiImage(id: id, image: image, pixelRatio: pixelRatio);
    } finally {
      image.dispose();
    }
  }

  /// Decodes the first frame of the encoded image [bytes].
  static Future<ui.Image> _decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    try {
      return (await codec.getNextFrame()).image;
    } finally {
      codec.dispose();
    }
  }

  /// The pixels of [image] in the form the C API takes.
  static Future<mln.PremultipliedRgba8Image> _premultipliedImage(
    ui.Image image,
    String id,
  ) async {
    // rawRgba is premultiplied RGBA8.
    final data = await image.toByteData();
    if (data == null) {
      throw StateError('Failed to read the pixels of the image "$id".');
    }
    return mln.PremultipliedRgba8Image(
      width: image.width,
      height: image.height,
      stride: image.width * 4,
      pixels: data.buffer.asUint8List(),
    );
  }

  @override
  Future<void> addImageFromUiImage({
    required String id,
    required ui.Image image,
    double pixelRatio = 1,
  }) async {
    await _map.setStyleImage(
      id,
      await _premultipliedImage(image, id),
      options: mln.StyleImageOptions(pixelRatio: pixelRatio),
    );
  }

  @override
  Future<void> removeImage(String id) async {
    await _checkUnlessMissing(_map.removeStyleImage(id));
  }

  /// Removing what the style lacks is not an error on other platforms.
  Future<void> _checkUnlessMissing(
    Future<mln.CommandCompletion> command,
  ) async {
    try {
      await command;
    } on mln.MaplibreException catch (error) {
      if (error.status != mln.Status.notFound) rethrow;
    }
  }

  /// Reads what the sources of the map learned from their TileJSON into
  /// [sources], and refreshes the cached attributions.
  Future<List<String>> refreshAttributions() async {
    if (_disposed) return _cachedAttributions;
    final infos = await _map.listStyleSources();
    if (_disposed) return _cachedAttributions;
    for (final info in infos) {
      if (info.tileJson case final tileJson?) {
        final bounds = info.bounds;
        sources.applyTileJson(
          info.id,
          attribution: info.attribution,
          minZoom: tileJson.minZoom,
          maxZoom: tileJson.maxZoom,
          bounds: bounds == null
              ? null
              : [
                  bounds.southwest.longitude,
                  bounds.southwest.latitude,
                  bounds.northeast.longitude,
                  bounds.northeast.latitude,
                ],
        );
      }
    }
    final attributions = List<String>.unmodifiable([
      for (final info in infos)
        if (switch (info.attribution) {
              final String attribution when attribution.isNotEmpty =>
                attribution,
              // MapLibre Native drops the attribution of GeoJSON sources.
              _ => switch (sources[info.id]) {
                final GeoJsonSource source => source.attribution,
                _ => null,
              },
            }
            case final String attribution when attribution.isNotEmpty)
          attribution,
    ]);
    if (listEquals(attributions, _cachedAttributions)) {
      return _cachedAttributions;
    }
    _cachedAttributions = attributions;
    onAttributionsChanged?.call();
    return attributions;
  }

  @override
  List<String> get attributions => _cachedAttributions;

  /// MapLibre Native has no globe projection, so the map stays on Mercator.
  @override
  void setProjection(MapProjection projection) {
    if (projection == MapProjection.mercator || _warnedGlobe) return;
    _warnedGlobe = true;
    debugPrint(
      'maplibre_native: the globe projection is not supported by MapLibre '
      'Native; the map stays on Mercator.',
    );
  }

  static var _warnedGlobe = false;

  @override
  void dispose() {
    _disposed = true;
    layers.dispose();
    sources.dispose();
  }
}

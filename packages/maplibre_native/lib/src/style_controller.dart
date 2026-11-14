import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/extensions.dart';
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

  /// Keeps the style's transition duration and delay, as the platform SDKs'
  /// switches did.
  @override
  Future<void> setPlacementTransitions({required bool enabled}) async {
    final options = await _map.getStyleTransitionOptions();
    // A style set meanwhile has its own options, with them on.
    if (_replaced) return;
    await _map.setStyleTransitionOptions(
      options.copyWith(enablePlacementTransitions: enabled),
    );
  }

  /// Called when [refreshAttributions] finds that the attributions changed.
  final VoidCallback? onAttributionsChanged;

  @override
  late final StyleSources sources = StyleSources(this, layers: () => layers);

  @override
  late final StyleLayers layers = StyleLayers(this, sources: sources);

  List<String> _cachedAttributions = const [];
  var _disposed = false;

  /// A newer style was set on the map, so the map's style commands no
  /// longer reach this one.
  bool get _replaced => _disposed || _replacedByNewer;
  var _replacedByNewer = false;

  /// Called when a newer style is set on the map, before its load is queued.
  void markReplaced() => _replacedByNewer = true;

  /// Fills [layers] and [sources] from the style that the map loaded, and
  /// reads its attributions.
  Future<void> load() async {
    final style = await _map.getLoadedStyleJson();
    if (_disposed) return;
    if (style case {'sources': final Map<String, Object?> styleSources}) {
      sources.load(styleSources);
    }
    if (style case {'layers': final List<Object?> styleLayers}) {
      layers.load(styleLayers.whereType<Map<String, Object?>>());
    }
    await refreshAttributions();
  }

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
      throw UnsupportedError('Video sources are only supported on web.');
    }
    final json = source.toJson();
    if (json == null) {
      throw UnimplementedError(
        'The source is not supported: ${source.runtimeType}',
      );
    }
    await _map.addStyleSourceJson(source.id, json);
    // Sources with inline tiles know their attribution now; a TileJSON source
    // reports it with a source change once its TileJSON loads.
    await refreshAttributions();
  }

  /// Adds an image source with decoded pixels, since the style JSON of an
  /// image source only takes a URL. Decoding takes a while, so the source
  /// starts with an empty image: calls after this one must find it on the
  /// map.
  Future<void> _addImageSourceImage(ImageSource source) async {
    final quad = source.coordinates;
    final added = _map.addImageSourceImage(
      source.id,
      [
        quad.topLeft,
        quad.topRight,
        quad.bottomRight,
        quad.bottomLeft,
      ].map((p) => p.toMln()).toList(),
      _emptyImage,
    );
    // Whether the source is still on the map: it may have been removed or
    // replaced meanwhile. Moving its corners keeps the image.
    bool current() => switch ((source, sources[source.id])) {
      (ImageSourceBytes(:final bytes), ImageSourceBytes(bytes: final now)) =>
        identical(bytes, now),
      (
        ImageSourceProvider(:final image),
        ImageSourceProvider(image: final now),
      ) =>
        identical(image, now),
      _ => false,
    };
    await added;
    final mln.PremultipliedRgba8Image pixels;
    try {
      final image = switch (source) {
        ImageSourceBytes(:final bytes) => await _decodeImage(bytes),
        ImageSourceProvider(:final image) => await resolveImageProvider(image),
        ImageSourceUrl() => throw ArgumentError.value(source, 'source'),
      };
      try {
        pixels = await _premultipliedImage(image, source.id);
      } finally {
        image.dispose();
      }
    } catch (_) {
      // The collection takes the source out again.
      if (current()) _map.discarding.removeStyleSource(source.id);
      rethrow;
    }
    if (current()) await _map.setImageSourceImage(source.id, pixels);
  }

  /// A transparent image of one pixel, the image of an image source until
  /// its image is decoded.
  static final _emptyImage = mln.PremultipliedRgba8Image(
    width: 1,
    height: 1,
    stride: 4,
    pixels: Uint8List(4),
  );

  @override
  Future<void> addLayer(
    Map<String, Object?> json, {
    String? belowLayerId,
  }) async {
    await _map.addStyleLayerJson(json, beforeLayerId: belowLayerId);
  }

  @override
  Future<void> removeLayer(String id) =>
      _checkUnlessMissing(_map.removeStyleLayer(id));

  @override
  void moveLayer(String id, {String? belowLayerId}) =>
      _map.discarding.moveStyleLayer(id, beforeLayerId: belowLayerId);

  // The command runs in order with later ones, so an animation doesn't wait
  // for each frame's update.
  @override
  void setLayerProperty(
    String layerId,
    String name,
    Object? value, {
    required bool layout,
  }) => _map.discarding.setStyleLayerProperty(layerId, name, value);

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
    await refreshAttributions();
  }

  @override
  Future<void> setGeoJsonData(String id, GeoJsonData data) async {
    try {
      // The map prepares the data in the background.
      await _map.setGeoJsonSourceData(id, data.toJson());
    } on mln.MaplibreException catch (error) {
      // Newer data for the source replaced this data before it was ready.
      if (error.status != mln.Status.cancelled) rethrow;
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
        corner.toMln(),
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
          beforeLayerId: index + 1 < all.length ? all[index + 1].id : null,
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
    StyleImageOptions options = const StyleImageOptions(),
  }) async {
    final image = await _decodeImage(bytes);
    try {
      await addImageFromUiImage(
        id: id,
        image: image,
        pixelRatio: pixelRatio,
        options: options,
      );
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
    StyleImageOptions options = const StyleImageOptions(),
  }) async {
    await _map.setStyleImage(
      id,
      await _premultipliedImage(image, id),
      options: options.toMln(pixelRatio),
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
        if (info.attribution.isNotEmpty) info.attribution,
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

  /// MapLibre Native has only Mercator, so the map stays on it.
  @override
  void setProjection(Expression<MapProjection> projection) {
    if (projection case Literal(value: MapProjection.mercator)) return;
    if (_warnedProjection) return;
    _warnedProjection = true;
    debugPrint(
      'maplibre: projections other than Mercator are only supported on web; '
      'the map stays on Mercator.',
    );
  }

  static var _warnedProjection = false;

  @override
  void dispose() {
    _disposed = true;
    layers.dispose();
    sources.dispose();
  }
}

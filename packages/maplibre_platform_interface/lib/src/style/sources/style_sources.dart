part of 'source.dart';

/// The sources of a map style.
///
/// Reading is synchronous: the collection is filled once when the style loads
/// and follows every change made through it. Sources are immutable, so an
/// update replaces the object in this collection. Changes apply to the
/// collection at once and reach the map in the order they were made.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class StyleSources extends Iterable<Source> {
  /// Creates an empty collection. Platforms create it, on their [StyleBackend].
  StyleSources(this._backend);

  final StyleBackend _backend;

  /// The sources by id, in the order of the style.
  final _sources = <String, Source>{};

  /// The source JSON of the sources as they were specified, without what a
  /// TileJSON resource added: an update must not carry that over.
  final _specifications = <String, Map<String, Object?>>{};

  @override
  Iterator<Source> get iterator => _sources.values.iterator;

  @override
  int get length => _sources.length;

  /// The source [id], or null if the style has none.
  Source? operator [](String id) => _sources[id];

  /// Adds [source].
  ///
  /// The source is in this collection at once. The future completes when the
  /// map took it. If the map rejects it, the future completes with the error
  /// and the source is taken out again.
  ///
  /// Fails with an [ArgumentError] if its id is taken.
  Future<void> add(Source source) async {
    if (_sources.containsKey(source.id)) {
      throw ArgumentError.value(
        source.id,
        'source',
        'The id is already in use',
      );
    }
    _sources[source.id] = source;
    if (_isTileSource(source)) _specifications[source.id] = source.toJson()!;
    try {
      await _backend.addSource(source);
    } catch (_) {
      if (identical(_sources[source.id], source)) {
        _sources.remove(source.id);
        _specifications.remove(source.id);
      }
      rethrow;
    }
  }

  /// Removes the source [id]. Removing a source the style doesn't have does
  /// nothing. The layers that use the source must be removed before.
  Future<void> remove(String id) async {
    if (_sources.remove(id) == null) return;
    _specifications.remove(id);
    await _backend.removeSource(id);
  }

  /// Replaces the data of the GeoJSON source [id] with the GeoJSON string
  /// [data].
  Future<void> updateGeoJsonData(String id, String data) async {
    final source = _sourceOfType<GeoJsonSource>(id);
    _sources[id] = GeoJsonSourceData(
      id: id,
      data: data,
      maxZoom: source.maxZoom,
      attribution: source.attribution,
      tolerance: source.tolerance,
      lineMetrics: source.lineMetrics,
    );
    await _backend.setGeoJsonData(id, data);
  }

  /// Makes the GeoJSON source [id] load its data from [url].
  Future<void> updateGeoJsonUrl(String id, String url) async {
    final source = _sourceOfType<GeoJsonSource>(id);
    _sources[id] = GeoJsonSourceUrl(
      id: id,
      url: url,
      maxZoom: source.maxZoom,
      attribution: source.attribution,
      tolerance: source.tolerance,
      lineMetrics: source.lineMetrics,
    );
    await _backend.setGeoJsonUrl(id, url);
  }

  /// Moves the corners of the image source [id] to [coordinates].
  Future<void> updateImageCoordinates(String id, LngLatQuad coordinates) async {
    final source = _sourceOfType<ImageSource>(id);
    _sources[id] = switch (source) {
      ImageSourceUrl(:final url) => ImageSourceUrl(
        id: id,
        url: url,
        coordinates: coordinates,
      ),
      ImageSourceBytes(:final bytes) => ImageSourceBytes(
        id: id,
        bytes: bytes,
        coordinates: coordinates,
      ),
      ImageSourceProvider(:final image) => ImageSourceProvider(
        id: id,
        image: image,
        coordinates: coordinates,
      ),
    };
    await _backend.setImageCoordinates(id, coordinates);
  }

  /// Replaces the tile URLs of the raster, raster DEM or vector source [id].
  ///
  /// A source that had a TileJSON URL uses [tiles] from now on. On native maps
  /// the layers of the source are removed and added again, which [StyleLayer]
  /// objects don't notice.
  Future<void> updateTiles(String id, List<String> tiles) async {
    final specification = {..._tileSpecification(id), 'tiles': tiles}
      ..remove('url');
    _replaceTileSource(id, specification);
    await _backend.setTiles(id, tiles, specification);
  }

  /// Replaces the TileJSON URL of the raster, raster DEM or vector source
  /// [id].
  ///
  /// A source that had tile URLs uses [url] from now on. On native maps the
  /// layers of the source are removed and added again, which [StyleLayer]
  /// objects don't notice.
  Future<void> updateTileJsonUrl(String id, String url) async {
    final specification = {..._tileSpecification(id), 'url': url}
      ..remove('tiles');
    _replaceTileSource(id, specification);
    await _backend.setTileJsonUrl(id, url, specification);
  }

  /// Fills the collection with the sources of a loaded style, by the `sources`
  /// member of its JSON. Platforms call it.
  void load(Map<String, Object?> sources) {
    for (final MapEntry(:key, :value) in sources.entries) {
      if (value is! Map<String, Object?>) continue;
      final source = Source.fromJson(key, value);
      _sources[key] = source;
      if (_isTileSource(source)) _specifications[key] = value;
    }
  }

  /// Merges what the TileJSON of the source [id] said into its object.
  /// Returns whether that changed anything. Platforms call it when a source
  /// changed.
  bool applyTileJson(
    String id, {
    String? attribution,
    double? minZoom,
    double? maxZoom,
    List<double>? bounds,
  }) {
    if (!_specifications.containsKey(id)) return false;
    final current = _sources[id]!.toJson()!;
    final merged = {
      ...current,
      if (attribution != null && attribution.isNotEmpty)
        'attribution': attribution,
      'minzoom': ?minZoom,
      'maxzoom': ?maxZoom,
      'bounds': ?bounds,
    };
    if (jsonEquals(current, merged)) return false;
    _sources[id] = Source.fromJson(id, merged);
    return true;
  }

  /// Forgets every source, when the style goes away. Platforms call it.
  void dispose() {
    _sources.clear();
    _specifications.clear();
  }

  T _sourceOfType<T extends Source>(String id) {
    final source = _sources[id];
    if (source is T) return source;
    throw ArgumentError.value(
      id,
      'id',
      source == null ? 'The style has no such source' : 'Not a $T',
    );
  }

  static bool _isTileSource(Source source) =>
      source is RasterSource ||
      source is RasterDemSource ||
      source is VectorSource;

  Map<String, Object?> _tileSpecification(String id) {
    final source = _sources[id];
    if (source == null || !_isTileSource(source)) {
      throw ArgumentError.value(
        id,
        'id',
        source == null ? 'The style has no such source' : 'Not a tile source',
      );
    }
    return _specifications[id]!;
  }

  void _replaceTileSource(String id, Map<String, Object?> specification) {
    _sources[id] = Source.fromJson(id, specification);
    _specifications[id] = specification;
  }
}

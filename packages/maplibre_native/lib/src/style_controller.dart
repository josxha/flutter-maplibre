import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/command.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Implementation of the [StyleController] on the MapLibre Native C API.
///
/// Sources and layers reach the map as style JSON, the form the C API takes
/// them in.
class StyleControllerNative extends StyleController {
  /// Creates a style controller for a map.
  StyleControllerNative(this._map, {String? styleJson})
    : _sourceAttributions = sourceAttributionsOf(styleJson);

  final mln.MapHandle _map;

  /// The attributions that the style and [addSource] gave sources, by id.
  /// MapLibre Native drops those of GeoJSON sources, so they come from here.
  final Map<String, String> _sourceAttributions;

  List<String> _cachedAttributions = const [];
  List<String> _cachedLayerIds = const [];
  var _disposed = false;

  /// The options that [addSource] gave GeoJSON sources, by id. Data for a
  /// source must be prepared with the options of the source.
  final _geoJsonOptions = <String, mln.GeojsonSourceOptions>{};

  /// Refreshes the cached layer ids and attributions from the map.
  Future<void> refresh() async {
    await Future.wait([_fetchLayerIds(), getAttributions()]);
  }

  @override
  Future<void> addSource(Source source) async {
    final json = <String, Object?>{
      ...switch (source) {
        GeoJsonSource() => {
          'type': 'geojson',
          'data': _geoJsonData(source.data),
          'maxzoom': source.maxZoom,
          'tolerance': source.tolerance,
          'lineMetrics': source.lineMetrics,
          'attribution': ?source.attribution,
        },
        RasterSource() => {
          'type': 'raster',
          'url': ?source.url,
          'tiles': ?source.tiles,
          'bounds': source.bounds,
          'minzoom': source.minZoom,
          'maxzoom': source.maxZoom,
          'tileSize': source.tileSize,
          'scheme': source.scheme.name,
          'attribution': ?source.attribution,
          'volatile': source.volatile,
        },
        RasterDemSource() => {
          'type': 'raster-dem',
          'url': ?source.url,
          'tiles': ?source.tiles,
          'bounds': source.bounds,
          'minzoom': source.minZoom,
          'maxzoom': source.maxZoom,
          'tileSize': source.tileSize,
          'attribution': ?source.attribution,
          'volatile': source.volatile,
          ...switch (source.encoding) {
            RasterDemTerrariumEncoding() => {'encoding': 'terrarium'},
            RasterDemMapboxEncoding() => {'encoding': 'mapbox'},
            final RasterDemCustomEncoding encoding => {
              'encoding': 'custom',
              'redFactor': encoding.redFactor,
              'greenFactor': encoding.greenFactor,
              'blueFactor': encoding.blueFactor,
              'baseShift': encoding.baseShift,
            },
          },
        },
        VectorSource() => {
          'type': 'vector',
          'url': ?source.url,
          'tiles': ?source.tiles,
          'bounds': source.bounds,
          'scheme': source.scheme.name,
          'minzoom': source.minZoom,
          'maxzoom': source.maxZoom,
          'attribution': ?source.attribution,
          'volatile': source.volatile,
        },
        ImageSource() => {
          'type': 'image',
          'url': source.url,
          'coordinates': [
            source.coordinates.topLeft,
            source.coordinates.topRight,
            source.coordinates.bottomRight,
            source.coordinates.bottomLeft,
          ].map((point) => [point.lon, point.lat]).toList(),
        },
        VideoSource() => throw UnsupportedError(
          'MapLibre Native has no video sources; they are only supported on '
          'web.',
        ),
        _ => throw UnimplementedError(
          'The source is not supported: ${source.runtimeType}',
        ),
      },
    };
    await checkCommand(_map.addStyleSourceJson(source.id, _encode(json)));
    if (source is GeoJsonSource) {
      _geoJsonOptions[source.id] = mln.GeojsonSourceOptions(
        maxZoom: source.maxZoom,
        tolerance: source.tolerance,
        lineMetrics: source.lineMetrics,
      );
    }
    if (json['attribution'] case final String attribution) {
      _sourceAttributions[source.id] = attribution;
    } else {
      _sourceAttributions.remove(source.id);
    }
    // Sources with inline tiles know their attribution now; a TileJSON source
    // reports it with a source change once its TileJSON loads.
    await getAttributions();
  }

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async {
    final json = <String, Object?>{
      'id': layer.id,
      'type': switch (layer) {
        FillStyleLayer() => 'fill',
        LineStyleLayer() => 'line',
        SymbolStyleLayer() => 'symbol',
        CircleStyleLayer() => 'circle',
        HeatmapStyleLayer() => 'heatmap',
        FillExtrusionStyleLayer() => 'fill-extrusion',
        RasterStyleLayer() => 'raster',
        HillshadeStyleLayer() => 'hillshade',
        BackgroundStyleLayer() => 'background',
        _ => throw UnimplementedError(
          'The layer is not supported: ${layer.runtimeType}',
        ),
      },
      if (layer is StyleLayerWithSource) ...{
        'source': layer.sourceId,
        'source-layer': ?layer.sourceLayerId,
      },
      'minzoom': layer.minZoom,
      'maxzoom': layer.maxZoom,
      'filter': ?layer.filter,
      'layout': layer.layout,
      'paint': layer.paint,
    };

    // The C API inserts below a named layer, so other placements translate
    // to the layer that ends up above the new one.
    var beforeLayerId = belowLayerId;
    if (beforeLayerId == null && (aboveLayerId != null || atIndex != null)) {
      final ids = await _fetchLayerIds();
      if (aboveLayerId != null) {
        final index = ids.indexOf(aboveLayerId);
        if (index < 0) {
          throw ArgumentError.value(aboveLayerId, 'aboveLayerId', 'not found');
        }
        beforeLayerId = index + 1 < ids.length ? ids[index + 1] : null;
      } else if (atIndex! < ids.length) {
        beforeLayerId = ids[atIndex < 0 ? 0 : atIndex];
      }
    }

    await checkCommand(
      _map.addStyleLayerJson(_encode(json), beforeLayerId: beforeLayerId),
    );
    await _fetchLayerIds();
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    final trimmed = data.trim();
    if (!trimmed.startsWith('{') && !trimmed.startsWith('[')) {
      await checkCommand(_map.setGeojsonSourceUrl(id, trimmed));
      return;
    }
    final handle = mln.geojsonSourceDataCreate(
      utf8.encode(trimmed),
      options: _geoJsonOptions[id],
    );
    try {
      await checkCommand(_map.setGeojsonSourceData(id, handle));
    } finally {
      handle.close();
    }
  }

  @override
  Future<void> removeLayer(String id) async {
    await _checkUnlessMissing(_map.removeStyleLayer(id));
    await _fetchLayerIds();
  }

  @override
  Future<void> removeSource(String id) async {
    await _checkUnlessMissing(_map.removeStyleSource(id));
    _sourceAttributions.remove(id);
    _geoJsonOptions.remove(id);
    await getAttributions();
  }

  @override
  Future<LineStyleLayerController?> getLineLayer(String id) async {
    final info = await _map.getStyleLayer(id);
    if (info?.type != 'line') return null;
    final paint = <String, Object?>{};
    for (final name in LineStyleLayerController.paintProperties) {
      final value = await _map.getStyleLayerProperty(id, name);
      paint[name] = value == null ? null : jsonDecode(utf8.decode(value));
    }
    return LineStyleLayerController(
      id: id,
      paint: paint,
      // The command runs in order with later ones, so an animation doesn't
      // wait for each frame's update.
      setPaintProperty: (name, value) =>
          _map.discarding.setStyleLayerProperty(id, name, _encode(value)),
    );
  }

  @override
  Future<void> addImage(
    String id,
    Uint8List bytes, {
    double pixelRatio = 1,
  }) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    codec.dispose();
    try {
      await addImageFromUiImage(
        id: id,
        image: frame.image,
        pixelRatio: pixelRatio,
      );
    } finally {
      frame.image.dispose();
    }
  }

  @override
  Future<void> addImageFromUiImage({
    required String id,
    required ui.Image image,
    double pixelRatio = 1,
  }) async {
    // rawRgba is premultiplied RGBA8, the form the C API takes.
    final data = await image.toByteData();
    if (data == null) {
      throw StateError('Failed to read the pixels of the image "$id".');
    }
    await checkCommand(
      _map.setStyleImage(
        id,
        mln.PremultipliedRgba8Image(
          width: image.width,
          height: image.height,
          stride: image.width * 4,
          pixels: data.buffer.asUint8List(),
        ),
        options: mln.StyleImageOptions(pixelRatio: pixelRatio),
      ),
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
    final completion = await command;
    if (completion.status == mln.Status.notFound) return;
    await checkCommand(Future.value(completion));
  }

  @override
  Future<List<String>> getAttributions() async {
    if (_disposed) return _cachedAttributions;
    final sources = await _map.listStyleSources();
    return _cachedAttributions = [
      for (final source in sources)
        if (switch (source.attribution) {
              final String attribution when attribution.isNotEmpty =>
                attribution,
              _ => _sourceAttributions[source.id],
            }
            case final String attribution when attribution.isNotEmpty)
          attribution,
    ];
  }

  @override
  List<String> getAttributionsSync() => _cachedAttributions;

  @override
  List<String> getLayerIds() => _cachedLayerIds;

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
  void dispose() => _disposed = true;

  Future<List<String>> _fetchLayerIds() async {
    if (_disposed) return _cachedLayerIds;
    final layers = await _map.listStyleLayers();
    return _cachedLayerIds = [for (final layer in layers) layer.id];
  }

  /// A GeoJSON object stays an object; anything else is a URL.
  static Object _geoJsonData(String data) {
    final trimmed = data.trim();
    if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
      return jsonDecode(trimmed) as Object;
    }
    return trimmed;
  }

  static Uint8List _encode(Object? json) =>
      Uint8List.fromList(utf8.encode(jsonEncode(json)));
}

/// The attributions of the sources in [styleJson], by source id.
Map<String, String> sourceAttributionsOf(String? styleJson) {
  if (styleJson == null) return {};
  try {
    if (jsonDecode(styleJson) case {'sources': final Map<String, Object?> s}) {
      return {
        for (final MapEntry(:key, :value) in s.entries)
          if (value case {'attribution': final String attribution})
            key: attribution,
      };
    }
  } on FormatException {
    // MapLibre Native reports the invalid style.
  }
  return {};
}

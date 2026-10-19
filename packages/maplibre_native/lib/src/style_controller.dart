import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:maplibre_native/src/command.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Implementation of the [StyleController] on the MapLibre Native C API.
///
/// Sources and layers reach the map as style JSON, the form the C API takes
/// them in.
class StyleControllerNative extends StyleController {
  /// Creates a style controller for a map.
  StyleControllerNative(this._map, this._pixelRatio);

  final mln.MapHandle _map;
  final double _pixelRatio;

  List<String> _cachedAttributions = const [];
  List<String> _cachedLayerIds = const [];
  var _disposed = false;

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
        VideoSource() => throw UnimplementedError(
          'Video sources are not supported by MapLibre Native.',
        ),
        _ => throw UnimplementedError(
          'The source is not supported: ${source.runtimeType}',
        ),
      },
    };
    await checkCommand(_map.addStyleSourceJson(source.id, _encode(json)));
    // A TileJSON source learns its attribution once its TileJSON loads.
    unawaited(
      Future<void>.delayed(const Duration(seconds: 1), getAttributions),
    );
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
      Uint8List.fromList(utf8.encode(trimmed)),
    );
    try {
      await checkCommand(_map.setGeojsonSourceData(id, handle));
    } finally {
      handle.close();
    }
  }

  @override
  Future<void> removeLayer(String id) async {
    await checkCommand(_map.removeStyleLayer(id));
    await _fetchLayerIds();
  }

  @override
  Future<void> removeSource(String id) =>
      checkCommand(_map.removeStyleSource(id));

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;
    // rawRgba is premultiplied RGBA8, the form the C API takes.
    final data = await image.toByteData();
    final width = image.width;
    final height = image.height;
    image.dispose();
    codec.dispose();
    if (data == null) {
      throw StateError('Failed to decode the image "$id".');
    }
    await checkCommand(
      _map.setStyleImage(
        id,
        mln.PremultipliedRgba8Image(
          width: width,
          height: height,
          stride: width * 4,
          pixels: data.buffer.asUint8List(),
        ),
        options: mln.StyleImageOptions(pixelRatio: _pixelRatio),
      ),
    );
  }

  @override
  Future<void> removeImage(String id) async {
    // Removing an image the style lacks is not an error on other platforms.
    final completion = await _map.removeStyleImage(id);
    if (completion.status == mln.MaplibreStatus.notFound) return;
    await checkCommand(Future.value(completion));
  }

  @override
  Future<List<String>> getAttributions() async {
    if (_disposed) return _cachedAttributions;
    final sources = await _map.listStyleSources();
    return _cachedAttributions = [
      for (final source in sources)
        if (source.attribution case final String attribution
            when attribution.isNotEmpty)
          attribution,
    ];
  }

  @override
  List<String> getAttributionsSync() => _cachedAttributions;

  @override
  List<String> getLayerIds() => _cachedLayerIds;

  @override
  void setProjection(MapProjection projection) {
    if (projection == MapProjection.mercator) return;
    throw UnimplementedError(
      'The globe projection is not available through the MapLibre Native C '
      'API yet.',
    );
  }

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

  static Uint8List _encode(Object json) =>
      Uint8List.fromList(utf8.encode(jsonEncode(json)));
}

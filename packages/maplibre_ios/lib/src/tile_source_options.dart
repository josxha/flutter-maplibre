import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

const _minimumZoomLevelOption = 'MLNTileSourceOptionMinimumZoomLevel';
const _maximumZoomLevelOption = 'MLNTileSourceOptionMaximumZoomLevel';
const _tileSizeOption = 'MLNTileSourceOptionTileSize';
const _attributionHtmlStringOption = 'MLNTileSourceOptionAttributionHTMLString';
const _demEncodingOption = 'MLNTileSourceOptionDEMEncoding';

/// The URL or tile templates and native options for a tiled source.
final class TileSourceConfiguration {
  /// Creates a TileJSON URL configuration.
  const TileSourceConfiguration.url(this.url)
    : tileUrlTemplates = null,
      options = const {};

  /// Creates a tile-template configuration.
  const TileSourceConfiguration.templates(this.tileUrlTemplates, this.options)
    : url = null;

  /// The TileJSON URL, or `null` for a tile-template configuration.
  final String? url;

  /// The tile URL templates, or `null` for a TileJSON URL configuration.
  final List<String>? tileUrlTemplates;

  /// Options passed to MapLibre Native for tile URL templates.
  final Map<String, Object> options;
}

/// Builds the native source configuration for a tiled [source].
TileSourceConfiguration buildTileSourceConfiguration(Source source) {
  final String? url;
  final List<String>? tiles;
  final options = <String, Object>{};

  switch (source) {
    case RasterDemSource():
      url = source.url;
      tiles = source.tiles;
      _addCommonOptions(
        options,
        minZoom: source.minZoom,
        maxZoom: source.maxZoom,
        attribution: source.attribution,
      );
      options[_tileSizeOption] = source.tileSize;
      switch (source.encoding) {
        case RasterDemMapboxEncoding():
          options[_demEncodingOption] = 0;
        case RasterDemTerrariumEncoding():
          options[_demEncodingOption] = 1;
        case RasterDemCustomEncoding():
          break;
      }
    case RasterSource():
      url = source.url;
      tiles = source.tiles;
      _addCommonOptions(
        options,
        minZoom: source.minZoom,
        maxZoom: source.maxZoom,
        attribution: source.attribution,
      );
      options[_tileSizeOption] = source.tileSize;
    case VectorSource():
      url = source.url;
      tiles = source.tiles;
      _addCommonOptions(
        options,
        minZoom: source.minZoom,
        maxZoom: source.maxZoom,
        attribution: source.attribution,
      );
    default:
      throw ArgumentError.value(source, 'source', 'Must be a tiled source');
  }

  return url == null
      ? TileSourceConfiguration.templates(tiles ?? const [], options)
      : TileSourceConfiguration.url(url);
}

void _addCommonOptions(
  Map<String, Object> options, {
  required double minZoom,
  required double maxZoom,
  required String? attribution,
}) {
  if (_isNativeZoomLevel(minZoom) &&
      _isNativeZoomLevel(maxZoom) &&
      minZoom <= maxZoom) {
    options[_minimumZoomLevelOption] = minZoom.toInt();
    options[_maximumZoomLevelOption] = maxZoom.toInt();
  }
  if (attribution != null) {
    options[_attributionHtmlStringOption] = attribution;
  }
}

bool _isNativeZoomLevel(double zoom) =>
    zoom.isFinite && zoom >= 0 && zoom <= 22 && zoom == zoom.truncateToDouble();

import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_ios/src/tile_source_options.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

const _minimumZoomLevelOption = 'MLNTileSourceOptionMinimumZoomLevel';
const _maximumZoomLevelOption = 'MLNTileSourceOptionMaximumZoomLevel';
const _tileSizeOption = 'MLNTileSourceOptionTileSize';
const _attributionHtmlStringOption = 'MLNTileSourceOptionAttributionHTMLString';
const _demEncodingOption = 'MLNTileSourceOptionDEMEncoding';

void main() {
  group('buildTileSourceConfiguration', () {
    test('preserves raster tile-template options', () {
      const source = RasterSource(
        id: 'raster',
        tiles: ['https://example.com/{z}/{x}/{y}.png'],
        minZoom: 4,
        maxZoom: 6,
        tileSize: 256,
        attribution: '<a href="https://example.com">Example</a>',
      );

      final configuration = buildTileSourceConfiguration(source);
      expect(configuration.url, isNull);
      expect(configuration.tileUrlTemplates, source.tiles);
      expect(configuration.options, {
        _minimumZoomLevelOption: 4,
        _maximumZoomLevelOption: 6,
        _tileSizeOption: 256,
        _attributionHtmlStringOption:
            '<a href="https://example.com">Example</a>',
      });
      expect(configuration.options[_minimumZoomLevelOption], isA<int>());
      expect(configuration.options[_maximumZoomLevelOption], isA<int>());
    });

    test('preserves vector tile-template options without raster tile size', () {
      const source = VectorSource(
        id: 'vector',
        tiles: ['https://example.com/{z}/{x}/{y}.pbf'],
        minZoom: 2,
        maxZoom: 12,
        attribution: 'Example',
      );

      final configuration = buildTileSourceConfiguration(source);
      expect(configuration.url, isNull);
      expect(configuration.tileUrlTemplates, source.tiles);
      expect(configuration.options, {
        _minimumZoomLevelOption: 2,
        _maximumZoomLevelOption: 12,
        _attributionHtmlStringOption: 'Example',
      });
    });

    test('preserves supported raster DEM tile-template encoding', () {
      const source = RasterDemSource(
        id: 'dem',
        tiles: ['https://example.com/{z}/{x}/{y}.png'],
        minZoom: 1,
        maxZoom: 14,
        tileSize: 256,
        encoding: RasterDemTerrariumEncoding(),
      );

      final configuration = buildTileSourceConfiguration(source);
      expect(configuration.url, isNull);
      expect(configuration.tileUrlTemplates, source.tiles);
      expect(configuration.options, {
        _minimumZoomLevelOption: 1,
        _maximumZoomLevelOption: 14,
        _tileSizeOption: 256,
        _demEncodingOption: 1,
      });
    });

    test('keeps all TileJSON URL variants on the URL path', () {
      const sources = <Source>[
        RasterSource(id: 'raster', url: 'https://example.com/raster.json'),
        RasterDemSource(id: 'dem', url: 'https://example.com/dem.json'),
        VectorSource(id: 'vector', url: 'https://example.com/vector.json'),
      ];

      for (final source in sources) {
        final configuration = buildTileSourceConfiguration(source);
        expect(configuration.url, isNotNull);
        expect(configuration.tileUrlTemplates, isNull);
        expect(configuration.options, isEmpty);
      }
    });

    test('uses the native default Mapbox raster DEM encoding value', () {
      const source = RasterDemSource(
        id: 'dem',
        tiles: ['https://example.com/{z}/{x}/{y}.png'],
      );

      expect(
        buildTileSourceConfiguration(source).options[_demEncodingOption],
        0,
      );
    });

    test('omits an invalid zoom range and unsupported custom DEM encoding', () {
      const source = RasterDemSource(
        id: 'dem',
        tiles: ['https://example.com/{z}/{x}/{y}.png'],
        minZoom: 10,
        maxZoom: 4,
        tileSize: 256,
        encoding: RasterDemCustomEncoding(),
      );

      expect(buildTileSourceConfiguration(source).options, {
        _tileSizeOption: 256,
      });
    });

    test('preserves an equal zoom range as a pair', () {
      const source = RasterSource(
        id: 'raster',
        tiles: ['https://example.com/{z}/{x}/{y}.png'],
        minZoom: 4,
        maxZoom: 4,
        tileSize: 256,
      );

      expect(buildTileSourceConfiguration(source).options, {
        _minimumZoomLevelOption: 4,
        _maximumZoomLevelOption: 4,
        _tileSizeOption: 256,
      });
    });

    test('omits zoom ranges that are invalid for MapLibre Native', () {
      const invalidRanges = <({double min, double max})>[
        (min: -1, max: 4),
        (min: 4, max: 23),
        (min: 3.5, max: 4),
        (min: double.nan, max: 4),
        (min: 0, max: double.infinity),
      ];

      for (final range in invalidRanges) {
        final source = RasterSource(
          id: 'raster',
          tiles: const ['https://example.com/{z}/{x}/{y}.png'],
          minZoom: range.min,
          maxZoom: range.max,
          tileSize: 256,
        );

        expect(buildTileSourceConfiguration(source).options, {
          _tileSizeOption: 256,
        });
      }
    });
  });
}

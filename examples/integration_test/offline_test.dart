import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

/// A transparent 1x1 PNG.
final Uint8List _tile = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA'
  '60e6kgAAAABJRU5ErkJggg==',
);

/// Serves a style with raster tiles up to zoom 1 and a glyph URL, on the
/// loopback interface, and counts the requests by kind.
class _TileServer {
  _TileServer._(this._server) {
    _server.listen(_serve);
  }

  static Future<_TileServer> start() async =>
      _TileServer._(await HttpServer.bind(InternetAddress.loopbackIPv4, 0));

  final HttpServer _server;
  final requests = <String, int>{};

  /// Whether tile requests fail with a server error. MapLibre stores tiles
  /// that are not found as empty, so a 404 is no error.
  bool failTiles = false;

  String get _origin => 'http://127.0.0.1:${_server.port}';

  String get styleUrl => '$_origin/style.json';

  String get _style => jsonEncode({
    'version': 8,
    // A font stack with a space, whose glyph URLs broke offline downloads on
    // Android (#535).
    'glyphs': '$_origin/fonts/{fontstack}/{range}.pbf',
    'sources': {
      'raster': {
        'type': 'raster',
        'tiles': ['$_origin/tiles/{z}/{x}/{y}.png'],
        'tileSize': 256,
        'maxzoom': 1,
      },
      'point': {
        'type': 'geojson',
        'data': {
          'type': 'Feature',
          'properties': {'name': 'A'},
          'geometry': {
            'type': 'Point',
            'coordinates': [0, 0],
          },
        },
      },
    },
    'layers': [
      {'id': 'raster', 'type': 'raster', 'source': 'raster'},
      {
        'id': 'label',
        'type': 'symbol',
        'source': 'point',
        'layout': {
          'text-field': ['get', 'name'],
          'text-font': ['Noto Sans Regular'],
        },
      },
    ],
  });

  Future<void> _serve(HttpRequest request) async {
    final path = request.uri.path;
    final kind = path.split('/')[1];
    requests[kind] = (requests[kind] ?? 0) + 1;
    final response = request.response;
    if (path == '/style.json') {
      response.headers.contentType = ContentType.json;
      response.write(_style);
    } else if (kind == 'tiles' && failTiles) {
      response.statusCode = HttpStatus.internalServerError;
    } else if (kind == 'tiles') {
      response.headers.contentType = ContentType('image', 'png');
      response.add(_tile);
    } else if (kind == 'fonts') {
      // An empty glyph range.
      response.headers.contentType = ContentType('application', 'x-protobuf');
    } else {
      response.statusCode = HttpStatus.notFound;
    }
    await response.close();
  }

  Future<void> close() => _server.close(force: true);
}

const _world = LngLatBounds(
  longitudeWest: -180,
  longitudeEast: 180,
  latitudeSouth: -85,
  latitudeNorth: 85,
);

/// Downloads [server]'s style over the world up to zoom 1, or [definition],
/// and returns every progress update.
Future<List<DownloadProgress>> _download(
  OfflineManager manager,
  _TileServer server, {
  OfflineRegionDefinition? definition,
  Map<String, Object?> metadata = const {},
}) => manager
    .downloadRegion(
      definition:
          definition ??
          OfflineTilePyramidRegionDefinition(
            styleUrl: server.styleUrl,
            bounds: _world,
            minZoom: 0,
            maxZoom: 1,
            pixelRatio: 1,
          ),
      metadata: metadata,
    )
    .toList()
    .timeout(const Duration(seconds: 60));

void runTests() {
  group('OfflineManager', () {
    late _TileServer server;
    late OfflineManager manager;

    setUp(() async {
      server = await _TileServer.start();
      manager = await OfflineManager.createInstance();
      for (final region in await manager.listOfflineRegions()) {
        await manager.deleteRegion(regionId: region.id);
      }
    });

    tearDown(() async {
      manager.dispose();
      await server.close();
    });

    test('is supported', () {
      expect(OfflineManager.isSupported, isTrue);
    });

    test('downloads a region and reports its progress', () async {
      const metadata = {'name': 'Zürich ✓', 'zoom': 1};
      final updates = await _download(manager, server, metadata: metadata);
      final last = updates.last;
      expect(last.downloadCompleted, isTrue);
      expect(updates.where((update) => update.downloadCompleted), hasLength(1));
      // MapLibre Native covers zoom 0 and 1 with the four 256 px tiles of zoom
      // 1, as 256 px tiles show one zoom level below 512 px ones.
      expect(last.status.requiredTileCount, 4);
      expect(last.status.completedTileCount, 4);
      expect(last.status.requiredResourceCountIsPrecise, isTrue);
      expect(
        last.status.completedResourceCount,
        last.status.requiredResourceCount,
      );
      expect(last.progress, 1);
      expect(last.status.completedResourceSize, greaterThan(0));
      expect(last.status.completedTileSize, greaterThan(0));
      expect(server.requests['tiles'], 4);
      expect(server.requests['fonts'], greaterThan(0));

      final region = last.region;
      expect(
        region.definition,
        OfflineTilePyramidRegionDefinition(
          styleUrl: server.styleUrl,
          bounds: _world,
          minZoom: 0,
          maxZoom: 1,
          pixelRatio: 1,
        ),
      );
      expect(region.metadata, metadata);
      expect(await manager.listOfflineRegions(), [region]);
      expect(await manager.getOfflineRegion(regionId: region.id), region);

      final status = await manager.getRegionStatus(regionId: region.id);
      expect(status.complete, isTrue);
      expect(status.downloadState, OfflineRegionDownloadState.inactive);
      expect(status.completedTileCount, 4);
      expect(status.progress, 1);
    });

    test('downloads only the tiles a geometry touches', () async {
      // A triangle within the north-east tile of zoom 1.
      final definition = OfflineGeometryRegionDefinition(
        styleUrl: server.styleUrl,
        geometry: Polygon.from(const [
          [
            Geographic(lon: 10, lat: 10),
            Geographic(lon: 20, lat: 10),
            Geographic(lon: 20, lat: 20),
            Geographic(lon: 10, lat: 10),
          ],
        ]),
        minZoom: 0,
        maxZoom: 1,
        pixelRatio: 1,
      );
      final updates = await _download(manager, server, definition: definition);
      final last = updates.last;
      expect(last.downloadCompleted, isTrue);
      expect(last.status.requiredTileCount, 1);
      expect(server.requests['tiles'], 1);
      expect(last.region.definition, definition);
      expect(await manager.listOfflineRegions(), [last.region]);
    });

    test('reports resources that fail to load', () async {
      server.failTiles = true;
      final errors = Completer<Object>();
      final subscription = manager
          .downloadRegion(
            definition: OfflineTilePyramidRegionDefinition(
              styleUrl: server.styleUrl,
              bounds: _world,
              minZoom: 0,
              maxZoom: 1,
              pixelRatio: 1,
            ),
          )
          .listen(
            (_) {},
            onError: (Object error) {
              if (!errors.isCompleted) errors.complete(error);
            },
          );
      final error = await errors.future.timeout(const Duration(seconds: 60));
      // Cancelling pauses the download, which retries the tiles otherwise.
      await subscription.cancel();
      expect(
        error,
        isA<OfflineResourceException>().having(
          (e) => e.reason,
          'reason',
          OfflineResourceErrorReason.server,
        ),
      );
      final regions = await manager.listOfflineRegions();
      expect(regions, hasLength(1));
      expect((error as OfflineResourceException).regionId, regions.single.id);
      final status = await manager.getRegionStatus(regionId: regions.single.id);
      expect(status.complete, isFalse);
      expect(status.downloadState, OfflineRegionDownloadState.inactive);
    });

    test('updates metadata and deletes regions', () async {
      final updates = await _download(manager, server);
      final region = updates.last.region;
      expect(region.metadata, isEmpty);

      final updated = await manager.updateRegionMetadata(
        regionId: region.id,
        metadata: {'name': 'Ünïcode'},
      );
      expect(updated.metadata, {'name': 'Ünïcode'});
      expect((await manager.getOfflineRegion(regionId: region.id))?.metadata, {
        'name': 'Ünïcode',
      });

      await manager.deleteRegion(regionId: region.id);
      expect(await manager.getOfflineRegion(regionId: region.id), isNull);
      expect(await manager.listOfflineRegions(), isEmpty);
    });

    test('maintains the ambient cache and the database', () async {
      await manager.setMaximumAmbientCacheSize(bytes: 50 * 1024 * 1024);
      await manager.invalidateAmbientCache();
      await manager.clearAmbientCache();
      await manager.packDatabase();
      await _download(manager, server);
      await manager.resetDatabase();
      expect(await manager.listOfflineRegions(), isEmpty);
    });

    testWidgets('a map shows a downloaded region without the network', (
      tester,
    ) async {
      final styleUrl = server.styleUrl;
      await tester.runAsync(() => _download(manager, server));
      await tester.runAsync(server.close);
      final map = await pumpMap(
        tester,
        options: MapOptions(initStyle: styleUrl, initZoom: 1),
      );
      expect(map.style.getLayerIds(), ['raster', 'label']);
      await map.waitForLatestFrame();
    });
  }, skip: kIsWeb);
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

/// Serves the zoom 0 tile of `assets/tiles/points_fastpfor.mlt` and a style
/// that shows it, on the loopback interface.
///
/// The tile holds the 2000 points of the layer `points`. Martin
/// 2.0.0-beta.5 encoded it as MLT (`Accept: application/vnd.maplibre-tile`)
/// from generated points in PostGIS, with its default FastPFOR integer
/// encoding.
class _MltServer {
  _MltServer._(this._server, this._tile) {
    _server.listen(_serve);
  }

  static Future<_MltServer> start() async {
    final tile = await rootBundle.load('assets/tiles/points_fastpfor.mlt');
    return _MltServer._(
      await HttpServer.bind(InternetAddress.loopbackIPv4, 0),
      tile.buffer.asUint8List(tile.offsetInBytes, tile.lengthInBytes),
    );
  }

  final HttpServer _server;
  final Uint8List _tile;

  /// Tile requests answered.
  int tiles = 0;

  String get style => jsonEncode({
    'version': 8,
    'sources': {
      'points': {
        'type': 'vector',
        'tiles': ['http://127.0.0.1:${_server.port}/tiles/{z}/{x}/{y}'],
        'maxzoom': 0,
        'encoding': 'mlt',
      },
    },
    'layers': [
      {
        'id': 'background',
        'type': 'background',
        'paint': {'background-color': '#dddddd'},
      },
      {
        'id': 'points',
        'type': 'circle',
        'source': 'points',
        'source-layer': 'points',
        'paint': {'circle-radius': 4, 'circle-color': '#ff0000'},
      },
    ],
  });

  Future<void> _serve(HttpRequest request) async {
    final response = request.response;
    if (request.uri.path == '/tiles/0/0/0') {
      tiles++;
      response.headers.contentType = ContentType(
        'application',
        'vnd.maplibre-tile',
      );
      response.add(_tile);
    } else {
      response.statusCode = HttpStatus.notFound;
    }
    await response.close();
  }

  Future<void> close() => _server.close(force: true);
}

void runTests() {
  group('MapLibre Tiles (MLT)', () {
    late _MltServer server;

    setUp(() async => server = await _MltServer.start());
    tearDown(() => server.close());

    Future<TestMap> pumpMltMap(WidgetTester tester, {required bool fastPfor}) =>
        pumpMap(
          tester,
          options: MapOptions(
            style: MapStyle.json(server.style),
            initCamera: const CameraUpdate.position(zoom: 0.5),
            fastPforEnabled: fastPfor,
          ),
        );

    testWidgets('with FastPFOR integer streams decode when enabled', (
      tester,
    ) async {
      final map = await pumpMltMap(tester, fastPfor: true);
      final everything = Offset.zero & map.size;
      final deadline = DateTime.now().add(defaultTimeout);
      var features = <RenderedFeature>[];
      while (features.isEmpty && DateTime.now().isBefore(deadline)) {
        await tester.pump(const Duration(milliseconds: 100));
        features = await map.controller.featuresInRect(
          everything,
          layerIds: ['points'],
        );
      }
      expect(features, isNotEmpty);
      expect(features.first.sourceLayer, 'points');
    });

    testWidgets('with FastPFOR integer streams are dropped by default', (
      tester,
    ) async {
      final map = await pumpMltMap(tester, fastPfor: false);
      // Idle once the tile has arrived and been parsed.
      await map.pumpUntil(
        () => server.tiles > 0,
        reason: () => 'waiting for the tile request',
      );
      await map.waitForEvent<MapEventIdle>(since: map.events.length);
      expect(
        await map.controller.featuresInRect(
          Offset.zero & map.size,
          layerIds: ['points'],
        ),
        isEmpty,
      );
    });
  }, skip: kIsWeb);
}

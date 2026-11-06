import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

/// A style that draws a circle at 0, 0 from the GeoJSON [data], a URL or
/// an inline object.
String _pointStyle(Object data) => jsonEncode({
  'version': 8,
  'sources': {
    'points': {'type': 'geojson', 'data': data},
  },
  'layers': [
    {'id': 'points', 'type': 'circle', 'source': 'points'},
  ],
});

const Map<String, Object> _point = {
  'type': 'Feature',
  'geometry': {
    'type': 'Point',
    'coordinates': [0, 0],
  },
  'properties': <String, Object?>{},
};

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

/// Serves a style with a GeoJSON source on the loopback interface, and
/// records the requests with the `X-Maplibre-Test` header they sent.
class _StyleServer {
  _StyleServer._(this._server) {
    _server.listen(_serve);
  }

  static Future<_StyleServer> start() async =>
      _StyleServer._(await HttpServer.bind(InternetAddress.loopbackIPv4, 0));

  final HttpServer _server;

  /// The path and `X-Maplibre-Test` header of each request.
  final requests = <(String, String?)>[];

  String get origin => 'http://127.0.0.1:${_server.port}';

  Future<void> _serve(HttpRequest request) async {
    final path = request.uri.path;
    requests.add((path, request.headers.value('x-maplibre-test')));
    final response = request.response
      ..headers.contentType = ContentType.json
      ..headers.set(HttpHeaders.cacheControlHeader, 'no-store');
    switch (path) {
      case '/style.json':
        response.write(_pointStyle('$origin/points.geojson'));
      case '/points.geojson':
        response.write(jsonEncode(_point));
      default:
        response.statusCode = HttpStatus.notFound;
    }
    await response.close();
  }

  Future<void> close() => _server.close(force: true);
}

void runTests() {
  group('MapLibreNetwork', () {
    tearDown(MapLibreNetwork.reset);

    testWidgets('rewrites the URLs that maps request', (tester) async {
      // The web loads the style from a data URL with the point inline, the
      // other platforms from a local server.
      _StyleServer? server;
      String target;
      if (kIsWeb) {
        target = Uri.dataFromString(
          _pointStyle(_point),
          mimeType: 'application/json',
        ).toString();
      } else {
        server = await _StyleServer.start();
        addTearDown(server.close);
        target = '${server.origin}/style.json';
        // Headers match the URL after the transform.
        MapLibreNetwork.requestHeaders = [
          const RequestHeaders({
            'X-Maplibre-Test': 'transformed',
          }, url: 'http://127.0.0.1:*/**'),
        ];
      }
      const requested = 'https://maplibre.invalid/style.json';
      final transformed = <(String, MapResourceKind)>[];
      MapLibreNetwork.urlTransform = (url, kind) {
        transformed.add((url, kind));
        return url == requested ? target : url;
      };

      final map = await pumpMap(
        tester,
        options: const MapOptions(style: MapStyle.url(requested)),
      );
      // The map shows the point of the style that it got instead.
      await map.waitForFeatures(
        map.center,
        (features) => features.isNotEmpty,
        layerIds: ['points'],
      );
      expect(transformed, contains((requested, MapResourceKind.style)));
      if (server != null) {
        expect(server.requests, contains(('/style.json', 'transformed')));
      }
    });

    testWidgets('send headers with the first entry that matches', (
      tester,
    ) async {
      final server = await _StyleServer.start();
      addTearDown(server.close);
      // Entries that match no kind leave no rules, which must not keep a map
      // from starting.
      MapLibreNetwork.requestHeaders = [
        const RequestHeaders({'X-Maplibre-Test': 'none'}, kinds: {}),
      ];
      // The headers reach a map that already exists.
      final map = await pumpMap(tester);
      MapLibreNetwork.requestHeaders = [
        const RequestHeaders({
          'X-Maplibre-Test': 'geojson',
        }, url: 'http://127.0.0.1:*/*.geojson'),
        const RequestHeaders({'X-Maplibre-Test': 'style'}),
      ];
      final since = map.styleLoads;
      await map.setOptions(
        MapOptions(style: MapStyle.url('${server.origin}/style.json')),
      );
      await map.waitForStyleLoad(since: since);
      await map.pumpUntil(
        () => server.requests.any((r) => r.$1 == '/points.geojson'),
        reason: () => 'waiting for the GeoJSON request',
      );
      await map.waitForFeatures(
        map.center,
        (features) => features.isNotEmpty,
        layerIds: ['points'],
      );
      expect(server.requests, contains(('/style.json', 'style')));
      expect(server.requests, contains(('/points.geojson', 'geojson')));

      // Without the headers, the next requests send none.
      MapLibreNetwork.reset();
      server.requests.clear();
      final sinceReset = map.styleLoads;
      await map.setOptions(
        MapOptions(style: MapStyle.url('${server.origin}/style.json?reset')),
      );
      await map.waitForStyleLoad(since: sinceReset);
      await map.pumpUntil(
        () => server.requests.any((r) => r.$1 == '/points.geojson'),
        reason: () => 'waiting for the GeoJSON request after the reset',
      );
      expect(server.requests.map((r) => r.$2), everyElement(isNull));
    }, skip: kIsWeb);
  });
}

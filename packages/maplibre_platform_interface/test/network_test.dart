import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

void main() {
  tearDown(MapLibreNetwork.reset);

  group('RequestHeaders', () {
    bool matches(String pattern, String url) =>
        RequestHeaders(const {}, url: pattern).matches(url, .tile);

    test('match every URL by default', () {
      expect(
        const RequestHeaders({}).matches('https://a.org/x?y=1', .style),
        isTrue,
      );
    });

    test('match the whole URL as a glob', () {
      const tiles = 'https://*.example.com/tiles/**';
      expect(matches(tiles, 'https://a.example.com/tiles/1/2/3.pbf'), isTrue);
      expect(matches(tiles, 'https://a.b.example.com/tiles/1.pbf'), isTrue);
      // `*` stops at `/`.
      expect(matches(tiles, 'https://x.org/.example.com/tiles/1'), isFalse);
      // The pattern must match from the start to the end.
      expect(matches(tiles, 'xhttps://a.example.com/tiles/1'), isFalse);
      expect(
        matches('https://a.org/style.json', 'https://a.org/style.json?k=1'),
        isFalse,
      );
      expect(
        matches('https://a.org/style.json', 'https://a.org/style.json'),
        isTrue,
      );
    });

    test('match one character with ? and escape with a backslash', () {
      expect(matches('https://a.org/v?/s', 'https://a.org/v1/s'), isTrue);
      expect(matches('https://a.org/v?/s', 'https://a.org/v//s'), isFalse);
      expect(matches(r'https://a.org/\*', 'https://a.org/*'), isTrue);
      expect(matches(r'https://a.org/\*', 'https://a.org/x'), isFalse);
      // Regular expression characters match only themselves.
      expect(
        matches('https://a.org/(x).json', 'https://a.org/(x).json'),
        isTrue,
      );
      expect(matches('https://a.org/x.json', 'https://a.org/xxjson'), isFalse);
    });

    test('match only the kinds given', () {
      const glyphs = RequestHeaders({}, kinds: {.glyphs});
      expect(glyphs.matches('https://a.org/font', .glyphs), isTrue);
      expect(glyphs.matches('https://a.org/font', .tile), isFalse);
      const nothing = RequestHeaders({}, kinds: {});
      expect(nothing.matches('https://a.org/font', .glyphs), isFalse);
    });

    test('compare by value', () {
      const a = RequestHeaders({'A': '1'}, url: 'https://**', kinds: {.tile});
      final b = RequestHeaders(
        Map.of({'A': '1'}),
        url: 'https://**',
        kinds: {MapResourceKind.values.byName('tile')},
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(const RequestHeaders({'A': '2'}, url: 'https://**')));
    });
  });

  group('MapLibreNetwork', () {
    test('has no headers and no transform by default', () {
      expect(MapLibreNetwork.requestHeaders, isEmpty);
      expect(MapLibreNetwork.urlTransform, isNull);
      expect(MapLibreNetwork.headersFor('https://a.org', .style), isNull);
      expect(
        MapLibreNetwork.transformUrl('https://a.org', .style),
        'https://a.org',
      );
    });

    test('takes the headers of the first entry that matches', () {
      MapLibreNetwork.requestHeaders = const [
        RequestHeaders({'A': 'tiles'}, url: 'https://a.org/tiles/**'),
        RequestHeaders({'A': 'all'}),
      ];
      expect(MapLibreNetwork.headersFor('https://a.org/tiles/1', .tile), {
        'A': 'tiles',
      });
      expect(MapLibreNetwork.headersFor('https://a.org/style', .style), {
        'A': 'all',
      });
    });

    test('transforms URLs and keeps them when the transform throws', () {
      final errors = <FlutterErrorDetails>[];
      final onError = FlutterError.onError;
      FlutterError.onError = errors.add;
      addTearDown(() => FlutterError.onError = onError);

      MapLibreNetwork.urlTransform = (url, kind) => switch (kind) {
        .tile => '$url?key=1',
        .style => throw StateError('no style'),
        _ => url,
      };
      expect(
        MapLibreNetwork.transformUrl('https://a.org/1', .tile),
        'https://a.org/1?key=1',
      );
      expect(
        MapLibreNetwork.transformUrl('https://a.org/s', .style),
        'https://a.org/s',
      );
      expect(errors.single.exception, isStateError);
    });

    test('notifies on changes only', () {
      var changes = 0;
      void listener() => changes++;
      MapLibreNetwork.changes.addListener(listener);
      addTearDown(() => MapLibreNetwork.changes.removeListener(listener));

      MapLibreNetwork.requestHeaders = const [
        RequestHeaders({'A': '1'}),
      ];
      MapLibreNetwork.requestHeaders = const [
        RequestHeaders({'A': '1'}),
      ];
      expect(changes, 1);
      String transform(String url, MapResourceKind kind) => url;
      MapLibreNetwork.urlTransform = transform;
      MapLibreNetwork.urlTransform = transform;
      expect(changes, 2);
      MapLibreNetwork.reset();
      expect(changes, 4);
      expect(
        () => MapLibreNetwork.requestHeaders.add(const RequestHeaders({})),
        throwsUnsupportedError,
      );
    });
  });
}

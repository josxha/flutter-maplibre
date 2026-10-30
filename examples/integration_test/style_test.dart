import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

const _point = Geographic(lon: 0, lat: 0);

String _pointData([Geographic point = _point]) => featureCollection([
  Feature(geometry: Point(point), id: 1, properties: const {'name': 'p'}),
]);

void runTests() {
  group('style', () {
    testWidgets('loads a style from JSON', (tester) async {
      final map = await pumpMap(tester);
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
      ]);
    });

    testWidgets('loads a style from an asset', (tester) async {
      final map = await pumpMap(
        tester,
        options: const MapOptions(
          style: MapStyle.asset('assets/styles/test_style.json'),
          initCamera: InitialCamera.position(zoom: 4),
        ),
      );
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
        'points',
      ]);
      await map.waitForFeatures(
        map.center,
        (features) => features.any((f) => f.sourceId == 'points'),
      );
    });

    testWidgets('loads a style from a URL (network)', (tester) async {
      final map = await pumpMap(
        tester,
        options: const MapOptions(initCamera: InitialCamera.position()),
      );
      expect(
        map.style.layers.map((layer) => layer.id).toList(),
        contains('countries-fill'),
      );
    });

    testWidgets('adds layers at the requested position', (tester) async {
      final map = await pumpMap(tester);
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: _pointData()),
      );
      await map.style.layers.add(CircleStyleLayer(id: 'top', sourceId: 'src'));
      await map.style.layers.add(
        CircleStyleLayer(id: 'below-top', sourceId: 'src'),
        belowLayerId: 'top',
      );
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
        'below-top',
        'top',
      ]);
    });

    testWidgets('adds and removes every kind of layer', (tester) async {
      final map = await pumpMap(tester);
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: _pointData()),
      );
      await map.style.sources.add(
        const RasterDemSource.tiles(
          id: 'dem',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          tileSize: 256,
        ),
      );
      await map.style.sources.add(
        const RasterSource.tiles(
          id: 'raster',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          tileSize: 256,
        ),
      );
      final layers = <StyleLayer>[
        BackgroundStyleLayer(
          id: 'l-background',
          color: const .literal(Colors.black),
        ),
        CircleStyleLayer(id: 'l-circle', sourceId: 'src'),
        ColorReliefStyleLayer(id: 'l-color-relief', sourceId: 'dem'),
        FillStyleLayer(id: 'l-fill', sourceId: 'src'),
        FillExtrusionStyleLayer(id: 'l-fill-extrusion', sourceId: 'src'),
        HeatmapStyleLayer(id: 'l-heatmap', sourceId: 'src'),
        HillshadeStyleLayer(id: 'l-hillshade', sourceId: 'dem'),
        LineStyleLayer(id: 'l-line', sourceId: 'src'),
        RasterStyleLayer(id: 'l-raster', sourceId: 'raster'),
        SymbolStyleLayer(id: 'l-symbol', sourceId: 'src'),
      ];
      for (final layer in layers) {
        await map.style.layers.add(layer);
      }
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
        ...layers.map((layer) => layer.id),
      ]);
      for (final layer in layers) {
        await map.style.layers.remove(layer.id);
      }
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
      ]);
      // Removing what is not there is not an error.
      await map.style.layers.remove('missing');
      await map.style.sources.remove('missing');
    });

    testWidgets('adds and removes every kind of source', (tester) async {
      final map = await pumpMap(tester);
      final markerBytes = (await rootBundle.load(_markerAsset)).buffer
          .asUint8List();
      final sources = <Source>[
        GeoJsonSource.data(id: 'geojson', data: _pointData()),
        const GeoJsonSource.url(
          id: 'geojson-url',
          url: 'https://example.invalid/data.geojson',
        ),
        const ImageSource.url(
          id: 'image',
          url: 'https://example.invalid/image.png',
          coordinates: LngLatQuad(
            bottomLeft: Geographic(lon: 0, lat: 0),
            bottomRight: Geographic(lon: 1, lat: 0),
            topLeft: Geographic(lon: 0, lat: 1),
            topRight: Geographic(lon: 1, lat: 1),
          ),
        ),
        ImageSource.bytes(
          id: 'image-bytes',
          bytes: markerBytes,
          coordinates: _quad,
        ),
        const ImageSource.provider(
          id: 'image-provider',
          image: AssetImage(_markerAsset),
          coordinates: _quad,
        ),
        const RasterSource.tiles(
          id: 'raster',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
        ),
        const RasterDemSource.tiles(
          id: 'raster-dem',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
        ),
        const VectorSource.tiles(
          id: 'vector',
          tiles: ['https://example.invalid/{z}/{x}/{y}.pbf'],
        ),
        const RasterSource.url(
          id: 'raster-url',
          url: 'https://example.invalid/tiles.json',
        ),
        const RasterDemSource.url(
          id: 'raster-dem-url',
          url: 'https://example.invalid/tiles.json',
        ),
        const VectorSource.url(
          id: 'vector-url',
          url: 'https://example.invalid/tiles.json',
        ),
        // MapLibre Native has no video sources.
        if (kIsWeb) ...[
          const VideoSource.urls(
            id: 'video',
            urls: ['https://example.invalid/video.mp4'],
            coordinates: _quad,
          ),
          VideoSource.bytes(
            id: 'video-bytes',
            bytes: markerBytes,
            coordinates: _quad,
          ),
          const VideoSource.asset(
            id: 'video-asset',
            asset: _markerAsset,
            coordinates: _quad,
          ),
        ],
      ];
      for (final source in sources) {
        await map.style.sources.add(source);
        // A layer can only be added on a source that exists.
        await map.style.layers.add(switch (source) {
          GeoJsonSource() => CircleStyleLayer(id: 'on', sourceId: source.id),
          RasterDemSource() => HillshadeStyleLayer(
            id: 'on',
            sourceId: source.id,
          ),
          VectorSource() => FillStyleLayer(
            id: 'on',
            sourceId: source.id,
            sourceLayerId: 'water',
          ),
          _ => RasterStyleLayer(id: 'on', sourceId: source.id),
        });
        expect(map.style.layers.map((layer) => layer.id).toList(), [
          'background',
          'on',
        ]);
        await map.style.layers.remove('on');
      }
      for (final source in sources) {
        await map.style.sources.remove(source.id);
      }
      // Every ID is free again.
      await map.style.sources.add(
        GeoJsonSource.data(id: 'geojson', data: _pointData()),
      );
    });

    testWidgets('fails to add an image source of a missing asset', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      await expectLater(
        map.style.sources.add(
          const ImageSource.provider(
            id: 'image',
            image: AssetImage('assets/images/missing.png'),
            coordinates: _quad,
          ),
        ),
        throwsA(anything),
      );
    });

    testWidgets('updates the data of a GeoJSON source', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: _pointData()),
      );
      await map.style.layers.add(
        CircleStyleLayer(
          id: 'circles',
          sourceId: 'src',
          paint: {'circle-radius': 10},
        ),
      );
      await map.waitForFeatures(map.center, (features) => features.length == 1);

      const moved = Geographic(lon: 0.5, lat: 0.5);
      await map.style.sources.updateGeoJsonData('src', _pointData(moved));
      await map.waitForFeatures(map.center, (features) => features.isEmpty);
      await map.waitForFeatures(
        map.controller.toScreenLocation(moved),
        (features) => features.length == 1,
      );
    });

    testWidgets('moves the end of a line gradient', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      String line(double lon) => featureCollection([
        Feature(
          geometry: LineString.from(
            const [
              Geographic(lon: -1, lat: 0),
              Geographic(lon: 1, lat: 0),
            ].map((p) => Geographic(lon: p.lon + lon, lat: p.lat)),
          ),
        ),
      ]);
      Expression<Color> gradient(double progress) => .step(
        .lineProgress(),
        const .literal(Color(0xFFFF0000)),
        {progress: const .literal(Color(0x00000000))},
      );
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: line(0), lineMetrics: true),
      );
      final layer = LineStyleLayer(
        id: 'line',
        sourceId: 'src',
        width: const .literal(10),
        gradient: gradient(0.25),
      );
      await map.style.layers.add(layer);
      // Tiles clip a line with line metrics into one feature each.
      await map.waitForFeatures(map.center, (features) => features.isNotEmpty);

      expect(layer.gradient, gradient(0.25));
      layer.gradient = gradient(0.75);
      expect(layer.gradient, gradient(0.75));

      // Data for a source with line metrics is prepared with them.
      await map.style.sources.updateGeoJsonData('src', line(0.5));
      await map.waitForFeatures(
        map.controller.toScreenLocation(const Geographic(lon: -0.75, lat: 0)),
        (features) => features.isEmpty,
      );
    });

    testWidgets('reads the layers and sources of a style back', (tester) async {
      final map = await pumpMap(
        tester,
        options: MapOptions(
          style: MapStyle.json(
            jsonEncode({
              'version': 8,
              'sources': {
                'points': {
                  'type': 'geojson',
                  'data': jsonDecode(_pointData()),
                  'attribution': 'A',
                  'lineMetrics': true,
                },
                'tiles': {
                  'type': 'vector',
                  'tiles': ['https://example.invalid/{z}/{x}/{y}.pbf'],
                  'maxzoom': 10,
                },
              },
              'layers': [
                {
                  'id': 'background',
                  'type': 'background',
                  'paint': {'background-color': '#00ff00'},
                },
                {
                  'id': 'circles',
                  'type': 'circle',
                  'source': 'points',
                  'minzoom': 1,
                  'maxzoom': 20,
                  'filter': ['has', 'name'],
                  'layout': {'visibility': 'none'},
                  'paint': {
                    'circle-radius': 7,
                    'circle-color': 'rgba(255, 0, 0, 0.5)',
                    'circle-blur': ['get', 'blur'],
                  },
                },
                {
                  'id': 'vectors',
                  'type': 'line',
                  'source': 'tiles',
                  'source-layer': 'roads',
                  'layout': {'line-cap': 'round'},
                  'paint': {
                    'line-translate': [1, 2],
                  },
                },
              ],
            }),
          ),
          initCamera: const InitialCamera.position(),
        ),
      );
      expect(map.style.layers.map((layer) => layer.id), [
        'background',
        'circles',
        'vectors',
      ]);
      final background =
          map.style.layers['background']! as BackgroundStyleLayer;
      expect(background.color, const Literal(Color(0xFF00FF00)));

      final circles = map.style.layers['circles']! as CircleStyleLayer;
      expect(circles.sourceId, 'points');
      expect(circles.minZoom, 1);
      expect(circles.maxZoom, 20);
      expect(circles.visible, isFalse);
      expect(circles.filter, const Expression<bool>.raw(['has', 'name']));
      expect(circles.radius, const Literal<num>(7));
      expect((circles.color as Literal<Color>).value.a, 0.5);
      expect(circles.blur, const Expression<num>.raw(['get', 'blur']));

      final vectors = map.style.layers['vectors']! as LineStyleLayer;
      expect(vectors.sourceLayerId, 'roads');
      expect(vectors.cap, const Literal(LineCap.round));
      expect(vectors.translate, const Literal(Offset(1, 2)));
      expect(vectors.width, const Literal<num>(1));

      expect(map.style.sources.length, 2);
      final points = map.style.sources['points']! as GeoJsonSourceData;
      expect(points.attribution, 'A');
      expect(points.lineMetrics, isTrue);
      expect(jsonDecode(points.data), jsonDecode(_pointData()));
      final tiles = map.style.sources['tiles']! as VectorSourceTiles;
      expect(tiles.tiles, ['https://example.invalid/{z}/{x}/{y}.pbf']);
      expect(tiles.maxZoom, 10);
    });

    testWidgets('setters of a layer on the map reach the map', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: _pointData()),
      );
      final layer = CircleStyleLayer(
        id: 'circles',
        sourceId: 'src',
        radius: const .literal(40),
      );
      await map.style.layers.add(layer);
      Future<void> expectShown({required bool shown}) => map.waitForFeatures(
        map.center,
        (features) => features.isNotEmpty == shown,
      );
      await expectShown(shown: true);

      // Inside the circle at its radius of 40 pixels, off it at 10. It starts
      // at 40 because gl-js only searches as far as the radius was when the
      // tile loaded.
      final beside = map.center + const Offset(25, 0);
      await map.waitForFeatures(beside, (features) => features.isNotEmpty);
      layer.radius = const .literal(10);
      await map.waitForFeatures(beside, (features) => features.isEmpty);
      layer.radius = const .literal(40);
      await map.waitForFeatures(beside, (features) => features.isNotEmpty);
      layer.radius = null;
      await map.waitForFeatures(beside, (features) => features.isEmpty);
      layer.radius = const .literal(40);
      await map.waitForFeatures(beside, (features) => features.isNotEmpty);

      layer.visible = false;
      await expectShown(shown: false);
      layer.visible = true;
      await expectShown(shown: true);

      layer.filter = Expression.equal(.get('name'), const .literal('other'));
      await expectShown(shown: false);
      layer.filter = Expression.equal(.get('name'), const .literal('p'));
      await expectShown(shown: true);
      layer.filter = null;
      await expectShown(shown: true);

      layer.minZoom = 10;
      await expectShown(shown: false);
      layer.minZoom = 0;
      await expectShown(shown: true);
      layer.maxZoom = 5;
      await expectShown(shown: false);
      layer.maxZoom = 24;
      await expectShown(shown: true);

      layer.setProperty('circle-radius', 10);
      await map.waitForFeatures(beside, (features) => features.isEmpty);
      expect(layer.radius, const Literal<num>(10));
    });

    testWidgets('moves layers', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: _pointData()),
      );
      final bytes = (await rootBundle.load(_markerAsset)).buffer.asUint8List();
      await map.style.addImage('marker', bytes);
      final a = _icon('a', 'src');
      await map.style.layers.add(a);
      await map.style.layers.add(_icon('b', 'src'));
      await _waitForIconOf(map, 'b');

      map.style.layers.move('b', belowLayerId: 'a');
      expect(map.style.layers.map((layer) => layer.id), [
        'background',
        'b',
        'a',
      ]);
      await _waitForIconOf(map, 'a');

      a.moveBelow('b');
      await _waitForIconOf(map, 'b');

      a.moveBelow(null);
      expect(map.style.layers.last, a);
      await _waitForIconOf(map, 'a');
    });

    testWidgets('a batch applies its changes', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: _pointData()),
      );
      final layer = CircleStyleLayer(
        id: 'first',
        sourceId: 'src',
        radius: const .literal(10),
      );
      await map.style.layers.add(layer);
      await map.waitForFeatures(map.center, (features) => features.isNotEmpty);

      map.style.batch(() {
        layer.visible = false;
        map.style.layers.add(
          CircleStyleLayer(
            id: 'second',
            sourceId: 'src',
            radius: const .literal(10),
          ),
          belowLayerId: 'first',
        );
      });
      await map.waitForFeatures(
        map.center,
        (features) =>
            features.length == 1 && features.single.layerId == 'second',
      );
      expect(
        () => map.style.batch(() => throw StateError('x')),
        throwsStateError,
      );
      // The group ended although the callback threw.
      layer.visible = true;
      await map.waitForFeatures(map.center, (features) => features.length == 2);
    });

    testWidgets('detaches layer objects from a replaced style', (tester) async {
      final options = offlineOptions(zoom: 8);
      final map = await pumpMap(tester, options: options);
      final background = map.style.layers['background']!;
      final oldStyle = map.style;
      await tester.pumpWidget(
        MapApp(
          options: MapOptions(
            style: MapStyle.json(
              jsonEncode({
                'version': 8,
                'sources': <String, Object?>{},
                'layers': [
                  {'id': 'other', 'type': 'background'},
                ],
              }),
            ),
            initCamera: options.initCamera,
          ),
        ),
      );
      await map.pumpUntil(
        () => map.controller.style != oldStyle,
        reason: () => 'the new style did not load',
      );
      background.visible = false;
      expect(background.visible, isFalse);
      expect(oldStyle.layers, isEmpty);
      expect(map.controller.style!.layers.single.id, 'other');
    });

    testWidgets('updates the image coordinates and the GeoJSON URL', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      const quad = LngLatQuad(
        bottomLeft: Geographic(lon: -1, lat: -1),
        bottomRight: Geographic(lon: 1, lat: -1),
        topLeft: Geographic(lon: -1, lat: 1),
        topRight: Geographic(lon: 1, lat: 1),
      );
      final bytes = (await rootBundle.load(_markerAsset)).buffer.asUint8List();
      await map.style.sources.add(
        ImageSource.bytes(id: 'image', bytes: bytes, coordinates: quad),
      );
      await map.style.layers.add(RasterStyleLayer(id: 'r', sourceId: 'image'));
      const moved = LngLatQuad(
        bottomLeft: Geographic(lon: 1, lat: 1),
        bottomRight: Geographic(lon: 2, lat: 1),
        topLeft: Geographic(lon: 1, lat: 2),
        topRight: Geographic(lon: 2, lat: 2),
      );
      await map.style.sources.updateImageCoordinates('image', moved);
      expect((map.style.sources['image']! as ImageSource).coordinates, moved);

      await map.style.sources.add(
        GeoJsonSource.data(id: 'geo', data: _pointData()),
      );
      await map.style.sources.updateGeoJsonUrl(
        'geo',
        'https://example.invalid/a',
      );
      expect(
        (map.style.sources['geo']! as GeoJsonSourceUrl).url,
        'https://example.invalid/a',
      );
    });

    testWidgets('updates tiles and keeps the layers of the source in place', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      await map.style.sources.add(
        const VectorSource.tiles(
          id: 'tiles',
          tiles: ['https://example.invalid/a/{z}/{x}/{y}.pbf'],
        ),
      );
      await map.style.sources.add(
        GeoJsonSource.data(id: 'geo', data: _pointData()),
      );
      final bytes = (await rootBundle.load(_markerAsset)).buffer.asUint8List();
      await map.style.addImage('marker', bytes);
      await map.style.layers.add(
        FillStyleLayer(id: 'low', sourceId: 'tiles', sourceLayerId: 'x'),
      );
      await map.style.layers.add(_icon('geo', 'geo'));
      final high = LineStyleLayer(
        id: 'high',
        sourceId: 'tiles',
        sourceLayerId: 'x',
      );
      await map.style.layers.add(high);
      await _waitForIconOf(map, 'geo');

      await map.style.sources.updateTiles('tiles', [
        'https://example.invalid/b/{z}/{x}/{y}.pbf',
      ]);
      expect((map.style.sources['tiles']! as VectorSourceTiles).tiles, [
        'https://example.invalid/b/{z}/{x}/{y}.pbf',
      ]);
      await map.style.sources.updateTileJsonUrl(
        'tiles',
        'https://example.invalid/tiles.json',
      );
      expect(
        (map.style.sources['tiles']! as VectorSourceUrl).url,
        'https://example.invalid/tiles.json',
      );
      await map.style.sources.updateTiles('tiles', [
        'https://example.invalid/c/{z}/{x}/{y}.pbf',
      ]);

      // The layer objects still reach the map, and the map still has the
      // layers at their positions: a position below them works, and removing
      // them frees the source.
      expect(map.style.layers.map((layer) => layer.id), [
        'background',
        'low',
        'geo',
        'high',
      ]);
      high.width = const .literal(4);
      // Below the icon of geo, if low is still below it.
      await map.style.layers.add(
        _icon('below-low', 'geo'),
        belowLayerId: 'low',
      );
      await _waitForIconOf(map, 'geo');
      // Above the icon of geo, if high is still above it.
      await map.style.layers.add(
        _icon('below-high', 'geo'),
        belowLayerId: 'high',
      );
      await _waitForIconOf(map, 'below-high');
      await map.style.layers.remove('low');
      await map.style.layers.remove('high');
      await map.style.sources.remove('tiles');
      expect(map.style.sources['tiles'], isNull);
    });

    testWidgets('adds images that symbol layers draw', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 8));
      final bytes = (await rootBundle.load('assets/images/marker.png')).buffer
          .asUint8List();
      await map.style.addImages({'marker': bytes, 'marker-2': bytes});
      await map.style.addImageFromIconData(
        id: 'icon',
        iconData: Icons.location_on,
        color: Colors.red,
      );
      await map.style.addImageFromWidget(
        id: 'widget',
        widget: const SizedBox.square(
          dimension: 24,
          child: ColoredBox(color: Colors.red),
        ),
      );
      await map.style.sources.add(
        GeoJsonSource.data(id: 'src', data: _pointData()),
      );
      for (final image in ['marker', 'marker-2', 'icon', 'widget']) {
        await map.style.layers.add(
          SymbolStyleLayer(
            id: 'symbols',
            sourceId: 'src',
            layout: {'icon-image': image, 'icon-allow-overlap': true},
          ),
        );
        // A symbol whose image is missing is not drawn, so the query proves
        // that the image arrived.
        await map.waitForFeatures(
          map.center,
          (features) => features.length == 1,
          layerIds: ['symbols'],
        );
        await map.style.layers.remove('symbols');
      }
      await map.style.removeImage('marker');
      await map.style.removeImage('marker');
    });

    testWidgets('reports the attributions of its sources', (tester) async {
      final map = await pumpMap(tester);
      expect(map.style.attributions, isEmpty);
      await map.style.sources.add(
        const RasterSource.tiles(
          id: 'src',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          attribution: '© Test Data',
        ),
      );
      await map.style.layers.add(RasterStyleLayer(id: 'r', sourceId: 'src'));
      await map.pumpUntil(
        () => map.style.attributions.contains('© Test Data'),
        reason: () => 'attributions: ${map.style.attributions}',
      );
      expect(map.style.attributions, ['© Test Data']);

      await map.style.layers.remove('r');
      await map.style.sources.remove('src');
      await map.pumpUntil(
        () => map.style.attributions.isEmpty,
        reason: () => 'attributions: ${map.style.attributions}',
      );
    });

    testWidgets('updates SourceAttribution when attributions change', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        children: const [
          SourceAttribution(showMapLibre: false, keepExpanded: true),
        ],
      );
      bool shown(String text) => find
          .byWidgetPredicate(
            (widget) =>
                widget is RichText && widget.text.toPlainText().contains(text),
          )
          .evaluate()
          .isNotEmpty;

      // The camera stays put, so only the attribution change rebuilds the
      // widget.
      await map.style.sources.add(
        const RasterSource.tiles(
          id: 'src',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          attribution: '© Widget Data',
        ),
      );
      await map.style.layers.add(RasterStyleLayer(id: 'r', sourceId: 'src'));
      await map.pumpUntil(
        () => shown('© Widget Data'),
        reason: () => 'attributions: ${map.style.attributions}',
      );

      await map.style.layers.remove('r');
      await map.style.sources.remove('src');
      await map.pumpUntil(
        () => !shown('© Widget Data'),
        reason: () => 'attributions: ${map.style.attributions}',
      );
    });

    testWidgets('reports the attributions of GeoJSON sources', (tester) async {
      final map = await pumpMap(
        tester,
        options: MapOptions(
          style: MapStyle.json(
            jsonEncode({
              'version': 8,
              'sources': {
                'style-points': {
                  'type': 'geojson',
                  'data': {'type': 'FeatureCollection', 'features': <Object>[]},
                  'attribution': '© Style Points',
                },
              },
              'layers': [
                {
                  'id': 'style-circles',
                  'type': 'circle',
                  'source': 'style-points',
                },
              ],
            }),
          ),
          initCamera: const InitialCamera.position(),
        ),
      );
      await map.pumpUntil(
        () => map.style.attributions.contains('© Style Points'),
        reason: () => 'attributions: ${map.style.attributions}',
      );

      await map.style.sources.add(
        const GeoJsonSource.data(
          id: 'points',
          data: '{"type":"FeatureCollection","features":[]}',
          attribution: '© Points',
        ),
      );
      await map.pumpUntil(
        () => map.style.attributions.contains('© Points'),
        reason: () => 'attributions: ${map.style.attributions}',
      );
      expect(
        map.style.attributions,
        unorderedEquals(['© Style Points', '© Points']),
      );

      await map.style.sources.remove('points');
      await map.pumpUntil(
        () => !map.style.attributions.contains('© Points'),
        reason: () => 'attributions: ${map.style.attributions}',
      );
    });

    testWidgets('rejects a layer whose source is missing', (tester) async {
      final map = await pumpMap(tester);
      await expectLater(
        map.style.layers.add(CircleStyleLayer(id: 'c', sourceId: 'none')),
        throwsA(anything),
      );
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
      ]);
    }, skip: kIsWeb);
  });
}

const _markerAsset = 'assets/images/marker.png';

/// A layer of an icon that hides the icons of the layers below it: symbols
/// are placed from the top layer down, and those that collide are not shown.
/// Which one the map shows tells the order of the layers, as feature queries
/// don't return layers in their order. Layers with the same layout share a
/// symbol placement on native, so each gets a slightly different size.
SymbolStyleLayer _icon(String id, String sourceId) => SymbolStyleLayer(
  id: id,
  sourceId: sourceId,
  iconImage: const .literal('marker'),
  iconSize: .literal(1 + (_iconLayers++) / 100),
);

var _iconLayers = 0;

Future<void> _waitForIconOf(TestMap map, String layerId) => map.waitForFeatures(
  map.center,
  (features) => features.length == 1 && features.single.layerId == layerId,
);

const _quad = LngLatQuad(
  bottomLeft: Geographic(lon: 0, lat: 0),
  bottomRight: Geographic(lon: 1, lat: 0),
  topLeft: Geographic(lon: 0, lat: 1),
  topRight: Geographic(lon: 1, lat: 1),
);

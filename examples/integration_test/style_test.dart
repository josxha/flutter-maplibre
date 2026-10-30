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
      expect(map.style.getLayerIds(), ['background']);
    });

    testWidgets('loads a style from an asset', (tester) async {
      final map = await pumpMap(
        tester,
        options: const MapOptions(
          style: MapStyle.asset('assets/styles/test_style.json'),
          initCamera: InitialCamera.position(zoom: 4),
        ),
      );
      expect(map.style.getLayerIds(), ['background', 'points']);
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
      expect(map.style.getLayerIds(), contains('countries-fill'));
    });

    testWidgets('adds layers at the requested position', (tester) async {
      final map = await pumpMap(tester);
      await map.style.addSource(GeoJsonSource(id: 'src', data: _pointData()));
      await map.style.addLayer(
        const CircleStyleLayer(id: 'top', sourceId: 'src'),
      );
      await map.style.addLayer(
        const CircleStyleLayer(id: 'below-top', sourceId: 'src'),
        belowLayerId: 'top',
      );
      expect(map.style.getLayerIds(), ['background', 'below-top', 'top']);
      if (!kIsWeb) {
        await map.style.addLayer(
          const CircleStyleLayer(id: 'above-bg', sourceId: 'src'),
          aboveLayerId: 'background',
        );
        await map.style.addLayer(
          const CircleStyleLayer(id: 'first', sourceId: 'src'),
          atIndex: 0,
        );
        expect(map.style.getLayerIds(), [
          'first',
          'background',
          'above-bg',
          'below-top',
          'top',
        ]);
      }
    });

    testWidgets('adds and removes every kind of layer', (tester) async {
      final map = await pumpMap(tester);
      await map.style.addSource(GeoJsonSource(id: 'src', data: _pointData()));
      await map.style.addSource(
        const RasterDemSource(
          id: 'dem',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          tileSize: 256,
        ),
      );
      await map.style.addSource(
        const RasterSource(
          id: 'raster',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          tileSize: 256,
        ),
      );
      const layers = <StyleLayer>[
        BackgroundStyleLayer(id: 'l-background', color: Colors.black),
        CircleStyleLayer(id: 'l-circle', sourceId: 'src'),
        FillStyleLayer(id: 'l-fill', sourceId: 'src'),
        FillExtrusionStyleLayer(id: 'l-fill-extrusion', sourceId: 'src'),
        HeatmapStyleLayer(id: 'l-heatmap', sourceId: 'src'),
        HillshadeStyleLayer(id: 'l-hillshade', sourceId: 'dem'),
        LineStyleLayer(id: 'l-line', sourceId: 'src'),
        RasterStyleLayer(id: 'l-raster', sourceId: 'raster'),
        SymbolStyleLayer(id: 'l-symbol', sourceId: 'src'),
      ];
      for (final layer in layers) {
        await map.style.addLayer(layer);
      }
      expect(map.style.getLayerIds(), [
        'background',
        ...layers.map((layer) => layer.id),
      ]);
      for (final layer in layers) {
        await map.style.removeLayer(layer.id);
      }
      expect(map.style.getLayerIds(), ['background']);
      // Removing what is not there is not an error.
      await map.style.removeLayer('missing');
      await map.style.removeSource('missing');
    });

    testWidgets('adds and removes every kind of source', (tester) async {
      final map = await pumpMap(tester);
      final markerBytes = (await rootBundle.load(_markerAsset)).buffer
          .asUint8List();
      final sources = <Source>[
        GeoJsonSource(id: 'geojson', data: _pointData()),
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
        const RasterSource(
          id: 'raster',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
        ),
        const RasterDemSource(
          id: 'raster-dem',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
        ),
        const VectorSource(
          id: 'vector',
          tiles: ['https://example.invalid/{z}/{x}/{y}.pbf'],
        ),
      ];
      for (final source in sources) {
        await map.style.addSource(source);
        // A layer can only be added on a source that exists.
        await map.style.addLayer(switch (source) {
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
        expect(map.style.getLayerIds(), ['background', 'on']);
        await map.style.removeLayer('on');
      }
      for (final source in sources) {
        await map.style.removeSource(source.id);
      }
      // Every ID is free again.
      await map.style.addSource(
        GeoJsonSource(id: 'geojson', data: _pointData()),
      );
    });

    testWidgets('fails to add an image source of a missing asset', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      await expectLater(
        map.style.addSource(
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
      await map.style.addSource(GeoJsonSource(id: 'src', data: _pointData()));
      await map.style.addLayer(
        const CircleStyleLayer(
          id: 'circles',
          sourceId: 'src',
          paint: {'circle-radius': 10},
        ),
      );
      await map.waitForFeatures(map.center, (features) => features.length == 1);

      const moved = Geographic(lon: 0.5, lat: 0.5);
      await map.style.updateGeoJsonSource(id: 'src', data: _pointData(moved));
      await map.waitForFeatures(map.center, (features) => features.isEmpty);
      await map.waitForFeatures(
        map.controller.toScreenLocation(moved),
        (features) => features.length == 1,
      );
    });

    testWidgets('reads and updates the paint of a line layer', (tester) async {
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
      List<Object> gradient(double progress) => [
        'step',
        ['line-progress'],
        '#ff0000',
        progress,
        'rgba(0, 0, 0, 0)',
      ];
      await map.style.addSource(
        GeoJsonSource(id: 'src', data: line(0), lineMetrics: true),
      );
      await map.style.addLayer(
        LineStyleLayer(
          id: 'line',
          sourceId: 'src',
          paint: {'line-width': 10, 'line-gradient': gradient(0.25)},
        ),
      );
      // Tiles clip a line with line metrics into one feature each.
      await map.waitForFeatures(map.center, (features) => features.isNotEmpty);

      // Platforms may read colors back in another notation, such as
      // ['rgba', 255, 0, 0, 1] on MapLibre Native, so compare the stop only.
      void expectStep(List<Object>? actual, double progress) {
        expect(actual, hasLength(5));
        expect(actual!.take(2), [
          'step',
          ['line-progress'],
        ]);
        expect(actual[3], progress);
      }

      final layer = await map.style.getLineLayer('line');
      expect(layer, isNotNull);
      expectStep(layer!.lineGradient, 0.25);

      layer.lineGradient = gradient(0.75);
      expect(layer.lineGradient, gradient(0.75));
      final reread = await map.style.getLineLayer('line');
      expectStep(reread!.lineGradient, 0.75);

      // Data for a source with line metrics is prepared with them.
      await map.style.updateGeoJsonSource(id: 'src', data: line(0.5));
      await map.waitForFeatures(
        map.controller.toScreenLocation(const Geographic(lon: -0.75, lat: 0)),
        (features) => features.isEmpty,
      );

      expect(await map.style.getLineLayer('missing'), isNull);
      expect(await map.style.getLineLayer('background'), isNull);
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
      await map.style.addSource(GeoJsonSource(id: 'src', data: _pointData()));
      for (final image in ['marker', 'marker-2', 'icon', 'widget']) {
        await map.style.addLayer(
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
        await map.style.removeLayer('symbols');
      }
      await map.style.removeImage('marker');
      await map.style.removeImage('marker');
    });

    testWidgets('reports the attributions of its sources', (tester) async {
      final map = await pumpMap(tester);
      expect(map.style.attributions, isEmpty);
      await map.style.addSource(
        const RasterSource(
          id: 'src',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          attribution: '© Test Data',
        ),
      );
      await map.style.addLayer(
        const RasterStyleLayer(id: 'r', sourceId: 'src'),
      );
      await map.pumpUntil(
        () => map.style.attributions.contains('© Test Data'),
        reason: () => 'attributions: ${map.style.attributions}',
      );
      expect(map.style.attributions, ['© Test Data']);

      await map.style.removeLayer('r');
      await map.style.removeSource('src');
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
      await map.style.addSource(
        const RasterSource(
          id: 'src',
          tiles: ['https://example.invalid/{z}/{x}/{y}.png'],
          attribution: '© Widget Data',
        ),
      );
      await map.style.addLayer(
        const RasterStyleLayer(id: 'r', sourceId: 'src'),
      );
      await map.pumpUntil(
        () => shown('© Widget Data'),
        reason: () => 'attributions: ${map.style.attributions}',
      );

      await map.style.removeLayer('r');
      await map.style.removeSource('src');
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

      await map.style.addSource(
        const GeoJsonSource(
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

      await map.style.removeSource('points');
      await map.pumpUntil(
        () => !map.style.attributions.contains('© Points'),
        reason: () => 'attributions: ${map.style.attributions}',
      );
    });

    testWidgets('rejects a layer whose source is missing', (tester) async {
      final map = await pumpMap(tester);
      await expectLater(
        map.style.addLayer(const CircleStyleLayer(id: 'c', sourceId: 'none')),
        throwsA(anything),
      );
      expect(map.style.getLayerIds(), ['background']);
    }, skip: kIsWeb);
  });
}

const _markerAsset = 'assets/images/marker.png';

const _quad = LngLatQuad(
  bottomLeft: Geographic(lon: 0, lat: 0),
  bottomRight: Geographic(lon: 1, lat: 0),
  topLeft: Geographic(lon: 0, lat: 1),
  topRight: Geographic(lon: 1, lat: 1),
);

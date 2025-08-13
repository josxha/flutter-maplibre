import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('controller', () {
    testWidgets('getCamera', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final events = <MapEvent>[];
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
        onEvent: events.add,
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      events.clear();
      await ctrl.moveCamera(
        center: Position(1, 1),
        bearing: 1,
        zoom: 1,
        pitch: 1,
      );
      await tester.pumpAndSettle();

      final camera = ctrl.getCamera();
      expect(camera.center.lng, closeTo(1, 0.00001));
      expect(camera.center.lat, closeTo(1, 0.00001));
      expect(camera.zoom, closeTo(1, 0.00001));
      expect(camera.bearing, closeTo(1, 0.00001));
      expect(camera.pitch, closeTo(1, 0.00001));

      expect(events[events.length - 3], isA<MapEventStartMoveCamera>());
      expect(events[events.length - 2], isA<MapEventMoveCamera>());
      expect(events[events.length - 1], isA<MapEventCameraIdle>());
    });

    testWidgets('toScreenLocation', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final offset = await ctrl.toScreenLocation(Position(1, 2));
      // Different devices have different screen sizes.
      expect(offset.dx, greaterThanOrEqualTo(0));
      expect(offset.dy, greaterThanOrEqualTo(0));
    });

    testWidgets('toScreenLocations', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final offsets = await ctrl.toScreenLocations([
        Position(1, 2),
        Position(43.5, -23),
      ]);
      // Different devices have different screen sizes.
      expect(offsets[0].dx, greaterThanOrEqualTo(0));
      expect(offsets[0].dy, greaterThanOrEqualTo(0));
      expect(offsets[1].dx, greaterThanOrEqualTo(0));
      expect(offsets[1].dy, greaterThanOrEqualTo(0));
    });

    testWidgets('toLngLat', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final lngLat = await ctrl.toLngLat(Offset.zero);
      // Different devices have different screen sizes.
      expect(lngLat.lng, isNot(equals(0)));
      expect(lngLat.lat, isNot(equals(0)));
    });

    testWidgets('toLnLats', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final lngLats = await ctrl.toLngLats([
        const Offset(23, 53),
        const Offset(23.3, 53.5),
      ]);
      // Different devices have different screen sizes.
      expect(lngLats[0].lng, isNot(equals(0)));
      expect(lngLats[0].lat, isNot(equals(0)));
      expect(lngLats[1].lng, isNot(equals(0)));
      expect(lngLats[1].lat, isNot(equals(0)));
    });

    testWidgets('getMetersPerPixelAtLatitude', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2), initZoom: 10),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final meters = await ctrl.getMetersPerPixelAtLatitude(2.34);
      expect(meters, closeTo(76.37, 0.1));
    });

    testWidgets('getVisibleRegion', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(0, 0), initZoom: 10),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final region = await ctrl.getVisibleRegion();
      // testing devices have different screen sizes
      expect(region.longitudeWest, lessThan(0));
      expect(region.longitudeEast, greaterThan(0));
      expect(region.latitudeNorth, greaterThan(0));
      expect(region.latitudeSouth, lessThan(0));

      expect(region.longitudeWest, greaterThan(-10));
      expect(region.longitudeEast, lessThan(10));
      expect(region.latitudeNorth, lessThan(10));
      expect(region.latitudeSouth, greaterThan(-10));
    });

    testWidgets('removeLayer', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(0, 0), initZoom: 10),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      // ensure no crash if a layer does not exist
      await ctrl.style?.removeLayer('notExisting');

      const layer = RasterStyleLayer(id: 'rasterLayer', sourceId: 'source');
      await ctrl.style?.addLayer(layer);
      await ctrl.style?.removeLayer(layer.id);
    });

    testWidgets('removeSource', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(0, 0), initZoom: 10),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;

      // ensure no crash if a source does not exist
      await ctrl.style?.removeSource('notExisting');

      const source = GeoJsonSource(id: 'source', data: '{}');
      await ctrl.style?.addSource(source);
      await ctrl.style?.removeSource(source.id);
    });

    testWidgets('updateGeoJsonSource', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(0, 0), initZoom: 10),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;

      const source = GeoJsonSource(id: '1', data: '{}');
      await ctrl.style?.addSource(source);
      await ctrl.style?.updateGeoJsonSource(
        id: source.id,
        data: jsonEncode(
          GeometryCollection(
            geometries: [Point(coordinates: Position(0, 0))],
          ).toJson(),
        ),
      );
    });

    group('feature queries', () {
      testWidgets('queryLayers', (tester) async {
        final ctrlCompleter = Completer<MapController>();
        final styleCompleter = Completer<void>();
        final app = App(
          onMapCreated: ctrlCompleter.complete,
          onStyleLoaded: styleCompleter.complete,
          options: MapOptions(initCenter: Position(0, 0), initZoom: 10),
        );
        await tester.pumpWidget(app);
        final ctrl = await ctrlCompleter.future;
        await styleCompleter.future;
        final size = tester.getSize(find.byType(MapLibreMap));

        var layers = await ctrl.queryLayers(Offset(size.width, size.height));
        expect(layers, hasLength(0));

        layers = await ctrl.queryLayers(Offset.zero);
        expect(layers, hasLength(0));
      });

      testWidgets('featuresAtPoint', (tester) async {
        final ctrlCompleter = Completer<MapController>();
        final styleCompleter = Completer<StyleController>();
        await tester.pumpWidget(
          App(
            onMapCreated: ctrlCompleter.complete,
            onStyleLoaded: styleCompleter.complete,
            options: MapOptions(
              initCenter: Position(0.1, 0.1),
              initZoom: 10,
            ),
          ),
        );
        final ctrl = await ctrlCompleter.future;
        final style = await styleCompleter.future;
        const pointSourceId = 'point_source';
        await style.addSource(
          GeoJsonSource(
            id: pointSourceId,
            data: jsonEncode(
              FeatureCollection(
                features: [
                  Feature(
                    geometry: Point(coordinates: Position(0.1, 0.1)),
                    id: 1,
                    properties: {'foo': 'bar'},
                  ),
                ],
              ).toJson(),
            ),
          ),
        );
        const pointLayerId = 'point_layer';
        await style.addLayer(
          const CircleStyleLayer(
            id: pointLayerId,
            sourceId: pointSourceId,
            paint: {'circle-radius': 5, 'circle-color': '#FF0000'},
          ),
        );
        const polygonSourceId = 'polygon_source';
        await style.addSource(
          GeoJsonSource(
            id: polygonSourceId,
            data: jsonEncode(
              FeatureCollection(
                features: [
                  Feature(
                    geometry: Polygon(
                      coordinates: [
                        [
                          Position(0.09, 0.09),
                          Position(0.11, 0.09),
                          Position(0.11, 0.11),
                          Position(0.09, 0.11),
                          Position(0.09, 0.09),
                        ],
                      ],
                    ),
                    id: 2,
                    properties: {'poly': 'gon'},
                  ),
                ],
              ).toJson(),
            ),
          ),
        );
        const polygonLayerId = 'polygon_layer';
        await style.addLayer(
          const FillStyleLayer(
            id: polygonLayerId,
            sourceId: polygonSourceId,
            paint: {'fill-color': '#00FF00'},
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        final size = tester.getSize(find.byType(MapLibreMap));
        final centerScreen = Offset(size.width / 2, size.height / 2);
        var features = await ctrl.featuresAtPoint(Offset.zero);
        expect(features, isEmpty);
        features = await ctrl.featuresAtPoint(centerScreen);
        expect(features, hasLength(2));
        final pointFeature = features.firstWhere(
          (f) => f.id == 1 || f.id == '1',
        );
        expect(pointFeature.properties['foo'], 'bar');

        final polygonFeature = features.firstWhere(
          (f) => f.id == 2 || f.id == '2',
        );
        expect(polygonFeature.properties['poly'], 'gon');

        features = await ctrl.featuresAtPoint(
          centerScreen,
          layerIds: [pointLayerId],
        );
        expect(features, hasLength(1));
        expect(features.first.id, isIn([1, '1']));
        expect(features.first.properties['foo'], 'bar');
        features = await ctrl.featuresAtPoint(
          centerScreen,
          layerIds: [polygonLayerId],
        );
        expect(features, hasLength(1));
        expect(features.first.id, isIn([2, '2']));
        expect(features.first.properties['poly'], 'gon');
        const pointLayer2Id = 'point_layer_2';
        await style.addLayer(
          const CircleStyleLayer(
            id: pointLayer2Id,
            sourceId: pointSourceId,
            paint: {'circle-radius': 5, 'circle-color': '#FF00FF'},
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        features = await ctrl.featuresAtPoint(centerScreen);
        expect(features, hasLength(3));
        features = await ctrl.featuresAtPoint(
          centerScreen,
          layerIds: [pointLayerId, pointLayer2Id],
        );
        expect(features, hasLength(2));
        features = await ctrl.featuresAtPoint(
          centerScreen,
          layerIds: [],
        );
        expect(features, isEmpty);
      });

      testWidgets('featuresInRect', (tester) async {
        final ctrlCompleter = Completer<MapController>();
        final styleCompleter = Completer<StyleController>();
        await tester.pumpWidget(
          App(
            onMapCreated: ctrlCompleter.complete,
            onStyleLoaded: styleCompleter.complete,
            options: MapOptions(
              initCenter: Position(0.1, 0.1),
              initZoom: 10,
            ),
          ),
        );
        final ctrl = await ctrlCompleter.future;
        final style = await styleCompleter.future;
        const pointSourceId = 'point_source';
        await style.addSource(
          GeoJsonSource(
            id: pointSourceId,
            data: jsonEncode(
              FeatureCollection(
                features: [
                  Feature(
                    geometry: Point(coordinates: Position(0.1, 0.1)),
                    id: 1,
                    properties: {'foo': 'bar'},
                  ),
                ],
              ).toJson(),
            ),
          ),
        );
        const pointLayerId = 'point_layer';
        await style.addLayer(
          const CircleStyleLayer(
            id: pointLayerId,
            sourceId: pointSourceId,
            paint: {'circle-radius': 5, 'circle-color': '#FF0000'},
          ),
        );
        const lineSourceId = 'line_source';
        await style.addSource(
          GeoJsonSource(
            id: lineSourceId,
            data: jsonEncode(
              FeatureCollection(
                features: [
                  Feature(
                    geometry: LineString(
                      coordinates: [Position(0.09, 0.11), Position(0.11, 0.11)],
                    ),
                    id: 2,
                    properties: {'line': 'string'},
                  ),
                ],
              ).toJson(),
            ),
          ),
        );
        const lineLayerId = 'line_layer';
        await style.addLayer(
          const LineStyleLayer(
            id: lineLayerId,
            sourceId: lineSourceId,
            paint: {
              'line-color': '#0000FF',
              'line-width': 5,
            },
          ),
        );
        const polygonSourceId = 'polygon_source';
        await style.addSource(
          GeoJsonSource(
            id: polygonSourceId,
            data: jsonEncode(
              FeatureCollection(
                features: [
                  Feature(
                    geometry: Polygon(
                      coordinates: [
                        [
                          Position(0.09, 0.09),
                          Position(0.11, 0.09),
                          Position(0.11, 0.11),
                          Position(0.09, 0.11),
                          Position(0.09, 0.09),
                        ],
                      ],
                    ),
                    id: 3,
                    properties: {'poly': 'gon'},
                  ),
                ],
              ).toJson(),
            ),
          ),
        );
        const polygonLayerId = 'polygon_layer';
        await style.addLayer(
          const FillStyleLayer(
            id: polygonLayerId,
            sourceId: polygonSourceId,
            paint: {'fill-color': '#00FF00'},
          ),
        );
        await tester.pump(const Duration(seconds: 1));
        final size = tester.getSize(find.byType(MapLibreMap));
        var features = await ctrl.featuresInRect(
          const Rect.fromLTWH(0, 0, 10, 10),
        );
        expect(features, isEmpty);
        final pointScreen = Offset(size.width / 2, size.height / 2);
        features = await ctrl.featuresInRect(
          Rect.fromCenter(center: pointScreen, width: 2, height: 2),
        );
        expect(features, hasLength(2));
        final pointFeature = features.firstWhere(
          (f) => f.id == 1 || f.id == '1',
        );
        expect(pointFeature.properties['foo'], 'bar');
        final polygonFeature = features.firstWhere(
          (f) => f.id == 3 || f.id == '3',
        );
        expect(polygonFeature.properties['poly'], 'gon');
        final lineStartScreen = await ctrl.toScreenLocation(
          Position(0.09, 0.11),
        );
        final lineEndScreen = await ctrl.toScreenLocation(Position(0.11, 0.11));
        features = await ctrl.featuresInRect(
          Rect.fromPoints(lineStartScreen, lineEndScreen),
        );
        // FIXME: blocked on https://github.com/josxha/flutter-maplibre/issues/317
        // expect(
        //   features.firstWhere((f) => f.id == 2 || f.id == '2').properties['line'],
        //   'string',
        // );
        features = await ctrl.featuresInRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
        );
        expect(features, hasLength(3));

        final pointFeature2 = features.firstWhere(
          (f) => f.id == 1 || f.id == '1',
        );
        expect(pointFeature2.properties['foo'], 'bar');

        final lineFeature = features.firstWhere(
          (f) => f.id == 2 || f.id == '2',
        );
        expect(lineFeature.properties['line'], 'string');

        final polygonFeature2 = features.firstWhere(
          (f) => f.id == 3 || f.id == '3',
        );
        expect(polygonFeature2.properties['poly'], 'gon');

        features = await ctrl.featuresInRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
          layerIds: [pointLayerId, lineLayerId],
        );
        expect(features, hasLength(2));

        final pointFeature3 = features.firstWhere(
          (f) => f.id == 1 || f.id == '1',
        );
        expect(pointFeature3.properties['foo'], 'bar');

        final lineFeature2 = features.firstWhere(
          (f) => f.id == 2 || f.id == '2',
        );
        expect(lineFeature2.properties['line'], 'string');
        features = await ctrl.featuresInRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
          layerIds: [],
        );
        expect(features, isEmpty);
      });
    });

    testWidgets('getAttributions', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final styleCompleter = Completer<StyleController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        onStyleLoaded: styleCompleter.complete,
        options: MapOptions(
          initCenter: Position(0, 0),
          initZoom: 10,
          initStyle: MapStyles.protomapsLight,
        ),
      );
      await tester.pumpWidget(app);
      final style = await styleCompleter.future;

      final attributions = await style.getAttributions();
      expect(attributions, hasLength(1));
      expect(attributions.first, contains('OpenStreetMap'));
    });

    testWidgets('moveCamera', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(onMapCreated: ctrlCompleter.complete);
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      await ctrl.moveCamera(
        center: Position(1, 2),
        bearing: 1,
        zoom: 1,
        pitch: 1,
      );
      await tester.pumpAndSettle();
      final camera = ctrl.getCamera();
      expect(camera.center.lng, closeTo(1, 0.00001));
      expect(camera.center.lat, closeTo(2, 0.00001));
      expect(camera.zoom, closeTo(1, 0.00001));
      expect(camera.bearing, closeTo(1, 0.00001));
      expect(camera.pitch, closeTo(1, 0.00001));
    });
  });

  testWidgets('add ImageSource', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    final source = ImageSource(
      id: '1',
      url:
          'https://raw.githubusercontent.com/josxha/flutter-maplibre/57396548693857a80083303f56aa83b4901dad48/docs/static/img/favicon-32x32.png',
      coordinates: LngLatQuad(
        bottomLeft: Position(0, 0),
        bottomRight: Position(1, 0),
        topLeft: Position(0, 1),
        topRight: Position(1, 1),
      ),
    );
    await ctrl.style?.addSource(source);
    await tester.pumpAndSettle();
  });

  testWidgets('add GeoJsonSource', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    final source = GeoJsonSource(
      id: '1',
      data: jsonEncode(
        GeometryCollection(
          geometries: [Point(coordinates: Position(12, 2))],
        ).toJson(),
      ),
    );
    await ctrl.style?.addSource(source);
    await tester.pumpAndSettle();
  });

  testWidgets('add VideoSource', (tester) async {
    if (!kIsWeb) return; // VideoSource is only supported on web.
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    final source = VideoSource(
      id: '1',
      coordinates: [Position(0, 0), Position(10, 10)],
      urls: [
        'https://file-examples.com/storage/fefd65c2506728a13a07e72/2017/04/file_example_MP4_480_1_5MG.mp4',
      ],
    );
    await ctrl.style?.addSource(source);
    await tester.pumpAndSettle();
  });

  testWidgets('add RasterDemSource', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const source = RasterDemSource(
      id: '1',
      url: 'https://demotiles.maplibre.org/terrain-tiles/tiles.json',
      tileSize: 256,
    );
    await ctrl.style?.addSource(source);
    await tester.pumpAndSettle();
  });

  testWidgets('add RasterSource', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const source = RasterSource(
      id: '1',
      tiles: ['https://tile.openstreetmap.org/{z}/{x}/{y}.png'],
      maxZoom: 20,
      tileSize: 256,
      attribution:
          '<a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    );
    await ctrl.style?.addSource(source);
    await tester.pumpAndSettle();
  });

  testWidgets('add VectorSource', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const source = VectorSource(
      id: '1',
      url: 'https://demotiles.maplibre.org/tiles/tiles.json',
    );
    await ctrl.style?.addSource(source);
    await tester.pumpAndSettle();
  });

  testWidgets('add BackgroundLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = BackgroundStyleLayer(id: '1', color: Colors.black);
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add FillLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = FillStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add CircleLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = CircleStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add FillExtrusionLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = FillExtrusionStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add HeatmapLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = HeatmapStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add HillshadeLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = HillshadeStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add LineLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = LineStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add RasterLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = RasterStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add SymbolLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = SymbolStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
  testWidgets('add unknown Layer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = SymbolStyleLayer(id: '1', sourceId: 'source1');
    await ctrl.style?.addLayer(layer);
    await tester.pumpAndSettle();
  });
}

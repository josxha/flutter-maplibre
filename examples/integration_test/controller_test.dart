import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('controller', () {
    testWidgets('getCamera', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final events = <MapEvent>[];
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: const MapOptions(
          initCenter: Geographic(lon: 1, lat: 2),
          initZoom: 5,
        ),
        onEvent: events.add,
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      events.clear();
      await ctrl.moveCamera(
        center: const Geographic(lon: 1, lat: 1),
        bearing: 1,
        zoom: 5,
        pitch: 1,
      );
      await tester.pumpAndSettle();

      final camera = ctrl.getCamera();
      expect(camera.center.lon, closeTo(1, 0.00001));
      expect(camera.center.lat, closeTo(1, 0.00001));
      expect(camera.zoom, closeTo(1, 0.00001));
      expect(camera.bearing, closeTo(1, 0.00001));
      expect(camera.pitch, closeTo(1, 0.00001));

      /*expect(events[events.length - 3], isA<MapEventStartMoveCamera>());
      expect(events[events.length - 2], isA<MapEventMoveCamera>());
      expect(events[events.length - 1], isA<MapEventCameraIdle>());*/
    });

    testWidgets('toScreenLocation', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: const MapOptions(initCenter: Geographic(lon: 1, lat: 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final size = tester.getSize(find.byType(MapLibreMap));

      final region = ctrl.getVisibleRegion();

      var offset = ctrl.toScreenLocation(
        Geographic(lon: region.longitudeWest, lat: region.latitudeNorth),
      );
      expect(offset.dx, closeTo(0, 1));
      expect(offset.dy, closeTo(0, 1));

      offset = ctrl.toScreenLocation(
        Geographic(lon: region.longitudeEast, lat: region.latitudeNorth),
      );
      expect(offset.dx, closeTo(size.width, 1));
      expect(offset.dy, closeTo(0, 1));

      offset = ctrl.toScreenLocation(
        Geographic(lon: region.longitudeWest, lat: region.latitudeSouth),
      );
      expect(offset.dx, closeTo(0, 1));
      expect(offset.dy, closeTo(size.height, 1));

      offset = ctrl.toScreenLocation(
        Geographic(lon: region.longitudeEast, lat: region.latitudeSouth),
      );
      expect(offset.dx, closeTo(size.width, 1));
      expect(offset.dy, closeTo(size.height, 1));
    });

    testWidgets('toScreenLocations', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: const MapOptions(initCenter: Geographic(lon: 1, lat: 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final size = tester.getSize(find.byType(MapLibreMap));
      final region = ctrl.getVisibleRegion();
      final positions = [
        Geographic(lon: region.longitudeWest, lat: region.latitudeNorth),
        Geographic(lon: region.longitudeEast, lat: region.latitudeNorth),
        Geographic(lon: region.longitudeWest, lat: region.latitudeSouth),
        Geographic(lon: region.longitudeEast, lat: region.latitudeSouth),
      ];
      final offsets = ctrl.toScreenLocations(positions);

      expect(offsets[0].dx, closeTo(0, 1));
      expect(offsets[0].dy, closeTo(0, 1));

      expect(offsets[1].dx, closeTo(size.width, 1));
      expect(offsets[1].dy, closeTo(0, 1));

      expect(offsets[2].dx, closeTo(0, 1));
      expect(offsets[2].dy, closeTo(size.height, 1));

      expect(offsets[3].dx, closeTo(size.width, 1));
      expect(offsets[3].dy, closeTo(size.height, 1));
    });

    testWidgets('toLngLat', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: const MapOptions(initCenter: Geographic(lon: 1, lat: 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final size = tester.getSize(find.byType(MapLibreMap));
      final region = ctrl.getVisibleRegion();

      var lngLat = ctrl.toLngLat(Offset.zero);
      expect(lngLat.lon, closeTo(region.longitudeWest, 0.00001));
      expect(lngLat.lat, closeTo(region.latitudeNorth, 0.00001));

      lngLat = ctrl.toLngLat(Offset(size.width, 0));
      expect(lngLat.lon, closeTo(region.longitudeEast, 0.00001));
      expect(lngLat.lat, closeTo(region.latitudeNorth, 0.00001));

      lngLat = ctrl.toLngLat(Offset(0, size.height));
      expect(lngLat.lon, closeTo(region.longitudeWest, 0.00001));
      expect(lngLat.lat, closeTo(region.latitudeSouth, 0.00001));

      lngLat = ctrl.toLngLat(Offset(size.width, size.height));
      expect(lngLat.lon, closeTo(region.longitudeEast, 0.00001));
      expect(lngLat.lat, closeTo(region.latitudeSouth, 0.00001));
    });

    testWidgets('toLngLats', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: const MapOptions(initCenter: Geographic(lon: 1, lat: 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final size = tester.getSize(find.byType(MapLibreMap));
      final region = ctrl.getVisibleRegion();
      final offsets = [
        Offset.zero,
        Offset(size.width, 0),
        Offset(0, size.height),
        Offset(size.width, size.height),
      ];
      final lngLats = ctrl.toLngLats(offsets);

      expect(lngLats[0].lon, closeTo(region.longitudeWest, 0.00001));
      expect(lngLats[0].lat, closeTo(region.latitudeNorth, 0.00001));

      expect(lngLats[1].lon, closeTo(region.longitudeEast, 0.00001));
      expect(lngLats[1].lat, closeTo(region.latitudeNorth, 0.00001));

      expect(lngLats[2].lon, closeTo(region.longitudeWest, 0.00001));
      expect(lngLats[2].lat, closeTo(region.latitudeSouth, 0.00001));

      expect(lngLats[3].lon, closeTo(region.longitudeEast, 0.00001));
      expect(lngLats[3].lat, closeTo(region.latitudeSouth, 0.00001));
    });

    testWidgets('getMetersPerPixelAtLatitude', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: const MapOptions(
          initCenter: Geographic(lon: 111.6513, lat: 35.1983),
          initZoom: 14,
        ),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final size = tester.getSize(find.byType(MapLibreMap));
      final pos0 = ctrl.toLngLat(Offset(0, size.height / 4));
      final pos1 = ctrl.toLngLat(Offset(100, size.height / 4));
      final meters = ctrl.getMetersPerPixelAtLatitude(pos0.lat);
      final actual =
          6371000 *
          (pos0.lon - pos1.lon).abs() *
          pi /
          180 *
          cos(pos0.lat * pi / 180);
      expect(meters * 100, closeTo(actual, 1));
    });

    testWidgets('getVisibleRegion', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: const MapOptions(
          initCenter: Geographic(lon: 0, lat: 0),
          initZoom: 10,
        ),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final region = ctrl.getVisibleRegion();
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
        options: const MapOptions(
          initCenter: Geographic(lon: 0, lat: 0),
          initZoom: 10,
        ),
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
        options: const MapOptions(
          initCenter: Geographic(lon: 0, lat: 0),
          initZoom: 10,
        ),
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
        options: const MapOptions(
          initCenter: Geographic(lon: 0, lat: 0),
          initZoom: 10,
        ),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;

      const source = GeoJsonSource(id: '1', data: '{}');
      await ctrl.style?.addSource(source);
      await ctrl.style?.updateGeoJsonSource(
        id: source.id,
        data: GeometryCollection(const [
          Point(Geographic(lon: 0, lat: 0)),
        ]).toText(),
      );
    });

    group('feature queries', () {
      testWidgets('queryLayers GeoJSON', (tester) async {
        final ctrlCompleter = Completer<MapController>();
        final styleCompleter = Completer<StyleController>();
        await tester.pumpWidget(
          App(
            onMapCreated: ctrlCompleter.complete,
            onStyleLoaded: styleCompleter.complete,
            options: const MapOptions(
              initCenter: Geographic(lon: 0.1, lat: 0.1),
              initZoom: 14,
            ),
          ),
        );
        final ctrl = await ctrlCompleter.future;
        final style = await styleCompleter.future;
        await tester.pumpAndSettle(const Duration(seconds: 2));

        const pointSourceId = 'point_source';
        await style.addSource(
          GeoJsonSource(
            id: pointSourceId,
            data: FeatureCollection(const [
              Feature(
                geometry: Point(Geographic(lon: 0.1, lat: 0.1)),
                id: 1,
                properties: {'foo': 'bar'},
              ),
            ]).toText(),
          ),
        );
        const pointLayerId = 'point_layer';
        await style.addLayer(
          const CircleStyleLayer(
            id: pointLayerId,
            sourceId: pointSourceId,
            paint: {'circle-radius': 10, 'circle-color': '#FF0000'},
          ),
        );
        const expectedPoint = QueriedLayer(
          layerId: pointLayerId,
          sourceId: pointSourceId,
          sourceLayer: null,
        );
        await tester.pumpAndSettle(const Duration(seconds: 2));

        final size = tester.getSize(find.byType(MapLibreMap));
        final centerScreen = Offset(size.width / 2, size.height / 2);

        var layers = ctrl.queryLayers(Offset.zero);
        expect(layers, isEmpty);

        layers = ctrl.queryLayers(centerScreen);
        expect(layers, hasLength(1));
        expect(layers.first, expectedPoint);

        const polygonSourceId = 'polygon_source';
        await style.addSource(
          GeoJsonSource(
            id: polygonSourceId,
            data: FeatureCollection([
              Feature(
                id: 2,
                geometry: Polygon.from(const [
                  [
                    Geographic(lon: 0.09, lat: 0.09),
                    Geographic(lon: 0.11, lat: 0.09),
                    Geographic(lon: 0.11, lat: 0.11),
                    Geographic(lon: 0.09, lat: 0.11),
                    Geographic(lon: 0.09, lat: 0.09),
                  ],
                ]),
              ),
            ]).toText(),
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
        const expectedPolygon = QueriedLayer(
          layerId: polygonLayerId,
          sourceId: polygonSourceId,
          sourceLayer: null,
        );

        await tester.pumpAndSettle(const Duration(seconds: 2));

        layers = ctrl.queryLayers(centerScreen);
        expect(layers, hasLength(2));
        expect(layers, containsAll([expectedPoint, expectedPolygon]));
      });

      testWidgets('queryLayers MVT', (tester) async {
        final ctrlCompleter = Completer<MapController>();
        final styleCompleter = Completer<StyleController>();
        await tester.pumpWidget(
          App(
            onMapCreated: ctrlCompleter.complete,
            onStyleLoaded: styleCompleter.complete,
            options: MapOptions(
              initCenter: const Geographic(lon: 0.1, lat: 0.1),
              initZoom: 14,
              initStyle: MapStyles.openMapTilesStreets.uri,
            ),
          ),
        );
        final ctrl = await ctrlCompleter.future;
        await styleCompleter.future;
        await tester.pumpAndSettle(const Duration(seconds: 2));

        const oceanExpected = QueriedLayer(
          layerId: 'Water',
          sourceId: 'maptiler_planet',
          sourceLayer: 'water',
        );
        final layers = ctrl.queryLayers(Offset.zero);
        expect(layers, hasLength(1));
        expect(layers.first, oceanExpected);
      });

      testWidgets('featuresAtPoint', (tester) async {
        final ctrlCompleter = Completer<MapController>();
        final styleCompleter = Completer<StyleController>();
        await tester.pumpWidget(
          App(
            onMapCreated: ctrlCompleter.complete,
            onStyleLoaded: styleCompleter.complete,
            options: const MapOptions(
              initCenter: Geographic(lon: 0.1, lat: 0.1),
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
            data: FeatureCollection(const [
              Feature(
                geometry: Point(Geographic(lon: 0.1, lat: 0.1)),
                id: 1,
                properties: {'foo': 'bar'},
              ),
            ]).toText(),
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
            data: FeatureCollection([
              Feature(
                geometry: Polygon.from(const [
                  [
                    Geographic(lon: 0.09, lat: 0.09),
                    Geographic(lon: 0.11, lat: 0.09),
                    Geographic(lon: 0.11, lat: 0.11),
                    Geographic(lon: 0.09, lat: 0.11),
                    Geographic(lon: 0.09, lat: 0.09),
                  ],
                ]),
                id: 2,
                properties: const {'poly': 'gon'},
              ),
            ]).toText(),
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
        var features = ctrl.featuresAtPoint(Offset.zero);
        expect(features, isEmpty);
        features = ctrl.featuresAtPoint(centerScreen);
        expect(features, hasLength(2));
        final pointFeature = features.firstWhere(
          (f) => f.id == 1 || f.id == '1',
        );
        expect(pointFeature.properties['foo'], 'bar');

        final polygonFeature = features.firstWhere(
          (f) => f.id == 2 || f.id == '2',
        );
        expect(polygonFeature.properties['poly'], 'gon');

        features = ctrl.featuresAtPoint(centerScreen, layerIds: [pointLayerId]);
        expect(features, hasLength(1));
        expect(features.first.id, isIn([1, '1']));
        expect(features.first.properties['foo'], 'bar');
        features = ctrl.featuresAtPoint(
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
        features = ctrl.featuresAtPoint(centerScreen);
        expect(features, hasLength(3));
        features = ctrl.featuresAtPoint(
          centerScreen,
          layerIds: [pointLayerId, pointLayer2Id],
        );
        expect(features, hasLength(2));
        features = ctrl.featuresAtPoint(centerScreen, layerIds: []);
        expect(features, isEmpty);
      });

      testWidgets('featuresInRect', (tester) async {
        final ctrlCompleter = Completer<MapController>();
        final styleCompleter = Completer<StyleController>();
        await tester.pumpWidget(
          App(
            onMapCreated: ctrlCompleter.complete,
            onStyleLoaded: styleCompleter.complete,
            options: const MapOptions(
              initCenter: Geographic(lon: 0.1, lat: 0.1),
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
            data: FeatureCollection(const [
              Feature(
                geometry: Point(Geographic(lon: 0.1, lat: 0.1)),
                id: 1,
                properties: {'foo': 'bar'},
              ),
            ]).toText(),
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
            data: FeatureCollection([
              Feature(
                geometry: LineString.from(const [
                  Geographic(lon: 0.09, lat: 0.11),
                  Geographic(lon: 0.11, lat: 0.11),
                ]),
                id: 2,
                properties: const {'line': 'string'},
              ),
            ]).toText(),
          ),
        );
        const lineLayerId = 'line_layer';
        await style.addLayer(
          const LineStyleLayer(
            id: lineLayerId,
            sourceId: lineSourceId,
            paint: {'line-color': '#0000FF', 'line-width': 5},
          ),
        );
        const polygonSourceId = 'polygon_source';
        await style.addSource(
          GeoJsonSource(
            id: polygonSourceId,
            data: FeatureCollection([
              Feature(
                geometry: Polygon.from(const [
                  [
                    Geographic(lon: 0.09, lat: 0.09),
                    Geographic(lon: 0.11, lat: 0.09),
                    Geographic(lon: 0.11, lat: 0.11),
                    Geographic(lon: 0.09, lat: 0.11),
                    Geographic(lon: 0.09, lat: 0.09),
                  ],
                ]),
                id: 3,
                properties: const {'poly': 'gon'},
              ),
            ]).toText(),
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
        var features = ctrl.featuresInRect(const Rect.fromLTWH(0, 0, 10, 10));
        expect(features, isEmpty);
        final pointScreen = Offset(size.width / 2, size.height / 2);
        features = ctrl.featuresInRect(
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
        final lineStartScreen = ctrl.toScreenLocation(
          const Geographic(lon: 0.09, lat: 0.11),
        );
        final lineEndScreen = ctrl.toScreenLocation(
          const Geographic(lon: 0.11, lat: 0.11),
        );
        features = ctrl.featuresInRect(
          Rect.fromPoints(lineStartScreen, lineEndScreen),
        );
        // FIXME: blocked on https://github.com/josxha/flutter-maplibre/issues/317
        // expect(
        //   features.firstWhere((f) => f.id == 2 || f.id == '2').properties['line'],
        //   'string',
        // );
        features = ctrl.featuresInRect(
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

        features = ctrl.featuresInRect(
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
        features = ctrl.featuresInRect(
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
          initCenter: const Geographic(lon: 0, lat: 0),
          initZoom: 10,
          initStyle: MapStyles.protomapsLight.uri,
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
        center: const Geographic(lon: 1, lat: 2),
        bearing: 1,
        zoom: 1,
        pitch: 1,
      );
      await tester.pumpAndSettle();
      final camera = ctrl.getCamera();
      expect(camera.center.lon, closeTo(1, 0.00001));
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
    const source = ImageSource(
      id: '1',
      url:
          'https://raw.githubusercontent.com/josxha/flutter-maplibre/57396548693857a80083303f56aa83b4901dad48/docs/static/img/favicon-32x32.png',
      coordinates: LngLatQuad(
        bottomLeft: Geographic(lon: 0, lat: 0),
        bottomRight: Geographic(lon: 1, lat: 0),
        topLeft: Geographic(lon: 0, lat: 1),
        topRight: Geographic(lon: 1, lat: 1),
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
      data: GeometryCollection(const [
        Point(Geographic(lon: 12, lat: 2)),
      ]).toText(),
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
    const source = VideoSource(
      id: '1',
      coordinates: [Geographic(lon: 0, lat: 0), Geographic(lon: 10, lat: 10)],
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

  testWidgets('addImage', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;

    const imageUrl =
        'https://upload.wikimedia.org/wikipedia/commons/f/f2/678111-map-marker-512.png';
    final imageBytes = await http.readBytes(Uri.parse(imageUrl));

    await ctrl.style?.addImage('test-icon', imageBytes);
    await tester.pumpAndSettle();
  });

  testWidgets('addImages', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;

    const redPinUrl =
        'https://upload.wikimedia.org/wikipedia/commons/f/f2/678111-map-marker-512.png';
    const blackPinUrl =
        'https://upload.wikimedia.org/wikipedia/commons/3/3b/Blackicon.png';

    final images = <String, Uint8List>{
      'image1': await http.readBytes(Uri.parse(redPinUrl)),
      'image2': await http.readBytes(Uri.parse(blackPinUrl)),
    };

    await ctrl.style?.addImages(images);
    await tester.pumpAndSettle();
  });

  testWidgets('removeImage', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;

    // Download the red pin image from Wikipedia (same as used in example)
    const imageUrl =
        'https://upload.wikimedia.org/wikipedia/commons/f/f2/678111-map-marker-512.png';
    final imageBytes = await http.readBytes(Uri.parse(imageUrl));

    // Add image first
    await ctrl.style?.addImage('test-image', imageBytes);
    await tester.pumpAndSettle();

    // Then remove it
    await ctrl.style?.removeImage('test-image');
    await tester.pumpAndSettle();

    // Ensure no crash if image doesn't exist
    await ctrl.style?.removeImage('test-image');
    await tester.pumpAndSettle();
  });
}

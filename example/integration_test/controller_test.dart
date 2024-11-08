import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('controller', () {
    testWidgets('getCamera', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
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
      expect(lngLat.lng, greaterThanOrEqualTo(0));
      expect(lngLat.lat, greaterThanOrEqualTo(0));
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
      expect(lngLats[0].lng, greaterThanOrEqualTo(0));
      expect(lngLats[0].lat, greaterThanOrEqualTo(0));
      expect(lngLats[1].lng, greaterThanOrEqualTo(0));
      expect(lngLats[1].lat, greaterThanOrEqualTo(0));
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
      coordinates: [Position(0, 0), Position(1, 1)],
    );
    await ctrl.addSource(source);
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
    await ctrl.addSource(source);
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
    await ctrl.addSource(source);
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
    await ctrl.addSource(source);
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
    await ctrl.addSource(source);
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
    await ctrl.addSource(source);
    await tester.pumpAndSettle();
  });

  testWidgets('add BackgroundLayer', (tester) async {
    final ctrlCompleter = Completer<MapController>();
    final app = App(onMapCreated: ctrlCompleter.complete);
    await tester.pumpWidget(app);
    final ctrl = await ctrlCompleter.future;
    const layer = BackgroundLayer(id: '1', color: Colors.black);
    await ctrl.addLayer(layer);
    await tester.pumpAndSettle();
  });
}

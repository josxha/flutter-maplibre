import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test();
}

void test() {
  group('MapCamera', () {
    testWidgets('get from map', (tester) async {
      final options = MapOptions(
        minZoom: 1,
        maxZoom: 2,
        initZoom: 1,
        initCenter: const Geographic(lon: 1, lat: 2),
        initStyle: MapStyles.protomapsLight.uri,
      );
      final completer = Completer<MapController>();
      await tester.pumpWidget(
        App(options: options, onMapCreated: completer.complete),
      );
      await tester.pumpAndSettle();
      final ctrl = await completer.future;
      final camera = ctrl.camera;
      expect(camera, isNot(isNull));
      expect(camera!.zoom, closeTo(1, 0.01));
      expect(camera.center.lon, closeTo(1, 0.01));
      expect(camera.center.lat, closeTo(2, 0.01));
    });

    testWidgets('fitBounds replaces padding from a previous camera move', (
      tester,
    ) async {
      const bounds = LngLatBounds(
        longitudeWest: -10,
        longitudeEast: 10,
        latitudeSouth: -10,
        latitudeNorth: 10,
      );
      final controller = Completer<MapController>();
      final style = Completer<StyleController>();
      final cameraEvents = <Type>[];
      Completer<void>? cameraStarted;
      Completer<void>? cameraIdle;
      var remainingCameraIdleEvents = 1;

      await tester.pumpWidget(
        App(
          options: const MapOptions(
            initCenter: Geographic(lon: 0, lat: 0),
            initStyle: '{"version":8,"sources":{},"layers":[]}',
          ),
          onMapCreated: controller.complete,
          onStyleLoaded: style.complete,
          onEvent: (event) {
            if (event is MapEventStartMoveCamera ||
                event is MapEventMoveCamera ||
                event is MapEventCameraIdle) {
              cameraEvents.add(event.runtimeType);
            }
            if (event is MapEventCameraIdle &&
                cameraIdle?.isCompleted == false) {
              remainingCameraIdleEvents--;
              if (remainingCameraIdleEvents == 0) cameraIdle?.complete();
            }
            if (event is MapEventStartMoveCamera &&
                cameraStarted?.isCompleted == false) {
              cameraStarted?.complete();
            }
          },
        ),
      );
      await tester.pumpAndSettle();
      final map = await controller.future;
      await style.future;

      cameraEvents.clear();
      cameraStarted = Completer<void>();
      remainingCameraIdleEvents = 2;
      cameraIdle = Completer<void>();
      final interruptedAnimation = map
          .animateCamera(
            center: const Geographic(lon: 80, lat: 30),
            zoom: 6,
            webSpeed: 0.1,
            webMaxDuration: const Duration(seconds: 10),
          )
          .then<Object?>((_) => null, onError: (Object error) => error);
      await cameraStarted.future.timeout(const Duration(seconds: 5));

      await map.fitBounds(
        bounds: bounds,
        webMaxDuration: const Duration(milliseconds: 1),
      );
      await cameraIdle.future.timeout(const Duration(seconds: 5));
      final animationResult = await interruptedAnimation.timeout(
        const Duration(seconds: 5),
      );

      expect(
        animationResult,
        isA<PlatformException>().having(
          (error) => error.code,
          'code',
          'CancellationException',
        ),
      );
      expect(
        cameraEvents.where((event) => event == MapEventCameraIdle),
        hasLength(2),
      );

      await map.moveCamera(
        center: const Geographic(lon: 0, lat: 0),
        zoom: 4,
        padding: const EdgeInsets.only(bottom: 200),
      );
      cameraEvents.clear();
      remainingCameraIdleEvents = 1;
      cameraIdle = Completer<void>();

      await map.fitBounds(
        bounds: bounds,
        webMaxDuration: const Duration(milliseconds: 1),
      );
      await cameraIdle.future.timeout(const Duration(seconds: 5));
      await tester.pump();

      expect(cameraEvents, contains(MapEventStartMoveCamera));
      expect(cameraEvents, contains(MapEventMoveCamera));
      expect(cameraEvents.last, MapEventCameraIdle);
      expect(
        cameraEvents.where((event) => event == MapEventStartMoveCamera),
        hasLength(1),
      );
      expect(
        cameraEvents.where((event) => event == MapEventCameraIdle),
        hasLength(1),
      );
      final mapCenter = tester.getCenter(find.byType(MapLibreMap));
      final boundsCenter = map.toScreenLocation(
        const Geographic(lon: 0, lat: 0),
      );
      expect(boundsCenter.dx, closeTo(mapCenter.dx, 1));
      expect(boundsCenter.dy, closeTo(mapCenter.dy, 1));
    }, skip: !kIsWeb);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/mocks.dart';

void main() {
  group('Model Classes', () {
    test('QueriedLayer', () {
      const o = QueriedLayer(
        layerId: 'layerId',
        sourceId: 'sourceId',
        sourceLayer: 'sourceLayer',
      );
      final o2 = QueriedLayer(
        layerId: o.layerId,
        sourceId: o.sourceId,
        sourceLayer: o.sourceLayer,
      );

      expect(o, equals(o2));
      expect(o.hashCode, equals(o2.hashCode));

      final oString = o.toString();
      expect(oString, contains(o.layerId));
      expect(oString, contains(o.sourceId));
      expect(oString, contains(o.sourceLayer));
    });
    test('MapGestures', () {
      const all = MapGestures.all();
      const all2 = MapGestures(
        rotate: true,
        zoom: true,
        pitch: true,
        pan: true,
      );
      const none = MapGestures.none();

      expect(all.allEnabled, isTrue);
      expect(none.allEnabled, isFalse);
      expect(all, equals(all2));
      expect(all, isNot(equals(none)));
      expect(all.hashCode, isNot(equals(none.hashCode)));
      expect(all, equals(all2));
      expect(all.hashCode, equals(all2.hashCode));
    });
    test('LngLatBounds', () {
      const o = LngLatBounds(
        latitudeSouth: -10,
        latitudeNorth: 10,
        longitudeWest: -10,
        longitudeEast: 10,
      );
      final o2 = o.copyWith(longitudeEast: 15);
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, isNot(equals(o2.hashCode)));

      final o3 = o.copyWith();
      expect(o, equals(o3));
      expect(o.hashCode, equals(o3.hashCode));

      final oString = o.toString();
      expect(oString, contains(o.latitudeSouth.toString()));
      expect(oString, contains(o.latitudeNorth.toString()));
      expect(oString, contains(o.longitudeEast.toString()));
      expect(oString, contains(o.longitudeWest.toString()));
    });
    test('LngLatBounds.fromPoints', () {
      // Test multiple points
      final o = [
        Position(10, 20), // lng: 10, lat: 20
        Position(-5, 30), // lng: -5, lat: 30
        Position(15, 10), // lng: 15, lat: 10
        Position(0, 0), // lng: 0,  lat: 0
      ];
      final b = LngLatBounds.fromPoints(o);
      expect(b.longitudeWest, -5.0);
      expect(b.longitudeEast, 15.0);
      expect(b.latitudeSouth, 0.0);
      expect(b.latitudeNorth, 30.0);

      // Test a single point
      final o2 = [Position(5.5, -5.5)]; // lng: 5.5, lat: -5.5
      final b2 = LngLatBounds.fromPoints(o2);
      expect(b2.longitudeWest, 5.5);
      expect(b2.longitudeEast, 5.5);
      expect(b2.latitudeSouth, -5.5);
      expect(b2.latitudeNorth, -5.5);

      // Test points at same latitude
      final o3 = [
        Position(0, 10), // lng: 0, lat: 10
        Position(5, 10), // lng: 5, lat: 10
        Position(-5, 10), // lng: -5, lat: 10
      ];
      final b3 = LngLatBounds.fromPoints(o3);
      expect(b3.longitudeWest, -5.0);
      expect(b3.longitudeEast, 5.0);
      expect(b3.latitudeSouth, 10.0);
      expect(b3.latitudeNorth, 10.0);

      // Test points at same longitude
      final o4 = [
        Position(10, 0), // lng: 10, lat: 0
        Position(10, 5), // lng: 10, lat: 5
        Position(10, -5), // lng: 10, lat: -5
      ];
      final b4 = LngLatBounds.fromPoints(o4);
      expect(b4.longitudeWest, 10.0);
      expect(b4.longitudeEast, 10.0);
      expect(b4.latitudeSouth, -5.0);
      expect(b4.latitudeNorth, 5.0);
    });
    test('MapCamera', () {
      final o = MapCamera(
        pitch: 12,
        zoom: 2,
        bearing: 213,
        center: Position(12, 2),
      );
      final o2 = MapCamera(
        pitch: 0,
        zoom: 0,
        bearing: 0,
        center: Position(0, 0),
      );
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
      final oString = o.toString();
      expect(
        oString,
        contains('Position(lng: ${o.center.lng}, lat: ${o.center.lat})'),
      );
      expect(oString, contains(o.pitch.toString()));
      expect(oString, contains(o.bearing.toString()));
      expect(oString, contains(o.zoom.toString()));
    });
    test('OfflineRegion', () {
      const o = OfflineRegion(
        minZoom: 2,
        maxZoom: 4,
        bounds: LngLatBounds(
          longitudeWest: 1,
          longitudeEast: 3,
          latitudeSouth: -3,
          latitudeNorth: 3,
        ),
        id: 23,
        pixelRatio: 1,
        styleUrl: 'https://example.com/style.json',
      );
      const o2 = OfflineRegion(
        minZoom: 3,
        maxZoom: 4,
        bounds: LngLatBounds(
          longitudeWest: 0,
          longitudeEast: 3,
          latitudeSouth: -5,
          latitudeNorth: 3,
        ),
        id: 22,
        pixelRatio: 1,
        styleUrl: 'https://example.com/style2.json',
      );
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
      final oString = o.toString();
      expect(oString, contains(o.bounds.toString()));
      expect(oString, contains(o.minZoom.toString()));
      expect(oString, contains(o.maxZoom.toString()));
      expect(oString, contains(o.id.toString()));
      expect(oString, contains(o.pixelRatio.toString()));
      expect(oString, contains(o.styleUrl));
    });
    test('DownloadProgress', () {
      const region = OfflineRegion(
        minZoom: 2,
        maxZoom: 4,
        bounds: LngLatBounds(
          longitudeWest: 1,
          longitudeEast: 3,
          latitudeSouth: -3,
          latitudeNorth: 3,
        ),
        id: 23,
        pixelRatio: 1,
        styleUrl: 'https://example.com/style.json',
      );
      const o = DownloadProgress(
        downloadCompleted: false,
        loadedBytes: 12,
        loadedTiles: 1,
        region: region,
        totalTiles: 2,
        totalTilesEstimated: true,
      );
      const o2 = DownloadProgress(
        downloadCompleted: true,
        loadedBytes: 13,
        loadedTiles: 1,
        region: region,
        totalTiles: 2,
        totalTilesEstimated: false,
      );
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
      final oString = o.toString();
      expect(oString, contains(o.downloadCompleted.toString()));
      expect(oString, contains(o.loadedBytes.toString()));
      expect(oString, contains(o.loadedTiles.toString()));
      expect(oString, contains(o.region.toString()));
      expect(oString, contains(o.totalTiles.toString()));
      expect(oString, contains(o.totalTilesEstimated.toString()));
    });
    test('MapEvents', () {
      final controller = MockMapController();
      final camera = MockMapCamera();
      final position = MockPosition();
      final screenPoint = MockOffset();

      final mapCreated = MapEventMapCreated(mapController: controller);
      expect(mapCreated, isA<MapEvent>());
      expect(mapCreated.mapController, equals(controller));

      final moveCamera = MapEventMoveCamera(camera: camera);
      expect(moveCamera, isA<MapEvent>());
      expect(moveCamera.camera, equals(camera));

      const startMoveCamera = MapEventStartMoveCamera(
        reason: CameraChangeReason.apiGesture,
      );
      expect(startMoveCamera, isA<MapEvent>());
      expect(startMoveCamera.reason, equals(CameraChangeReason.apiGesture));

      final click = MapEventClick(point: position, screenPoint: screenPoint);
      expect(click, isA<MapEvent>());
      expect(click.point, equals(position));
      expect(click.screenPoint, equals(screenPoint));
      expect(click.toString(), contains('MapEventClick'));

      final doubleClick = MapEventDoubleClick(
        point: position,
        screenPoint: screenPoint,
      );
      expect(doubleClick, isA<MapEvent>());
      expect(doubleClick.point, equals(position));
      expect(doubleClick.screenPoint, equals(screenPoint));
      expect(doubleClick.toString(), contains('MapEventDoubleClick'));

      final secondaryClick = MapEventSecondaryClick(
        point: position,
        screenPoint: screenPoint,
      );
      expect(secondaryClick, isA<MapEvent>());
      expect(secondaryClick.point, equals(position));
      expect(secondaryClick.screenPoint, equals(screenPoint));
      expect(secondaryClick.toString(), contains('MapEventSecondaryClick'));

      final longClick = MapEventLongClick(
        point: position,
        screenPoint: screenPoint,
      );
      expect(longClick, isA<MapEvent>());
      expect(longClick.point, equals(position));
      expect(longClick.screenPoint, equals(screenPoint));
      expect(longClick.toString(), contains('MapEventLongClick'));

      const idle = MapEventIdle();
      expect(idle, isA<MapEvent>());

      const cameraIdle = MapEventCameraIdle();
      expect(cameraIdle, isA<MapEvent>());
    });
  });
}

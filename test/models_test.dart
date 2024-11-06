import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

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
      const all2 =
          MapGestures(rotate: true, zoom: true, pitch: true, pan: true);
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
  });
}

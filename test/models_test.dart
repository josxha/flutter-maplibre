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
      final oString = o.toString();
      expect(oString, contains(o.latitudeSouth));
      expect(oString, contains(o.latitudeNorth));
      expect(oString, contains(o.longitudeEast));
      expect(oString, contains(o.longitudeWest));
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
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
      final oString = o.toString();
      expect(oString, contains(o.center));
      expect(oString, contains(o.pitch));
      expect(oString, contains(o.bearing));
      expect(oString, contains(o.zoom));
    });
  });
}

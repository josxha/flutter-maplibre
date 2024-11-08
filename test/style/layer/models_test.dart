import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  group('Style Layer Model Classes', () {
    test('BackgroundLayer', () {
      const o = BackgroundLayer(id: '12');
      const o2 = BackgroundLayer(id: '42');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('CircleLayer', () {
      const o = CircleLayer(id: '12', sourceId: '342');
      const o2 = CircleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('FillExtrusionLayer', () {
      const o = FillExtrusionLayer(id: '12', sourceId: '342');
      const o2 = FillExtrusionLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('FillLayer', () {
      const o = FillLayer(id: '12', sourceId: '342');
      const o2 = FillLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('HeatmapLayer', () {
      const o = HeatmapLayer(id: '12', sourceId: '342');
      const o2 = HeatmapLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('HillshadeLayer', () {
      const o = HillshadeLayer(id: '12', sourceId: '342');
      const o2 = HillshadeLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('LineLayer', () {
      const o = LineLayer(id: '12', sourceId: '342');
      const o2 = LineLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('RasterLayer', () {
      const o = RasterLayer(id: '12', sourceId: '342');
      const o2 = RasterLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('SymbolLayer', () {
      const o = SymbolLayer(id: '12', sourceId: '342');
      const o2 = SymbolLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
  });
}

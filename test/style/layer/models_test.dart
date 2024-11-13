import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  group('Style Layer Model Classes', () {
    test('BackgroundLayer', () {
      const o = BackgroundStyleLayer(id: '12');
      const o2 = BackgroundStyleLayer(id: '42');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('CircleLayer', () {
      const o = CircleStyleLayer(id: '12', sourceId: '342');
      const o2 = CircleStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('FillExtrusionLayer', () {
      const o = FillExtrusionStyleLayer(id: '12', sourceId: '342');
      const o2 = FillExtrusionStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('FillLayer', () {
      const o = FillStyleLayer(id: '12', sourceId: '342');
      const o2 = FillStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('HeatmapLayer', () {
      const o = HeatmapStyleLayer(id: '12', sourceId: '342');
      const o2 = HeatmapStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('HillshadeLayer', () {
      const o = HillshadeStyleLayer(id: '12', sourceId: '342');
      const o2 = HillshadeStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('LineLayer', () {
      const o = LineStyleLayer(id: '12', sourceId: '342');
      const o2 = LineStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('RasterLayer', () {
      const o = RasterStyleLayer(id: '12', sourceId: '342');
      const o2 = RasterStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('SymbolLayer', () {
      const o = SymbolStyleLayer(id: '12', sourceId: '342');
      const o2 = SymbolStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
  });
}

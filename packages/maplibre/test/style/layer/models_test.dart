import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  group('Style Layer Model Classes', () {
    test('BackgroundLayer', () {
      final o = BackgroundStyleLayer(id: '12');
      final o2 = BackgroundStyleLayer(id: '42');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('CircleLayer', () {
      final o = CircleStyleLayer(id: '12', sourceId: '342');
      final o2 = CircleStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('FillExtrusionLayer', () {
      final o = FillExtrusionStyleLayer(id: '12', sourceId: '342');
      final o2 = FillExtrusionStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('FillLayer', () {
      final o = FillStyleLayer(id: '12', sourceId: '342');
      final o2 = FillStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('HeatmapLayer', () {
      final o = HeatmapStyleLayer(id: '12', sourceId: '342');
      final o2 = HeatmapStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('HillshadeLayer', () {
      final o = HillshadeStyleLayer(id: '12', sourceId: '342');
      final o2 = HillshadeStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('LineLayer', () {
      final o = LineStyleLayer(id: '12', sourceId: '342');
      final o2 = LineStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('RasterLayer', () {
      final o = RasterStyleLayer(id: '12', sourceId: '342');
      final o2 = RasterStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('SymbolLayer', () {
      final o = SymbolStyleLayer(id: '12', sourceId: '342');
      final o2 = SymbolStyleLayer(id: '42', sourceId: '342');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
  });
}

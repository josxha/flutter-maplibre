import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  group('Style Source Model Classes', () {
    test('GeoJsonSource', () {
      const o = GeoJsonSource(id: '12', data: '{}');
      const o2 = GeoJsonSource(id: '42', data: '{}');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('ImageSource', () {
      final o = ImageSource(
        id: '12',
        url: '',
        coordinates: LngLatQuad(
          bottomLeft: Position(0, 0),
          bottomRight: Position(1, 0),
          topLeft: Position(0, 1),
          topRight: Position(1, 1),
        ),
      );
      final o2 = ImageSource(
        id: '13',
        url: '',
        coordinates: LngLatQuad(
          bottomLeft: Position(0, 0),
          bottomRight: Position(1, 0),
          topLeft: Position(0, 1),
          topRight: Position(1, 1),
        ),
      );
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('RasterDemSource', () {
      const o = RasterDemSource(id: '12', url: '');
      const o2 = RasterDemSource(id: '13', url: '');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('RasterSource', () {
      const o = RasterSource(id: '12', url: '');
      const o2 = RasterSource(id: '13', url: '');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('VectorSource', () {
      const o = VectorSource(id: '12', url: '');
      const o2 = VectorSource(id: '13', url: '');
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
    test('VideoSource', () {
      final o = VideoSource(id: '12', urls: [], coordinates: [Position(2, 3)]);
      final o2 = VideoSource(id: '13', urls: [], coordinates: [Position(2, 3)]);
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
  });
}

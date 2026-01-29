import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

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
      const o = ImageSource(
        id: '12',
        url: '',
        coordinates: LngLatQuad(
          bottomLeft: Geographic(lon: 0, lat: 0),
          bottomRight: Geographic(lon: 1, lat: 0),
          topLeft: Geographic(lon: 0, lat: 1),
          topRight: Geographic(lon: 1, lat: 1),
        ),
      );
      const o2 = ImageSource(
        id: '13',
        url: '',
        coordinates: LngLatQuad(
          bottomLeft: Geographic(lon: 0, lat: 0),
          bottomRight: Geographic(lon: 1, lat: 0),
          topLeft: Geographic(lon: 0, lat: 1),
          topRight: Geographic(lon: 1, lat: 1),
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
      const o = VideoSource(
        id: '12',
        urls: [],
        coordinates: [Geographic(lon: 2, lat: 3)],
      );
      const o2 = VideoSource(
        id: '13',
        urls: [],
        coordinates: [Geographic(lon: 2, lat: 3)],
      );
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));
    });
  });
}

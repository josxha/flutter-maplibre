import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  group('Annotation Model Classes', () {
    test('CircleLayer', () {
      final o = CircleLayer(
        circles: Layer.generateFeatureList([
          Point(coordinates: Position(0, 0)),
          Point(coordinates: Position(12.4, -4)),
        ]),
        color: Colors.purple,
        strokeWidth: 5,
        blur: 2.4,
        strokeColor: Colors.greenAccent,
        radius: 10,
      );
      final o2 = CircleLayer(circles: Layer.generateFeatureList([]));
      final o3 = CircleLayer(circles: Layer.generateFeatureList([]));
      expect(o, equals(o));
      expect(o2, equals(o3));
      expect(o2.hashCode, equals(o3.hashCode));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));

      expect(o.getSourceId(5123), contains(5123.toString()));
      expect(o.getLayerId(1532), contains(1532.toString()));
      expect(o.createStyleLayer(142), isA<CircleStyleLayer>());
      expect(o.getLayout(), isA<Map<String, Object>>());
      expect(o.getPaint(), isA<Map<String, Object>>());
    });
    test('MarkerLayer', () {
      final o = MarkerLayer(
        markers: Layer.generateFeatureList([
          Point(coordinates: Position(0, 0)),
          Point(coordinates: Position(12.4, -4)),
        ]),
        textColor: Colors.purple,
        textHaloColor: Colors.greenAccent,
        iconHaloColor: Colors.amber,
        iconColor: Colors.yellow,
        textOffset: const [2, 4],
        iconImage: 'test.png',
        textAllowOverlap: true,
        textSize: 23,
      );
      final o2 = MarkerLayer(markers: Layer.generateFeatureList([]));
      final o3 = MarkerLayer(markers: Layer.generateFeatureList([]));
      expect(o, equals(o));
      expect(o2, equals(o3));
      expect(o2.hashCode, equals(o3.hashCode));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));

      expect(o.getSourceId(5123), contains(5123.toString()));
      expect(o.getLayerId(1532), contains(1532.toString()));
      expect(o.createStyleLayer(142), isA<SymbolStyleLayer>());
      expect(o.getLayout(), isA<Map<String, Object>>());
      expect(o.getPaint(), isA<Map<String, Object>>());
    });
    test('PolygonLayer', () {
      final o = PolygonLayer(
        polygons: Layer.generateFeatureList([
          Polygon(
            coordinates: [
              [Position(2, 23.4), Position(5.2, 32), Position(53, 2)],
              [Position(2, 23.4), Position(5.2, 32), Position(53, 3)],
            ],
          ),
        ]),
      );
      final o2 = PolygonLayer(
        polygons: Layer.generateFeatureList([
          Polygon(
            coordinates: [
              [Position(2, 23.4), Position(5.2, 32), Position(53, 2)],
            ],
          ),
        ]),
      );
      final o3 = PolygonLayer(
        polygons: Layer.generateFeatureList([
          Polygon(
            coordinates: [
              [Position(2, 23.4), Position(5.2, 32), Position(53, 2)],
            ],
          ),
        ]),
      );
      expect(o, equals(o));
      expect(o2, equals(o3));
      expect(o2.hashCode, equals(o3.hashCode));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));

      expect(o.getSourceId(5123), contains(5123.toString()));
      expect(o.getLayerId(1532), contains(1532.toString()));
      expect(o.createStyleLayer(142), isA<FillStyleLayer>());
      expect(o.getLayout(), isA<Map<String, Object>>());
      expect(o.getPaint(), isA<Map<String, Object>>());
    });
    test('PolylineLayer', () {
      final o = PolylineLayer(
        polylines: Layer.generateFeatureList([
          LineString(coordinates: [Position(2, 23.4), Position(5.2, 32)]),
        ]),
      );
      final o2 = PolylineLayer(
        polylines: Layer.generateFeatureList([
          LineString(
            coordinates: [
              Position(2, 23.4),
              Position(5.2, 32),
              Position(53, 2),
            ],
          ),
        ]),
      );
      final o3 = PolylineLayer(
        polylines: Layer.generateFeatureList([
          LineString(
            coordinates: [
              Position(2, 23.4),
              Position(5.2, 32),
              Position(53, 2),
            ],
          ),
        ]),
      );
      expect(o, equals(o));
      expect(o2, equals(o3));
      expect(o2.hashCode, equals(o3.hashCode));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));

      expect(o.getSourceId(5123), contains(5123.toString()));
      expect(o.getLayerId(1532), contains(1532.toString()));
      expect(o.createStyleLayer(142), isA<LineStyleLayer>());
      expect(o.getLayout(), isA<Map<String, Object>>());
      expect(o.getPaint(), isA<Map<String, Object>>());
    });
  });
}

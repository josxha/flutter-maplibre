import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  group('Annotation Model Classes', () {
    test('CircleAnnotationLayer', () {
      const o = CircleLayer(
        points: [
          Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
          Feature(geometry: Point(Geographic(lon: 12.4, lat: -4))),
        ],
        color: Colors.purple,
        strokeWidth: 5,
        blur: 2.4,
        strokeColor: Colors.greenAccent,
        radius: 10,
      );
      const o2 = CircleLayer(points: []);
      const o3 = CircleLayer(points: []);
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
    test('MarkerAnnotationLayer', () {
      const o = MarkerLayer(
        points: [
          Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
          Feature(geometry: Point(Geographic(lon: 12.4, lat: -4))),
        ],
        textColor: Colors.purple,
        textHaloColor: Colors.greenAccent,
        iconHaloColor: Colors.amber,
        iconColor: Colors.yellow,
        textOffset: [2, 4],
        iconImage: 'test.png',
        textAllowOverlap: true,
        textSize: 23,
      );
      const o2 = MarkerLayer(points: []);
      const o3 = MarkerLayer(points: []);
      expect(o, equals(o));
      expect(o2, equals(o2));
      expect(o, isNot(equals(o2)));
      expect(o2, equals(o3));
      expect(o2.hashCode, equals(o3.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));

      expect(o.getSourceId(5123), contains(5123.toString()));
      expect(o.getLayerId(1532), contains(1532.toString()));
      expect(o.createStyleLayer(142), isA<SymbolStyleLayer>());
      expect(o.getLayout(), isA<Map<String, Object>>());
      expect(o.getPaint(), isA<Map<String, Object>>());
    });
    test('PolygonAnnotationLayer', () {
      final o = PolygonLayer(
        polygons: [
          Feature(
            geometry: Polygon.from(const [
              [
                Geographic(lon: 2, lat: 23.4),
                Geographic(lon: 5.2, lat: 32),
                Geographic(lon: 53, lat: 2),
              ],
              [
                Geographic(lon: 2, lat: 23.4),
                Geographic(lon: 5.2, lat: 32),
                Geographic(lon: 53, lat: 3),
              ],
            ]),
          ),
        ],
      );
      final o2 = PolygonLayer(
        polygons: [
          Feature(
            geometry: Polygon.from(const [
              [
                Geographic(lon: 2, lat: 23.4),
                Geographic(lon: 5.2, lat: 32),
                Geographic(lon: 53, lat: 2),
              ],
            ]),
          ),
        ],
      );
      /*final o3 = PolygonAnnotationLayer(
        polygons: [
          Polygon(
            coordinates: [
              [Geographic(lon: 2, 23.4), Geographic(lon: 5.2, 32), Geographic(lon: 53, 2)],
            ],
          ),
        ],
      );*/
      expect(o, equals(o));
      // expect(o2, equals(o3));
      // expect(o2.hashCode, equals(o3.hashCode));
      expect(o, isNot(equals(o2)));
      expect(o.hashCode, equals(o.hashCode));
      expect(o.hashCode, isNot(equals(o2.hashCode)));

      expect(o.getSourceId(5123), contains(5123.toString()));
      expect(o.getLayerId(1532), contains(1532.toString()));
      expect(o.createStyleLayer(142), isA<FillStyleLayer>());
      expect(o.getLayout(), isA<Map<String, Object>>());
      expect(o.getPaint(), isA<Map<String, Object>>());
    });
    test('PolylineAnnotationLayer', () {
      final o = PolylineLayer(
        polylines: [
          Feature(
            geometry: LineString.from(const [
              Geographic(lon: 2, lat: 23.4),
              Geographic(lon: 5.2, lat: 32),
            ]),
          ),
        ],
      );
      final o2 = PolylineLayer(
        polylines: [
          Feature(
            geometry: LineString.from(const [
              Geographic(lon: 2, lat: 23.4),
              Geographic(lon: 5.2, lat: 32),
              Geographic(lon: 53, lat: 2),
            ]),
          ),
        ],
      );
      /*final o3 = PolylineAnnotationLayer(
        polylines: [
          LineString(
            coordinates: [
              Geographic(lon: 2, lat: 23.4),
              Geographic(lon: 5.2, lat: 32),
              Geographic(lon: 53, lat: 2),
            ],
          ),
        ],
      );*/
      expect(o, equals(o));
      // expect(o2, equals(o3));
      // expect(o2.hashCode, equals(o3.hashCode));
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

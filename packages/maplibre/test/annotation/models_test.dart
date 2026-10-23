import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  const points = [
    Feature(geometry: Point(Geographic(lon: 0, lat: 0))),
    Feature(geometry: Point(Geographic(lon: 12.4, lat: -4))),
  ];

  group('Layer', () {
    test('names its source and style layer by index', () {
      const layer = CircleLayer(points: points);
      expect(layer.getSourceId(3), 'maplibre-source-3');
      expect(layer.getLayerId(3), 'maplibre-layer-3');
      expect(layer.getSourceId(3), isNot(layer.getSourceId(4)));
    });

    test('compares its features by identity', () {
      const layer = CircleLayer(points: points, radius: 3);
      expect(layer, const CircleLayer(points: points, radius: 3));
      expect(layer, isNot(const CircleLayer(points: points, radius: 4)));
      // An equal, but new list counts as a change.
      expect(layer, isNot(CircleLayer(points: List.of(points), radius: 3)));
    });
  });

  group('CircleLayer', () {
    const layer = CircleLayer(
      points: points,
      radius: 10,
      color: Color(0x80FF0000),
      blur: 0.5,
      strokeWidth: 2,
      strokeColor: Color(0xFF00FF00),
      minZoom: 3,
      maxZoom: 12,
    );

    test('creates a circle style layer on its source', () {
      final style = layer.createStyleLayer(1);
      expect(style, isA<CircleStyleLayer>());
      style as CircleStyleLayer;
      expect(style.id, 'maplibre-layer-1');
      expect(style.sourceId, 'maplibre-source-1');
      expect(style.minZoom, 3);
      expect(style.maxZoom, 12);
      expect(style.paint, layer.getPaint());
    });

    test('maps its properties to the style spec', () {
      expect(layer.getPaint(), {
        'circle-radius': 10,
        'circle-color': '#FF0000',
        'circle-blur': 0.5,
        'circle-opacity': closeTo(0.5, 0.01),
        'circle-stroke-width': 2,
        'circle-stroke-color': '#00FF00',
        'circle-stroke-opacity': 1.0,
      });
      expect(layer.getLayout(), isEmpty);
    });
  });

  group('MarkerLayer', () {
    const layer = MarkerLayer(
      points: points,
      iconImage: 'marker',
      iconSize: 2,
      iconOpacity: 0.5,
      iconTranslate: [1, 2],
      iconAnchor: IconAnchor.bottomLeft,
      textField: 'label',
      textSize: 23,
      textOpacity: 0.8,
      textColor: Colors.purple,
      textOffset: [2, 4],
      textAllowOverlap: true,
    );

    test('creates a symbol style layer', () {
      final style = layer.createStyleLayer(0);
      expect(style, isA<SymbolStyleLayer>());
      expect(style.layout, layer.getLayout());
      expect(style.paint, layer.getPaint());
    });

    test('maps its layout to the style spec', () {
      final layout = layer.getLayout();
      expect(layout['icon-image'], 'marker');
      expect(layout['icon-size'], 2);
      expect(layout['icon-anchor'], 'bottom-left');
      expect(layout['text-field'], 'label');
      expect(layout['text-size'], 23);
      expect(layout['text-offset'], [2, 4]);
      expect(layout['text-allow-overlap'], isTrue);
    });

    test('maps its paint to the style spec', () {
      final paint = layer.getPaint();
      expect(paint['icon-opacity'], 0.5);
      expect(paint['icon-translate'], [1, 2]);
      expect(paint['text-opacity'], 0.8);
      expect(paint['text-color'], Colors.purple.toHexString());
    });

    test('leaves out the icon without an image', () {
      expect(
        const MarkerLayer(points: points).getLayout(),
        isNot(contains('icon-image')),
      );
    });
  });

  group('PolygonLayer', () {
    final layer = PolygonLayer(
      polygons: [
        Feature(
          geometry: Polygon.from(const [
            [
              Geographic(lon: 2, lat: 23.4),
              Geographic(lon: 5.2, lat: 32),
              Geographic(lon: 53, lat: 2),
              Geographic(lon: 2, lat: 23.4),
            ],
          ]),
        ),
      ],
      color: const Color(0x4000FF00),
    );

    test('creates a fill style layer', () {
      expect(layer.createStyleLayer(0), isA<FillStyleLayer>());
    });

    test('maps its properties to the style spec', () {
      expect(layer.getPaint(), {
        'fill-color': '#00FF00',
        'fill-opacity': closeTo(0.25, 0.01),
        'fill-outline-color': '#000000',
      });
    });
  });

  group('PolylineLayer', () {
    final layer = PolylineLayer(
      polylines: [
        Feature(
          geometry: LineString.from(const [
            Geographic(lon: 2, lat: 23.4),
            Geographic(lon: 5.2, lat: 32),
          ]),
        ),
      ],
      color: Colors.blue,
      width: 4,
      gapWidth: 1,
      blur: 2,
      dashArray: const [2, 1],
    );

    test('creates a line style layer', () {
      expect(layer.createStyleLayer(0), isA<LineStyleLayer>());
    });

    test('maps its properties to the style spec', () {
      expect(layer.getPaint(), {
        'line-color': Colors.blue.toHexString(),
        'line-opacity': 1.0,
        'line-width': 4,
        'line-gap-width': 1,
        'line-blur': 2,
        'line-dasharray': [2, 1],
      });
    });

    test('leaves out the dash array when it has none', () {
      expect(
        PolylineLayer(polylines: layer.list).getPaint(),
        isNot(contains('line-dasharray')),
      );
    });
  });
}

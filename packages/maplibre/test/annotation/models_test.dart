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
      const layer = CircleLayer(points: points, radius: .literal(3));
      expect(layer, const CircleLayer(points: points, radius: .literal(3)));
      expect(
        layer,
        isNot(const CircleLayer(points: points, radius: .literal(4))),
      );
      // An equal, but new list counts as a change.
      expect(
        layer,
        isNot(CircleLayer(points: List.of(points), radius: const .literal(3))),
      );
    });
  });

  group('CircleLayer', () {
    const layer = CircleLayer(
      points: points,
      radius: .literal(10),
      color: .literal(Color(0x80FF0000)),
      blur: .literal(0.5),
      strokeWidth: .literal(2),
      strokeColor: .literal(Color(0xFF00FF00)),
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
    });

    test('maps its properties to the style spec', () {
      expect(layer.createStyleLayer(0).toJson()['paint'], {
        'circle-radius': 10,
        'circle-color': startsWith('rgba(255, 0, 0, 0.5'),
        'circle-blur': 0.5,
        'circle-opacity': 1,
        'circle-stroke-width': 2,
        'circle-stroke-color': '#00ff00',
        'circle-stroke-opacity': 1,
      });
      expect(layer.createStyleLayer(0).toJson(), isNot(contains('layout')));
    });
  });

  group('expressions', () {
    test('reach the style layer for per feature styling', () {
      final layer = CircleLayer(
        points: points,
        radius: Expression.get('size').asNumber(),
        color: Expression.get('color').convertToColor(),
      );
      expect(
        layer.createStyleLayer(0).toJson()['paint'],
        containsPair('circle-radius', [
          'number',
          ['get', 'size'],
        ]),
      );
      expect(
        layer.createStyleLayer(0).toJson()['paint'],
        containsPair('circle-color', [
          'to-color',
          ['get', 'color'],
        ]),
      );
    });

    test('compare deeply', () {
      CircleLayer layerOf(String name) =>
          CircleLayer(points: points, radius: Expression.get(name).asNumber());
      expect(layerOf('a'), layerOf('a'));
      expect(layerOf('a').hashCode, layerOf('a').hashCode);
      expect(layerOf('a'), isNot(layerOf('b')));
    });
  });

  group('MarkerLayer', () {
    const layer = MarkerLayer(
      points: points,
      iconImage: .literal('marker'),
      iconSize: .literal(2),
      iconOpacity: .literal(0.5),
      iconTranslate: .literal(Offset(1, 2)),
      iconAnchor: .literal(IconAnchor.bottomLeft),
      textField: .literal('label'),
      textSize: .literal(23),
      textOpacity: .literal(0.8),
      textColor: .literal(Colors.purple),
      textOffset: .literal(Offset(2, 4)),
      textAllowOverlap: .literal(true),
    );

    test('creates a symbol style layer', () {
      final style = layer.createStyleLayer(0);
      expect(style, isA<SymbolStyleLayer>());
    });

    test('maps its layout to the style spec', () {
      final layout = layer.createStyleLayer(0).toJson()['layout']! as Map;
      expect(layout['icon-image'], 'marker');
      expect(layout['icon-size'], 2);
      expect(layout['icon-anchor'], 'bottom-left');
      expect(layout['text-field'], 'label');
      expect(layout['text-size'], 23);
      expect(layout['text-offset'], [2, 4]);
      expect(layout['text-allow-overlap'], isTrue);
    });

    test('maps its paint to the style spec', () {
      final paint = layer.createStyleLayer(0).toJson()['paint']! as Map;
      expect(paint['icon-opacity'], 0.5);
      expect(paint['icon-translate'], [1, 2]);
      expect(paint['text-opacity'], 0.8);
      expect(paint['text-color'], Colors.purple.toHexString().toLowerCase());
    });

    test('leaves out the icon without an image', () {
      expect(
        const MarkerLayer(points: points)
            .createStyleLayer(0)
            .toJson()['layout'],
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
      color: const .literal(Color(0x4000FF00)),
    );

    test('creates a fill style layer', () {
      expect(layer.createStyleLayer(0), isA<FillStyleLayer>());
    });

    test('maps its properties to the style spec', () {
      expect(layer.createStyleLayer(0).toJson()['paint'], {
        'fill-color': startsWith('rgba(0, 255, 0, 0.2'),
        'fill-opacity': 1,
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
      color: const .literal(Colors.blue),
      width: const .literal(4),
      gapWidth: const .literal(1),
      blur: const .literal(2),
      dashArray: const .literal([2, 1]),
    );

    test('creates a line style layer', () {
      expect(layer.createStyleLayer(0), isA<LineStyleLayer>());
    });

    test('maps its properties to the style spec', () {
      expect(layer.createStyleLayer(0).toJson()['paint'], {
        'line-color': Colors.blue.toHexString().toLowerCase(),
        'line-opacity': 1,
        'line-width': 4,
        'line-gap-width': 1,
        'line-blur': 2,
        'line-dasharray': [2, 1],
      });
    });

    test('leaves out the dash array when it has none', () {
      expect(
        PolylineLayer(polylines: layer.list)
            .createStyleLayer(0)
            .toJson()['paint'],
        isNot(contains('line-dasharray')),
      );
    });
  });
}

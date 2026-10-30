import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

void main() {
  group('StyleLayer JSON', () {
    test('writes only what is set', () {
      expect(CircleStyleLayer(id: 'c', sourceId: 's').toJson(), {
        'id': 'c',
        'type': 'circle',
        'source': 's',
      });
      expect(BackgroundStyleLayer(id: 'b').toJson(), {
        'id': 'b',
        'type': 'background',
      });
    });

    test('writes typed properties, filter, zoom range and visibility', () {
      final layer = SymbolStyleLayer(
        id: 'l',
        sourceId: 's',
        sourceLayerId: 'sl',
        minZoom: 1,
        maxZoom: 2,
        visible: false,
        filter: Expression.has('a'),
        placement: const .literal(SymbolPlacement.lineCenter),
        iconOffset: const .literal(Offset(1, 2)),
        textFont: const .literal(['Noto']),
        textColor: const .literal(Color(0xFFFF0000)),
        textAllowOverlap: const .literal(true),
        textSize: .interpolate(const .linear(), .zoom(), {
          1: const .literal(2),
        }),
      );
      expect(layer.toJson(), {
        'id': 'l',
        'type': 'symbol',
        'source': 's',
        'source-layer': 'sl',
        'minzoom': 1.0,
        'maxzoom': 2.0,
        'filter': ['has', 'a'],
        'layout': {
          'visibility': 'none',
          'symbol-placement': 'line-center',
          'icon-offset': [1.0, 2.0],
          'text-font': ['Noto'],
          'text-allow-overlap': true,
          'text-size': [
            'interpolate',
            ['linear'],
            ['zoom'],
            1,
            2,
          ],
        },
        'paint': {'text-color': '#ff0000'},
      });
    });

    test('writes transitions as the properties of the spec', () {
      final layer = LineStyleLayer(
        id: 'l',
        sourceId: 's',
        widthTransition: const StyleTransition(
          duration: Duration(seconds: 1),
          delay: Duration(milliseconds: 5),
        ),
      );
      expect(layer.toJson()['paint'], {
        'line-width-transition': {'duration': 1000, 'delay': 5},
      });
      expect(
        layer.widthTransition,
        const StyleTransition(
          duration: Duration(seconds: 1),
          delay: Duration(milliseconds: 5),
        ),
      );
      expect(layer.colorTransition, isNull);
    });

    test('round trips every layer type', () {
      const layers = <Map<String, Object?>>[
        {
          'type': 'background',
          'paint': {'background-color': '#ff0000'},
        },
        {
          'type': 'circle',
          'source': 's',
          'layout': {'circle-sort-key': 1},
          'paint': {'circle-radius': 2},
        },
        {
          'type': 'color-relief',
          'source': 's',
          'paint': {'color-relief-opacity': 0.5},
        },
        {
          'type': 'fill',
          'source': 's',
          'source-layer': 'sl',
          'filter': ['has', 'a'],
          'paint': {'fill-color': 'red'},
        },
        {
          'type': 'fill-extrusion',
          'source': 's',
          'paint': {'fill-extrusion-height': 2},
        },
        {
          'type': 'heatmap',
          'source': 's',
          'paint': {'heatmap-radius': 2},
        },
        {
          'type': 'hillshade',
          'source': 's',
          'paint': {'hillshade-method': 'igor'},
        },
        {
          'type': 'line',
          'source': 's',
          'minzoom': 1.0,
          'maxzoom': 2.0,
          'layout': {'line-cap': 'round', 'visibility': 'none'},
          'paint': {'line-width': 2},
          'metadata': {'a': 1},
        },
        {
          'type': 'raster',
          'source': 's',
          'paint': {'raster-opacity': 0.5},
        },
        {
          'type': 'symbol',
          'source': 's',
          'layout': {'text-field': '{name}'},
          'paint': {'text-color': '#000000'},
        },
      ];
      for (final json in layers) {
        final full = {'id': 'x', ...json};
        final layer = StyleLayer.fromJson(full);
        expect(layer.toJson(), full, reason: '${json['type']}');
        expect(layer.type, json['type']);
        expect(layer, isNot(isA<UnknownStyleLayer>()));
      }
    });

    test('keeps a layer type it does not know', () {
      final json = {
        'id': 'x',
        'type': 'future',
        'source': 's',
        'layout': {'a': 1},
        'paint': {'b': 2},
      };
      final layer = StyleLayer.fromJson(json);
      expect(layer, isA<UnknownStyleLayer>());
      expect(layer.toJson(), json);
    });
  });

  group('getters', () {
    test('return the default of the spec when nothing is set', () {
      final line = LineStyleLayer(id: 'l', sourceId: 's');
      expect(line.width, const Literal<num>(1));
      expect(line.color, const Literal(Color(0xFF000000)));
      expect(line.cap, const Literal(LineCap.butt));
      expect(line.translate, const Literal(Offset.zero));
      expect(line.gradient, isNull);
      expect(line.visible, isTrue);
      expect(line.minZoom, 0);
      expect(line.maxZoom, 24);
      expect(line.filter, isNull);
      final hillshade = HillshadeStyleLayer(id: 'h', sourceId: 's');
      expect(hillshade.illuminationDirection, const Literal<List<num>>([335]));
      expect(hillshade.shadowColor, const Literal([Color(0xFF000000)]));
      expect(
        HeatmapStyleLayer(id: 'h', sourceId: 's').color,
        isA<Call<Color>>(),
      );
    });

    test('read literals back', () {
      final layer = StyleLayer.fromJson({
        'id': 'l',
        'type': 'line',
        'source': 's',
        'layout': {'line-cap': 'round'},
        'paint': {
          'line-width': 3,
          'line-color': '#FF0000',
          'line-translate': [1, 2],
          'line-dasharray': [
            'literal',
            [1, 2],
          ],
        },
      }) as LineStyleLayer;
      expect(layer.cap, isA<Literal<LineCap>>());
      expect(layer.cap, const Literal(LineCap.round));
      expect(layer.width, isA<Literal<num>>());
      expect(layer.width, const Literal<num>(3));
      expect(layer.color, const Literal(Color(0xFFFF0000)));
      expect(layer.translate, const Literal(Offset(1, 2)));
      expect(layer.dasharray, const Literal<List<num>>([1, 2]));
    });

    test('read colors in every notation back', () {
      Expression<Color> colorOf(Object json) => (StyleLayer.fromJson({
        'id': 'c',
        'type': 'circle',
        'source': 's',
        'paint': {'circle-color': json},
      }) as CircleStyleLayer).color;
      const red = Literal(Color(0xFFFF0000));
      expect(colorOf('#f00'), red);
      expect(colorOf('#ff0000'), red);
      expect(colorOf('#FF0000FF'), red);
      expect(colorOf('rgb(255, 0, 0)'), red);
      expect(colorOf('rgba(255,0,0,1)'), red);
      expect(colorOf('hsl(0, 100%, 50%)'), red);
      expect(colorOf('red'), red);
      expect(colorOf(const ['rgba', 255, 0, 0, 1]), red);
      expect(colorOf(const ['rgb', 255, 0, 0]), red);
      expect(colorOf('transparent'), const Literal(Color(0x00000000)));

      final translucent = colorOf(const ['rgba', 255, 0, 0, 0.5]);
      expect(translucent, isA<Literal<Color>>());
      expect((translucent as Literal<Color>).value.a, 0.5);
    });

    test('keep what is no literal as it is', () {
      final layer = StyleLayer.fromJson({
        'id': 'c',
        'type': 'circle',
        'source': 's',
        'filter': [
          '==',
          ['get', 'a'],
          1,
        ],
        'paint': {
          'circle-radius': ['get', 'r'],
          'circle-color': [
            'rgba',
            ['get', 'r'],
            0,
            0,
            1,
          ],
          'circle-blur': {
            'stops': [
              [1, 2],
            ],
          },
          'circle-stroke-color': 'chartreuse',
        },
      }) as CircleStyleLayer;
      expect(layer.radius, const Expression<num>.raw(['get', 'r']));
      expect(layer.radius, isA<Call<num>>());
      expect(layer.color, isA<Call<Color>>());
      expect(layer.blur, isA<RawValue<num>>());
      expect(layer.strokeColor, isA<RawValue<Color>>());
      expect(layer.strokeColor.toJson(), 'chartreuse');
      expect(layer.filter, isA<Call<bool>>());
    });

    test('tell an array value from an expression', () {
      final layer = StyleLayer.fromJson({
        'id': 's',
        'type': 'symbol',
        'source': 's',
        'layout': {
          'text-font': ['get', 'font'],
          'icon-text-fit-padding': [1, 2, 3, 4],
          'text-variable-anchor': ['top', 'left'],
        },
      }) as SymbolStyleLayer;
      expect(layer.textFont, isA<Call<List<String>>>());
      expect(layer.iconTextFitPadding, const Literal<List<num>>([1, 2, 3, 4]));
      expect(
        layer.textVariableAnchor,
        const Literal([TextVariableAnchor.top, TextVariableAnchor.left]),
      );
    });
  });

  group('setters', () {
    test('change the object', () {
      final line = LineStyleLayer(id: 'l', sourceId: 's')
        ..width = const .literal(3)
        ..visible = false
        ..minZoom = 1
        ..maxZoom = 2
        ..filter = Expression.has('a');
      expect(line.toJson(), {
        'id': 'l',
        'type': 'line',
        'source': 's',
        'minzoom': 1.0,
        'maxzoom': 2.0,
        'filter': ['has', 'a'],
        'layout': {'visibility': 'none'},
        'paint': {'line-width': 3},
      });
    });

    test('null resets a property to its default', () {
      final line = LineStyleLayer(id: 'l', sourceId: 's')
        ..width = const .literal(3)
        ..width = null;
      expect(line.width, const Literal<num>(1));
      expect(line.toJson(), isNot(contains('paint')));
    });

    test('updateFrom sets only what differs', () {
      final layer = LineStyleLayer(
        id: 'l',
        sourceId: 's',
        width: const .literal(1),
        blur: const .literal(1),
        cap: const .literal(LineCap.round),
        filter: Expression.has('a'),
      );
      layer.updateFrom(
        LineStyleLayer(
          id: 'l',
          sourceId: 's',
          width: const .literal(2),
          blur: const .literal(1),
          minZoom: 3,
          filter: Expression.has('b'),
        ),
      );
      expect(layer.toJson(), {
        'id': 'l',
        'type': 'line',
        'source': 's',
        'minzoom': 3.0,
        'filter': ['has', 'b'],
        'paint': {'line-width': 2, 'line-blur': 1},
      });
    });
  });
}

// Dot shorthands need the type of the local variable.
// ignore_for_file: omit_local_variable_types

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

void main() {
  void expectJson(Expression<Object?> expression, Object? json) =>
      expect(expression.toJson(), json);

  group('Literal', () {
    test('writes scalars as they are', () {
      expectJson(const Expression<num>.literal(5), 5);
      expectJson(const Expression<String>.literal('a'), 'a');
      expectJson(const Expression<bool>.literal(true), true);
      expectJson(const Expression<Object?>.literal(null), null);
    });

    test('wraps lists, maps and offsets', () {
      expectJson(const Expression<List<num>>.literal([1, 2]), [
        'literal',
        [1, 2],
      ]);
      expectJson(const Expression<Map<String, num>>.literal({'a': 1}), [
        'literal',
        {'a': 1},
      ]);
      expectJson(const Expression<Offset>.literal(Offset(1, 2)), [
        'literal',
        [1.0, 2.0],
      ]);
    });

    test('writes colors as CSS strings', () {
      expectJson(const Expression.literal(Color(0xFFFF0080)), '#ff0080');
      expect(
        const Literal(Color(0x80FF0000)).toJson(),
        startsWith('rgba(255, 0, 0, 0.50'),
      );
      expectJson(const Expression.literal([Color(0xFF000000)]), [
        'literal',
        ['#000000'],
      ]);
    });

    test('writes enums as their spec strings', () {
      expectJson(
        const Expression.literal(SymbolPlacement.lineCenter),
        'line-center',
      );
      expectJson(const Expression.literal([TextWritingMode.vertical]), [
        'literal',
        ['vertical'],
      ]);
    });
  });

  group('Expression', () {
    test('compares deeply by JSON', () {
      expect(
        Expression.get('a').asNumber() > const Expression.literal(1),
        Expression.get('a').asNumber() > const Expression.literal(1),
      );
      expect(
        (Expression.get('a').asNumber() > const Expression.literal(1)).hashCode,
        (Expression.get('a').asNumber() > const Expression.literal(1)).hashCode,
      );
      expect(Expression.get('a') == Expression.get('b'), isFalse);
      expect(const Literal<num>(5), const Literal<num>(5.0));
      expect(
        const Expression<List<num>>.literal([1]),
        const Expression<List<num>>.literal([1]),
      );
    });

    test('raw keeps its JSON', () {
      expectJson(const Expression<num>.raw(['zoom']), ['zoom']);
    });

    test('cast changes the type only', () {
      expect(Expression.get('a').cast<num>(), isA<Expression<num>>());
      expectJson(Expression.get('a').cast<num>(), ['get', 'a']);
      expect(const Literal<Object?>(1).cast<num>(), isA<Literal<num>>());
      expect(const Literal<Object?>(1).cast<String>(), isA<RawValue<String>>());
      expectJson(const Literal<Object?>(1).cast<String>(), 1);
    });

    test('works with dot shorthands', () {
      final Expression<bool> filter = .all([
        .greaterThan(.get('mag').asNumber(), const .literal(5)),
        .has('place'),
      ]);
      expectJson(filter, [
        'all',
        [
          '>',
          [
            'number',
            ['get', 'mag'],
          ],
          5,
        ],
        ['has', 'place'],
      ]);
      final Expression<num> radius = .interpolate(
        const .exponential(2),
        .zoom(),
        {10: const .literal(8), 5: const .literal(2)},
      );
      expectJson(radius, [
        'interpolate',
        ['exponential', 2],
        ['zoom'],
        5,
        2,
        10,
        8,
      ]);
      final Expression<Color> color = .match(.get('type'), {
        'major': const .literal(Color(0xFFFF0000)),
      }, fallback: const .literal(Color(0xFF888888)));
      expectJson(color, [
        'match',
        ['get', 'type'],
        'major',
        '#ff0000',
        '#888888',
      ]);
    });
  });

  group('variables and control flow', () {
    test('withVariable', () {
      expectJson(
        Expression.withVariable(
          'size',
          Expression.get('size').asNumber(),
          (size) => size.use() * size.use(),
        ),
        [
          'let',
          'size',
          [
            'number',
            ['get', 'size'],
          ],
          [
            '*',
            ['var', 'size'],
            ['var', 'size'],
          ],
        ],
      );
    });

    test('select', () {
      expectJson(
        Expression.select<num>([
          (Expression.has('a'), const .literal(1)),
          (Expression.has('b'), const .literal(2)),
        ], fallback: const .literal(3)),
        [
          'case',
          ['has', 'a'],
          1,
          ['has', 'b'],
          2,
          3,
        ],
      );
    });

    test('match with a list of labels', () {
      expectJson(
        Expression.match<num>(Expression.get('a'), {
          const ['x', 'y']: const .literal(1),
          2: const .literal(2),
        }, fallback: const .literal(3)),
        [
          'match',
          ['get', 'a'],
          ['x', 'y'],
          1,
          2,
          2,
          3,
        ],
      );
    });

    test('coalesce', () {
      expectJson(
        Expression.coalesce<Object?>([
          Expression.get('a'),
          const .literal('b'),
        ]),
        [
          'coalesce',
          ['get', 'a'],
          'b',
        ],
      );
    });

    test('step sorts its stops', () {
      expectJson(
        Expression.step<num>(Expression.zoom(), const .literal(0), {
          10: const .literal(2),
          5: const .literal(1),
        }),
        [
          'step',
          ['zoom'],
          0,
          5,
          1,
          10,
          2,
        ],
      );
    });

    test('interpolate variants', () {
      expectJson(
        Expression.interpolate<num>(const .linear(), Expression.zoom(), {
          1: const .literal(1),
        }),
        [
          'interpolate',
          ['linear'],
          ['zoom'],
          1,
          1,
        ],
      );
      expectJson(
        Expression.interpolate<num>(
          const .cubicBezier(0, 0.5, 1, 0.5),
          Expression.zoom(),
          {1: const .literal(1)},
        ),
        [
          'interpolate',
          ['cubic-bezier', 0, 0.5, 1, 0.5],
          ['zoom'],
          1,
          1,
        ],
      );
      expectJson(
        Expression.interpolateHcl(const .linear(), Expression.zoom(), {
          1: const .literal(Color(0xFF000000)),
        }),
        [
          'interpolate-hcl',
          ['linear'],
          ['zoom'],
          1,
          '#000000',
        ],
      );
      expectJson(
        Expression.interpolateLab(const .linear(), Expression.zoom(), {
          1: const .literal(Color(0xFF000000)),
        }),
        [
          'interpolate-lab',
          ['linear'],
          ['zoom'],
          1,
          '#000000',
        ],
      );
    });
  });

  group('types', () {
    final value = Expression.get('v');
    final raw = ['get', 'v'];

    test('assertions', () {
      expectJson(value.asString(), ['string', raw]);
      expectJson(value.asNumber([const Literal(1)]), ['number', raw, 1]);
      expectJson(value.asBoolean(), ['boolean', raw]);
      expectJson(value.asObject(), ['object', raw]);
      expectJson(value.asArray<Object?>(), ['array', raw]);
      expectJson(value.asArray<num>(), ['array', 'number', raw]);
      expectJson(value.asArray<String>(length: 2), ['array', 'string', 2, raw]);
    });

    test('conversions', () {
      expectJson(value.type(), ['typeof', raw]);
      expectJson(value.convertToString(), ['to-string', raw]);
      expectJson(value.convertToNumber(), ['to-number', raw]);
      expectJson(value.convertToBoolean(), ['to-boolean', raw]);
      expectJson(value.convertToColor([const Literal('red')]), [
        'to-color',
        raw,
        'red',
      ]);
      expectJson(const Literal(Color(0xFF000000)).toRgba(), [
        'to-rgba',
        '#000000',
      ]);
    });

    test('semiliteral', () {
      expectJson(Expression.semiliteral<Object?>([value, const Literal(1)]), [
        'semiliteral',
        [raw, 1],
      ]);
    });

    test('colors', () {
      const c = Literal<num>(1);
      expectJson(Expression.rgb(c, c, c), ['rgb', 1, 1, 1]);
      expectJson(Expression.rgba(c, c, c, c), ['rgba', 1, 1, 1, 1]);
    });

    test('formatted text', () {
      expectJson(
        Expression.format([
          FormatSection(
            value,
            fontScale: const .literal(1.2),
            textFont: const .literal(['Noto']),
            textColor: const .literal(Color(0xFF000000)),
            verticalAlign: const .literal('top'),
          ),
          FormatSection(Expression.image(const .literal('i'))),
        ]),
        [
          'format',
          raw,
          {
            'font-scale': 1.2,
            'text-font': [
              'literal',
              ['Noto'],
            ],
            'text-color': '#000000',
            'vertical-align': 'top',
          },
          ['image', 'i'],
          <String, Object?>{},
        ],
      );
    });

    test('collator', () {
      final collator = Expression.collator(
        caseSensitive: const .literal(true),
        diacriticSensitive: const .literal(false),
        locale: const .literal('de'),
      );
      expectJson(collator, [
        'collator',
        {'case-sensitive': true, 'diacritic-sensitive': false, 'locale': 'de'},
      ]);
      expectJson(collator.resolvedLocale(), [
        'resolved-locale',
        collator.toJson(),
      ]);
      expectJson(
        Expression.equal(value, const .literal('a'), collator: collator),
        ['==', raw, 'a', collator.toJson()],
      );
    });
  });

  group('data access', () {
    test('every accessor', () {
      expectJson(Expression.get('a'), ['get', 'a']);
      expectJson(Expression.get('a', object: Expression.properties()), [
        'get',
        'a',
        ['properties'],
      ]);
      expectJson(Expression.has('a'), ['has', 'a']);
      expectJson(Expression.has('a', object: Expression.properties()), [
        'has',
        'a',
        ['properties'],
      ]);
      expectJson(Expression.properties(), ['properties']);
      expectJson(Expression.featureState('a'), ['feature-state', 'a']);
      expectJson(Expression.globalState('a'), ['global-state', 'a']);
      expectJson(Expression.geometryType(), ['geometry-type']);
      expectJson(Expression.id(), ['id']);
      expectJson(Expression.zoom(), ['zoom']);
      expectJson(Expression.heatmapDensity(), ['heatmap-density']);
      expectJson(Expression.elevation(), ['elevation']);
      expectJson(Expression.lineProgress(), ['line-progress']);
      expectJson(Expression.accumulated(), ['accumulated']);
    });
  });

  group('numbers', () {
    const a = Literal<num>(1);
    const b = Literal<num>(2);

    test('operators', () {
      expectJson(a + b, ['+', 1, 2]);
      expectJson(a - b, ['-', 1, 2]);
      expectJson(a * b, ['*', 1, 2]);
      expectJson(a / b, ['/', 1, 2]);
      expectJson(a % b, ['%', 1, 2]);
      expectJson(-a, ['-', 1]);
      expectJson(a > b, ['>', 1, 2]);
      expectJson(a < b, ['<', 1, 2]);
      expectJson(a >= b, ['>=', 1, 2]);
      expectJson(a <= b, ['<=', 1, 2]);
      expectJson(a.pow(b), ['^', 1, 2]);
    });

    test('functions', () {
      final functions = {
        'sqrt': a.sqrt(),
        'log10': a.log10(),
        'ln': a.ln(),
        'log2': a.log2(),
        'sin': a.sin(),
        'cos': a.cos(),
        'tan': a.tan(),
        'asin': a.asin(),
        'acos': a.acos(),
        'atan': a.atan(),
        'round': a.round(),
        'abs': a.abs(),
        'ceil': a.ceil(),
        'floor': a.floor(),
      };
      for (final MapEntry(:key, :value) in functions.entries) {
        expectJson(value, [key, 1]);
      }
    });

    test('constants and lists', () {
      expectJson(Expression.pi(), ['pi']);
      expectJson(Expression.e(), ['e']);
      expectJson(Expression.ln2(), ['ln2']);
      expectJson(Expression.sum([a, b, a]), ['+', 1, 2, 1]);
      expectJson(Expression.product([a, b, a]), ['*', 1, 2, 1]);
      expectJson(Expression.min([a, b]), ['min', 1, 2]);
      expectJson(Expression.max([a, b]), ['max', 1, 2]);
    });

    test('numberFormat', () {
      expectJson(
        a.numberFormat(
          locale: const .literal('de'),
          currency: const .literal('EUR'),
          minFractionDigits: const .literal(1),
          maxFractionDigits: const .literal(2),
        ),
        [
          'number-format',
          1,
          {
            'locale': 'de',
            'currency': 'EUR',
            'min-fraction-digits': 1,
            'max-fraction-digits': 2,
          },
        ],
      );
    });

    test('geometry', () {
      const point = {
        'type': 'Point',
        'coordinates': [0, 0],
      };
      expectJson(Expression.distance(point), ['distance', point]);
      expectJson(Expression.within(point), ['within', point]);
    });
  });

  group('comparisons and logic', () {
    const a = Literal<num>(1);
    const b = Literal<num>(2);
    const t = Literal(true);

    test('statics', () {
      expectJson(Expression.equal(a, b), ['==', 1, 2]);
      expectJson(Expression.notEqual(a, b), ['!=', 1, 2]);
      expectJson(Expression.greaterThan(a, b), ['>', 1, 2]);
      expectJson(Expression.lessThan(a, b), ['<', 1, 2]);
      expectJson(Expression.greaterThanOrEqual(a, b), ['>=', 1, 2]);
      expectJson(Expression.lessThanOrEqual(a, b), ['<=', 1, 2]);
    });

    test('logic', () {
      expectJson(Expression.all([t, t]), ['all', true, true]);
      expectJson(Expression.any([t, t]), ['any', true, true]);
      expectJson(t.not(), ['!', true]);
    });
  });

  group('strings and lists', () {
    const s = Literal('abc');
    const x = Literal('b');
    const list = Literal<List<String>>(['a']);
    const one = Literal<num>(1);
    const rawList = [
      'literal',
      ['a'],
    ];

    test('strings', () {
      expectJson(s + x, ['concat', 'abc', 'b']);
      expectJson(s > x, ['>', 'abc', 'b']);
      expectJson(s < x, ['<', 'abc', 'b']);
      expectJson(s >= x, ['>=', 'abc', 'b']);
      expectJson(s <= x, ['<=', 'abc', 'b']);
      expectJson(s.contains(x), ['in', 'b', 'abc']);
      expectJson(s.indexOf(x), ['index-of', 'b', 'abc']);
      expectJson(s.indexOf(x, from: one), ['index-of', 'b', 'abc', 1]);
      expectJson(s.slice(one), ['slice', 'abc', 1]);
      expectJson(s.slice(one, one), ['slice', 'abc', 1, 1]);
      expectJson(s.length(), ['length', 'abc']);
      expectJson(s.upcase(), ['upcase', 'abc']);
      expectJson(s.downcase(), ['downcase', 'abc']);
      expectJson(s.split(x), ['split', 'abc', 'b']);
      expectJson(s.isSupportedScript(), ['is-supported-script', 'abc']);
      expectJson(Expression.concat([s, one]), ['concat', 'abc', 1]);
    });

    test('lists', () {
      expectJson(list.at(one), ['at', 1, rawList]);
      expectJson(list.contains(x), ['in', 'b', rawList]);
      expectJson(list.indexOf(x), ['index-of', 'b', rawList]);
      expectJson(list.indexOf(x, from: one), ['index-of', 'b', rawList, 1]);
      expectJson(list.slice(one), ['slice', rawList, 1]);
      expectJson(list.slice(one, one), ['slice', rawList, 1, 1]);
      expectJson(list.length(), ['length', rawList]);
      expectJson(list.join(x), ['join', rawList, 'b']);
    });
  });
}

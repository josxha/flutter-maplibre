// ignore_for_file: prefer_single_quotes

import 'package:flutter_test/flutter_test.dart'
    show equals, expect, group, test;
import 'package:maplibre/expressions.dart';

void main() {
  group('Style Expressions', () {
    test('let var', () {
      final expected = [
        "let",
        "someNumber",
        500,
        [
          "interpolate",
          ["linear"],
          ["var", "someNumber"],
          274,
          "#edf8e9",
          1551,
          "#006d2c",
        ],
      ];
      final expression = Expression.let(
        variables: {'someNumber': 500},
        expression: Expression.interpolate(
          type: InterpolationType.linear(),
          input: Expression.var_('someNumber'),
          stopInputs: [274, 1551],
          stopOutputs: ['#edf8e9', '#006d2c'],
        ),
      );
      expect(expression.json, equals(expected));
    });
    test('literal', () {
      final expected = [
        "literal",
        ["DIN Offc Pro Italic", "Arial Unicode MS Regular"],
      ];
      final expression = Expression.literal([
        "DIN Offc Pro Italic",
        "Arial Unicode MS Regular",
      ]);
      expect(expression.json, equals(expected));
    });
    test('array', () {
      final expected = [
        "array",
        "string",
        3,
        [
          "literal",
          ["a", "b", "c"],
        ],
      ];
      final expression = Expression.array(
        Expression.literal(["a", "b", "c"]),
        length: 3,
        type: .string,
      );
      expect(expression.json, equals(expected));
    });
    test('typeof', () {
      final expected = [
        "typeof",
        ["get", "name"],
      ];
      final expression = Expression.typeOf(Expression.get('name'));
      expect(expression.json, equals(expected));
    });
    test('string', () {
      final expected = [
        "string",
        ["get", "name"],
      ];
      final expression = Expression.string([Expression.get('name')]);
      expect(expression.json, equals(expected));
    });
    test('number', () {
      final expected = [
        "number",
        ["get", "population"],
      ];
      final expression = Expression.number([Expression.get('population')]);
      expect(expression.json, equals(expected));
    });
    test('boolean', () {
      final expected = [
        "boolean",
        ["feature-state", "hover"],
        false,
      ];
      final expression = Expression.boolean([
        Expression.featureState('hover'),
        false,
      ]);
      expect(expression.json, equals(expected));
    });
    test('object', () {
      final expected = [
        "object",
        ["get", "some-property"],
      ];
      final expression = Expression.object([Expression.get('some-property')]);
      expect(expression.json, equals(expected));
    });
    test('collator', () {
      final expected = [
        "collator",
        {"case-sensitive": true, "diacritic-sensitive": true, "locale": "fr"},
      ];
      final expression = Expression.collator(
        caseSensitive: true,
        diacriticSensitive: true,
        locale: 'fr',
      );
      expect(expression.json, equals(expected));
    });
    test('format', () {
      final expected = [
        "format",
        [
          "upcase",
          ["get", "FacilityName"],
        ],
        {"font-scale": 0.8},
        "\n\n",
        <dynamic, dynamic>{},
        [
          "downcase",
          ["get", "Comments"],
        ],
        {"font-scale": 0.6, "vertical-align": "center"},
      ];
      final expression = Expression.format([
        FormatSection(
          content: Expression.upcase(Expression.get('FacilityName')),
          style: StyleOverrides(fontScale: 0.8),
        ),
        FormatSection(content: '\n\n'),
        FormatSection(
          content: Expression.downcase(Expression.get('Comments')),
          style: StyleOverrides(fontScale: 0.6, verticalAlign: .center),
        ),
      ]);
      expect(expression.json, equals(expected));
    });
    test('image', () {
      final expected = ["image", "marker_15"];
      final expression = Expression.image("marker_15");
      expect(expression.json, equals(expected));
    });
    test('number-format', () {
      final expected = [
        "number-format",
        ["get", "mag"],
        {"min-fraction-digits": 1, "max-fraction-digits": 1},
      ];
      final expression = Expression.numberFormat(
        input: Expression.get('mag'),
        minFractionDigits: 1,
        maxFractionDigits: 1,
      );
      expect(expression.json, equals(expected));
    });
    test('to-string', () {
      final expected = [
        "to-string",
        ["get", "mag"],
      ];
      final expression = Expression.toString(Expression.get('mag'));
      expect(expression.json, equals(expected));
    });
    test('to-number', () {
      final expected = ["to-number", Expression.get('someProperty')];
      final expression = Expression.toNumber(Expression.get('someProperty'));
      expect(expression.json, equals(expected));
    });
    test('to-boolean', () {
      final expected = ["to-boolean", Expression.get('someProperty')];
      final expression = Expression.toBoolean(Expression.get('someProperty'));
      expect(expression.json, equals(expected));
    });
    test('to-color', () {
      final expected = ["to-color", "#edf8e9"];
      final expression = Expression.toColor(['#edf8e9']);
      expect(expression.json, equals(expected));
    });
    test('at', () {
      final expected = [
        "at",
        1,
        [
          "literal",
          ["a", "b", "c"],
        ],
      ];
      final expression = Expression.at(
        index: 1,
        list: Expression.literal(["a", "b", "c"]),
      );
      expect(expression.json, equals(expected));
    });
    test('in', () {
      final expected = ["in", r"$type", "Point"];
      final expression = Expression.in_(item: r'$type', list: "Point");
      expect(expression.json, equals(expected));
    });
    test('index-of', () {
      final expected = [
        "index-of",
        "foo",
        ["baz", "bar", "hello", "foo", "world"],
      ];
      final expression = Expression.indexOf(
        item: "foo",
        list: ["baz", "bar", "hello", "foo", "world"],
      );
      expect(expression.json, equals(expected));
    });
    test('slice', () {
      final expected = [
        "slice",
        ["get", "name"],
        0,
        3,
      ];
      final expression = Expression.slice(
        input: Expression.get('name'),
        start: 0,
        end: 3,
      );
      expect(expression.json, equals(expected));
    });
    test('global-state', () {
      final expected = ["global-state", "someProperty"];
      final expression = Expression.globalState('someProperty');
      expect(expression.json, equals(expected));
    });
    test('get', () {
      final expected = ["get", "someProperty"];
      final expression = Expression.get('someProperty');
      expect(expression.json, equals(expected));
    });
    test('has', () {
      final expected = ["has", "someProperty"];
      final expression = Expression.has('someProperty');
      expect(expression.json, equals(expected));
    });
    test('length', () {
      final expected = [
        "length",
        ["get", "myArray"],
      ];
      final expression = Expression.length(Expression.get('myArray'));
      expect(expression.json, equals(expected));
    });
    test('case', () {
      final expected = [
        "case",
        [
          "boolean",
          ["feature-state", "hover"],
          false,
        ],
        1,
        0.5,
      ];
      final expression = Expression.case_(
        cases: {
          Expression.boolean([Expression.featureState('hover'), false]): 1,
        },
        fallback: 0.5,
      );
      expect(expression.json, equals(expected));
    });
    test('match', () {
      final expected = [
        "match",
        ["get", "building_type"],
        "residential",
        "#f00",
        "commercial",
        "#0f0",
        "#000",
      ];
      final expression = Expression.match(
        input: Expression.get('building_type'),
        cases: {'residential': '#f00', 'commercial': '#0f0'},
        fallback: '#000',
      );
      expect(expression.json, equals(expected));
    });
    test('coalesce', () {
      final expected = [
        "coalesce",
        [
          "image",
          [
            "concat",
            ["get", "icon"],
            "_15",
          ],
        ],
        ["image", "marker_15"],
      ];
      final expression = Expression.coalesce([
        Expression.image(Expression.concat([Expression.get('icon'), '_15'])),
        Expression.image("marker_15"),
      ]);
      expect(expression.json, equals(expected));
    });
    test('==', () {
      final expected = ["==", r"$type", "Polygon"];
      final expression = Expression.equal(r"$type", "Polygon");
      expect(expression.json, equals(expected));
    });
    test('!=', () {
      final expected = ["!=", "cluster", true];
      final expression = Expression.notEqual('cluster', true);
      expect(expression.json, equals(expected));
    });
    test('>', () {
      final expected = [
        ">",
        ["get", "mag"],
        2,
      ];
      final expression = Expression.greaterThan(Expression.get('mag'), 2);
      expect(expression.json, equals(expected));
    });
    test('<', () {
      final expected = [
        "<",
        ["get", "mag"],
        2,
      ];
      final expression = Expression.lessThan(Expression.get('mag'), 2);
      expect(expression.json, equals(expected));
    });
    test('>=', () {
      final expected = [
        ">=",
        ["get", "mag"],
        6,
      ];
      final expression = Expression.greaterThanOrEqual(
        Expression.get('mag'),
        6,
      );
      expect(expression.json, equals(expected));
    });
    test('<=', () {
      final expected = [
        "<=",
        ["get", "mag"],
        6,
      ];
      final expression = Expression.lessThanOrEqual(Expression.get('mag'), 6);
      expect(expression.json, equals(expected));
    });
    test('all', () {
      final expected = [
        "all",
        [
          ">=",
          ["get", "mag"],
          4,
        ],
        [
          "<",
          ["get", "mag"],
          5,
        ],
      ];
      final expression = Expression.all([
        Expression.greaterThanOrEqual(Expression.get('mag'), 4),
        Expression.lessThan(Expression.get('mag'), 5),
      ]);
      expect(expression.json, equals(expected));
    });
    test('any', () {
      final expected = [
        "any",
        [
          ">=",
          ["get", "mag"],
          4,
        ],
        [
          "<",
          ["get", "mag"],
          5,
        ],
      ];
      final expression = Expression.any([
        Expression.greaterThanOrEqual(Expression.get('mag'), 4),
        Expression.lessThan(Expression.get('mag'), 5),
      ]);
      expect(expression.json, equals(expected));
    });
    test('!', () {
      final expected = [
        "!",
        ["has", "point_count"],
      ];
      final expression = Expression.not(Expression.has('point_count'));
      expect(expression.json, equals(expected));
    });
    test('within', () {
      final expected = [
        "within",
        {
          "type": "Polygon",
          "coordinates": [
            [
              [0, 0],
              [0, 5],
              [5, 5],
              [5, 0],
              [0, 0],
            ],
          ],
        },
      ];
      final expression = Expression.within(
        Polygon.from([
          [
            Position.create(x: 0, y: 0),
            Position.create(x: 0, y: 5),
            Position.create(x: 5, y: 5),
            Position.create(x: 5, y: 0),
            Position.create(x: 0, y: 0),
          ],
        ]),
      );
      expect(expression.json, equals(expected));
    });
    test('step', () {
      final expected = [
        "step",
        ["get", "point_count"],
        20,
        100,
        30,
        750,
        40,
      ];
      final expression = Expression.step(
        input: Expression.get('point_count'),
        output0: 20,
        stopInputs: [100, 750],
        stopOutputs: [30, 40],
      );
      expect(expression.json, equals(expected));
    });
    test('interpolate', () {
      final expected = [
        "interpolate",
        ["linear"],
        ["zoom"],
        15,
        0,
        15.05,
        ["get", "height"],
      ];
      final expression = Expression.interpolate(
        type: InterpolationType.linear(),
        input: const Expression.fromJson(['zoom']),
        stopInputs: [15, 15.05],
        stopOutputs: [0, Expression.get('height')],
      );
      expect(expression.json, equals(expected));
    });
    test('interpolate-hcl', () {
      final expected = [
        "interpolate-hcl",
        ["linear"],
        ["zoom"],
        15.0,
        "#f00",
        15.05,
        "#00f",
      ];
      final expression = Expression.interpolateHcl(
        type: InterpolationType.linear(),
        input: const Expression.fromJson(['zoom']),
        stopInputs: [15, 15.05],
        stopOutputs: ['#f00', '#00f'],
      );
      expect(expression.json, equals(expected));
    });
    test('interpolate-lab', () {
      final expected = [
        "interpolate-lab",
        ["linear"],
        ["zoom"],
        15.0,
        "#f00",
        15.05,
        "#00f",
      ];
      final expression = Expression.interpolateLab(
        type: InterpolationType.linear(),
        input: const Expression.fromJson(['zoom']),
        stopInputs: [15, 15.05],
        stopOutputs: ['#f00', '#00f'],
      );
      expect(expression.json, equals(expected));
    });
    test('ln2', () {
      final expected = ["ln2"];
      final expression = Expression.ln2();
      expect(expression.json, equals(expected));
    });
    test('pi', () {
      final expected = ["pi"];
      final expression = Expression.pi();
      expect(expression.json, equals(expected));
    });
    test('e', () {
      final expected = ["e"];
      final expression = Expression.e();
      expect(expression.json, equals(expected));
    });
    test('+', () {
      final expected = ["+", 2, 3];
      final expression = Expression.sum([2, 3]);
      expect(expression.json, equals(expected));
    });
    test('*', () {
      final expected = ["*", 2, 3];
      final expression = Expression.product([2, 3]);
      expect(expression.json, equals(expected));
    });
    test('-', () {
      final expected = ["-", 10];
      final expression = Expression.subtract(10);
      expect(expression.json, equals(expected));
    });
    test('/', () {
      final expected = [
        "/",
        ["get", "population"],
        ["get", "sq-km"],
      ];
      final expression = Expression.divide(
        Expression.get('population'),
        Expression.get('sq-km'),
      );
      expect(expression.json, equals(expected));
    });
    test('%', () {
      final expected = ["%", 10, 3];
      final expression = Expression.mod(10, 3);
      expect(expression.json, equals(expected));
    });
    test('^', () {
      final expected = ["^", 2, 3];
      final expression = Expression.pow(2, 3);
      expect(expression.json, equals(expected));
    });
    test('sqrt', () {
      final expected = ["sqrt", 9];
      final expression = Expression.sqrt(9);
      expect(expression.json, equals(expected));
    });
    test('log10', () {
      final expected = ["log10", 8];
      final expression = Expression.log10(8);
      expect(expression.json, equals(expected));
    });
    test('ln', () {
      final expected = ["ln", 8];
      final expression = Expression.ln(8);
      expect(expression.json, equals(expected));
    });
    test('log2', () {
      final expected = ["log2", 8];
      final expression = Expression.log2(8);
      expect(expression.json, equals(expected));
    });
    test('sin', () {
      final expected = ["sin", 1];
      final expression = Expression.sin(1);
      expect(expression.json, equals(expected));
    });
    test('cos', () {
      final expected = ["cos", 1];
      final expression = Expression.cos(1);
      expect(expression.json, equals(expected));
    });
    test('tan', () {
      final expected = ["tan", 1];
      final expression = Expression.tan(1);
      expect(expression.json, equals(expected));
    });
    test('asin', () {
      final expected = ["asin", 1];
      final expression = Expression.asin(1);
      expect(expression.json, equals(expected));
    });
    test('acos', () {
      final expected = ["acos", 1];
      final expression = Expression.acos(1);
      expect(expression.json, equals(expected));
    });
    test('atan', () {
      final expected = ["atan", 1];
      final expression = Expression.atan(1);
      expect(expression.json, equals(expected));
    });
    test('min', () {
      final expected = ["min", 1, 2];
      final expression = Expression.min([1, 2]);
      expect(expression.json, equals(expected));
    });
    test('max', () {
      final expected = ["max", 1, 2];
      final expression = Expression.max([1, 2]);
      expect(expression.json, equals(expected));
    });
    test('round', () {
      final expected = ["round", 1.5];
      final expression = Expression.round(1.5);
      expect(expression.json, equals(expected));
    });
    test('abs', () {
      final expected = ["abs", -1.5];
      final expression = Expression.abs(-1.5);
      expect(expression.json, equals(expected));
    });
    test('ceil', () {
      final expected = ["ceil", 1.5];
      final expression = Expression.ceil(1.5);
      expect(expression.json, equals(expected));
    });
    test('floor', () {
      final expected = ["floor", 1.5];
      final expression = Expression.floor(1.5);
      expect(expression.json, equals(expected));
    });
    test('distance', () {
      final expected = [
        "distance",
        {
          "type": "Point",
          "coordinates": [0, 0],
        },
      ];
      final expression = Expression.distance(Point.build(const [0, 0]));
      expect(expression.json, equals(expected));
    });
    test('to-rgba', () {
      final expected = ["to-rgba", "#ff0000"];
      final expression = Expression.toRgba('#ff0000');
      expect(expression.json, equals(expected));
    });
    test('rgb', () {
      final expected = ["rgb", 255, 0, 0];
      final expression = Expression.rgb(255, 0, 0);
      expect(expression.json, equals(expected));
    });
    test('rgba', () {
      final expected = ["rgba", 255, 0, 0, 1];
      final expression = Expression.rgba(red: 255, green: 0, blue: 0, alpha: 1);
      expect(expression.json, equals(expected));
    });
    test('properties', () {
      final expected = ["properties"];
      const expression = Expression.properties();
      expect(expression.json, equals(expected));
    });
    test('feature-state', () {
      final expected = ["feature-state", "hover"];
      final expression = Expression.featureState('hover');
      expect(expression.json, equals(expected));
    });
    test('geometry-type', () {
      final expected = [
        "==",
        ["geometry-type"],
        "Polygon",
      ];
      final expression = Expression.equal(
        const Expression.geometryType(),
        "Polygon",
      );
      expect(expression.json, equals(expected));
    });
    test('id', () {
      final expected = ["id"];
      const expression = Expression.id();
      expect(expression.json, equals(expected));
    });
    test('line-progress', () {
      final expected = ["line-progress"];
      final expression = Expression.lineProgress();
      expect(expression.json, equals(expected));
    });
    test('accumulated', () {
      final expected = ["accumulated"];
      final expression = Expression.accumulated();
      expect(expression.json, equals(expected));
    });
    test('zoom', () {
      final expected = [
        "interpolate",
        ["linear"],
        ["zoom"],
        15,
        0,
        15.05,
        ["get", "height"],
      ];
      final expression = Expression.interpolate(
        type: InterpolationType.linear(),
        input: Expression.zoom(),
        stopInputs: [15, 15.05],
        stopOutputs: [0, Expression.get('height')],
      );
      expect(expression.json, equals(expected));
    });
    test('heatmap-density', () {
      final expected = ["heatmap-density"];
      final expression = Expression.heatmapDensity();
      expect(expression.json, equals(expected));
    });
    test('elevation', () {
      final expected = ["elevation"];
      const expression = Expression.elevation();
      expect(expression.json, equals(expected));
    });
    test('is-supported-script', () {
      final expected = ["is-supported-script", "दिल्ली"];
      final expression = Expression.isSupportedScript('दिल्ली');
      expect(expression.json, equals(expected));
    });
    test('upcase', () {
      final expected = [
        "upcase",
        ["get", "name"],
      ];
      final expression = Expression.upcase(Expression.get('name'));
      expect(expression.json, equals(expected));
    });
    test('downcase', () {
      final expected = [
        "downcase",
        ["get", "name"],
      ];
      final expression = Expression.downcase(Expression.get('name'));
      expect(expression.json, equals(expected));
    });
    test('concat', () {
      final expected = [
        "concat",
        "square-rgb-",
        ["get", "color"],
      ];
      final expression = Expression.concat([
        "square-rgb-",
        Expression.get('color'),
      ]);
      expect(expression.json, equals(expected));
    });
    test('resolved-locale', () {
      final expected = [
        "resolved-locale",
        [
          "collator",
          {
            "case-sensitive": true,
            "diacritic-sensitive": false,
            "locale": "de",
          },
        ],
      ];
      final expression = Expression.resolvedLocale(
        Expression.collator(
          caseSensitive: true,
          diacriticSensitive: false,
          locale: 'de',
        ),
      );
      expect(expression.json, equals(expected));
    });
    test('split', () {
      final expected = [
        "split",
        ["get", "name"],
        ";",
      ];
      final expression = Expression.split(Expression.get('name'), ';');
      expect(expression.json, equals(expected));
    });
    test('join', () {
      final expected = [
        "join",
        [
          "split",
          ["get", "name"],
          ";",
        ],
        "\n",
      ];
      final expression = Expression.join([
        Expression.split(Expression.get('name'), ';'),
      ], '\n');
      expect(expression.json, equals(expected));
    });
    test('test', () {});
  });
}

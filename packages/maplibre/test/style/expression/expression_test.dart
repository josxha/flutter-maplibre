import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/expressions.dart';

void main() {
  group('Style Expressions', () {
    test('numberFormat', () {
      final expression = numberFormat(
        input: OneOf2.t2(e_()),
        locale: 'de-DE',
        currency: 'EUR',
        minFractionDigits: 2,
        maxFractionDigits: 2,
      );
      final expected = [
        'number-format',
        ['e'],
        {
          'locale': 'de-DE',
          'currency': 'EUR',
          'min-fraction-digits': 2,
          'max-fraction-digits': 2,
        },
      ];
      expect(expression.json, equals(expected));
    });
    test('match', () {
      final expression = match(
        input: join([
          OneOf2.t2(toString(e_())),
          OneOf2.t2(toString(ln2_())),
          OneOf2.t2(toString(pi_())),
        ], const OneOf2.t1(', ')),
        cases: {
          'case1': const OneOf2.t1('value1'),
          'case2': const OneOf2.t1('value2'),
        },
        fallback: const OneOf2.t1('fallback'),
      );
      final expected = [
        'match',
        [
          'join',
          [
            [
              'to-string',
              ['e'],
            ],
            [
              'to-string',
              ['ln2'],
            ],
            [
              'to-string',
              ['pi'],
            ],
          ],
          ', ',
        ],
        'case1',
        'value1',
        'case2',
        'value2',
        'fallback',
      ];
      expect(expression.json, equals(expected));
    });
  });
}

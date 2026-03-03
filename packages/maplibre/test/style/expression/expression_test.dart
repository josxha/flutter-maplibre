import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/expressions.dart';

void main() {
  group('Style Expressions', () {
    test('numberFormat', () {
      final expression = numberFormat(
        input: e_(),
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
        input: join([toString(e_()), toString(ln2_()), toString(pi_())], ', '),
        cases: {'case1': 'value1', 'case2': 'value2'},
        fallback: 'fallback',
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

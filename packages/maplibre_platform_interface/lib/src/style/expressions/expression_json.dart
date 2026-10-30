import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/src/style/expressions/expression.dart';
import 'package:maplibre_platform_interface/src/style/expressions/spec_operators.g.dart';
import 'package:maplibre_platform_interface/src/utils.dart';

/// An enum of the style spec, which carries its string in the spec.
///
/// {@category Style}
abstract interface class StyleEnum {
  /// The string of this value in the style spec.
  String get value;
}

/// Reads the value of a [T] from style JSON, or returns null if [json] is not
/// one.
typedef LiteralDecoder<T> = T? Function(Object? json);

/// Deep equality of JSON values.
bool jsonEquals(Object? a, Object? b) {
  if (identical(a, b)) return true;
  return switch ((a, b)) {
    (final List<Object?> a, final List<Object?> b) =>
      a.length == b.length &&
          Iterable<int>.generate(a.length).every((i) => jsonEquals(a[i], b[i])),
    (final Map<Object?, Object?> a, final Map<Object?, Object?> b) =>
      a.length == b.length &&
          a.entries.every(
            (e) => b.containsKey(e.key) && jsonEquals(e.value, b[e.key]),
          ),
    _ => a == b,
  };
}

/// A hash for [jsonEquals].
int jsonHash(Object? json) => switch (json) {
  final List<Object?> list => Object.hashAll(list.map(jsonHash)),
  final Map<Object?, Object?> map => Object.hashAllUnordered(
    map.entries.map((e) => Object.hash(e.key, jsonHash(e.value))),
  ),
  _ => json.hashCode,
};

/// The Dart value of a literal as style JSON: colors as CSS strings, enums as
/// their spec strings, offsets as two numbers.
Object? encodeLiteral(Object? value) => switch (value) {
  final Color color => cssColorOf(color),
  final StyleEnum enumValue => enumValue.value,
  final Offset offset => [offset.dx, offset.dy],
  final List<Object?> list => [for (final item in list) encodeLiteral(item)],
  final Map<Object?, Object?> map => {
    for (final MapEntry(:key, :value) in map.entries) key: encodeLiteral(value),
  },
  _ => value,
};

/// The value of [expression] for a property of style layer JSON. The style
/// spec's plain form of an array is the one every property accepts, so a
/// [Literal] goes without its `literal` wrapper.
Object? encodeProperty(Expression<Object?> expression) => switch (expression) {
  Literal(:final jsonValue) => jsonValue,
  _ => expression.toJson(),
};

/// The [Expression] of the style JSON [json] of a property: a [Literal] if
/// [decode] can read it, else a [Call] for expressions, else a [RawValue].
Expression<T> decodeExpression<T>(Object? json, LiteralDecoder<T> decode) {
  if (json case ['literal', final Object? value]) {
    if (decode(value) case final T literal?) return Literal(literal);
    return Call(json);
  }
  if (json is List<Object?> && _isCall(json)) return Call(json);
  if (decode(json) case final T literal?) return Literal(literal);
  return json is List<Object?> ? Call(json) : RawValue(json);
}

/// Whether [json] is an expression rather than an array value. Colors are read
/// as literals where they can be: MapLibre Native writes them as `rgba` calls.
bool _isCall(List<Object?> json) {
  final operator = json.firstOrNull;
  if (operator is! String || !specExpressionOperators.contains(operator)) {
    return false;
  }
  return _rgbaOf(json) == null;
}

/// Reads a number.
num? decodeNum(Object? json) => json is num ? json : null;

/// Reads a string.
String? decodeString(Object? json) => json is String ? json : null;

/// Reads a boolean.
bool? decodeBool(Object? json) => json is bool ? json : null;

/// Reads a color from a CSS string or MapLibre Native's `rgba` array.
Color? decodeColor(Object? json) => switch (json) {
  final String css => _parseCssColor(css),
  final List<Object?> list => _rgbaOf(list),
  _ => null,
};

/// Reads an offset from an array of two numbers.
Offset? decodeOffset(Object? json) => switch (json) {
  [final num dx, final num dy] => Offset(dx.toDouble(), dy.toDouble()),
  _ => null,
};

/// Reads an enum value of [values] from its spec string.
LiteralDecoder<T> decodeEnum<T extends StyleEnum>(List<T> values) =>
    (json) => values.where((e) => e.value == json).firstOrNull;

/// Reads a list of numbers. A single number is a list of one, as in the
/// `padding` and `numberArray` types of the spec.
List<num>? decodeNumList(Object? json) => _decodeList(json, decodeNum);

/// Reads a list of strings.
List<String>? decodeStringList(Object? json) => _decodeList(json, decodeString);

/// Reads a list of colors. A single color is a list of one, as in the
/// `colorArray` type of the spec.
List<Color>? decodeColorList(Object? json) => _decodeList(json, decodeColor);

/// Reads a list of enum values of [values].
LiteralDecoder<List<T>> decodeEnumList<T extends StyleEnum>(List<T> values) =>
    (json) => _decodeList(json, decodeEnum(values));

/// Reads a list of any values.
List<Object?>? decodeObjectList(Object? json) =>
    json is List<Object?> ? json : null;

List<T>? _decodeList<T>(Object? json, LiteralDecoder<T> decode) {
  if (json is! List<Object?>) {
    return switch (decode(json)) {
      final T value? => [value],
      _ => null,
    };
  }
  final result = <T>[];
  for (final item in json) {
    final value = decode(item);
    if (value == null) return null;
    result.add(value);
  }
  return result;
}

/// The [color] as a CSS string. MapLibre Native's parser doesn't read hex
/// colors with alpha, so translucent colors use `rgba()`.
String cssColorOf(Color color) {
  int channel(double value) => (value * 255).round();
  final (r, g, b) = (channel(color.r), channel(color.g), channel(color.b));
  if (color.a >= 1) {
    String hex(int value) => value.toRadixString(16).padLeft(2, '0');
    return '#${hex(r)}${hex(g)}${hex(b)}';
  }
  return 'rgba($r, $g, $b, ${color.a})';
}

Color? _rgbaOf(List<Object?> json) => switch (json) {
  ['rgb', final num r, final num g, final num b] => _rgba(r, g, b, 1),
  ['rgba', final num r, final num g, final num b, final num a] => _rgba(
    r,
    g,
    b,
    a,
  ),
  _ => null,
};

Color _rgba(num r, num g, num b, num a) => Color.from(
  alpha: a.toDouble().clamp(0, 1),
  red: (r / 255).clamp(0, 1),
  green: (g / 255).clamp(0, 1),
  blue: (b / 255).clamp(0, 1),
);

final _functionalColor = RegExp(r'^(rgb|hsl)a?\((.*)\)$');

/// Reads the CSS colors that styles commonly have. Extended color names are
/// not among them, see [RawValue].
Color? _parseCssColor(String css) {
  final color = css.trim().toLowerCase();
  if (color == 'transparent') return const Color(0x00000000);
  if (htmlColorNames[color] case final String hex) return _parseHex(hex);
  if (color.startsWith('#')) return _parseHex(color);
  final match = _functionalColor.firstMatch(color);
  if (match == null) return null;
  final parts = match.group(2)!.split(RegExp(r'[\s,/]+'));
  if (parts.length != 3 && parts.length != 4) return null;
  double? number(String part, num percentOf) => part.endsWith('%')
      ? switch (double.tryParse(part.substring(0, part.length - 1))) {
          final double value => value / 100 * percentOf,
          _ => null,
        }
      : double.tryParse(part);
  final alpha = parts.length == 4 ? number(parts[3], 1) : 1.0;
  if (alpha == null) return null;
  if (match.group(1) == 'rgb') {
    final r = number(parts[0], 255);
    final g = number(parts[1], 255);
    final b = number(parts[2], 255);
    if (r == null || g == null || b == null) return null;
    return _rgba(r, g, b, alpha);
  }
  final h = double.tryParse(parts[0].replaceAll('deg', ''));
  final s = number(parts[1], 1);
  final l = number(parts[2], 1);
  if (h == null || s == null || l == null) return null;
  return HSLColor.fromAHSL(
    alpha.clamp(0, 1),
    h % 360,
    s.clamp(0, 1),
    l.clamp(0, 1),
  ).toColor();
}

Color? _parseHex(String hex) {
  final digits = hex.substring(1);
  final expanded = switch (digits.length) {
    3 || 4 => [for (final digit in digits.split('')) '$digit$digit'].join(),
    6 || 8 => digits,
    _ => null,
  };
  if (expanded == null) return null;
  final value = int.tryParse(expanded, radix: 16);
  if (value == null) return null;
  return expanded.length == 6
      ? Color(0xFF000000 | value)
      // CSS writes alpha last.
      : Color(((value & 0xFF) << 24) | (value >>> 8));
}

import 'dart:ui' show Color, Offset;

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/src/style/expressions/expression_json.dart';

part 'expression_extensions.dart';

/// A value of a style property or an argument of another expression: either
/// a constant ([Expression.literal]) or a
/// [style expression](https://maplibre.org/maplibre-style-spec/expressions/)
/// that the map evaluates.
///
/// [T] is the Dart type the expression evaluates to, such as [num], [String],
/// [bool], [Color], [Offset], a [List] or a spec enum like `LineCap`.
///
/// ```dart
/// CircleStyleLayer(
///   id: 'quakes',
///   sourceId: 'quakes',
///   filter: .all([
///     .greaterThan(.get('mag').asNumber(), .literal(5)),
///     .has('place'),
///   ]),
///   radius: .interpolate(.exponential(2), .zoom(), {
///     5: .literal(2),
///     10: .literal(8),
///   }),
/// );
/// ```
///
/// Dot shorthands don't work as operands of an operator. Start with
/// `Expression.` there: `Expression.get('mag').asNumber() > .literal(5)`.
///
/// Spec names are kept, except for those that clash with Dart keywords or
/// members: `case` is [select], `in` is `contains`, `let` and `var` are
/// [withVariable], `!` is `not()`, `==` and `!=` are [equal] and [notEqual],
/// `typeof` is [type], `string`, `number` and `boolean` are [asString],
/// [asNumber] and [asBoolean], and `to-string` and the like are
/// [convertToString] and the like.
///
/// {@category Style}
@immutable
sealed class Expression<T> {
  const Expression();

  /// The constant [value].
  const factory Expression.literal(T value) = Literal<T>;

  /// The expression [json] in the JSON form of the style spec. The fallback
  /// for anything not covered by this class.
  const factory Expression.raw(List<Object?> json) = Call<T>;

  /// The expression in the JSON form of the style spec.
  Object? toJson();

  /// Asserts nothing and only changes the static type to [R]. Use [asString],
  /// [asNumber] or [asBoolean] for an assertion that the map checks. A
  /// [Literal] whose value is not an [R] becomes a [RawValue] of its JSON.
  Expression<R> cast<R>() => switch (this) {
    Literal(:final value) when value is R => Literal<R>(value),
    Literal() => RawValue<R>(toJson()),
    Call(:final json) => Call<R>(json),
    RawValue(:final json) => RawValue<R>(json),
  };

  /// The type of this value as a string (spec: `typeof`).
  Expression<String> type() => _call('typeof', [this]);

  /// Asserts that this value is a string. If it isn't, the [fallbacks] are
  /// tried in order (spec: `string`).
  Expression<String> asString([
    List<Expression<Object?>> fallbacks = const [],
  ]) => _call('string', [this, ...fallbacks]);

  /// Asserts that this value is a number. If it isn't, the [fallbacks] are
  /// tried in order (spec: `number`).
  Expression<num> asNumber([List<Expression<Object?>> fallbacks = const []]) =>
      _call('number', [this, ...fallbacks]);

  /// Asserts that this value is a boolean. If it isn't, the [fallbacks] are
  /// tried in order (spec: `boolean`).
  Expression<bool> asBoolean([
    List<Expression<Object?>> fallbacks = const [],
  ]) => _call('boolean', [this, ...fallbacks]);

  /// Asserts that this value is an object. If it isn't, the [fallbacks] are
  /// tried in order (spec: `object`).
  Expression<Map<String, Object?>> asObject([
    List<Expression<Object?>> fallbacks = const [],
  ]) => _call('object', [this, ...fallbacks]);

  /// Asserts that this value is an array of [E], optionally of [length]
  /// items (spec: `array`). Only [num], [String] and [bool] can be asserted
  /// as item types; any other [E] asserts an array of any items, which can't
  /// be combined with a [length].
  Expression<List<E>> asArray<E>({int? length}) {
    final itemType = E == num
        ? 'number'
        : E == String
        ? 'string'
        : E == bool
        ? 'boolean'
        : null;
    assert(
      length == null || itemType != null,
      'The style spec can only assert a length together with an item type.',
    );
    return Call(['array', ?itemType, ?length, toJson()]);
  }

  /// Converts this value to a string (spec: `to-string`).
  Expression<String> convertToString() => _call('to-string', [this]);

  /// Converts this value to a number. If that fails, the [fallbacks] are tried
  /// in order (spec: `to-number`).
  Expression<num> convertToNumber([
    List<Expression<Object?>> fallbacks = const [],
  ]) => _call('to-number', [this, ...fallbacks]);

  /// Converts this value to a boolean (spec: `to-boolean`).
  Expression<bool> convertToBoolean() => _call('to-boolean', [this]);

  /// Converts this value to a color. If that fails, the [fallbacks] are tried
  /// in order (spec: `to-color`).
  Expression<Color> convertToColor([
    List<Expression<Object?>> fallbacks = const [],
  ]) => _call('to-color', [this, ...fallbacks]);

  /// Binds [value] to the variable [name] for the expression that [body]
  /// returns (spec: `let` and `var`).
  ///
  /// ```dart
  /// Expression.withVariable(
  ///   'size',
  ///   Expression.get('size').asNumber(),
  ///   (size) => size.use() * size.use(),
  /// );
  /// ```
  static Expression<R> withVariable<V, R>(
    String name,
    Expression<V> value,
    Expression<R> Function(Variable<V> variable) body,
  ) => Call(['let', name, value.toJson(), body(Variable<V>(name)).toJson()]);

  /// An array of the [items], which unlike a [Expression.literal] may be
  /// expressions (spec: `semiliteral`).
  static Expression<List<E>> semiliteral<E>(List<Expression<E>> items) => Call([
    'semiliteral',
    [for (final item in items) item.toJson()],
  ]);

  /// The output of the first branch whose test is true, or else [fallback]
  /// (spec: `case`).
  static Expression<R> select<R>(
    List<(Expression<bool>, Expression<R>)> branches, {
    required Expression<R> fallback,
  }) => Call([
    'case',
    for (final (test, output) in branches) ...[test.toJson(), output.toJson()],
    fallback.toJson(),
  ]);

  /// The output whose label equals [input], or else [fallback]. A label is a
  /// string, a number or a list of them (spec: `match`).
  static Expression<R> match<R>(
    Expression<Object?> input,
    Map<Object, Expression<R>> cases, {
    required Expression<R> fallback,
  }) => Call([
    'match',
    input.toJson(),
    for (final MapEntry(:key, :value) in cases.entries) ...[
      key,
      value.toJson(),
    ],
    fallback.toJson(),
  ]);

  /// The first of [values] that isn't null (spec: `coalesce`).
  static Expression<R> coalesce<R>(List<Expression<R>> values) =>
      _call('coalesce', values);

  /// The output of the last stop at or below [input], or [output0] below the
  /// first stop (spec: `step`). The stops are sorted on serialization.
  static Expression<R> step<R>(
    Expression<num> input,
    Expression<R> output0,
    Map<num, Expression<R>> stops,
  ) => Call(['step', input.toJson(), output0.toJson(), ..._stopsJson(stops)]);

  /// Interpolates between the outputs of the [stops] at [input] (spec:
  /// `interpolate`). The stops are sorted on serialization.
  ///
  /// Interpolating a type that can't be interpolated, such as a string, is
  /// only caught by the map at runtime.
  static Expression<R> interpolate<R>(
    Interpolation interpolation,
    Expression<num> input,
    Map<num, Expression<R>> stops,
  ) => _interpolate('interpolate', interpolation, input, stops);

  /// Like [interpolate], for colors in the Hue-Chroma-Luminance color space
  /// (spec: `interpolate-hcl`).
  static Expression<Color> interpolateHcl(
    Interpolation interpolation,
    Expression<num> input,
    Map<num, Expression<Color>> stops,
  ) => _interpolate('interpolate-hcl', interpolation, input, stops);

  /// Like [interpolate], for colors in the CIELAB color space (spec:
  /// `interpolate-lab`).
  static Expression<Color> interpolateLab(
    Interpolation interpolation,
    Expression<num> input,
    Map<num, Expression<Color>> stops,
  ) => _interpolate('interpolate-lab', interpolation, input, stops);

  /// The mathematical constant ln(2) (spec: `ln2`).
  static Expression<num> ln2() => const Call(['ln2']);

  /// The mathematical constant pi (spec: `pi`).
  static Expression<num> pi() => const Call(['pi']);

  /// The mathematical constant e (spec: `e`).
  static Expression<num> e() => const Call(['e']);

  /// A collator for locale-dependent comparisons (spec: `collator`).
  static Expression<Collator> collator({
    Expression<bool>? caseSensitive,
    Expression<bool>? diacriticSensitive,
    Expression<String>? locale,
  }) => Call([
    'collator',
    {
      if (caseSensitive != null) 'case-sensitive': caseSensitive.toJson(),
      if (diacriticSensitive != null)
        'diacritic-sensitive': diacriticSensitive.toJson(),
      if (locale != null) 'locale': locale.toJson(),
    },
  ]);

  /// A formatted string of mixed fonts and images, for a text field (spec:
  /// `format`).
  static Expression<String> format(List<FormatSection> sections) =>
      Call(['format', for (final section in sections) ...section._toJson()]);

  /// The image [name] of the style, for an icon, pattern or formatted text
  /// (spec: `image`).
  static Expression<String> image(Expression<String> name) =>
      _call('image', [name]);

  /// The property [name] from the global state (spec: `global-state`).
  static Expression<Object?> globalState(String name) =>
      Call(['global-state', name]);

  /// A color of the components [red], [green] and [blue] from 0 to 255 (spec:
  /// `rgb`).
  static Expression<Color> rgb(
    Expression<num> red,
    Expression<num> green,
    Expression<num> blue,
  ) => _call('rgb', [red, green, blue]);

  /// A color of the components [red], [green] and [blue] from 0 to 255 and
  /// [alpha] from 0 to 1 (spec: `rgba`).
  static Expression<Color> rgba(
    Expression<num> red,
    Expression<num> green,
    Expression<num> blue,
    Expression<num> alpha,
  ) => _call('rgba', [red, green, blue, alpha]);

  /// The property [name] of the feature, or of [object] if given (spec:
  /// `get`).
  static Expression<Object?> get(
    String name, {
    Expression<Map<String, Object?>>? object,
  }) => Call(['get', name, if (object != null) object.toJson()]);

  /// Whether the feature, or [object] if given, has the property [name] (spec:
  /// `has`).
  static Expression<bool> has(
    String name, {
    Expression<Map<String, Object?>>? object,
  }) => Call(['has', name, if (object != null) object.toJson()]);

  /// The properties of the feature (spec: `properties`).
  static Expression<Map<String, Object?>> properties() =>
      const Call(['properties']);

  /// The property [name] of the feature's state (spec: `feature-state`).
  static Expression<Object?> featureState(String name) =>
      Call(['feature-state', name]);

  /// The geometry type of the feature (spec: `geometry-type`).
  static Expression<String> geometryType() => const Call(['geometry-type']);

  /// The id of the feature (spec: `id`).
  static Expression<Object?> id() => const Call(['id']);

  /// The zoom level of the map (spec: `zoom`).
  static Expression<num> zoom() => const Call(['zoom']);

  /// The density at a point of a heatmap, for its color (spec:
  /// `heatmap-density`).
  static Expression<num> heatmapDensity() => const Call(['heatmap-density']);

  /// The elevation in meters at a point (spec: `elevation`).
  static Expression<num> elevation() => const Call(['elevation']);

  /// The progress along a line from 0 to 1, for its gradient. Needs a GeoJSON
  /// source with line metrics (spec: `line-progress`).
  static Expression<num> lineProgress() => const Call(['line-progress']);

  /// The value of a cluster property accumulated so far (spec: `accumulated`).
  static Expression<Object?> accumulated() => const Call(['accumulated']);

  /// The sum of [values] (spec: `+`). `+` adds two.
  static Expression<num> sum(List<Expression<num>> values) =>
      _call('+', values);

  /// The product of [values] (spec: `*`). `*` multiplies two.
  static Expression<num> product(List<Expression<num>> values) =>
      _call('*', values);

  /// The smallest of [values] (spec: `min`).
  static Expression<num> min(List<Expression<num>> values) =>
      _call('min', values);

  /// The largest of [values] (spec: `max`).
  static Expression<num> max(List<Expression<num>> values) =>
      _call('max', values);

  /// The shortest distance in meters from the feature to the GeoJSON [geometry]
  /// (spec: `distance`).
  static Expression<num> distance(Map<String, Object?> geometry) =>
      Call(['distance', geometry]);

  /// Whether the feature lies inside the GeoJSON [geometry] (spec: `within`).
  static Expression<bool> within(Map<String, Object?> geometry) =>
      Call(['within', geometry]);

  /// Whether [a] equals [b] (spec: `==`).
  static Expression<bool> equal(
    Expression<Object?> a,
    Expression<Object?> b, {
    Expression<Collator>? collator,
  }) => _compare('==', a, b, collator);

  /// Whether [a] differs from [b] (spec: `!=`).
  static Expression<bool> notEqual(
    Expression<Object?> a,
    Expression<Object?> b, {
    Expression<Collator>? collator,
  }) => _compare('!=', a, b, collator);

  /// Whether [a] is greater than [b] (spec: `>`).
  static Expression<bool> greaterThan(
    Expression<Object?> a,
    Expression<Object?> b, {
    Expression<Collator>? collator,
  }) => _compare('>', a, b, collator);

  /// Whether [a] is less than [b] (spec: `<`).
  static Expression<bool> lessThan(
    Expression<Object?> a,
    Expression<Object?> b, {
    Expression<Collator>? collator,
  }) => _compare('<', a, b, collator);

  /// Whether [a] is greater than or equal to [b] (spec: `>=`).
  static Expression<bool> greaterThanOrEqual(
    Expression<Object?> a,
    Expression<Object?> b, {
    Expression<Collator>? collator,
  }) => _compare('>=', a, b, collator);

  /// Whether [a] is less than or equal to [b] (spec: `<=`).
  static Expression<bool> lessThanOrEqual(
    Expression<Object?> a,
    Expression<Object?> b, {
    Expression<Collator>? collator,
  }) => _compare('<=', a, b, collator);

  /// Whether all of [values] are true (spec: `all`).
  static Expression<bool> all(List<Expression<bool>> values) =>
      _call('all', values);

  /// Whether any of [values] is true (spec: `any`).
  static Expression<bool> any(List<Expression<bool>> values) =>
      _call('any', values);

  /// The [values] joined to one string (spec: `concat`). `+` joins two
  /// strings.
  static Expression<String> concat(List<Expression<Object?>> values) =>
      _call('concat', values);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Expression && jsonEquals(toJson(), other.toJson());

  @override
  int get hashCode => jsonHash(toJson());

  @override
  String toString() => 'Expression(${toJson()})';
}

/// A constant [Expression]. Read a value back with a pattern:
/// `if (layer.radius case Literal(:final value))`.
///
/// {@category Style}
final class Literal<T> extends Expression<T> {
  /// Creates the constant [value].
  const Literal(this.value);

  /// The value.
  final T value;

  /// The [value] as style JSON, without the `literal` wrapper of [toJson].
  Object? get jsonValue => encodeLiteral(value);

  @override
  Object? toJson() => switch (value) {
    List<Object?>() ||
    Map<Object?, Object?>() ||
    Offset() => ['literal', jsonValue],
    _ => jsonValue,
  };
}

/// An [Expression] in the JSON form of the style spec. Every expression other
/// than a [Literal] is one.
///
/// {@category Style}
final class Call<T> extends Expression<T> {
  /// Creates an expression of the JSON [json].
  const Call(this.json);

  /// The expression as JSON.
  final List<Object?> json;

  @override
  Object? toJson() => json;
}

/// A value that a style holds and that is neither a [Literal] of [T] nor an
/// expression: a legacy function object such as `{"stops": […]}`, or a value
/// that this package can't read, such as an extended CSS color name. It only
/// comes from reading a style, and is written back as it was.
///
/// {@category Style}
final class RawValue<T> extends Expression<T> {
  /// Creates a value of the JSON [json].
  const RawValue(this.json);

  /// The value as JSON.
  final Object? json;

  @override
  Object? toJson() => json;
}

/// A typed variable of [Expression.withVariable].
///
/// {@category Style}
final class Variable<T> {
  /// Creates a reference to the variable [name].
  const Variable(this.name);

  /// The name of the variable.
  final String name;

  /// The value of the variable (spec: `var`).
  Expression<T> use() => Call(['var', name]);
}

/// How [Expression.interpolate] interpolates between its stops.
///
/// {@category Style}
sealed class Interpolation {
  const Interpolation();

  /// Linearly between a pair of stops.
  const factory Interpolation.linear() = _Linear;

  /// Exponentially between a pair of stops. [base] controls the rate at which
  /// the output increases; 1 is linear.
  const factory Interpolation.exponential(num base) = _Exponential;

  /// With the cubic bezier curve of the control points ([x1], [y1]) and
  /// ([x2], [y2]).
  const factory Interpolation.cubicBezier(num x1, num y1, num x2, num y2) =
      _CubicBezier;

  List<Object?> _toJson();
}

final class _Linear extends Interpolation {
  const _Linear();

  @override
  List<Object?> _toJson() => const ['linear'];
}

final class _Exponential extends Interpolation {
  const _Exponential(this.base);

  final num base;

  @override
  List<Object?> _toJson() => ['exponential', base];
}

final class _CubicBezier extends Interpolation {
  const _CubicBezier(this.x1, this.y1, this.x2, this.y2);

  final num x1;
  final num y1;
  final num x2;
  final num y2;

  @override
  List<Object?> _toJson() => ['cubic-bezier', x1, y1, x2, y2];
}

/// The type of [Expression.collator].
///
/// {@category Style}
abstract final class Collator {}

/// A section of [Expression.format].
///
/// {@category Style}
final class FormatSection {
  /// A section of [content], a string or an [Expression.image], with optional
  /// style overrides.
  const FormatSection(
    this.content, {
    this.fontScale,
    this.textFont,
    this.textColor,
    this.verticalAlign,
  });

  /// The string or image of the section.
  final Expression<Object?> content;

  /// Scales the font size of the layer.
  final Expression<num>? fontScale;

  /// Overrides the font of the layer.
  final Expression<List<String>>? textFont;

  /// Overrides the text color of the layer.
  final Expression<Color>? textColor;

  /// Aligns the section vertically: `bottom`, `center` or `top`.
  final Expression<String>? verticalAlign;

  List<Object?> _toJson() => [
    content.toJson(),
    {
      if (fontScale != null) 'font-scale': fontScale!.toJson(),
      if (textFont != null) 'text-font': textFont!.toJson(),
      if (textColor != null) 'text-color': textColor!.toJson(),
      if (verticalAlign != null) 'vertical-align': verticalAlign!.toJson(),
    },
  ];
}

Call<R> _call<R>(String operator, List<Expression<Object?>> arguments) =>
    Call([operator, for (final argument in arguments) argument.toJson()]);

Call<bool> _compare(
  String operator,
  Expression<Object?> a,
  Expression<Object?> b,
  Expression<Collator>? collator,
) => _call(operator, [a, b, ?collator]);

Call<R> _interpolate<R>(
  String operator,
  Interpolation interpolation,
  Expression<num> input,
  Map<num, Expression<R>> stops,
) => Call([
  operator,
  interpolation._toJson(),
  input.toJson(),
  ..._stopsJson(stops),
]);

List<Object?> _stopsJson<R>(Map<num, Expression<R>> stops) {
  final keys = stops.keys.toList()..sort();
  return [
    for (final key in keys) ...[key, stops[key]!.toJson()],
  ];
}

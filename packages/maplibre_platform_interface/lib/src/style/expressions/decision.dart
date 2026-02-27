part of 'expressions.dart';

/// Selects the first output whose corresponding test condition evaluates to
/// true, or the fallback value otherwise.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#case
Expression<T> case_<T>({
  required Map<Expression<bool>, Expression<T>> cases,
  required Expression<T> fallback,
}) => Expression.fromJson([
  'case',
  ...cases.entries.expand((e) => [e.key, e.value]),
  fallback,
]);

/// Selects the output whose label value matches the input value, or the fallback value if no match is found. The input can be any expression (e.g. ["get", "building_type"]). Each label must be either:
/// - a single literal value; or
/// - an array of literal values, whose values must be all strings or all numbers (e.g. [100, 101] or ["c", "b"]). The input matches if any of the values in the array matches, similar to the "in" operator.
/// Each label must be unique. If the input type does not match the type of the labels, the result will be the fallback value.
Expression<T> match<T extends Object?>({
  required Expression input,
  required Map<T, OneOf2<T, Expression<T>>> cases,
  required OneOf2<T, Expression<T>> fallback,
}) => Expression.fromJson([
  'match',
  input,
  ...cases.entries.expand((e) => [e.key, e.value]),
  fallback,
]);

/// Evaluates each expression in turn until the first non-null value is obtained, and returns that value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#coalesce
Expression<T?> coalesce<T>(List<Expression<T>> expressions) =>
    Expression.fromJson(['coalesce', ...expressions]);

/// Returns `true` if the input values are equal, `false` otherwise. The comparison is strictly typed: values of different runtime types are always considered unequal. Cases where the types are known to be different at parse time are considered invalid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_1
Expression<bool> equal(OneOf input1, OneOf input2, {String? collator}) =>
    Expression.fromJson([
      '==',
      input1,
      input2,
      if (collator != null) {'collator': collator},
    ]);

/// Returns `true` if the input values are not equal, `false` otherwise. The comparison is strictly typed: values of different runtime types are always considered unequal. Cases where the types are known to be different at parse time are considered invalid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_2
Expression<bool> notEqual(OneOf input1, OneOf input2, {String? collator}) =>
    Expression.fromJson([
      '!=',
      input1,
      input2,
      if (collator != null) {'collator': collator},
    ]);

/// Returns `true` if the first input is strictly greater than the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_3
Expression<bool> greaterThan(OneOf input1, OneOf input2, {String? collator}) =>
    Expression.fromJson([
      '>',
      input1,
      input2,
      if (collator != null) {'collator': collator},
    ]);

/// Returns `true` if the first input is strictly less than the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_4
Expression<bool> lessThan(OneOf input1, OneOf input2, {String? collator}) =>
    Expression.fromJson([
      '<',
      input1,
      input2,
      if (collator != null) {'collator': collator},
    ]);

/// Returns `true` if the first input is greater than or equal to the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_5
Expression<bool> greaterThanOrEqual(
  OneOf input1,
  OneOf input2, {
  String? collator,
}) => Expression.fromJson([
  '>=',
  input1,
  input2,
  if (collator != null) {'collator': collator},
]);

/// Returns `true` if the first input is less than or equal to the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_6
Expression<bool> lessThanOrEqual(
  OneOf input1,
  OneOf input2, {
  String? collator,
}) => Expression.fromJson([
  '<=',
  input1,
  input2,
  if (collator != null) {'collator': collator},
]);

/// Returns `true` if all the inputs are `true`, `false` otherwise. The inputs are evaluated in order, and evaluation is short-circuiting: once an input expression evaluates to `false`, the result is `false` and no further input expressions are evaluated.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#all
Expression<bool> all(List<Expression> inputs) =>
    Expression.fromJson(['all', ...inputs]);

/// Returns `true` if any of the inputs are `true`, `false` otherwise. The inputs are evaluated in order, and evaluation is short-circuiting: once an input expression evaluates to `true`, the result is `true` and no further input expressions are evaluated.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#any
Expression<bool> any_(List<Expression> inputs) =>
    Expression.fromJson(['any', ...inputs]);

/// Logical negation. Returns `true` if the input is `false`, and `false` if the input is `true`.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#!
Expression<bool> not(Expression input) => Expression.fromJson(['!', input]);

/// Returns `true` if the evaluated feature is fully contained inside a boundary of the input geometry, `false` otherwise. The input value can be a valid GeoJSON of type Polygon, MultiPolygon, Feature, or FeatureCollection. Supported features for evaluation:
/// - [Point]: Returns false if a point is on the boundary or falls outside the boundary.
/// - [LineString]: Returns false if any part of a line falls outside the boundary, the line intersects the boundary, or a line's endpoint is on the boundary.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#within
Expression<bool> within(OneOf2<Point, LineString> input) =>
    Expression.fromJson([
      'within',
      switch (input) {
        final Point point => point.toText(),
        final LineString lineString => lineString.toText(),
        _ => StateError('Unreachable'),
      },
    ]);

part of 'expressions.dart';

/// Selects the first output whose corresponding test condition evaluates to 
/// true, or the fallback value otherwise.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#case
Expression case_({
  required Map<Expression, Expression> cases,
  required Expression fallback,
}) => Expression.fromJson([
  'case',
  ...cases.entries.expand((e) => [e.key, e.value]),
  fallback,
]);

/// Selects the output whose label value matches the input value, or the fallback value if no match is found. The input can be any expression (e.g. ["get", "building_type"]). Each label must be either:
/// - a single literal value; or
/// - an array of literal values, whose values must be all strings or all numbers (e.g. [100, 101] or ["c", "b"]). The input matches if any of the values in the array matches, similar to the "in" operator.
/// Each label must be unique. If the input type does not match the type of the labels, the result will be the fallback value.
Expression match({
  required Expression input,
  required Map<Object?, Expression> cases,
  required Expression fallback,
}) => Expression.fromJson([
  'match',
  input,
  ...cases.entries.expand((e) => [e.key, e.value]),
  fallback,
]);
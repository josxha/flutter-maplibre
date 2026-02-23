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

/// Evaluates each expression in turn until the first non-null value is obtained, and returns that value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#coalesce
Expression coalesce(List<Expression> expressions) =>
    Expression.fromJson(['coalesce', ...expressions]);

/// Returns `true` if the input values are equal, `false` otherwise. The comparison is strictly typed: values of different runtime types are always considered unequal. Cases where the types are known to be different at parse time are considered invalid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_1
Expression equal(OneOf input1, OneOf input2, {String? collator}) =>
    Expression.fromJson([
      '==',
      input1,
      input2,
      if (collator != null) {'collator': collator},
    ]);

/// Returns `true` if the input values are not equal, `false` otherwise. The comparison is strictly typed: values of different runtime types are always considered unequal. Cases where the types are known to be different at parse time are considered invalid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_2
Expression notEqual(OneOf input1, OneOf input2, {String? collator}) =>
    Expression.fromJson([
      '!=',
      input1,
      input2,
      if (collator != null) {'collator': collator},
    ]);

/// Returns `true` if the first input is strictly greater than the second, false otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_3
Expression greaterThan(OneOf input1, OneOf input2, {String? collator}) =>
    Expression.fromJson([
      '>',
      input1,
      input2,
      if (collator != null) {'collator': collator},
    ]);

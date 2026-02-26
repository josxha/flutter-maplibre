part of 'expressions.dart';

/// Returns the mathematical constant `ln(2)`.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#ln2
Expression ln2_() => const Expression.fromJson(['ln2']);

/// Returns the mathematical constant `pi`.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#pi
Expression pi_() => const Expression.fromJson(['pi']);

/// Returns the mathematical constant `e`.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#e
Expression e_() => const Expression.fromJson(['e']);

/// Returns the sum of the inputs.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_8
Expression sum(List<Expression> inputs) =>
    Expression.fromJson(['sum', ...inputs]);

/// Returns the product of the inputs.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_9
Expression product(List<Expression> inputs) =>
    Expression.fromJson(['product', ...inputs]);

/// For two inputs, returns the result of subtracting the second input from the first. For a single input, returns the result of subtracting it from 0.
/// - [input1]: number- The number from which to subtract [input2].
/// - [input2]: number- The number to subtract from [input1]. If not set, the result is the negation of [input1].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#-
Expression subtract(Expression input1, [Expression? input2]) =>
    Expression.fromJson(['subtract', input1, ?input2]);

/// Returns the result of floating point division of the first input by the second.
/// [dividend]: number- The dividend.
/// [input2]: number- The divisor.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_10
Expression divide(Expression dividend, Expression divisor) =>
    Expression.fromJson(['divide', dividend, divisor]);

/// Returns the remainder after integer division of the first input by the second.
/// [dividend]: number- The dividend.
/// [divisor]: number- The divisor.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#_11
Expression mod_(Expression dividend, Expression divisor) =>
    Expression.fromJson(['mod', dividend, divisor]);

/// Returns the result of raising the first input to the power specified by the second.
/// [base]: number- The base.
/// [exponent]: number- The exponent.
Expression pow_(Expression base, Expression exponent) =>
    Expression.fromJson(['pow', base, exponent]);

/// Returns the square root of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#sqrt
Expression sqrt_(Expression input) => Expression.fromJson(['sqrt', input]);

/// Returns the base 10 logarithm of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#log10
Expression log10_(Expression input) => Expression.fromJson(['log10', input]);

/// Returns the natural logarithm of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#ln
Expression ln_(Expression input) => Expression.fromJson(['ln', input]);

/// Returns the base 2 logarithm of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#log2
Expression log2_(Expression input) => Expression.fromJson(['log2', input]);

/// Returns the sine of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#sin
Expression sin_(Expression angle) => Expression.fromJson(['sin', angle]);

/// Returns the cosine of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#cos
Expression<num> cos_(Expression<num> angle) => Expression.fromJson(['cos', angle]);

/// Returns the tangent of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#tan
Expression<num> tan_(Expression<num> angle) => Expression.fromJson(['tan', angle]);

/// Returns the arcsine of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#asin
Expression<num> asin_(Expression<num> input) => Expression.fromJson(['asin', input]);

/// Returns the arccosine of the [input].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#acos
Expression<num> acos_(Expression<num> input) => Expression.fromJson(['acos', input]);

/// Returns the arctangent of the [input].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#atan
Expression<num> atan_(Expression<num> input) => Expression.fromJson(['atan', input]);

/// Returns the minimum value of the [inputs].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#min
Expression<num> min(List<Expression<num>> inputs) =>
    Expression.fromJson(['min', ...inputs]);

/// Returns the maximum value of the [inputs].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#max
Expression<num> max(List<Expression<num>> inputs) =>
    Expression.fromJson(['max', ...inputs]);

/// Rounds the [input] to the nearest integer. Halfway values are rounded away from zero. For example, `["round", -1.5]` evaluates to -2.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#round
Expression<num> round(Expression<num> input) => Expression.fromJson(['round', input]);

/// Returns the absolute value of the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#abs
Expression<num> abs(Expression<num> input) => Expression.fromJson(['abs', input]);

/// Returns the smallest integer that is greater than or equal to the [input].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#ceil
Expression<num> ceil(Expression<num> input) => Expression.fromJson(['ceil', input]);

/// Returns the largest integer that is less than or equal to the [input].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#floor
Expression<num> floor(Expression<num> input) => Expression.fromJson(['floor', input]);

/// Returns the shortest distance in meters between the evaluated feature and the input [geometry].
/// The input value can be a valid GeoJSON of type [Point], [MultiPoint], [LineString], [MultiLineString], [Polygon], [MultiPolygon], [Feature], or [FeatureCollection]. Distance values returned may vary in precision due to loss in precision from encoding geometries, particularly below zoom level 13.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#distance
Expression<num> distance(Object? geometry) => Expression.fromJson([
  'distance',
  switch (geometry) {
    final SimpleGeometry geometry => geometry.toText(),
    final FeatureObject geometry => geometry.toText(),
    final Map<String, Object?> geometry => geometry,
    final List<Object?> geometry => geometry,
    _ => ArgumentError.value(geometry),
  },
]);

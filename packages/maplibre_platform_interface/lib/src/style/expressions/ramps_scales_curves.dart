part of 'expressions.dart';

/// Produces discrete, stepped results by evaluating a piecewise-constant function defined by pairs of input and output values ("stops"). The [input] may be any numeric [Expression] (e.g., `["get", "population"]`). [stopInputs] must be numeric [literal]s in strictly ascending order.
///
/// Returns the output value of the stop just less than the [input], or the first output if the [input] is less than the first stop.
/// - [input]: number- Any numeric expression.
/// - [output0]: any- The result when the input is less than the first stop.
/// - [stopInputs]: number literal- The value of the i-th stop against which the input is compared.
/// - [stopOutputs]: any- The result when the i-th stop is the last stop less than the input.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#step
Expression<T> step<T extends Object?>({
  required Expression<num> input,
  required Expression<T> output0,
  required List<double> stopInputs,
  required List<Expression<T>> stopOutputs,
}) => Expression.fromJson([
  'step',
  [
    input,
    output0,
    for (int i = 0; i < stopInputs.length; i++) ...[
      stopInputs[i],
      stopOutputs[i],
    ],
  ],
]);

/// Produces continuous, smooth results by interpolating between pairs of input
/// and output values ("stops"). The input may be any numeric expression
/// (e.g., ["get", "population"]). Stop inputs must be numeric literals in
/// strictly ascending order. The output type must be number, [List<double>],
/// color, [List<color>], or projection.
/// - [type]: interpolation- The interpolation type.
/// - [input]: number- Any numeric expression.
/// - [stopInputs]: number literal- The value of the i-th stop against which the input is compared.
/// - [stopOutputs]: number | [List<double>] | color | [List<color>] | projection- The output value corresponding to the i-th stop.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#interpolate
Expression<T> interpolate<T extends Object?>({
  required InterpolationType type,
  required Expression<num> input,
  required List<double> stopInputs,
  required List<Object> stopOutputs,
}) => Expression.fromJson([
  'interpolate',
  [type, input, ...stopInputs, ...stopOutputs],
]);

/// Produces continuous, smooth results by interpolating between pairs of input
/// and output values ("stops"). Works like [interpolate], but the output type
/// must be color or [List<color>], and the interpolation is performed in the
/// Hue-Chroma-Luminance color space.
/// - [type]: interpolation- The interpolation type.
/// - [input]: number
/// - [stopInputs]: number literal
/// - [stopOutputs]: color | [List<color>]
///
/// https://maplibre.org/maplibre-style-spec/expressions/#interpolate-hcl
Expression<T> interpolateHcl<T extends Object>({
  required InterpolationType type,
  required Expression<num> input,
  required List<double> stopInputs,
  required List<Object> stopOutputs,
}) => Expression.fromJson([
  'interpolate-hcl',
  [type, input, ...stopInputs, ...stopOutputs],
]);

/// Produces continuous, smooth results by interpolating between pairs of input
/// and output values ("stops"). Works like interpolate, but the output type
/// must be color or [List<color>], and the interpolation is performed in the
/// CIELAB color space.
/// - [type]: interpolation- The interpolation type.
/// - [input]: number
/// - [stopInputs]: number literal
/// - [stopOutputs]: color | [List<color>]
///
/// https://maplibre.org/maplibre-style-spec/expressions/#interpolate-lab
Expression<T> interpolateLab<T extends Object>({
  required InterpolationType type,
  required Expression<num> input,
  required List<double> stopInputs,
  required List<Expression> stopOutputs,
}) => Expression.fromJson([
  'interpolate-lab',
  [type, input, ...stopInputs, ...stopOutputs],
]);

import 'dart:convert';
import 'dart:ui';

import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Base class for expressions.
extension type const Expression.fromJson(List<Object?> json)
    implements List<Object?> {
  // COLOR

  /// Returns a four-element array containing the input color's red, green, blue, and alpha components, in that order.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#to-rgba
  Expression.toRgba(Object color) : json = ['to-rgba', color];

  /// Creates a color value from red, green, and blue components, which must
  /// range between 0 and 255, and an alpha component of 1. If any component is
  /// out of range, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#rgb
  Expression.rgb(Object red, Object green, Object blue)
    : json = ['rgb', red, green, blue];

  /// Creates a color value from red, green, blue components, which must range
  /// between 0 and 255, and an alpha component which must range between zero and
  /// one. If any component is out of range, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#rgba
  Expression.rgba({
    required Object red,
    required Object green,
    required Object blue,
    required Object alpha,
  }) : json = ['rgba', red, green, blue, alpha];

  // COLOR RELIEF

  /// Gets the elevation of a pixel (in meters above the vertical datum reference
  /// of the raster-dem tiles) from a [RasterDemSource]. Can only be used in the
  /// [ColorReliefStyleLayer.color].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#elevation
  const Expression.elevation() : json = const ['elevation'];

  // DECISION

  /// Selects the first output whose corresponding test condition evaluates to
  /// true, or the fallback value otherwise.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#case
  Expression.case_({
    required Map<Expression, Object?> cases,
    required Object? fallback,
  }) : json = [
         'case',
         ...cases.entries.expand((e) => [e.key, e.value]),
         fallback,
       ];

  /// Selects the output whose label value matches the input value, or the fallback value if no match is found. The input can be any expression (e.g. ["get", "building_type"]). Each label must be either:
  /// - a single literal value; or
  /// - an array of literal values, whose values must be all strings or all numbers (e.g. [100, 101] or ["c", "b"]). The input matches if any of the values in the array matches, similar to the "in" operator.
  /// Each label must be unique. If the input type does not match the type of the labels, the result will be the fallback value.
  Expression.match({
    required Expression input,
    required Map<Object, Object> cases,
    required Object fallback,
  }) : json = [
         'match',
         input,
         ...cases.entries.expand((e) => [e.key, e.value]),
         fallback,
       ];

  /// Evaluates each expression in turn until the first non-null value is obtained, and returns that value.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#coalesce
  Expression.coalesce(List<Expression> expressions)
    : json = ['coalesce', ...expressions];

  /// Returns `true` if the input values are equal, `false` otherwise. The comparison is strictly typed: values of different runtime types are always considered unequal. Cases where the types are known to be different at parse time are considered invalid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_1
  Expression.equal(Object input1, Object input2, {String? collator})
    : json = [
        '==',
        input1,
        input2,
        if (collator != null) {'collator': collator},
      ];

  /// Returns `true` if the input values are not equal, `false` otherwise. The comparison is strictly typed: values of different runtime types are always considered unequal. Cases where the types are known to be different at parse time are considered invalid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_2
  Expression.notEqual(Object input1, Object input2, {String? collator})
    : json = [
        '!=',
        input1,
        input2,
        if (collator != null) {'collator': collator},
      ];

  /// Returns `true` if the first input is strictly greater than the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_3
  Expression.greaterThan(Object input1, Object input2, {String? collator})
    : json = [
        '>',
        input1,
        input2,
        if (collator != null) {'collator': collator},
      ];

  /// Returns `true` if the first input is strictly less than the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_4
  Expression.lessThan(Object input1, Object input2, {String? collator})
    : json = [
        '<',
        input1,
        input2,
        if (collator != null) {'collator': collator},
      ];

  /// Returns `true` if the first input is greater than or equal to the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_5
  Expression.greaterThanOrEqual(
    Object input1,
    Object input2, {
    String? collator,
  }) : json = [
         '>=',
         input1,
         input2,
         if (collator != null) {'collator': collator},
       ];

  /// Returns `true` if the first input is less than or equal to the second, `false` otherwise. The arguments are required to be either both strings or both numbers; if during evaluation they are not, expression evaluation produces an error. Cases where this constraint is known not to hold at parse time are considered in valid and will produce a parse error. Accepts an optional [collator] argument to control locale-dependent string comparisons.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_6
  Expression.lessThanOrEqual(Object input1, Object input2, {String? collator})
    : json = [
        '<=',
        input1,
        input2,
        if (collator != null) {'collator': collator},
      ];

  /// Returns `true` if all the inputs are `true`, `false` otherwise. The inputs are evaluated in order, and evaluation is short-circuiting: once an input expression evaluates to `false`, the result is `false` and no further input expressions are evaluated.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#all
  Expression.all(List<Expression> inputs) : json = ['all', ...inputs];

  /// Returns `true` if any of the inputs are `true`, `false` otherwise. The inputs are evaluated in order, and evaluation is short-circuiting: once an input expression evaluates to `true`, the result is `true` and no further input expressions are evaluated.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#any
  Expression.any(List<Expression> inputs) : json = ['any', ...inputs];

  /// Logical negation. Returns `true` if the input is `false`, and `false` if the input is `true`.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#!
  Expression.not(Expression input) : json = ['!', input];

  /// Returns `true` if the evaluated feature is fully contained inside a boundary of the input geometry, `false` otherwise.
  /// The input value can be a valid GeoJSON of type [Polygon], [MultiPolygon], [Feature], or [FeatureCollection].
  /// Supported features for evaluation:
  /// - [Point]: Returns false if a point is on the boundary or falls outside the boundary.
  /// - [LineString]: Returns false if any part of a line falls outside the boundary, the line intersects the boundary, or a line's endpoint is on the boundary.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#within
  Expression.within(SimpleGeometry geometry)
    : json = ['within', jsonDecode(geometry.toText())];

  // FEATURE DATA

  /// Gets the feature properties object. Note that in some cases, it may be more efficient to use `["get", "property_name"]` directly.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#properties
  const Expression.properties() : json = const ['properties'];

  /// Retrieves a property value from the current feature's state. Returns null if
  /// the requested property is not present on the feature's state. A feature's
  /// state is not part of the GeoJSON or vector tile data, and must be set
  /// programmatically on each feature. When source.promoteId is not provided,
  /// features are identified by their id attribute, which must be an integer or a
  /// string that can be cast to an integer. When source.promoteId is provided,
  /// features are identified by their promoteId property, which may be a number,
  /// string, or any primitive data type. Note that ["feature-state"] can only be
  /// used with paint properties that support data-driven styling.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#feature-state
  Expression.featureState(String propertyName)
    : json = ['feature-state', propertyName];

  /// Returns the feature's simple geometry type: [Point], [LineString], or [Polygon] as [String].
  /// [MultiPoint], [MultiLineString], and [MultiPolygon] are returned as [Point], [LineString], and [Polygon], respectively.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#geometry-type
  const Expression.geometryType() : json = const ['geometry-type'];

  /// Gets the feature's id, if it has one.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#id
  const Expression.id() : json = const ['id'];

  /// Gets the progress along a gradient line.
  /// Can only be used in the [LineStyleLayer.gradient] property.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#line-progress
  Expression.lineProgress() : json = ['line-progress'];

  /// Gets the value of a cluster property accumulated so far. Can only be used in the clusterProperties option of a clustered GeoJSON source.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#accumulated
  Expression.accumulated() : json = ['accumulated'];

  // HEATMAP

  /// Gets the kernel density estimation of a pixel in a heatmap layer, which is
  /// a relative measure of how many data points are crowded around a particular
  /// pixel. Can only be used in the [HeatmapStyleLayer.color] property.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#heatmap-density
  Expression.heatmapDensity() : json = ['heatmap-density'];

  // LOOKUP

  /// Retrieves an item from an array.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#at
  Expression.at({required Object index, required Expression list})
    : json = ['at', index, list];

  /// Determines whether an item exists in an array or a substring exists in a
  /// string.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#in
  Expression.in_({required Object item, required Object list})
    : json = ['in', item, list];

  /// Returns the first position at which an item can be found in an array or a
  /// substring can be found in a string, or -1 if the input cannot be found.
  /// Accepts an optional index from where to begin the search. In a string, a
  /// UTF-16 surrogate pair counts as a single position.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#index-of
  Expression.indexOf({
    required Object item,
    required Object list,
    Object? fromIndex,
  }) : json = ['index-of', item, list, ?fromIndex];

  /// Returns a subarray from an array or a substring from a string from a
  /// specified start index, or between a start index and an end index if set.
  /// The return value is inclusive of the start index but not of the end index.
  /// In a string, a UTF-16 surrogate pair counts as a single position.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#slice
  Expression.slice({required Object input, required Object start, Object? end})
    : json = ['slice', input, start, ?end];

  /// Retrieves a property value from global state that can be set with
  /// platform-specific APIs. Defaults can be provided using the `state`
  /// root property. Returns null if no value nor default value is set for the
  /// retrieved property.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#global-state
  Expression.globalState(String propertyName)
    : json = ['global-state', propertyName];

  /// Retrieves a property value from the current feature's properties, or from
  /// another object if a second argument is provided. Returns null if the
  /// requested property is missing.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#get
  Expression.get(String propertyName, {Map<String, Object?>? object})
    : json = ['get', propertyName, ?object];

  /// Tests for the presence of a property value in the current feature's
  /// properties, or from another object if a second argument is provided.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#has
  Expression.has(String propertyName, {Map<String, Object?>? object})
    : json = ['has', propertyName, ?object];

  /// Gets the length of an array or string. In a string, a UTF-16 surrogate pair
  /// counts as a single position.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#length
  Expression.length(Object input) : json = ['length', input];

  // MATH

  /// Returns the mathematical constant `ln(2)`.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#ln2
  Expression.ln2() : json = ['ln2'];

  /// Returns the mathematical constant `pi`.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#pi
  Expression.pi() : json = ['pi'];

  /// Returns the mathematical constant `e`.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#e
  Expression.e() : json = ['e'];

  /// Returns the sum of the inputs.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_8
  Expression.sum(List<Object> inputs) : json = ['+', ...inputs];

  /// Returns the product of the inputs.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_9
  Expression.product(List<Object> inputs) : json = ['*', ...inputs];

  /// For two inputs, returns the result of subtracting the second input from the first. For a single input, returns the result of subtracting it from 0.
  /// - [input1]: number- The number from which to subtract [input2].
  /// - [input2]: number- The number to subtract from [input1]. If not set, the result is the negation of [input1].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#-
  Expression.subtract(Object input1, [Object? input2])
    : json = ['-', input1, ?input2];

  /// Returns the result of floating point division of the first input by the second.
  /// [dividend]: number- The dividend.
  /// [divisor]: number- The divisor.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_10
  Expression.divide(Object dividend, Object divisor)
    : json = ['/', dividend, divisor];

  /// Returns the remainder after integer division of the first input by the second.
  /// [dividend]: number- The dividend.
  /// [divisor]: number- The divisor.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#_11
  Expression.mod(Object dividend, Object divisor)
    : json = ['%', dividend, divisor];

  /// Returns the result of raising the first input to the power specified by the second.
  /// [base]: number- The base.
  /// [exponent]: number- The exponent.
  Expression.pow(Object base, Object exponent) : json = ['^', base, exponent];

  /// Returns the square root of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#sqrt
  Expression.sqrt(Object input) : json = ['sqrt', input];

  /// Returns the base 10 logarithm of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#log10
  Expression.log10(Object input) : json = ['log10', input];

  /// Returns the natural logarithm of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#ln
  Expression.ln(Object input) : json = ['ln', input];

  /// Returns the base 2 logarithm of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#log2
  Expression.log2(Object input) : json = ['log2', input];

  /// Returns the sine of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#sin
  Expression.sin(Object angle) : json = ['sin', angle];

  /// Returns the cosine of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#cos
  Expression.cos(Object angle) : json = ['cos', angle];

  /// Returns the tangent of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#tan
  Expression.tan(Object angle) : json = ['tan', angle];

  /// Returns the arcsine of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#asin
  Expression.asin(Object input) : json = ['asin', input];

  /// Returns the arccosine of the [input].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#acos
  Expression.acos(Object input) : json = ['acos', input];

  /// Returns the arctangent of the [input].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#atan
  Expression.atan(Object input) : json = ['atan', input];

  /// Returns the minimum value of the [inputs].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#min
  Expression.min(List<Object> inputs) : json = ['min', ...inputs];

  /// Returns the maximum value of the [inputs].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#max
  Expression.max(List<Object> inputs) : json = ['max', ...inputs];

  /// Rounds the [input] to the nearest integer. Halfway values are rounded away from zero. For example, `["round", -1.5]` evaluates to -2.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#round
  Expression.round(Object input) : json = ['round', input];

  /// Returns the absolute value of the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#abs
  Expression.abs(Object input) : json = ['abs', input];

  /// Returns the smallest integer that is greater than or equal to the [input].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#ceil
  Expression.ceil(Object input) : json = ['ceil', input];

  /// Returns the largest integer that is less than or equal to the [input].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#floor
  Expression.floor(Object input) : json = ['floor', input];

  /// Returns the shortest distance in meters between the evaluated feature and the input [geometry].
  /// The input value can be a valid GeoJSON of type [Point], [MultiPoint], [LineString], [MultiLineString], [Polygon], [MultiPolygon], [Feature], or [FeatureCollection]. Distance values returned may vary in precision due to loss in precision from encoding geometries, particularly below zoom level 13.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#distance
  Expression.distance(Object? geometry)
    : json = [
        'distance',
        switch (geometry) {
          final SimpleGeometry geometry => jsonDecode(geometry.toText()),
          final FeatureObject geometry => jsonDecode(geometry.toText()),
          final Map<String, Object?> geometry => geometry,
          final List<Object?> geometry => geometry,
          _ => ArgumentError.value(geometry),
        },
      ];

  // RAMPS, SCALES, CURVES

  /// Produces discrete, stepped results by evaluating a piecewise-constant
  /// function defined by pairs of input and output values ("stops"). The
  /// [input] may be any numeric [Expression] (e.g., `["get", "population"]`).
  /// [stopInputs] must be numeric [Expression.literal]s in strictly ascending order.
  ///
  /// Returns the output value of the stop just less than the [input], or the first output if the [input] is less than the first stop.
  /// - [input]: number- Any numeric expression.
  /// - [output0]: any- The result when the input is less than the first stop.
  /// - [stopInputs]: number literal- The value of the i-th stop against which the input is compared.
  /// - [stopOutputs]: any- The result when the i-th stop is the last stop less than the input.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#step
  Expression.step({
    required Expression input,
    required Object output0,
    required List<double> stopInputs,
    required List<Object> stopOutputs,
  }) : json = [
         'step',
         input,
         output0,
         for (int i = 0; i < stopInputs.length; i++) ...[
           stopInputs[i],
           stopOutputs[i],
         ],
       ];

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
  Expression.interpolate({
    required InterpolationType type,
    required Expression input,
    required List<double> stopInputs,
    required List<Object> stopOutputs,
  }) : json = [
         'interpolate',
         type,
         input,
         for (int i = 0; i < stopInputs.length; i++) ...[
           stopInputs[i],
           stopOutputs[i],
         ],
       ];

  /// Produces continuous, smooth results by interpolating between pairs of input
  /// and output values ("stops"). Works like [Expression.interpolate], but the output type
  /// must be color or [List<color>], and the interpolation is performed in the
  /// Hue-Chroma-Luminance color space.
  /// - [type]: interpolation- The interpolation type.
  /// - [input]: number
  /// - [stopInputs]: number literal
  /// - [stopOutputs]: color | [List<color>]
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#interpolate-hcl
  Expression.interpolateHcl({
    required InterpolationType type,
    required Expression input,
    required List<double> stopInputs,
    required List<Object> stopOutputs,
  }) : json = [
         'interpolate-hcl',
         type,
         input,
         for (int i = 0; i < stopInputs.length; i++) ...[
           stopInputs[i],
           stopOutputs[i],
         ],
       ];

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
  Expression.interpolateLab({
    required InterpolationType type,
    required Expression input,
    required List<double> stopInputs,
    required List<Object> stopOutputs,
  }) : json = [
         'interpolate-lab',
         type,
         input,
         for (int i = 0; i < stopInputs.length; i++) ...[
           stopInputs[i],
           stopOutputs[i],
         ],
       ];

  // STRING

  /// Returns true if the [input] string is expected to render legibly.
  /// Returns `false` if the [input] string contains sections that cannot be
  /// rendered without potential loss of meaning (e.g. Indic scripts that require
  /// complex text shaping, or right-to-left scripts if the mapbox-gl-rtl-text
  /// plugin is not in use in MapLibre GL JS).
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#is-supported-script
  Expression.isSupportedScript(Object input)
    : json = ['is-supported-script', input];

  /// Returns the input string converted to uppercase. Follows the Unicode Default Case Conversion algorithm and the locale-insensitive case mappings in the Unicode Character Database.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#upcase
  Expression.upcase(Object input) : json = ['upcase', input];

  /// Returns the input string converted to lowercase. Follows the Unicode Default Case Conversion algorithm and the locale-insensitive case mappings in the Unicode Character Database.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#downcase
  Expression.downcase(Object input) : json = ['downcase', input];

  /// Returns a string consisting of the concatenation of the inputs. Each input
  /// is converted to a string as if by [toString].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#concat
  Expression.concat(List<Object> inputs) : json = ['concat', ...inputs];

  /// Returns the IETF language tag of the locale being used by the provided
  /// [collator]. This can be used to determine the default system locale, or to
  /// determine if a requested locale was successfully loaded.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#resolved-locale
  Expression.resolvedLocale(Object collator)
    : json = ['resolved-locale', collator];

  /// Returns an array of substrings formed by splitting an input string by a
  /// separator string.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#split
  Expression.split(Object input, Object separator)
    : json = ['split', input, separator];

  /// Returns a string formed by concatenating the elements of the input array,
  /// inserting a separator between each element.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#join
  Expression.join(List<Object> input, Object separator)
    : json = ['join', ...input, separator];

  // TYPES

  /// Provides a literal array or object value.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#literal
  Expression.literal(Object value) : json = ['literal', value];

  /// Asserts that the input is an array (optionally with a specific item type
  /// and length). If, when the input expression is evaluated, it is not of the
  /// asserted type or length, then this assertion will cause the whole
  /// expression to be aborted.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#array
  Expression.array(Expression expression, {ArrayType? type, int? length})
    : json = ['array', ?type?.name, ?length, expression];

  /// Returns a string describing the type of the given value.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#typeof
  Expression.typeOf(Expression expression) : json = ['typeof', expression];

  /// Asserts that the input value is a string. If multiple values are provided,
  /// each one is evaluated in order until a string is obtained. If none of the
  /// inputs are strings, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#string
  Expression.string(List<Object> inputs) : json = ['string', ...inputs];

  /// Asserts that the input value is a number. If multiple values are provided,
  /// each one is evaluated in order until a number is obtained. If none of the
  /// inputs are numbers, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#number
  Expression.number(List<Object> inputs) : json = ['number', ...inputs];

  /// Asserts that the input value is a boolean. If multiple values are provided,
  /// each one is evaluated in order until a boolean is obtained. If none of the
  /// inputs are booleans, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#boolean
  Expression.boolean(List<Object> inputs) : json = ['boolean', ...inputs];

  /// Asserts that the input value is a [Map]. If multiple values are provided,
  /// each one is evaluated in order until an object is obtained. If none of the
  /// inputs are objects, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#object
  Expression.object(List<Expression> inputs) : json = ['object', ...inputs];

  /// Returns a `collator` for use in locale-dependent comparison operations. Use
  /// `resolved-locale` to test the results of locale fallback behavior.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#collator
  Expression.collator({
    Object? caseSensitive,
    Object? diacriticSensitive,
    Object? locale,
  }) : json = [
         'collator',
         <String, Object?>{
           'case-sensitive': ?caseSensitive,
           'diacritic-sensitive': ?diacriticSensitive,
           'locale': ?locale,
         },
       ];

  /// Returns a `formatted` string for displaying mixed-format text in the
  /// [SymbolStyleLayer.textField] property. The input may contain a string
  /// literal or [Expression], including an [Expression.image]. Strings may be
  /// followed by a style override object.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#format
  Expression.format(List<FormatSection> sections)
    : json = ['format', ...sections.expand((json) => json.json)];

  /// Returns an image type for use in `icon-image`, `*-pattern` entries and as a
  /// section in the [Expression.format] expression. If set, the image argument will check
  /// that the requested image exists in the style and will return either the
  /// resolved image name or `null`, depending on whether or not the image is
  /// currently in the style. This validation process is synchronous and requires
  /// the image to have been added to the style before requesting it in the image
  /// argument.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#image
  Expression.image(Object input) : json = ['image', input];

  /// Converts the input number into a string representation using the provided
  /// format_options.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#number-format
  Expression.numberFormat({
    required Object input,
    String? locale,
    String? currency,
    String? unit,
    int? minFractionDigits,
    int? maxFractionDigits,
  }) : json = [
         'number-format',
         input,
         <String, Object?>{
           'locale': ?locale,
           'currency': ?currency,
           'unit': ?unit,
           'min-fraction-digits': ?minFractionDigits,
           'max-fraction-digits': ?maxFractionDigits,
         },
       ];

  /// Converts the input value to a string. If the input is null, the result is
  /// "". If the input is a boolean, the result is "true" or "false". If the input
  /// is a number, it is converted to a string as specified by the
  /// ["NumberToString" algorithm](https://tc39.es/ecma262/#sec-tostring-applied-to-the-number-type)
  /// of the ECMAScript Language Specification. If the
  /// input is a color, it is converted to a string of the form `"rgba(r,g,b,a)"`,
  /// where `r`, `g`, and `b` are numerals ranging from 0 to 255, and a ranges
  /// from 0 to 1. Otherwise, the input is converted to a string in the format
  /// specified by the [JSON.stringify](https://tc39.es/ecma262/#sec-json.stringify) function
  /// of the ECMAScript Language Specification.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#to-string
  Expression.toString(Expression input) : json = ['to-string', input];

  /// Converts the input value to a number, if possible. If the input is null or
  /// false, the result is 0. If the input is true, the result is 1. If the input
  /// is a string, it is converted to a number as specified by the "ToNumber
  /// Applied to the String Type" algorithm of the ECMAScript Language
  /// Specification. If multiple values are provided, each one is evaluated in
  /// order until the first successful conversion is obtained. If none of the
  /// inputs can be converted, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#to-number
  Expression.toNumber(Object input)
    : json = switch (input) {
        final List<Expression> list => ['to-number', ...list],
        _ => ['to-number', input],
      };

  /// Converts the input value to a boolean. The result is false when the input is
  /// an empty string, 0, false, null, or NaN; otherwise it is true.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#to-boolean
  Expression.toBoolean(Expression input) : json = ['to-boolean', input];

  /// Converts the input value to a color. If multiple values are provided, each
  /// one is evaluated in order until the first successful conversion is obtained.
  /// If none of the inputs can be converted, the expression is an error.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#to-color
  Expression.toColor(List<Object> inputs) : json = ['to-color', ...inputs];

  // VARIABLE BINDING

  /// Binds expressions to named variables, which can then be referenced in the
  /// result expression using [Expression.var_].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#let
  Expression.let({
    required Map<String, Object?> variables,
    required Expression expression,
  }) : json = [
         'let',
         ...variables.entries.expand((e) => [e.key, e.value]),
         expression,
       ];

  /// References variable bound using [Expression.let].
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#var
  Expression.var_(Object variable) : json = ['var', variable];

  // ZOOM

  /// Gets the current zoom level. Note that in style layout and paint properties,
  /// `["zoom"]` may only appear as the input to a top-level [Expression.step] or
  /// [Expression.interpolate] expression.
  ///
  /// https://maplibre.org/maplibre-style-spec/expressions/#zoom
  Expression.zoom() : json = ['zoom'];
}

/// The asserted items type in an [Expression.array] expression.
enum ArrayType {
  /// An array of numbers.
  double('number'),

  /// An array of strings.
  string('string'),

  /// An array of booleans.
  bool('boolean');

  const ArrayType(this.name);

  /// The name of the array type.
  final String name;

  @override
  String toString() => name;
}

/// An object defining a section of text in a [Expression.format] expression, along with
/// optional style overrides for that section.
extension type const FormatSection.fromJson(List<Object> json) {
  /// Create a new [FormatSection] object.
  FormatSection({
    required Object content,
    StyleOverrides style = const StyleOverrides.fromJson({}),
  }) : json = [content, style.json];
}

/// An object defining style overrides for a section of text in a [Expression.format]
/// expression.
extension type const StyleOverrides.fromJson(Map<String, Object> json) {
  /// Create a new [StyleOverrides] object.
  ///
  /// - [textFont]: Overrides the font stack specified by the root
  ///   layout property.
  /// - [textColor]: Overrides the color specified by the root paint
  ///   property.
  /// - [fontScale]: Applies a scaling factor on text-size as specified
  ///   by the root layout property.
  /// - [verticalAlign]: Aligns a vertical text section or image in relation to
  ///   the row it belongs to. Refer to the design proposal for more details.
  StyleOverrides({
    String? textFont,
    Color? textColor,
    double? fontScale,
    VerticalAlign? verticalAlign,
  }) : json = {
         'text-font': ?textFont,
         'text-color': ?textColor?.toHexString(),
         'font-scale': ?fontScale,
         'vertical-align': ?verticalAlign?.name,
       };
}

/// The vertical alignment options for text sections in a [Expression.format] expression.
enum VerticalAlign {
  /// Align the bottom of this section with the bottom of other sections.
  ///
  /// ![Preview](https://github.com/user-attachments/assets/0474a2fd-a4b2-417c-9187-7a13a28695bc)
  bottom,

  /// Align the center of this section with the center of other sections.
  ///
  /// ![Preview](https://github.com/user-attachments/assets/92237455-be6d-4c5d-b8f6-8127effc1950)
  center,

  /// Align the top of this section with the top of other sections.
  ///
  /// ![Preview](https://github.com/user-attachments/assets/45dccb28-d977-4abb-a006-4ea9792b7c53)
  top;

  @override
  String toString() => name;
}

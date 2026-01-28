part of 'expressions.dart';

/// A literal expression that represents a constant value.
/// Provides a literal array or object value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#literal
Expression literal(Object? value) => Expression.fromJson(['literal', value]);

/// Asserts that the input is an array (optionally with a specific item type
/// and length). If, when the input expression is evaluated, it is not of the
/// asserted type or length, then this assertion will cause the whole
/// expression to be aborted.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#array
Expression array(Expression expression, {ArrayType? type, int? length}) =>
    Expression.fromJson(['array', ?type?.name, ?length, expression]);

/// The asserted items type in an [array] expression.
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
}

/// Returns a string describing the type of the given value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#typeof
Expression typeOf(Expression expression) =>
    Expression.fromJson(['typeof', expression]);

/// Asserts that the input value is a string. If multiple values are provided,
/// each one is evaluated in order until a string is obtained. If none of the
/// inputs are strings, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#string
Expression string(OneOf2<Expression, List<Expression>> input) {
  if (input is List<Expression>) {
    final values = input as List<Expression>;
    return Expression.fromJson(['string', ...values]);
  }
  if (input is Expression) {
    return Expression.fromJson(['string', input]);
  }
  throw StateError('Unreachable');
}

/// Asserts that the input value is a number. If multiple values are provided,
/// each one is evaluated in order until a number is obtained. If none of the
/// inputs are numbers, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#number
Expression number(OneOf2<Expression, List<Expression>> input) {
  if (input is List<Expression>) {
    final values = input as List<Expression>;
    return Expression.fromJson(['number', ...values]);
  }
  if (input is Expression) {
    return Expression.fromJson(['number', input]);
  }
  throw StateError('Unreachable');
}

/// Asserts that the input value is a boolean. If multiple values are provided,
/// each one is evaluated in order until a boolean is obtained. If none of the
/// inputs are booleans, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#boolean
Expression boolean(OneOf2<Expression, List<Expression>> input) {
  if (input is List<Expression>) {
    final values = input as List<Expression>;
    return Expression.fromJson(['boolean', ...values]);
  }
  if (input is Expression) {
    return Expression.fromJson(['boolean', input]);
  }
  throw StateError('Unreachable');
}

/// Asserts that the input value is a [Map]. If multiple values are provided,
/// each one is evaluated in order until an object is obtained. If none of the
/// inputs are objects, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#object
Expression object(OneOf2<Expression, List<Expression>> input) {
  if (input is List<Expression>) {
    final values = input as List<Expression>;
    return Expression.fromJson(['object', ...values]);
  }
  if (input is Expression) {
    return Expression.fromJson(['object', input]);
  }
  throw StateError('Unreachable');
}

/// Returns a `collator` for use in locale-dependent comparison operations. Use
/// `resolved-locale` to test the results of locale fallback behavior.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#collator
Expression collator({
  OneOf2<bool, Expression>? caseSensitive,
  OneOf2<bool, Expression>? diacriticSensitive,
  OneOf2<Locale, Expression>? locale,
}) => Expression.fromJson([
  'collator',
  <String, Object?>{
    'case-sensitive': ?caseSensitive,
    'diacritic-sensitive': ?diacriticSensitive,
    if (locale != null)
      'locale': switch (locale) {
        Locale locale => locale.toString(),
        Expression expr => expr,
        _ => throw StateError('Unreachable'),
      },
  },
]);

/// Returns a `formatted` string for displaying mixed-format text in the
/// [SymbolStyleLayer.textField] property. The input may contain a string
/// literal or [Expression], including an [image]. Strings may be
/// followed by a style override object.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#format
Expression format(Map<String, StyleOverrides> overrides) =>
    Expression.fromJson([
      'format',
      for (final entry in overrides.entries)
        ...[entry.key, entry.value.json],
    ]);

/// An object defining style overrides for a section of text in a [format]
/// expression.
extension type StyleOverrides._(Map<String, Object> json) {
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

/// The vertical alignment options for text sections in a [format] expression.
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
  top,
}

/// Returns an image type for use in icon-image, *-pattern entries and as a
/// section in the format expression. If set, the image argument will check that
/// the requested image exists in the style and will return either the resolved
/// image name or null, depending on whether or not the image is currently in
/// the style. This validation process is synchronous and requires the image to
/// have been added to the style before requesting it in the image argument.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#image
Expression image(OneOf2<String, Expression> input) => Expression.fromJson([
  'image',
  switch (input) {
    String imageName => imageName,
    Expression expression => expression,
    _ => throw StateError('Unreachable'),
  },
]);

/// Converts the input number into a string representation using the provided
/// format_options.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#number-format
Expression numberFormat({
  required OneOf2<double, Expression> input,
  required String? locale,
  required String? currency,
  required int? minFractionDigits,
  required int? maxFractionDigits,
}) => Expression.fromJson([
  'number-format',
  switch (input) {
    double value => value,
    Expression expr => expr,
    _ => throw StateError('Unreachable'),
  },
  <String, Object?>{
    'locale': ?locale,
    'currency': ?currency,
    'min-fraction-digits': ?minFractionDigits,
    'max-fraction-digits': ?maxFractionDigits,
  },
]);

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
Expression toString(Expression input) =>
    Expression.fromJson(['to-string', input]);

/// Converts the input value to a number, if possible. If the input is null or
/// false, the result is 0. If the input is true, the result is 1. If the input
/// is a string, it is converted to a number as specified by the "ToNumber
/// Applied to the String Type" algorithm of the ECMAScript Language
/// Specification. If multiple values are provided, each one is evaluated in
/// order until the first successful conversion is obtained. If none of the
/// inputs can be converted, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-number
Expression toNumber(OneOf2<Expression, List<Expression>> input) {
  if (input is List<Expression>) {
    final values = input as List<Expression>;
    return Expression.fromJson(['to-number', ...values]);
  }
  if (input is Expression) {
    return Expression.fromJson(['to-number', input]);
  }
  throw StateError('Unreachable');
}

/// Converts the input value to a boolean. The result is false when the input is
/// an empty string, 0, false, null, or NaN; otherwise it is true.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-boolean
Expression toBoolean(Expression input) =>
    Expression.fromJson(['to-boolean', input]);

/// Converts the input value to a color. If multiple values are provided, each
/// one is evaluated in order until the first successful conversion is obtained.
/// If none of the inputs can be converted, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-color
Expression toColor(OneOf2<Expression, List<Expression>> input) {
  if (input is List<Expression>) {
    final values = input as List<Expression>;
    return Expression.fromJson(['to-color', ...values]);
  }
  if (input is Expression) {
    return Expression.fromJson(['to-color', input]);
  }
  throw StateError('Unreachable');
}

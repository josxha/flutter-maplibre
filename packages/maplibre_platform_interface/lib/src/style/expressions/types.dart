part of 'expressions.dart';

/// Provides a literal array or object value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#literal
Expression<T> literal<T extends Object>(T value) =>
    Expression.fromJson(['literal', value]);

/// Asserts that the input is an array (optionally with a specific item type
/// and length). If, when the input expression is evaluated, it is not of the
/// asserted type or length, then this assertion will cause the whole
/// expression to be aborted.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#array
Expression<List<T>> array<T extends Object>(
  Expression<List<T>> expression, {
  ArrayType? type,
  int? length,
}) => Expression.fromJson(['array', ?type?.name, ?length, expression]);

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
Expression<String> typeOf(Expression expression) =>
    Expression.fromJson(['typeof', expression]);

/// Asserts that the input value is a string. If multiple values are provided,
/// each one is evaluated in order until a string is obtained. If none of the
/// inputs are strings, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#string
Expression<String> string(List<Expression> inputs) {
  return Expression.fromJson(['string', ...inputs]);
}

/// Asserts that the input value is a number. If multiple values are provided,
/// each one is evaluated in order until a number is obtained. If none of the
/// inputs are numbers, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#number
Expression<num> number(List<Expression> inputs) {
  return Expression.fromJson(['number', ...inputs]);
}

/// Asserts that the input value is a boolean. If multiple values are provided,
/// each one is evaluated in order until a boolean is obtained. If none of the
/// inputs are booleans, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#boolean
Expression<bool> boolean(List<Expression> inputs) {
  return Expression.fromJson(['boolean', ...inputs]);
}

/// Asserts that the input value is a [Map]. If multiple values are provided,
/// each one is evaluated in order until an object is obtained. If none of the
/// inputs are objects, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#object
Expression<Map<String, Object?>> object(List<Expression> inputs) {
  return Expression.fromJson(['object', ...inputs]);
}

/// Returns a `collator` for use in locale-dependent comparison operations. Use
/// `resolved-locale` to test the results of locale fallback behavior.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#collator
Expression collator({
  Object? caseSensitive,
  Object? diacriticSensitive,
  Object? locale,
}) {
  assert(
    caseSensitive == null ||
        caseSensitive is bool ||
        caseSensitive is Expression<bool>,
    'caseSensitive must be a bool or an Expression<bool>',
  );
  assert(
    diacriticSensitive == null ||
        diacriticSensitive is bool ||
        diacriticSensitive is Expression<bool>,
    'diacriticSensitive must be a bool or an Expression<bool>',
  );
  assert(
    locale == null || locale is String || locale is Expression<String>,
    'locale must be a String or an Expression<String>',
  );
  return Expression.fromJson([
    'collator',
    <String, Object?>{
      'case-sensitive': ?caseSensitive,
      'diacritic-sensitive': ?diacriticSensitive,
      if (locale != null)
        'locale': switch (locale) {
          final Locale locale => locale.toString(),
          final Expression expr => expr.json,
          _ => throw StateError('Unreachable'),
        },
    },
  ]);
}

/// Returns a `formatted` string for displaying mixed-format text in the
/// [SymbolStyleLayer.textField] property. The input may contain a string
/// literal or [Expression], including an [image]. Strings may be
/// followed by a style override object.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#format
Expression<Formatted> format(Map<Object, StyleOverrides> overrides) =>
    Expression.fromJson([
      'format',
      for (final entry in overrides.entries) ...[
        switch (entry.key) {
          final String str => str,
          final Expression expr => expr.json,
          _ => throw ArgumentError.value(
            entry.key,
            'overrides',
            'Keys must be either String or Expression',
          ),
        },
        entry.value.json,
      ],
    ]);

/// An object defining style overrides for a section of text in a [format]
/// expression.
extension type StyleOverrides.fromJson(Map<String, Object> json) {
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

/// Returns an image type for use in `icon-image`, `*-pattern` entries and as a
/// section in the [format] expression. If set, the image argument will check
/// that the requested image exists in the style and will return either the
/// resolved image name or `null`, depending on whether or not the image is
/// currently in the style. This validation process is synchronous and requires
/// the image to have been added to the style before requesting it in the image
/// argument.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#image
Expression image(Object input) => Expression.fromJson([
  'image',
  switch (input) {
    final String imageName => imageName,
    final Expression expression => expression,
    _ => throw ArgumentError.value(
      input,
      'input',
      'Input must be either a String or an Expression',
    ),
  },
]);

/// Converts the input number into a string representation using the provided
/// format_options.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#number-format
Expression<String> numberFormat({
  required Object input,
  String? locale,
  String? currency,
  String? unit,
  int? minFractionDigits,
  int? maxFractionDigits,
}) => Expression.fromJson([
  'number-format',
  switch (input) {
    final double value => value,
    final Expression expr => expr,
    _ => throw ArgumentError.value(
      input,
      'input',
      'Input must be either a num or an Expression',
    ),
  },
  <String, Object?>{
    'locale': ?locale,
    'currency': ?currency,
    'unit': ?unit,
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
Expression<String> toString(Expression input) =>
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
Expression<num> toNumber(Object input) => switch (input) {
  final List<Expression> list => Expression.fromJson(['to-number', ...list]),
  final Expression expr => Expression.fromJson(['to-number', expr]),
  _ => throw ArgumentError.value(
    input,
    'input',
    'Input must be either an Expression or a List<Expression>',
  ),
};

/// Converts the input value to a boolean. The result is false when the input is
/// an empty string, 0, false, null, or NaN; otherwise it is true.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-boolean
Expression<bool> toBoolean(Expression input) =>
    Expression.fromJson(['to-boolean', input]);

/// Converts the input value to a color. If multiple values are provided, each
/// one is evaluated in order until the first successful conversion is obtained.
/// If none of the inputs can be converted, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-color
Expression<Color_> toColor(List<Expression> inputs) {
  return Expression.fromJson(['to-color', ...inputs]);
}

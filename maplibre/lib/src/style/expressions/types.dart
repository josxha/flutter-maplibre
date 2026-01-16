part of 'expressions.dart';

/// {@template literal-expression}
/// A literal expression that represents a constant value.
/// Provides a literal array or object value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#literal
/// {@endtemplate}
extension type const LiteralExpr._(List<Object?> json) implements Expression {
  /// Create a new `literal` expression with a boolean value.
  // ignore: avoid_positional_boolean_parameters
  LiteralExpr.bool(bool value) : json = [op, value];

  /// Create a new `literal` expression with a [double] value.
  LiteralExpr.double(double value) : json = [op, value];

  /// Create a new `literal` expression with a [String] value.
  LiteralExpr.string(String value) : json = [op, value];

  /// Create a new `literal` expression with an [List] value.
  LiteralExpr.list(List<Object?> value) : json = [op, value];

  /// Create a new `literal` expression with a [Map] value.
  LiteralExpr.map(Map<String, Object?> value) : json = [op, value];

  /// The operator for `literal` expressions.
  static const String op = 'literal';
}

/// {@template array-expression}
/// Asserts that the input is an array (optionally with a specific item type
/// and length). If, when the input expression is evaluated, it is not of the
/// asserted type or length, then this assertion will cause the whole
/// expression to be aborted.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#array
/// {@endtemplate}
extension type const ArrayExpr._(List<Object?> json) implements Expression {
  /// Create a new `array` expression.
  ArrayExpr(Expression expression, {ArrayType? type, int? length})
    : json = [op, ?type?.name, ?length, ...expression.json];

  /// The operator for `array` expressions.
  static const String op = 'array';
}

/// The asserted items type in an [ArrayExpr].
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

/// {@template object-typeof}
/// Returns a string describing the type of the given value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#typeof
/// {@endtemplate}
extension type const TypeOfExpr._(List<Object?> json) implements Expression {
  /// Create a new `typeof` expression.
  TypeOfExpr(Expression expression) : json = [op, expression.json];

  /// The operator for `typeof` expressions.
  static const String op = 'typeof';
}

/// {@template string-expression}
/// Asserts that the input value is a string. If multiple values are provided,
/// each one is evaluated in order until a string is obtained. If none of the
/// inputs are strings, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#string
/// {@endtemplate}
extension type const StringExpr._(List<Object?> json) implements Expression {
  /// Create a new `string` expression with a single value.
  StringExpr(Expression input) : json = [op, input];

  /// Create a new `string` expression with multiple values.
  StringExpr.list(List<Expression> input) : json = [op, ...input];

  /// The operator for `string` expressions.
  static const String op = 'string';
}

/// {@template number-expression}
/// Asserts that the input value is a number. If multiple values are provided,
/// each one is evaluated in order until a number is obtained. If none of the
/// inputs are numbers, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#number
/// {@endtemplate}
extension type const NumberExpr._(List<Object?> json) implements Expression {
  /// Create a new `number` expression with a single value.
  NumberExpr(Expression input) : json = [op, input];

  /// Create a new `number` expression with multiple values.
  NumberExpr.list(List<Expression> input) : json = [op, ...input];

  /// The operator for `number` expressions.
  static const String op = 'number';
}

/// {@template boolean-expression}
/// Asserts that the input value is a boolean. If multiple values are provided,
/// each one is evaluated in order until a boolean is obtained. If none of the
/// inputs are booleans, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#boolean
/// {@endtemplate}
extension type const BooleanExpr._(List<Object?> json) implements Expression {
  /// Create a new `boolean` expression with a single value.
  BooleanExpr(Expression input) : json = [op, input];

  /// Create a new `boolean` expression with multiple values.
  BooleanExpr.list(List<Expression> input) : json = [op, ...input];

  /// The operator for `boolean` expressions.
  static const String op = 'boolean';
}

/// {@template object-expression}
/// Asserts that the input value is a [Map]. If multiple values are provided,
/// each one is evaluated in order until an object is obtained. If none of the
/// inputs are objects, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#object
/// {@endtemplate}
extension type const ObjectExpr._(List<Object?> json) implements Expression {
  /// Create a new `object` expression with a single value.
  ObjectExpr(Expression input) : json = [op, input];

  /// Create a new `object` expression with multiple values.
  ObjectExpr.list(List<Expression> input) : json = [op, ...input];

  /// The operator for `object` expressions.
  static const String op = 'object';
}

/// {@template collator-expression}
/// Returns a `collator` for use in locale-dependent comparison operations. Use
/// `resolved-locale` to test the results of locale fallback behavior.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#collator
/// {@endtemplate}
extension type const CollatorExpr._(List<Object?> json) implements Expression {
  /// Create a new `collator` expression with the given options.
  ///
  /// - [caseSensitive]: If characters of different case-ness are
  ///   considered different
  /// - [diacriticSensitive]: If characters with different diacritics
  ///   are considered different
  /// - [locale]: IETF language tag of the locale to use. If none is
  ///   provided, the default locale is used. If the requested locale is not
  ///   available, the collator will use a system-defined fallback locale.
  CollatorExpr({
    OneOf2<bool, Expression>? caseSensitive,
    OneOf2<bool, Expression>? diacriticSensitive,
    OneOf2<Locale, Expression>? locale,
  }) : json = [
         op,
         <String, Object?>{
           'case-sensitive': ?caseSensitive,
           'diacritic-sensitive': ?diacriticSensitive,
           if (locale != null)
             'locale': switch (locale) {
               Locale locale => locale.toString(),
               Expression expr => expr.json,
               _ => throw StateError('Unreachable'),
             },
         },
       ];

  /// The operator for `collator` expressions.
  static const String op = 'collator';
}

/// {@template format-expression}
/// Returns a `formatted` string for displaying mixed-format text in the
/// [SymbolStyleLayer.textField] property. The input may contain a string
/// literal or [Expression], including an [ImageExpr]. Strings may be
/// followed by a style override object.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#format
/// {@endtemplate}
extension type const FormatExpr._(List<Object?> json) implements Expression {
  /// Create a new `format` expression.
  ///
  /// - input_i: string | image
  /// - style_overrides_i: {text-font?: string, text-color?: color, font-scale?: number, vertical-align?: "bottom" | "center" | "top"}
  FormatExpr(Map<String, StyleOverrides> overrides)
    : json = [
        op,
        for (final entry in overrides.entries) ...[entry.key, entry.value.json],
      ];

  /// The operator for `format` expressions.
  static const String op = 'format';
}

/// An object defining style overrides for a section of text in a [FormatExpr].
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

/// The vertical alignment options for text sections in a [FormatExpr].
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

/// {@template image-expression}
/// Returns an image type for use in icon-image, *-pattern entries and as a
/// section in the format expression. If set, the image argument will check that
/// the requested image exists in the style and will return either the resolved
/// image name or null, depending on whether or not the image is currently in
/// the style. This validation process is synchronous and requires the image to
/// have been added to the style before requesting it in the image argument.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#image
/// {@endtemplate}
extension type const ImageExpr._(List<Object?> json) implements Expression {
  /// Create a new `image` expression from an image name.
  ImageExpr.string(String imageName) : json = [op, imageName];

  /// Create a new `image` expression from an [Expression].
  ImageExpr.expr(Expression expression) : json = [op, expression.json];

  /// The operator for `image` expressions.
  static const String op = 'image';
}

/// {@template number-format-expression}
/// Converts the input number into a string representation using the provided
/// format_options.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#number-format
/// {@endtemplate}
extension type const NumberFormatExpr._(List<Object?> json)
    implements Expression {
  /// Create a new [number-format] expression.
  ///
  /// - input: number - number to format
  /// - format_options: {locale?: string, currency?: string, min-fraction-digits?: number, max-fraction-digits?: number}- Format options for the number
  NumberFormatExpr({
    required OneOf2<double, Expression> input,
    required String? locale,
    required String? currency,
    required int? minFractionDigits,
    required int? maxFractionDigits,
  }) : json = [
         op,
         switch (input) {
           double value => value,
           Expression expr => expr.json,
           _ => throw StateError('Unreachable'),
         },
         <String, Object?>{
           'locale': ?locale,
           'currency': ?currency,
           'min-fraction-digits': ?minFractionDigits,
           'max-fraction-digits': ?maxFractionDigits,
         },
       ];

  /// The operator for `number-format` expressions.
  static const String op = 'number-format';
}

/// {@template to-string-expression}
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
/// {@endtemplate}
extension type const ToStringExpr._(List<Object?> json) implements Expression {
  /// Create a new `to-string` expression.
  ToStringExpr(Expression input) : json = [op, input.json];

  /// The operator for `to-string` expressions.
  static const String op = 'to-string';
}

/// {@template to-number-expression}
/// Converts the input value to a number, if possible. If the input is null or
/// false, the result is 0. If the input is true, the result is 1. If the input
/// is a string, it is converted to a number as specified by the "ToNumber
/// Applied to the String Type" algorithm of the ECMAScript Language
/// Specification. If multiple values are provided, each one is evaluated in
/// order until the first successful conversion is obtained. If none of the
/// inputs can be converted, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-number
/// {@endtemplate}
extension type const ToNumberExpr._(List<Object?> json) implements Expression {
  /// Create a new `to-number` expression with a single value.
  ToNumberExpr(Expression input) : json = [op, input.json];

  /// Create a new `to-number` expression with multiple values.
  ToNumberExpr.list(List<Expression> input) : json = [op, ...input];

  /// The operator for `to-number` expressions.
  static const String op = 'to-number';
}

/// {@template to-boolean-expression}
/// Converts the input value to a boolean. The result is false when the input is
/// an empty string, 0, false, null, or NaN; otherwise it is true.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-boolean
/// {@endtemplate}
extension type const ToBooleanExpr._(List<Object?> json) implements Expression {
  /// Create a new `to-boolean` expression.
  ToBooleanExpr(Expression input) : json = [op, input];

  /// The operator for `to-boolean` expressions.
  static const String op = 'to-boolean';
}

/// {@template to-color-expression}
/// Converts the input value to a color. If multiple values are provided, each
/// one is evaluated in order until the first successful conversion is obtained.
/// If none of the inputs can be converted, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-color
/// {@endtemplate}
extension type const ToColorExpr._(List<Object?> json) implements Expression {
  /// Create a new [to-color] expression with a single value.
  ToColorExpr(Expression input) : json = [op, input];

  /// Create a new [to-color] expression with multiple values.
  ToColorExpr.list(List<Expression> input) : json = [op, ...input];

  /// The operator for [to-color] expressions.
  static const String op = 'to-color';
}

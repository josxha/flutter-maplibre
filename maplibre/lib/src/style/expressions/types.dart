part of 'expressions.dart';

/// {@template literal-expression}
/// A literal expression that represents a constant value.
/// Provides a literal array or object value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#literal
/// {@endtemplate}
extension type const LiteralExpression<T extends Object?>._(List<Object?> json)
    implements Expression {
  /// Create a new [literal] expression.
  LiteralExpression(T value) : json = [operator, value];

  /// The operator for [literal] expressions.
  static const String operator = 'literal';

  /// The literal value of the expression.
  T get value => json[1] as T;
}

/// {@template array-expression}
/// Asserts that the input is an array (optionally with a specific item type
/// and length). If, when the input expression is evaluated, it is not of the
/// asserted type or length, then this assertion will cause the whole
/// expression to be aborted.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#array
/// {@endtemplate}
extension type const ArrayExpression<Type extends Object>._(List<Object?> json)
    implements Expression {
  /// Create a new [array] expression.
  ArrayExpression(List<Type> value, {ArrayType? type, int? length})
    : json = [operator, ?type?.name, ?length, ...value];

  /// The operator for [array] expressions.
  static const String operator = 'array';
}

/// The asserted items type in an [ArrayExpression].
enum ArrayType {
  /// An array of numbers.
  number,

  /// An array of strings.
  string,

  /// An array of booleans.
  boolean,
}

/// {@template object-typeof}
/// Returns a string describing the type of the given value.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#typeof
/// {@endtemplate}
extension type const TypeOfExpression._(List<Object?> json)
    implements Expression {
  /// Create a new [typeof] expression.
  TypeOfExpression(Object? value) : json = [operator, value];

  /// The operator for [typeof] expressions.
  static const String operator = 'typeof';
}

/// {@template string-expression}
/// Asserts that the input value is a string. If multiple values are provided,
/// each one is evaluated in order until a string is obtained. If none of the
/// inputs are strings, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#string
/// {@endtemplate}
extension type const StringExpression._(List<Object?> json)
    implements Expression {
  /// Create a new [string] expression.
  StringExpression(List<Object?> values) : json = [operator, ...values];

  /// The operator for [string] expressions.
  static const String operator = 'string';
}

/// {@template number-expression}
/// Asserts that the input value is a number. If multiple values are provided,
/// each one is evaluated in order until a number is obtained. If none of the
/// inputs are numbers, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#number
/// {@endtemplate}
extension type const NumberExpression._(List<Object?> json)
    implements Expression {
  /// Create a new [number] expression.
  NumberExpression(List<Object?> values) : json = [operator, ...values];

  /// The operator for [number] expressions.
  static const String operator = 'number';
}

// TODO continue implementing other expression types.

import 'package:flutter/painting.dart';
import 'package:maplibre/src/style/expressions/expressions.dart';

/// [PropertyValue] is a simple wrapper around a value that can either be a
/// literal value of type [V] or an [Expression] that evaluates to a value of
/// type [V].
///
/// It is used so that style properties can be created in a type-safe way.
extension type const PropertyValue<V extends Object?>._(dynamic object) {
  /// Creates a [PropertyValue] from an [Expression].
  const PropertyValue.expression(Expression expression) : object = expression;

  /// Creates a [PropertyValue] from a literal value.
  const PropertyValue.value(V value) : object = value;

  /// Get the value as type [V].
  V get value => object as V;

  /// Get the value as an [Expression].
  Expression get expression => object as Expression;

  /// Indicates whether the [PropertyValue] is an expression.
  bool get isExpression => object is Expression;
}

/// A single [double] value, or an [List] of [double] values.
///
/// ```json
/// {
///    "hillshade-illumination-direction": 24,
///    "hillshade-illumination-direction": [45, 57.3]
/// }
/// ```
///
/// https://maplibre.org/maplibre-style-spec/types/#numberarray
extension type const NumberArray._(Object object) {
  /// Creates a [NumberArray] from an [List].
  const NumberArray.array(List<double> list) : object = list;

  /// Creates a [NumberArray] from a [double].
  const NumberArray.number(double value) : object = value;

  /// Get the value as [double].
  double get number => object as double;

  /// Get the value as an [List].
  List<double> get array => object as List<double>;

  /// Indicates whether the [NumberArray] is a [List].
  bool get isArray => object is List<double>;
}

/// A single [Color] value, or an [List] of [Color] values.
///
/// ```json
/// {
///    "hillshade-highlight-color": "#ffff00",
///    "hillshade-highlight-color": ["#ffff00", "rgb(255, 255, 0)", "yellow"]
/// }
/// ```
///
/// https://maplibre.org/maplibre-style-spec/types/#colorarray
extension type const ColorArray._(Object object) {
  /// Creates a [ColorArray] from a [List].
  const ColorArray.array(List<Color> list) : object = list;

  /// Creates a [ColorArray] from a [Color].
  const ColorArray.color(Color value) : object = value;

  /// Get the value as [Color].
  Color get color => object as Color;

  /// Get the value as an [List].
  List<Color> get array => object as List<Color>;

  /// Indicates whether the [ColorArray] is a [List].
  bool get isArray => object is List<Color>;
}

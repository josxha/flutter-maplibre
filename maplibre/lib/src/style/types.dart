import 'dart:ui';

import 'package:maplibre/maplibre.dart';

/// Create a union type with two possible types [T1] and [T2].
extension type const OneOf2<T1, T2>._(dynamic _) {
  /// Create a new instance of [OneOf2] with a value of type [T1].
  const OneOf2.t1(T1 value) : this._(value);

  /// Create a new instance of [OneOf2] with a value of type [T2].
  const OneOf2.t2(T2 value) : this._(value);

  /// Get the value as type [T1].
  T1 get asT1 => this as T1;

  /// Get the value as type [T2].
  T2 get asT2 => this as T2;
}

/// Create a union type with three possible types [T1], [T2] and [T3].
extension type const OneOf3<T1, T2, T3>._(dynamic _) {
  /// Create a new instance of [OneOf3] with a value of type [T1].
  const OneOf3.t1(T1 value) : this._(value);

  /// Create a new instance of [OneOf3] with a value of type [T2].
  const OneOf3.t2(T2 value) : this._(value);

  /// Create a new instance of [OneOf3] with a value of type [T3].
  const OneOf3.t3(T3 value) : this._(value);

  /// Get the value as type [T1].
  T1 get asT1 => this as T1;

  /// Get the value as type [T2].
  T2 get asT2 => this as T2;

  /// Get the value as type [T3].
  T3 get asT3 => this as T3;
}

/// Create a union type with three possible types [T1], [T2], [T3] and [T4].
extension type const OneOf4<T1, T2, T3, T4>._(dynamic _) {
  /// Create a new instance of [OneOf4] with a value of type [T1].
  const OneOf4.t1(T1 value) : this._(value);

  /// Create a new instance of [OneOf4] with a value of type [T2].
  const OneOf4.t2(T2 value) : this._(value);

  /// Create a new instance of [OneOf4] with a value of type [T3].
  const OneOf4.t3(T3 value) : this._(value);

  /// Create a new instance of [OneOf4] with a value of type [T4].
  const OneOf4.t4(T4 value) : this._(value);

  /// Get the value as type [T1].
  T1 get asT1 => this as T1;

  /// Get the value as type [T2].
  T2 get asT2 => this as T2;

  /// Get the value as type [T3].
  T3 get asT3 => this as T3;

  /// Get the value as type [T4].
  T4 get asT4 => this as T4;
}

/// Create a union type with three possible types : [String], [double], [bool],
/// [Map<String, Object?>] and [List<Object?>].
extension type const OneOf._(dynamic _) {
  /// Create a new instance of [OneOf] with a value of type [String].
  const OneOf.string(String value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type [double].
  const OneOf.double(double value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type [bool].
  // ignore: avoid_positional_boolean_parameters
  const OneOf.bool(bool value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type
  /// [Map<String, Object?>].
  const OneOf.map(Map<String, Object?> value) : this._(value);

  /// Create a new instance of [OneOf] with a value of type [List<Object?>].
  const OneOf.list(List<Object?> value) : this._(value);

  /// Get the value as type [String].
  String get asString => this as String;

  /// Get the value as type [double].
  double get asDouble => this as double;

  /// Get the value as type [bool].
  bool get asBool => this as bool;

  /// Get the value as type [Map<String, Object?>].
  Map<String, Object?> get asMap => this as Map<String, Object?>;

  /// Get the value as type [List<Object?>].
  List<Object?> get asList => this as List<Object?>;
}

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

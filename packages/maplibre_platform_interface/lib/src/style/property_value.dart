import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

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
  bool get isExpression => switch (object) {
  // In addition to checking if the object is an Expression / List, we also
  // have to check if the first element is a String that represents the
  // operator of the expression, otherwise we might have a
  // NumArray / List<double> that is not an expression.
    final Expression expression => expression.json.firstOrNull is String,
    _ => false,
  };

  Object? toJson() => switch (object) {
    final Expression expression => expression.json,
    null => null,
    final Color color => color.toHexString(),
    final Enum object => object.name,
    final Offset offset => [offset.dx, offset.dy],
    final EdgeInsets edgeInsets => [
      edgeInsets.top,
      edgeInsets.right,
      edgeInsets.bottom,
      edgeInsets.left,
    ],
    _ => object,
  };
}

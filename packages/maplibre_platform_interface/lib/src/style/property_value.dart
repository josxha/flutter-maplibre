import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// [PropertyValue] is a simple wrapper around a value that can either be a
/// literal value of type [V] or an [Expression] that evaluates to a value of
/// type [V].
///
/// It is used so that style properties can be created in a type-safe way.
class PropertyValue<V extends Object?> {
  /// Creates a [PropertyValue] from an [Expression].
  const PropertyValue.expression(Expression expression)
    : _object = expression,
      isExpression = true;

  /// Creates a [PropertyValue] from a literal value.
  const PropertyValue.value(V value) : _object = value, isExpression = false;

  final dynamic _object;

  /// Indicates whether the [PropertyValue] is an expression.
  final bool isExpression;

  /// Get the value as type [V].
  V get value => _object as V;

  /// Get the value as an [Expression].
  Expression<V> get expression => _object as Expression<V>;

  Object? toJson() => switch (_object) {
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
    _ => _object,
  };
}

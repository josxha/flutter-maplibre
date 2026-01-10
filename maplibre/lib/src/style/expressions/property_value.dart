import 'package:maplibre/src/style/expressions/expressions.dart';

/// Represents a property value that can either be a literal value of type V
/// or an expression that evaluates to a value of type V.
extension type PropertyValue<V extends Object>(Object object) {
  /// Creates a PropertyValue from an expression.
  const PropertyValue.expression(Expression expression) : object = expression;

  /// Creates a PropertyValue from a literal value.
  const PropertyValue.value(V value) : object = value;

  /// The underlying object, which can be either a literal value of type V
  /// or an [Expression].
  V get value => object as V;

  /// Get the value as an [Expression].
  Expression get expression => object as Expression;

  /// Indicates whether the PropertyValue is an expression.
  bool get isExpression => object is Expression;
}

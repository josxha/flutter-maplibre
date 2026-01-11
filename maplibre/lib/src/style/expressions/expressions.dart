/// Base class for expressions.
extension type Expression._(List<Object?> json) {
  /// Creates an expression from its JSON representation.
  static Expression fromJson(List<Object?> json) {
    final operator = json.first;
    switch (operator) {
      case LiteralExpression.operator:
        return LiteralExpression(json[1]);
      default:
        throw Exception('Unsupported expression operator: $operator');
    }
  }
}

/// Represents a literal expression.
extension type LiteralExpression<T extends Object?>._(List<Object?> json)
    implements Expression {
  /// Const constructor for LiteralExpression.
  LiteralExpression(T value) : json = [operator, value];

  /// The operator for literal expressions.
  static const String operator = 'literal';

  /// The literal value of the expression.
  T get value => json[1] as T;
}

/// Creates a [LiteralExpression] with the given [value].
LiteralExpression literal(Object? value) => LiteralExpression(value);

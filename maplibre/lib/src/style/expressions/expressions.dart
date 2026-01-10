/// Base class for expressions.
sealed class Expression {
  /// Const constructor for Expression.
  const Expression();

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

  /// Converts the expression to a JSON representation.
  List<Object?> toJson();
}

/// Represents a literal expression.
final class LiteralExpression extends Expression {
  /// Const constructor for LiteralExpression.
  const LiteralExpression(this.value);

  /// The operator for literal expressions.
  static const String operator = 'literal';

  /// The literal value of the expression.
  final Object? value;

  @override
  List<Object?> toJson() => [operator, value];
}

/// Creates a [LiteralExpression] with the given [value].
Expression literal(Object? value) => LiteralExpression(value);

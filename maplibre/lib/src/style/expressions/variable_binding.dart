part of 'expressions.dart';

/// {@template let-expression}
/// Binds expressions to named variables, which can then be referenced in the
/// result expression using [VarExpr].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#let
/// {@endtemplate}
extension type const LetExpr._(List<Object?> json) implements Expression {
  /// Create a new [LetExpr] expression.
  LetExpr({
    required Map<String, Object?> variables,
    required Expression expression,
  }) : json = [
         op,
         ...variables.entries.expand((e) => [e.key, e.value]),
         expression,
       ];

  /// The operator for `literal` expressions.
  static const String op = 'let';
}

/// {@template var-expression}
/// References variable bound using [LetExpr].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#var
/// {@endtemplate}
extension type const VarExpr._(List<Object?> json) implements Expression {
  /// Create a new `var` expression.
  VarExpr.string(String variableName) : json = [op, variableName];

  /// Create a new `var` expression.
  VarExpr.expr(Expression expression) : json = [op, expression];

  /// The operator for `var` expressions.
  static const String op = 'var';
}

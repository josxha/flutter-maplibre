part of 'expressions.dart';

/// {@template let-expression}
/// Binds expressions to named variables, which can then be referenced in the
/// result expression using `["var", "variable_name"]`.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#let
/// {@endtemplate}
extension type const LetExpression._(List<Object?> json) implements Expression {
  /// Create a new [let] expression.
  /// - `var_name_i`: string literal- The name of the i-th variable.
  /// - `var_value_i`: any- The value of the i-th variable.
  /// - `expression`: any- The expression within which the named variables can be referenced.
  LetExpression({
    required Map<String, Object?> variables,
    required Expression expression,
  }) : json = [
    operator,
    ...variables.entries.expand((e) => [e.key, e.value]),
    expression,
  ];

  /// The operator for [literal] expressions.
  static const String operator = 'let';
}

/// {@template var-expression}
/// References variable bound using [let].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#var
/// {@endtemplate}
extension type const VarExpression._(List<Object?> json) implements Expression {
  /// Create a new [var] expression.
  VarExpression(String variableName) : json = [operator, variableName];

  /// The operator for [var] expressions.
  static const String operator = 'var';
}

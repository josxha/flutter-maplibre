part of 'expressions.dart';

/// Binds expressions to named variables, which can then be referenced in the
/// result expression using [var_].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#let
Expression let({
  required Map<String, OneOf?> variables,
  required Expression expression,
}) => Expression.fromJson([
  'let',
  ...variables.entries.expand((e) => [e.key, e.value]),
  expression,
]);

/// References variable bound using [let].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#var
Expression<T> var_<T extends Object?>(OneOf2<String, Expression> variable) =>
    Expression.fromJson([
      'var',
      switch (variable) {
        final String name => name,
        final Expression expression => expression,
        _ => throw StateError('Unreachable'),
      },
    ]);

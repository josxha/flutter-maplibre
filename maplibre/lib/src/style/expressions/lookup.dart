part of 'expressions.dart';

/// {@template at-expression}
/// Retrieves an item from an array.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#at
/// {@endtemplate}
extension type const AtExpr._(List<Object?> json) implements Expression {
  /// Create a new `at` expression with an integer index.
  AtExpr({required int index, required Expression list})
    : this._(<Object?>[op, index, list]);

  /// Create a new `at` expression with an [Expression] index.
  AtExpr.expr({required Expression index, required Expression list})
    : this._(<Object?>[op, index, list]);

  /// The operator for `at` expressions.
  static const String op = 'at';
}

/// {@template in-expression}
/// Determines whether an item exists in an array or a substring exists in a string.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#in
/// {@endtemplate}
extension type const InExpr._(List<Object?> json) implements Expression {
  /// Create a new `in` expression. Find a expression [item] in an expression
  /// [list].
  InExpr({
    required OneOf3<num, String, Expression> item,
    required OneOf2<String, Expression> list,
  }) : this._(<Object?>[op, item, list]);

  /// The operator for `in` expressions.
  static const String op = 'in';
}

/// {@template index-of-expression}
/// Returns the first position at which an item can be found in an array or a substring can be found in a string, or -1 if the input cannot be found. Accepts an optional index from where to begin the search. In a string, a UTF-16 surrogate pair counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#index-of
/// {@endtemplate}
extension type const IndexOfExpr._(List<Object?> json) implements Expression {
  /// Create a new `index-of` expression. Find an [item] in an
  /// [list], starting at optional [fromIndex].
  IndexOfExpr({
    required OneOf3<num, String, Expression> item,
    required OneOf2<String, Expression> list,
    OneOf2<int, Expression>? fromIndex,
  }) : this._(<Object?>[op, item, list, ?fromIndex]);

  /// The operator for `index-of` expressions.
  static const String op = 'index-of';
}

/// {@template slice-expression}
/// Returns a subarray from an array or a substring from a string from a specified start index, or between a start index and an end index if set. The return value is inclusive of the start index but not of the end index. In a string, a UTF-16 surrogate pair counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#slice
/// {@endtemplate}
extension type const SliceExpr._(List<Object?> json) implements Expression {
  /// Create a new `slice` expression. Slice an [input] from [start]
  /// to optional [end].
  SliceExpr({
    required OneOf2<String, Expression> input,
    required OneOf2<int, Expression> start,
    OneOf2<int, Expression>? end,
  }) : this._(<Object?>[op, input, start, ?end]);

  /// The operator for `slice` expressions.
  static const String op = 'slice';
}

/// {@template global-state-expression}
/// Retrieves a property value from global state that can be set with
/// platform-specific APIs. Defaults can be provided using the `state`
/// root property. Returns null if no value nor default value is set for the
/// retrieved property.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#global-state
/// {@endtemplate}
extension type const GlobalStateExpr._(List<Object?> json)
    implements Expression {
  /// Create a new `global-state` expression.
  GlobalStateExpr(String propertyName) : this._(<Object?>[op, propertyName]);

  /// The operator for `global-state` expressions.
  static const String op = 'global-state';
}

/// {@template get-expression}
/// Retrieves a property value from the current feature's properties, or from another object if a second argument is provided. Returns null if the requested property is missing.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#get
/// {@endtemplate}
extension type const GetExpr._(List<Object?> json) implements Expression {
  /// Create a new `get` expression.
  GetExpr(String propertyName, {Expression? object})
    : this._(<Object?>[op, propertyName, ?object]);

  /// Create a new `get` expression.
  GetExpr.expr(Expression propertyName, {Expression? object})
    : this._(<Object?>[op, propertyName, ?object]);

  /// The operator for `get` expressions.
  static const String op = 'get';
}

/// {@template has-expression}
/// Tests for the presence of a property value in the current feature's
/// properties, or from another object if a second argument is provided.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#has
/// {@endtemplate}
extension type const HasExpr._(List<Object?> json) implements Expression {
  /// Create a new `has` expression.
  HasExpr(String propertyName, {Expression? object})
    : this._(<Object?>[op, propertyName, ?object]);

  /// Create a new `has` expression.
  HasExpr.expr(Expression propertyName, {Expression? object})
    : this._(<Object?>[op, propertyName, ?object]);

  /// The operator for `has` expressions.
  static const String op = 'has';
}

/// {@template length-expression}
/// Gets the length of an array or string. In a string, a UTF-16 surrogate pair
/// counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#length
/// {@endtemplate}
extension type const LengthExpr._(List<Object?> json) implements Expression {
  /// Create a new `length` expression.
  LengthExpr.string(String input) : this._(<Object?>[op, input]);

  /// Create a new `length` expression.
  LengthExpr.list(Expression input) : this._(<Object?>[op, input]);

  /// The operator for `length` expressions.
  static const String op = 'length';
}

part of 'expressions.dart';

/// Retrieves an item from an array.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#at
Expression at({required int index, required Expression list}) =>
    Expression.fromJson(['at', index, list]);

/// Determines whether an item exists in an array or a substring exists in a 
/// string.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#in
Expression in_({
    required OneOf3<num, String, Expression> item,
    required OneOf2<String, Expression> list,
  }) => Expression.fromJson(['in', item, list]);

/// Returns the first position at which an item can be found in an array or a 
/// substring can be found in a string, or -1 if the input cannot be found. 
/// Accepts an optional index from where to begin the search. In a string, a 
/// UTF-16 surrogate pair counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#index-of
Expression indexOf({
  required OneOf3<num, String, Expression> item,
  required OneOf2<String, Expression> list,
  OneOf2<int, Expression>? fromIndex,
}) =>
    Expression.fromJson(
        ['index-of', item, list, ?fromIndex]);

/// Returns a subarray from an array or a substring from a string from a 
/// specified start index, or between a start index and an end index if set. 
/// The return value is inclusive of the start index but not of the end index. 
/// In a string, a UTF-16 surrogate pair counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#slice
Expression slice({
  required OneOf2<String, Expression> input,
  required OneOf2<int, Expression> start,
  OneOf2<int, Expression>? end,
}) =>
    Expression.fromJson(['slice', input, start, ?end]);

/// Retrieves a property value from global state that can be set with
/// platform-specific APIs. Defaults can be provided using the `state`
/// root property. Returns null if no value nor default value is set for the
/// retrieved property.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#global-state
Expression globalState(String propertyName) =>
    Expression.fromJson(['global-state', propertyName]);

/// Retrieves a property value from the current feature's properties, or from 
/// another object if a second argument is provided. Returns null if the 
/// requested property is missing.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#get
Expression get(String propertyName, {Expression? object}) =>
    Expression.fromJson(['get', propertyName, ?object]);

/// Tests for the presence of a property value in the current feature's
/// properties, or from another object if a second argument is provided.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#has
Expression has(String propertyName, {Expression? object}) =>
    Expression.fromJson(['has', propertyName, ?object]);

/// Gets the length of an array or string. In a string, a UTF-16 surrogate pair
/// counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#length
Expression length(OneOf2<String, Expression> input) =>
    Expression.fromJson(['length', input]);

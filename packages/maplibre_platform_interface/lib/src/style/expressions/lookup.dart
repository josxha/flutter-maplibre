part of 'expressions.dart';

/// Retrieves an item from an array.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#at
Expression<T> at<T extends Object?>({
  required Object index,
  required Expression<T> list,
}) {
  assert(
    index is num || index is Expression<num>,
    'index must be a number or an expression that evaluates to a number',
  );
  return Expression.fromJson(['at', index, list]);
}

/// Determines whether an item exists in an array or a substring exists in a
/// string.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#in
Expression<bool> in_<T extends Object?>({
  required Object item,
  required Object list,
}) {
  assert(
    item is num ||
        item is String ||
        item is Expression<num> ||
        item is Expression<String>,
    'item must be a number, a string, or an expression that evaluates to a number or a string',
  );
  assert(
    list is String ||
        list is Expression<String> ||
        list is List ||
        list is Expression<List>,
    'list must be a string, an array, or an expression that evaluates to a string or an array',
  );
  return Expression.fromJson(['in', item, list]);
}

/// Returns the first position at which an item can be found in an array or a
/// substring can be found in a string, or -1 if the input cannot be found.
/// Accepts an optional index from where to begin the search. In a string, a
/// UTF-16 surrogate pair counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#index-of
Expression<num> indexOf<T extends Object?>({
  required Object item,
  required Object list,
  Object? fromIndex,
}) {
  assert(
    item is num ||
        item is String ||
        item is Expression<num> ||
        item is Expression<String>,
    'item must be a number, a string, or an expression that evaluates to a '
    'number or a string',
  );
  assert(
    list is String ||
        list is Expression<String> ||
        list is List ||
        list is Expression<List>,
    'list must be a string, an array, or an expression that evaluates to a '
    'string or an array',
  );
  assert(
    fromIndex == null || fromIndex is num || fromIndex is Expression<num>,
    'fromIndex must be null, a number, or an expression that evaluates to a '
    'number',
  );
  return Expression.fromJson(['index-of', item, list, ?fromIndex]);
}

/// Returns a subarray from an array or a substring from a string from a
/// specified start index, or between a start index and an end index if set.
/// The return value is inclusive of the start index but not of the end index.
/// In a string, a UTF-16 surrogate pair counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#slice
Expression<T> slice<T extends Object?>({
  required Object input,
  required Object start,
  Object? end,
}) {
  assert(
    input is String ||
        input is Expression<String> ||
        input is List ||
        input is Expression<List>,
    'input must be a string, an array, or an expression that evaluates to a '
    'string or an array',
  );
  assert(
    start is num || start is Expression<num>,
    'start must be a number or an expression that evaluates to a number',
  );
  assert(
    end == null || end is num || end is Expression<num>,
    'end must be null, a number, or an expression that evaluates to a number',
  );
  return Expression.fromJson(['slice', input, start, ?end]);
}

/// Retrieves a property value from global state that can be set with
/// platform-specific APIs. Defaults can be provided using the `state`
/// root property. Returns null if no value nor default value is set for the
/// retrieved property.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#global-state
Expression<T> globalState<T extends Object>(String propertyName) =>
    Expression.fromJson(['global-state', propertyName]);

/// Retrieves a property value from the current feature's properties, or from
/// another object if a second argument is provided. Returns null if the
/// requested property is missing.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#get
Expression get(String propertyName, {Map<String, Object?>? object}) =>
    Expression.fromJson(['get', propertyName, ?object]);

/// Tests for the presence of a property value in the current feature's
/// properties, or from another object if a second argument is provided.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#has
Expression<bool> has(String propertyName, {Map<String, Object?>? object}) =>
    Expression.fromJson(['has', propertyName, ?object]);

/// Gets the length of an array or string. In a string, a UTF-16 surrogate pair
/// counts as a single position.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#length
Expression<num> length(Object input) {
  assert(
    input is String ||
        input is Expression<String> ||
        input is List ||
        input is Expression<List>,
    'input must be a string, an array, or an expression that evaluates to a '
    'string or an array',
  );
  return Expression.fromJson(['length', input]);
}

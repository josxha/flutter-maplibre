import 'dart:ui';

import 'package:maplibre/maplibre.dart';

part 'lookup.dart';
part 'types.dart';
part 'variable_binding.dart';

/// Base class for expressions.
extension type const Expression.fromJson(List<Object?> json) {}

/// {@template feature-state-expression}
/// Retrieves a property value from the current feature's state. Returns null if
/// the requested property is not present on the feature's state. A feature's
/// state is not part of the GeoJSON or vector tile data, and must be set
/// programmatically on each feature. When source.promoteId is not provided,
/// features are identified by their id attribute, which must be an integer or a
/// string that can be cast to an integer. When source.promoteId is provided,
/// features are identified by their promoteId property, which may be a number,
/// string, or any primitive data type. Note that ["feature-state"] can only be
/// used with paint properties that support data-driven styling.
/// {@endtemplate}
extension type const FeatureState<T extends Object?>._(List<Object?> json)
    implements Expression {
  /// Create a new feature-state expression.
  FeatureState(String key) : json = [op, key];

  /// The operator for [featureState] expressions.
  static const String op = 'feature-state';
}

/// {@template interpolate-expression}
/// Produces continuous, smooth results by interpolating between pairs of input
/// and output values ("stops"). The `input` may be any numeric expression
/// (e.g., `["get", "population"]`). Stop inputs must be numeric literals in
/// strictly ascending order. The output type must be `number`, `array<number>`,
/// `color`, `array<color>`, or `projection`.
/// {@endtemplate}
@Deprecated('Rework this expression')
extension type const Interpolate<T extends Object?>._(List<Object?> json)
    implements Expression {
  /// Create a new interpolate expression.
  Interpolate(String key) : json = [op, key];

  /// The operator for [interpolate] expressions.
  static const String op = 'interpolate';

  /// The key of the feature state to retrieve.
  T get value => json[1] as T;
}

/// {@template get-expression}
///
@Deprecated('Rework this expression')
extension type const Get<T extends Object?>._(List<Object?> json)
    implements Expression {
  /// Create a new interpolate expression.
  Get(String key) : json = [op, key];

  /// The operator for [interpolate] expressions.
  static const String op = 'interpolate';
}

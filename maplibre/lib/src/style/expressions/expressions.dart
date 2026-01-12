import 'package:maplibre/src/style/expressions/functional.dart';

part 'types.dart';
part 'variable_binding.dart';

/// Base class for expressions.
extension type const Expression._(List<Object?> json) {
  /// Creates an expression from its JSON representation.
  static Expression fromJson(List<Object?> json) {
    switch (json.first) {
      // Variable binding¶
      case LetExpression.operator:
        final vars = <String, Object?>{};
        for (var i = 1; i < json.length - 1; i += 2) {
          vars[json[i]! as String] = json[i + 1];
        }
        return LetExpression(
          variables: vars,
          expression: Expression.fromJson(json.last! as List<Object?>),
        );
      case VarExpression.operator:
        return VarExpression(json[1]! as String);
      // Types
      case LiteralExpression.operator:
        return LiteralExpression(json[1]);
      default:
        throw Exception('Unsupported expression operator: ${json.first}');
    }
  }
}

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
extension type const FeatureStateExpression<T extends Object?>._(
  List<Object?> json
)
    implements Expression {
  /// Create a new feature-state expression.
  FeatureStateExpression(String key) : json = [operator, key];

  /// The operator for [featureState] expressions.
  static const String operator = 'feature-state';

  /// The key of the feature state to retrieve.
  T get value => json[1] as T;
}

/// {@template interpolate-expression}
/// Produces continuous, smooth results by interpolating between pairs of input
/// and output values ("stops"). The `input` may be any numeric expression
/// (e.g., `["get", "population"]`). Stop inputs must be numeric literals in
/// strictly ascending order. The output type must be `number`, `array<number>`,
/// `color`, `array<color>`, or `projection`.
/// {@endtemplate}
extension type const InterpolateExpression<T extends Object?>._(
  List<Object?> json
)
    implements Expression {
  /// Create a new interpolate expression.
  InterpolateExpression(String key) : json = [operator, key];

  /// The operator for [interpolate] expressions.
  static const String operator = 'interpolate';

  /// The key of the feature state to retrieve.
  T get value => json[1] as T;
}

/// {@template get-expression}
///
extension type const GetExpression<T extends Object?>._(List<Object?> json)
    implements Expression {
  /// Create a new interpolate expression.
  GetExpression(String key) : json = [operator, key];

  /// The operator for [interpolate] expressions.
  static const String operator = 'interpolate';

  /// The key of the feature state to retrieve.
  T get value => json[1] as T;
}

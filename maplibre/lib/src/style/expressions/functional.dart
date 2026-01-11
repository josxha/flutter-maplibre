import 'package:maplibre/src/style/expressions/expressions.dart';

/// {@macro literal-expression}
LiteralExpression literal(Object? value) => LiteralExpression(value);

/// {@macro feature-state-expression}
FeatureStateExpression featureState(String value) =>
    FeatureStateExpression(value);

/// {@macro interpolate-expression}
InterpolateExpression interpolate(String value) => InterpolateExpression(value);

part of 'expressions.dart';

/// Gets the current zoom level. Note that in style layout and paint properties,
/// `["zoom"]` may only appear as the input to a top-level [step] or
/// [interpolate] expression.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#zoom
Expression zoom_() => const Expression.fromJson(['zoom']);

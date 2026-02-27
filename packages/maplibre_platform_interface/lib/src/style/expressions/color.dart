part of 'expressions.dart';

/// Returns a four-element array containing the input color's red, green, blue, and alpha components, in that order.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#to-rgba
Expression<List<num>> toRgba(Expression<Color_> color) =>
    Expression.fromJson(['to-rgba', color]);

/// Creates a color value from red, green, and blue components, which must
/// range between 0 and 255, and an alpha component of 1. If any component is
/// out of range, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#rgb
Expression<Color_> rgb(
  Expression<num> red,
  Expression<num> green,
  Expression<num> blue,
) => Expression.fromJson(['rgb', red, green, blue]);

/// Creates a color value from red, green, blue components, which must range
/// between 0 and 255, and an alpha component which must range between zero and
/// one. If any component is out of range, the expression is an error.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#rgba
Expression<Color_> rgba({
  required Expression<num> red,
  required Expression<num> green,
  required Expression<num> blue,
  required Expression<num> alpha,
}) => Expression.fromJson(['rgba', red, green, blue, alpha]);

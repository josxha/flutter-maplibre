import 'package:flutter/cupertino.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

export 'expressions/expressions.dart';
export 'layers/style_layer.dart';
export 'sources/source.dart';

/// https://maplibre.org/maplibre-style-spec/types/#color
// ignore: camel_case_types
extension type const Color_(String color) {}

/// https://maplibre.org/maplibre-style-spec/types/#formatted
extension type const Formatted.fromJson(List<Object?> json) {
  /// Creates a [Formatted] from a [List] of sections.
  Formatted(Map<String, Map<String, Object?>> sections)
    : this.fromJson([
        'format',
        for (final entry in sections.entries) ...[entry.key, entry.value],
      ]);
}

/// A single [double] value, or an [List] of [double] values.
///
/// ```json
/// {
///    "hillshade-illumination-direction": 24,
///    "hillshade-illumination-direction": [45, 57.3]
/// }
/// ```
///
/// https://maplibre.org/maplibre-style-spec/types/#numberarray
extension type const NumberArray._(Object object) {
  /// Creates a [NumberArray] from an [List].
  const NumberArray.array(List<double> list) : object = list;

  /// Creates a [NumberArray] from a [double].
  const NumberArray.number(double value) : object = value;

  /// Get the value as [double].
  double get number => object as double;

  /// Get the value as an [List].
  List<double> get array => object as List<double>;

  /// Indicates whether the [NumberArray] is a [List].
  bool get isArray => object is List<double>;
}

/// A single [Color] value, or an [List] of [Color] values.
///
/// ```json
/// {
///    "hillshade-highlight-color": "#ffff00",
///    "hillshade-highlight-color": ["#ffff00", "rgb(255, 255, 0)", "yellow"]
/// }
/// ```
///
/// https://maplibre.org/maplibre-style-spec/types/#colorarray
extension type const ColorArray._(Object object) {
  /// Creates a [ColorArray] from a [List].
  const ColorArray.array(List<Color> list) : object = list;

  /// Creates a [ColorArray] from a [Color].
  const ColorArray.color(Color value) : object = value;

  /// Get the value as [Color].
  Color get color => object as Color;

  /// Get the value as an [List].
  List<Color> get array => object as List<Color>;

  /// Indicates whether the [ColorArray] is a [List].
  bool get isArray => object is List<Color>;
}

/// The interpolation type for [interpolate] and [interpolateHcl].
extension type const InterpolationType.fromJson(List<Object?> json) {
  /// Interpolates linearly between the pair of stops just less than and just greater than the input.
  InterpolationType.linear() : this.fromJson(['linear']);

  /// Interpolates exponentially between the stops just less than and just greater than the input.
  /// - [base]: rate at which the output increases in f(x) = x^r. Values higher than 1 increase, close to one behaves linearly, and below one decrease.
  InterpolationType.exponential(double base)
    : this.fromJson(['exponential', base]);

  /// Interpolates using the cubic bézier curve defined by the given control points.
  /// - [x1]: X-coordinate of the first control point. Must be between zero and one for a valid monotonic easing curve. Controls how quickly the curve speeds up at the beginning.
  /// - [y1]: Y-coordinate of the first control point. Typically between zero and one, but may exceed this range for overshoot effects. Influences the starting slope of the curve.
  /// - [x2]: X-coordinate of the second control point. Must be between zero and one for a valid monotonic easing curve. Controls when the curve begins to decelerate toward the end.
  /// - [y2]: Y-coordinate of the second control point. Typically between zero and one, but may exceed this range for overshoot effects. Influences the ending slope of the curve.
  InterpolationType.cubicBezier({
    required double x1,
    required double y1,
    required double x2,
    required double y2,
  }) : this.fromJson(['cubic-bezier', x1, y1, x2, y2]);
}

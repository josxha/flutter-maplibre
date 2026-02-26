part of 'expressions.dart';

/// Gets the kernel density estimation of a pixel in a heatmap layer, which is
/// a relative measure of how many data points are crowded around a particular
/// pixel. Can only be used in the [HeatmapStyleLayer.color] property.
///
/// https://maplibre.org/maplibre-style-spec/expressions/#heatmap-density
Expression<num> heatmapDensity() => const Expression.fromJson(['heatmap-density']);

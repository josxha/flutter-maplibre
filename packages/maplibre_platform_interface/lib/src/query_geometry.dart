import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Where [MapController.queryRenderedFeatures] looks for features, in
/// logical pixels of the map.
///
/// ```dart
/// controller.queryRenderedFeatures(QueryGeometry.point(event.screenPoint));
/// controller.queryRenderedFeatures(QueryGeometry.rect(rect));
/// ```
///
/// {@category Basic}
@immutable
sealed class QueryGeometry {
  const QueryGeometry();

  /// The features drawn at [point].
  const factory QueryGeometry.point(Offset point) = QueryGeometryPoint;

  /// The features that intersect [rect].
  const factory QueryGeometry.rect(Rect rect) = QueryGeometryRect;

  /// The features anywhere in the map.
  const factory QueryGeometry.viewport() = QueryGeometryViewport;
}

/// A [QueryGeometry] at a point, see [QueryGeometry.point].
///
/// {@category Basic}
final class QueryGeometryPoint extends QueryGeometry {
  /// Creates a [QueryGeometry] at [point].
  const QueryGeometryPoint(this.point);

  /// The screen location in logical pixels.
  final Offset point;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueryGeometryPoint && point == other.point;

  @override
  int get hashCode => point.hashCode;

  @override
  String toString() => 'QueryGeometry.point($point)';
}

/// A [QueryGeometry] in a rectangle, see [QueryGeometry.rect].
///
/// {@category Basic}
final class QueryGeometryRect extends QueryGeometry {
  /// Creates a [QueryGeometry] in [rect].
  const QueryGeometryRect(this.rect);

  /// The rectangle in logical pixels.
  final Rect rect;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueryGeometryRect && rect == other.rect;

  @override
  int get hashCode => rect.hashCode;

  @override
  String toString() => 'QueryGeometry.rect($rect)';
}

/// A [QueryGeometry] that covers the map, see [QueryGeometry.viewport].
///
/// {@category Basic}
final class QueryGeometryViewport extends QueryGeometry {
  /// Creates a [QueryGeometry] that covers the map.
  const QueryGeometryViewport();

  @override
  bool operator ==(Object other) => other is QueryGeometryViewport;

  @override
  int get hashCode => (QueryGeometryViewport).hashCode;

  @override
  String toString() => 'QueryGeometry.viewport()';
}

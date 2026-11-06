import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Where the map camera goes: to a position, or to a camera that fits
/// bounds, points or a geometry into the map.
///
/// [MapController.moveCamera], [MapController.animateCamera],
/// [MapController.cameraFor] and [MapOptions.initCamera] take it.
///
/// ```dart
/// controller.moveCamera(const CameraUpdate.position(zoom: 12));
/// controller.animateCamera(CameraUpdate.bounds(bounds));
/// ```
///
/// {@category Basic}
@immutable
sealed class CameraUpdate {
  const CameraUpdate();

  /// Sets the given fields of the camera. A null field keeps its current
  /// value, or MapLibre's default when the map starts.
  const factory CameraUpdate.position({
    Geographic? center,
    double? zoom,
    double? bearing,
    double? pitch,
    double? roll,
    EdgeInsets? padding,
    Offset? anchor,
  }) = CameraUpdatePosition;

  /// Fits [bounds] into the map, inset by [padding].
  const factory CameraUpdate.bounds(
    GeoBox bounds, {
    EdgeInsets padding,
    double? bearing,
    double? pitch,
    double? maxZoom,
  }) = CameraUpdateBounds;

  /// Fits all [points] into the map, inset by [padding].
  const factory CameraUpdate.points(
    List<Geographic> points, {
    EdgeInsets padding,
    double? bearing,
    double? pitch,
    double? maxZoom,
  }) = CameraUpdatePoints;

  /// Fits [geometry] into the map, inset by [padding].
  const factory CameraUpdate.geometry(
    Geometry geometry, {
    EdgeInsets padding,
    double? bearing,
    double? pitch,
    double? maxZoom,
  }) = CameraUpdateGeometry;
}

/// A [CameraUpdate] that sets fields of the camera, see
/// [CameraUpdate.position].
///
/// {@category Basic}
final class CameraUpdatePosition extends CameraUpdate {
  /// Creates a [CameraUpdate] that sets fields of the camera.
  const CameraUpdatePosition({
    this.center,
    this.zoom,
    this.bearing,
    this.pitch,
    this.roll,
    this.padding,
    this.anchor,
  });

  /// The center of the map.
  final Geographic? center;

  /// The zoom level.
  final double? zoom;

  /// The bearing in degrees, 0 is north on top.
  final double? bearing;

  /// The pitch in degrees.
  final double? pitch;

  /// The roll in degrees.
  final double? roll;

  /// The insets in logical pixels that move the center of the camera away
  /// from the center of the map, for example to keep it clear of an overlay.
  final EdgeInsets? padding;

  /// The screen location in logical pixels that stays in place while the
  /// camera zooms or rotates. Without it, the camera zooms and rotates
  /// around [center].
  final Offset? anchor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraUpdatePosition &&
          center == other.center &&
          zoom == other.zoom &&
          bearing == other.bearing &&
          pitch == other.pitch &&
          roll == other.roll &&
          padding == other.padding &&
          anchor == other.anchor;

  @override
  int get hashCode =>
      Object.hash(center, zoom, bearing, pitch, roll, padding, anchor);

  @override
  String toString() =>
      'CameraUpdate.position(center: $center, zoom: $zoom, '
      'bearing: $bearing, pitch: $pitch, roll: $roll, padding: $padding, '
      'anchor: $anchor)';
}

/// A [CameraUpdate] that fits a target into the map: [CameraUpdateBounds],
/// [CameraUpdatePoints] or [CameraUpdateGeometry].
///
/// {@category Basic}
sealed class CameraUpdateFit extends CameraUpdate {
  const CameraUpdateFit({
    this.padding = EdgeInsets.zero,
    this.bearing,
    this.pitch,
    this.maxZoom,
  });

  /// The space in logical pixels between the target and the map's edges.
  final EdgeInsets padding;

  /// The bearing in degrees, 0 is north on top. Null keeps the current one.
  final double? bearing;

  /// The pitch in degrees. Null keeps the current one.
  final double? pitch;

  /// The highest zoom level, so that a small target is not shown too close.
  final double? maxZoom;

  /// The smallest box that contains the target.
  GeoBox get bounds;

  bool _fitEquals(CameraUpdateFit other) =>
      padding == other.padding &&
      bearing == other.bearing &&
      pitch == other.pitch &&
      maxZoom == other.maxZoom;

  String get _fitString =>
      'padding: $padding, bearing: $bearing, pitch: $pitch, '
      'maxZoom: $maxZoom';
}

/// A [CameraUpdate] that fits bounds into the map, see
/// [CameraUpdate.bounds].
///
/// {@category Basic}
final class CameraUpdateBounds extends CameraUpdateFit {
  /// Creates a [CameraUpdate] that fits [bounds] into the map.
  const CameraUpdateBounds(
    this.bounds, {
    super.padding,
    super.bearing,
    super.pitch,
    super.maxZoom,
  });

  @override
  final GeoBox bounds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraUpdateBounds &&
          bounds == other.bounds &&
          _fitEquals(other);

  @override
  int get hashCode => Object.hash(bounds, padding, bearing, pitch, maxZoom);

  @override
  String toString() => 'CameraUpdate.bounds($bounds, $_fitString)';
}

/// A [CameraUpdate] that fits points into the map, see
/// [CameraUpdate.points].
///
/// {@category Basic}
final class CameraUpdatePoints extends CameraUpdateFit {
  /// Creates a [CameraUpdate] that fits all [points] into the map.
  const CameraUpdatePoints(
    this.points, {
    super.padding,
    super.bearing,
    super.pitch,
    super.maxZoom,
  });

  /// The points that the map shows.
  final List<Geographic> points;

  @override
  GeoBox get bounds {
    if (points.isEmpty) {
      throw ArgumentError.value(points, 'points', 'must not be empty');
    }
    var west = points.first.lon;
    var east = west;
    var south = points.first.lat;
    var north = south;
    for (final point in points.skip(1)) {
      if (point.lon < west) west = point.lon;
      if (point.lon > east) east = point.lon;
      if (point.lat < south) south = point.lat;
      if (point.lat > north) north = point.lat;
    }
    return GeoBox(west: west, south: south, east: east, north: north);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraUpdatePoints &&
          listEquals(points, other.points) &&
          _fitEquals(other);

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(points), padding, bearing, pitch, maxZoom);

  @override
  String toString() => 'CameraUpdate.points($points, $_fitString)';
}

/// A [CameraUpdate] that fits a geometry into the map, see
/// [CameraUpdate.geometry].
///
/// {@category Basic}
final class CameraUpdateGeometry extends CameraUpdateFit {
  /// Creates a [CameraUpdate] that fits [geometry] into the map.
  const CameraUpdateGeometry(
    this.geometry, {
    super.padding,
    super.bearing,
    super.pitch,
    super.maxZoom,
  });

  /// The geometry that the map shows.
  final Geometry geometry;

  @override
  GeoBox get bounds {
    final box = geometry.bounds ?? geometry.calculateBounds();
    if (box == null) {
      throw ArgumentError.value(geometry, 'geometry', 'must not be empty');
    }
    return GeoBox(
      west: box.minX,
      south: box.minY,
      east: box.maxX,
      north: box.maxY,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraUpdateGeometry &&
          geometry == other.geometry &&
          _fitEquals(other);

  @override
  int get hashCode => Object.hash(geometry, padding, bearing, pitch, maxZoom);

  @override
  String toString() =>
      'CameraUpdate.geometry(${geometry.toText()}, $_fitString)';
}

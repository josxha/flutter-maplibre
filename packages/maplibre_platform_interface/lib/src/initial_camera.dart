import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The camera that a map starts with, see [MapOptions.initCamera].
///
/// {@category Basic}
@immutable
sealed class InitialCamera {
  const InitialCamera();

  /// Starts the map at [center], [zoom], [bearing] and [pitch].
  const factory InitialCamera.position({
    Geographic center,
    double zoom,
    double bearing,
    double pitch,
  }) = InitialCameraPosition;

  /// Starts the map with [bounds] fitted into the map, inset by [padding].
  const factory InitialCamera.bounds(
    GeoBox bounds, {
    EdgeInsets padding,
    double bearing,
    double pitch,
  }) = InitialCameraBounds;
}

/// An [InitialCamera] at a position.
///
/// {@category Basic}
final class InitialCameraPosition extends InitialCamera {
  /// Creates an [InitialCamera] at a position.
  const InitialCameraPosition({
    this.center = const Geographic(lon: 0, lat: 0),
    this.zoom = 0,
    this.bearing = 0,
    this.pitch = 0,
  });

  /// The center of the map.
  final Geographic center;

  /// The zoom level.
  final double zoom;

  /// The bearing in degrees, 0 is north on top.
  final double bearing;

  /// The pitch in degrees.
  final double pitch;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InitialCameraPosition &&
          center == other.center &&
          zoom == other.zoom &&
          bearing == other.bearing &&
          pitch == other.pitch;

  @override
  int get hashCode => Object.hash(center, zoom, bearing, pitch);

  @override
  String toString() =>
      'InitialCamera.position(center: $center, zoom: $zoom, '
      'bearing: $bearing, pitch: $pitch)';
}

/// An [InitialCamera] that fits bounds into the map.
///
/// {@category Basic}
final class InitialCameraBounds extends InitialCamera {
  /// Creates an [InitialCamera] that fits [bounds] into the map.
  const InitialCameraBounds(
    this.bounds, {
    this.padding = EdgeInsets.zero,
    this.bearing = 0,
    this.pitch = 0,
  });

  /// The bounds that the map shows.
  final GeoBox bounds;

  /// The space in logical pixels between [bounds] and the map's edges.
  final EdgeInsets padding;

  /// The bearing in degrees, 0 is north on top.
  final double bearing;

  /// The pitch in degrees.
  final double pitch;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InitialCameraBounds &&
          bounds == other.bounds &&
          padding == other.padding &&
          bearing == other.bearing &&
          pitch == other.pitch;

  @override
  int get hashCode => Object.hash(bounds, padding, bearing, pitch);

  @override
  String toString() =>
      'InitialCamera.bounds($bounds, padding: $padding, '
      'bearing: $bearing, pitch: $pitch)';
}

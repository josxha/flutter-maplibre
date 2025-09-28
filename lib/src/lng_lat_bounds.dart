import 'package:flutter/foundation.dart';
import 'package:maplibre/maplibre.dart';

/// LatLng bounds class.
///
/// {@category Basic}
@immutable
class LngLatBounds {
  /// Create a new [LngLatBounds] object.
  const LngLatBounds({
    required this.longitudeWest,
    required this.longitudeEast,
    required this.latitudeSouth,
    required this.latitudeNorth,
  });

  /// Create a new [LngLatBounds] from a list of [Position] points. This
  /// calculates the bounding box of the provided points.
  factory LngLatBounds.fromPoints(List<Geographic> points) {
    assert(
      points.isNotEmpty,
      'LngLatBounds cannot be created with an empty List',
    );

    // Initialize bounds with max values.
    var minX = maxLongitude;
    var maxX = minLongitude;
    var minY = maxLatitude;
    var maxY = minLatitude;

    // Find the largest and smallest latitude and longitude
    for (final point in points) {
      if (point.lon < minX) minX = point.lon;
      if (point.lon > maxX) maxX = point.lon;
      if (point.lat < minY) minY = point.lat;
      if (point.lat > maxY) maxY = point.lat;
    }

    return LngLatBounds(
      latitudeNorth: maxY,
      latitudeSouth: minY,
      longitudeEast: maxX,
      longitudeWest: minX,
    );
  }

  /// Minimum latitude value, south
  static const double minLatitude = -90;

  /// Maximum latitude value, north
  static const double maxLatitude = 90;

  /// Minimum longitude value, west
  static const double minLongitude = -180;

  /// Maximum longitude value, east
  static const double maxLongitude = 180;

  /// The minimum longitude, most west
  final double longitudeWest;

  /// The maximum longitude, most east
  final double longitudeEast;

  /// The minimum latitude, most south
  final double latitudeSouth;

  /// The maximum latitude, most north
  final double latitudeNorth;

  @override
  String toString() =>
      'LngLatBounds('
      'longitudeWest: $longitudeWest, '
      'longitudeEast: $longitudeEast, '
      'latitudeSouth: $latitudeSouth, '
      'latitudeNorth: $latitudeNorth)';

  /// Create a new [LngLatBounds] object by changing no, some or all values.
  LngLatBounds copyWith({
    double? longitudeWest,
    double? longitudeEast,
    double? latitudeSouth,
    double? latitudeNorth,
  }) => LngLatBounds(
    longitudeWest: longitudeWest ?? this.longitudeWest,
    longitudeEast: longitudeEast ?? this.longitudeEast,
    latitudeSouth: latitudeSouth ?? this.latitudeSouth,
    latitudeNorth: latitudeNorth ?? this.latitudeNorth,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LngLatBounds &&
          runtimeType == other.runtimeType &&
          longitudeWest == other.longitudeWest &&
          longitudeEast == other.longitudeEast &&
          latitudeSouth == other.latitudeSouth &&
          latitudeNorth == other.latitudeNorth;

  @override
  int get hashCode =>
      Object.hash(longitudeWest, longitudeEast, latitudeSouth, latitudeNorth);
}

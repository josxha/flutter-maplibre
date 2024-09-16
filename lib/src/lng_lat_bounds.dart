import 'package:flutter/foundation.dart';

/// LatLng bounds class.
@immutable
class LngLatBounds {
  /// Create a new [LngLatBounds] object.
  const LngLatBounds({
    required this.longitudeWest,
    required this.longitudeEast,
    required this.latitudeSouth,
    required this.latitudeNorth,
  });

  /// The minimum longitude, most west
  final double longitudeWest;

  /// The maximum longitude, most east
  final double longitudeEast;

  /// The minimum latitude, most south
  final double latitudeSouth;

  /// The maximum latitude, most north
  final double latitudeNorth;

  @override
  String toString() => 'LngLatBounds('
      'longitudeWest: $longitudeWest, '
      'longitudeEast: $longitudeEast, '
      'latitudeSouth: $latitudeSouth, '
      'latitudeNorth: $latitudeNorth)';

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
      longitudeWest.hashCode ^
      longitudeEast.hashCode ^
      latitudeSouth.hashCode ^
      latitudeNorth.hashCode;
}

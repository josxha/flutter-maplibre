import 'package:flutter/foundation.dart';
import 'package:maplibre/maplibre.dart';

/// A location of the user, as a [UserLocationLayer] shows it.
///
/// Create them from any location source, such as the `geolocator` package,
/// for which `maplibre_geolocator` has an adapter.
///
/// {@category Location}
@immutable
class UserLocation {
  /// Creates a user location at [position].
  const UserLocation({
    required this.position,
    this.accuracy,
    this.heading,
    this.timestamp,
  });

  /// Where the user is.
  final Geographic position;

  /// The radius in meters around [position] that the user is in, or null if
  /// unknown.
  final double? accuracy;

  /// The direction the user faces or moves in, in degrees clockwise from
  /// north, or null if unknown.
  final double? heading;

  /// When the location was measured.
  final DateTime? timestamp;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocation &&
          position == other.position &&
          accuracy == other.accuracy &&
          heading == other.heading &&
          timestamp == other.timestamp;

  @override
  int get hashCode => Object.hash(position, accuracy, heading, timestamp);

  @override
  String toString() =>
      'UserLocation(position: $position, accuracy: $accuracy, '
      'heading: $heading, timestamp: $timestamp)';
}

/// How a [UserLocationLayer] moves the camera with the user location.
///
/// {@category Location}
enum UserLocationTracking {
  /// The camera stays where it is.
  none,

  /// The camera centers on the user location.
  position,

  /// The camera centers on the user location and turns with its heading.
  positionAndHeading,
}

/// Shows the positions of the `geolocator` package with the
/// `UserLocationLayer` of the `maplibre` package.
library;

import 'package:geolocator/geolocator.dart';
import 'package:maplibre/maplibre.dart'
    show Geographic, UserLocation, UserLocationLayer;

/// The positions of `Geolocator.getPositionStream` as [UserLocation]s, for a
/// [UserLocationLayer].
///
/// The stream asks for the location permission when it starts listening, if
/// it was not granted yet, and reports an error if it was denied.
Stream<UserLocation> geolocatorUserLocations({
  LocationSettings? locationSettings,
}) =>
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .map((position) => position.toUserLocation());

/// Converts a `geolocator` [Position] to a [UserLocation].
extension PositionToUserLocation on Position {
  /// The [UserLocation] at this position. Negative headings and accuracies
  /// that are not positive, which platforms report when they measured none,
  /// become null.
  UserLocation toUserLocation() => UserLocation(
    position: Geographic(lon: longitude, lat: latitude),
    accuracy: accuracy > 0 ? accuracy : null,
    heading: heading >= 0 ? heading % 360 : null,
    timestamp: timestamp,
  );
}

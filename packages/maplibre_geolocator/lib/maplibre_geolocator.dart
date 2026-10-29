/// Shows the positions of the `geolocator` package with the
/// `UserLocationLayer` of the `maplibre` package.
library;

import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:maplibre/maplibre.dart'
    show Geographic, UserLocation, UserLocationLayer;

/// The positions of `Geolocator.getPositionStream` as [UserLocation]s, for a
/// [UserLocationLayer].
///
/// When the stream starts listening, it asks for the location permission if
/// it was not granted yet, and reports a [PermissionDeniedException] if it was
/// denied or a [LocationServiceDisabledException] if the location services
/// are off. It starts with the current position, because some platforms,
/// such as Windows, report a position only when it changes, so a device that
/// does not move would show none.
Stream<UserLocation> geolocatorUserLocations({
  LocationSettings? locationSettings,
}) {
  late final StreamController<UserLocation> controller;
  StreamSubscription<Position>? subscription;
  var canceled = false;

  Future<void> start() async {
    try {
      await _requestPermission();
    } on Object catch (error, stackTrace) {
      if (canceled) return;
      controller.addError(error, stackTrace);
      await controller.close();
      return;
    }
    if (canceled) return;
    var streamed = false;
    subscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (position) {
            streamed = true;
            controller.add(position.toUserLocation());
          },
          onError: controller.addError,
          onDone: controller.close,
        );
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      // The stream is newer once it reported a position.
      if (!canceled && !streamed) controller.add(position.toUserLocation());
    } on Object {
      // The stream reports the errors.
    }
  }

  controller = StreamController<UserLocation>(
    onListen: () => unawaited(start()),
    onCancel: () {
      canceled = true;
      return subscription?.cancel();
    },
  );
  return controller.stream;
}

/// Asks for the location permission if it was not granted yet.
///
/// On Windows, the position stream gets no positions until the app asked for
/// the access, which `checkPermission` and `requestPermission` do.
Future<void> _requestPermission() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    throw const LocationServiceDisabledException();
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw const PermissionDeniedException(
      'The location permission was denied.',
    );
  }
}

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

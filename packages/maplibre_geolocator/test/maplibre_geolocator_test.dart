import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:maplibre/maplibre.dart' show Geographic, UserLocation;
import 'package:maplibre_geolocator/maplibre_geolocator.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

Position _position({double accuracy = 5, double heading = 90}) => Position(
  longitude: 9.7,
  latitude: 47.5,
  timestamp: DateTime.utc(2026, 10, 23),
  accuracy: accuracy,
  altitude: 400,
  altitudeAccuracy: 3,
  heading: heading,
  headingAccuracy: 10,
  speed: 1,
  speedAccuracy: 1,
);

class _FakeGeolocator extends GeolocatorPlatform
    with MockPlatformInterfaceMixin {
  bool serviceEnabled = true;
  LocationPermission permission = LocationPermission.denied;
  LocationPermission requestedPermission = LocationPermission.whileInUse;
  int requests = 0;
  final positions = StreamController<Position>();
  Completer<Position> current = Completer();

  @override
  Future<bool> isLocationServiceEnabled() async => serviceEnabled;

  @override
  Future<LocationPermission> checkPermission() async => permission;

  @override
  Future<LocationPermission> requestPermission() async {
    requests++;
    return permission = requestedPermission;
  }

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) =>
      positions.stream;

  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) =>
      current.future;
}

void main() {
  group('geolocatorUserLocations', () {
    late _FakeGeolocator geolocator;

    setUp(() => GeolocatorPlatform.instance = geolocator = _FakeGeolocator());

    test(
      'asks for the permission and starts with the current position',
      () async {
        final locations = <double?>[];
        final subscription = geolocatorUserLocations().listen(
          (location) => locations.add(location.heading),
        );
        await pumpEventQueue();
        expect(geolocator.requests, 1);
        geolocator.current.complete(_position());
        await pumpEventQueue();
        geolocator.positions.add(_position(heading: 45));
        await pumpEventQueue();
        expect(locations, [90, 45]);
        await subscription.cancel();
      },
    );

    test('drops the current position once the stream reported one', () async {
      final locations = <double?>[];
      final subscription = geolocatorUserLocations().listen(
        (location) => locations.add(location.heading),
      );
      await pumpEventQueue();
      geolocator.positions.add(_position(heading: 45));
      await pumpEventQueue();
      geolocator.current.complete(_position());
      await pumpEventQueue();
      expect(locations, [45]);
      await subscription.cancel();
    });

    test('reports a denied permission', () {
      geolocator.requestedPermission = LocationPermission.deniedForever;
      expect(
        geolocatorUserLocations(),
        emitsInOrder([emitsError(isA<PermissionDeniedException>()), emitsDone]),
      );
    });

    test('reports disabled location services', () {
      geolocator.serviceEnabled = false;
      expect(
        geolocatorUserLocations(),
        emitsError(isA<LocationServiceDisabledException>()),
      );
    });
  });

  group('toUserLocation', () {
    test('converts a position', () {
      expect(
        _position().toUserLocation(),
        UserLocation(
          position: const Geographic(lon: 9.7, lat: 47.5),
          accuracy: 5,
          heading: 90,
          timestamp: DateTime.utc(2026, 10, 23),
        ),
      );
    });

    test('drops headings and accuracies that were not measured', () {
      final location = _position(accuracy: 0, heading: -1).toUserLocation();
      expect(location.accuracy, isNull);
      expect(location.heading, isNull);
    });
  });
}

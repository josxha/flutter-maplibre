import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre/maplibre.dart' show Geographic, UserLocation;
import 'package:maplibre_geolocator/maplibre_geolocator.dart';

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

void main() {
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

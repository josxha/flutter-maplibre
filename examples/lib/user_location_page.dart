import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';
import 'package:maplibre_geolocator/maplibre_geolocator.dart';

@immutable
class UserLocationPage extends StatefulWidget {
  const UserLocationPage({super.key});

  static const location = '/user-location';

  @override
  State<UserLocationPage> createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
  // Asks for the location permission when the layer listens.
  late final Stream<UserLocation> _locations = geolocatorUserLocations()
      .handleError((Object error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      });
  UserLocationTracking _tracking = UserLocationTracking.position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Location')),
      body: MapLibreMap(
        options: MapOptions(
          initZoom: 1,
          initCenter: const Geographic(lon: 0, lat: 0),
          initStyle: MapStyles.protomapsLight.uri,
        ),
        children: [
          UserLocationLayer(
            locations: _locations,
            tracking: _tracking,
            trackingZoom: 15,
            onTrackingChanged: (tracking) =>
                setState(() => _tracking = tracking),
          ),
          MapControlButtons(
            tracking: _tracking,
            // Cycles through the tracking modes.
            onTrackingPressed: () => setState(
              () => _tracking = switch (_tracking) {
                UserLocationTracking.none => UserLocationTracking.position,
                UserLocationTracking.position =>
                  UserLocationTracking.positionAndHeading,
                UserLocationTracking.positionAndHeading =>
                  UserLocationTracking.none,
              },
            ),
          ),
        ],
      ),
    );
  }
}

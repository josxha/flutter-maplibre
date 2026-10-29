import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  /// The user locations, once the location permission was granted.
  Stream<UserLocation>? _locations;
  UserLocationTracking _tracking = UserLocationTracking.position;

  @override
  void initState() {
    super.initState();
    unawaited(_requestPermission());
  }

  /// Asks for the location permission. On Windows, geolocator gets no
  /// positions until the app asked, and permission_handler does not ask there.
  Future<void> _requestPermission() async {
    String? error;
    if (!await Geolocator.isLocationServiceEnabled()) {
      error = 'The location services are turned off.';
    } else {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        error = 'The location permission was denied.';
      }
    }
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    setState(
      () => _locations = geolocatorUserLocations().handleError((Object error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locations = _locations;
    return Scaffold(
      appBar: AppBar(title: const Text('User Location')),
      body: MapLibreMap(
        options: MapOptions(
          initZoom: 1,
          initCenter: const Geographic(lon: 0, lat: 0),
          initStyle: MapStyles.protomapsLight.uri,
        ),
        children: [
          if (locations != null)
            UserLocationLayer(
              locations: locations,
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

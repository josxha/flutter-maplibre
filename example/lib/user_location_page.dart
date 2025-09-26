import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/extensions.dart';
import 'package:maplibre_example/utils/map_styles.dart';

@immutable
class UserLocationPage extends StatefulWidget {
  const UserLocationPage({super.key});

  static const location = '/user-location';

  @override
  State<UserLocationPage> createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
  final _permissionManager = PermissionManager();
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Location')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 2,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    final granted = await _permissionManager
                        .requestLocationPermissions(
                          explanation: 'Show the user location on the map.',
                        );
                    if (context.mounted) {
                      context.showSnackBox(
                        'Permission ${granted ? 'granted' : 'not granted'}.',
                      );
                    }
                  },
                  child: const Text(
                    'Get permission',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    try {
                      await _controller.enableLocation();
                      if (context.mounted) {
                        context.showSnackBox('Location enabled.');
                      }
                    } catch (error) {
                      if (context.mounted) {
                        context.showSnackBox(error.toString());
                      }
                    }
                  },
                  child: const Text(
                    'Enable location',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    try {
                      await _controller.trackLocation();
                      if (context.mounted) {
                        context.showSnackBox('Tracking location.');
                      }
                    } catch (error) {
                      if (context.mounted) {
                        context.showSnackBox(error.toString());
                      }
                    }
                  },
                  child: const Text(
                    'Track location',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                initZoom: 1,
                initCenter: const Geographic(lon: 0, lat: 0),
                initStyle: MapStyles.protomapsLight.uri,
              ),
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
        ],
      ),
    );
  }
}

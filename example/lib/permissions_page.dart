import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  static const location = '/permissions';

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  final _manager = PermissionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Permissions')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('runtimePermissionsRequired'),
            subtitle: const Text(
              'Weather the OS requires to ask for permissions at runtime.',
            ),
            trailing: _manager.runtimePermissionsRequired.toIcon(),
          ),
          ListTile(
            title: const Text('locationPermissionsGranted'),
            subtitle: const Text(
              'Weather location permissions are granted.',
            ),
            trailing: _manager.locationPermissionsGranted.toIcon(),
          ),
          ListTile(
            title: const Text('backgroundLocationPermissionGranted'),
            subtitle: const Text(
              'Weather permission is granted to access location in '
              'the background.',
            ),
            trailing: _manager.backgroundLocationPermissionGranted.toIcon(),
          ),
          ListTile(
            title: OutlinedButton(
              child: const Text('requestLocationPermissions'),
              onPressed: () {
                _manager.requestLocationPermissions();
                setState(() {}); // refresh the screen
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _manager.dispose();
    super.dispose();
  }
}

extension BoolExt on bool {
  Widget toIcon() => Icon(
        this ? Icons.check_box : Icons.cancel,
        color: this ? Colors.green : Colors.red,
      );
}

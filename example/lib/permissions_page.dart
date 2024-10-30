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
            leading: const Text('runtimePermissionsRequired'),
            trailing: Text('${_manager.runtimePermissionsRequired}'),
          ),
          ListTile(
            leading: const Text('locationPermissionsGranted'),
            trailing: Text('${_manager.locationPermissionsGranted}'),
          ),
          ListTile(
            leading: const Text('backgroundLocationPermissionGranted'),
            trailing: Text('${_manager.backgroundLocationPermissionGranted}'),
          ),
          ListTile(
            title: OutlinedButton(
              child: const Text('more to come'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _print(String message) {
    debugPrint(message);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _manager.dispose();
    super.dispose();
  }
}

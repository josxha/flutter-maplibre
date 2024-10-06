import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/styled_map_page.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class UserLocationPage extends StatefulWidget {
  const UserLocationPage({super.key});

  static const location = '/user-location';

  @override
  State<UserLocationPage> createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
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
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    final status = await Permission.locationWhenInUse.request();
                    debugPrint(status.toString());
                  },
                  child: const Text(
                    'Get permission',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await _controller.enableLocation();
                  },
                  child: const Text(
                    'Enable location',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await _controller.trackLocation();
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
                zoom: 1,
                center: Position(0, 0),
                style: StyledMapPage.styleUrl,
              ),
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
        ],
      ),
    );
  }
}

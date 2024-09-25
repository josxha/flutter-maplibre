import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  static const location = '/controller';

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('move to start');
                    await _controller.moveCamera(
                      update: CameraUpdate(
                        center: Position(172.4714, -42.4862),
                        zoom: 4,
                        pitch: 0,
                        bearing: 0,
                      ),
                    );
                    debugPrint('move to end');
                  },
                  child: const Text('Jump to New Zealand'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('animate to start');
                    try {
                      await _controller.animateCamera(
                        update: CameraUpdate(
                          center: Position(-18.6874, 64.9445),
                          zoom: 5,
                          bearing: -50,
                          pitch: 60,
                        ),
                      );
                      debugPrint('animate to end');
                    } catch (error) {
                      final e = error as PlatformException;
                      debugPrint(
                        'animate to cancelled: code: '
                        '"${e.code}", message: "${e.message}"',
                      );
                    }
                  },
                  child: const Text('Fly to Iceland'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('fit bounds start');
                    try {
                      await _controller.animateCamera(
                        update: const CameraUpdate.fitBounds(
                          bounds: LngLatBounds(
                            longitudeWest: 32.958984,
                            longitudeEast: 43.50585,
                            latitudeSouth: -5.353521,
                            latitudeNorth: 5.615985,
                          ),
                        ),
                      );
                      debugPrint('fit bounds end');
                    } catch (error) {
                      final e = error as PlatformException;
                      debugPrint(
                        'fit bounds cancelled: code: '
                        '"${e.code}", message: "${e.message}"',
                      );
                    }
                  },
                  child: const Text('Fit bounds to Kenya'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final camera = await _controller.getCamera();
                    debugPrint(camera.toString());
                    if (context.mounted) {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('MapCenter'),
                          content: Text('''
center.lng: ${camera.center.lng}
center.lat: ${camera.center.lat}
zoom: ${camera.zoom}
bearing: ${camera.bearing}
pitch: ${camera.pitch}'''),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Current MapCamera'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final camera = await _controller.getCamera();
                    final lat = camera.center.lat.toDouble();
                    final meters =
                        await _controller.getMetersPerPixelAtLatitude(lat);
                    debugPrint('latitude: $lat: $meters m/px');
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              'latitude: $lat: $meters m/px',
                            ),
                          ),
                        );
                    }
                  },
                  child: const Text('Meter/Pixel at center'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final region = await _controller.getVisibleRegion();
                    debugPrint(region.toString());
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text(region.toString())),
                        );
                    }
                  },
                  child: const Text('Visible region'),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(center: Position(9.17, 47.68), zoom: 3),
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
        ],
      ),
    );
  }
}

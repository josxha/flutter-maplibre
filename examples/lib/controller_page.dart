import 'package:flutter/material.dart';
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
              runSpacing: 2,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('moveCamera start');
                    await _controller.moveCamera(
                      const CameraUpdate.position(
                        center: Geographic(lon: 172.4714, lat: -42.4862),
                        zoom: 4,
                        pitch: 0,
                        bearing: 0,
                      ),
                    );
                    debugPrint('moveCamera end');
                  },
                  child: const Text(
                    'Move to\nNew Zealand',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('animateCamera start');
                    final result = await _controller.animateCamera(
                      const CameraUpdate.position(
                        center: Geographic(lon: -18.6874, lat: 64.9445),
                        zoom: 5,
                        bearing: -50,
                        pitch: 60,
                      ),
                      animation: const CameraAnimation.fly(),
                    );
                    debugPrint('animateCamera end: ${result.name}');
                  },
                  child: const Text(
                    'Animate to\nIceland',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('fit bounds start');
                    final result = await _controller.animateCamera(
                      const CameraUpdate.bounds(
                        GeoBox(
                          west: 5.894357,
                          east: 10.560848,
                          south: 45.806154,
                          north: 47.902069,
                        ),
                        padding: EdgeInsets.all(50),
                      ),
                      animation: const CameraAnimation.fly(),
                    );
                    debugPrint('fit bounds end: ${result.name}');
                  },
                  child: const Text(
                    'Fit bounds to\nSwitzerland',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final camera = _controller.getCamera();
                    debugPrint(camera.toString());
                    if (context.mounted) {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('MapCenter'),
                          content: Text('''
center.lng: ${camera.center.lon}
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
                  child: const Text(
                    'Current\nCameraPosition',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final camera = _controller.getCamera();
                    final lat = camera.center.lat;
                    final meters = _controller.getMetersPerPixelAtLatitude(lat);
                    debugPrint('latitude: $lat: $meters m/px');
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('latitude: $lat: $meters m/px'),
                          ),
                        );
                    }
                  },
                  child: const Text(
                    'Meter/Pixel\nat center',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final region = _controller.getVisibleBounds();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text(region.toString())),
                        );
                    }
                  },
                  child: const Text(
                    'Visible\nregion',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final lngLat = _controller.toLngLat(Offset.zero);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              'Geographic(lon: ${lngLat.lon}, lat: ${lngLat.lat})',
                            ),
                          ),
                        );
                    }
                  },
                  child: const Text(
                    'toLngLat 0,0',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final offset = _controller.toScreenLocation(
                      const Geographic(lon: 0, lat: 0),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('Offset(${offset.dx}, ${offset.dy})'),
                          ),
                        );
                    }
                  },
                  child: const Text(
                    'toScreenLocation 0,0',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: const MapOptions(
                initCamera: CameraUpdate.position(
                  center: Geographic(lon: 9.17, lat: 47.68),
                  zoom: 3,
                ),
              ),
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
        ],
      ),
    );
  }
}

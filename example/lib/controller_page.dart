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
              runSpacing: 2,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('moveCamera start');
                    await _controller.moveCamera(
                      center: Position(172.4714, -42.4862),
                      zoom: 4,
                      pitch: 0,
                      bearing: 0,
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
                    debugPrint('animateTo start');
                    try {
                      await _controller.animateCamera(
                        center: Position(-18.6874, 64.9445),
                        zoom: 5,
                        bearing: -50,
                        pitch: 60,
                      );
                      debugPrint('flyTo end');
                    } on PlatformException catch (error) {
                      debugPrint(
                        'flyTo cancelled: code: '
                        '"${error.code}", message: "${error.message}"',
                      );
                    }
                  },
                  child: const Text(
                    'Animate to\nIceland',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('fitBounds start');
                    try {
                      await _controller.fitBounds(
                        bounds: const LngLatBounds(
                          longitudeWest: 5.894357,
                          longitudeEast: 10.560848,
                          latitudeSouth: 45.806154,
                          latitudeNorth: 47.902069,
                        ),
                      );
                      debugPrint('fitBounds end');
                    } on PlatformException catch (error) {
                      debugPrint(
                        'fitBounds cancelled: code: '
                        '"${error.code}", message: "${error.message}"',
                      );
                    }
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
                  child: const Text(
                    'Current\nMapCamera',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final camera = _controller.getCamera();
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
                  child: const Text(
                    'Meter/Pixel\nat center',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final region = await _controller.getVisibleRegion();
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
                              'Position(${lngLat.lng}, ${lngLat.lat})',
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
                    final offset =
                        _controller.toScreenLocation(Position(0, 0));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              'Offset(${offset.dx}, ${offset.dy})',
                            ),
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
              options:
                  MapOptions(initCenter: Position(9.17, 47.68), initZoom: 3),
              onMapCreated: (controller) => _controller = controller,
            ),
          ),
        ],
      ),
    );
  }
}

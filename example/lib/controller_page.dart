// ignore_for_file: prefer_single_quotes, require_trailing_commas

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
                    debugPrint('jumpTo start');
                    await _controller.jumpTo(
                      center: Position(172.4714, -42.4862),
                      zoom: 4,
                      tilt: 0,
                      bearing: 0,
                    );
                    debugPrint('jumpTo end');
                  },
                  child: const Text('Jump to New Zealand'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    debugPrint('flyTo start');
                    try {
                      await _controller.flyTo(
                        center: Position(-18.6874, 64.9445),
                        zoom: 5,
                        bearing: -50,
                        tilt: 60,
                      );
                      debugPrint('flyTo end');
                    } catch (error) {
                      final e = error as PlatformException;
                      debugPrint(
                        'flyTo cancelled: code: '
                        '"${e.code}", message: "${e.message}"',
                      );
                    }
                  },
                  child: const Text('Fly to Iceland'),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                center: Position(9.17, 47.68),
              ),
              onMapCreated: (controller) => _controller = controller,
              onStyleLoaded: () async {
                debugPrint('[MapLibreMap] onStyleLoadedCallback');
              },
            ),
          ),
        ],
      ),
    );
  }
}

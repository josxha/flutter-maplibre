// ignore_for_file: prefer_single_quotes, require_trailing_commas

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
  MapController? _controller;

  @override
  Widget build(BuildContext context) {
    debugPrint('build _controller: $_controller');
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
                  onPressed: () {
                    debugPrint('_controller: $_controller');
                  },
                  child: const Text('Check controller'),
                ),
                OutlinedButton(
                  onPressed: () {
                    debugPrint('_controller: $_controller');
                    _controller?.jumpTo(
                      center: Position(172.4714, -42.4862),
                      zoom: 4,
                    );
                  },
                  child: const Text('Move to New Zealand'),
                ),
                OutlinedButton(
                  onPressed: () {
                    debugPrint('_controller: $_controller');
                    _controller?.flyTo(
                      center: Position(-18.6874, 64.9445),
                      zoom: 5,
                      bearing: -50,
                      pitch: 60,
                    );
                  },
                  child: const Text('Animate to Iceland'),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                center: Position(9, 48),
              ),
              onMapCreated: (controller) {
                debugPrint('[MapLibreMap] onMapCreated');
                _controller = controller;
                debugPrint('_controller: $_controller');
              },
              onStyleLoaded: () async {
                debugPrint('[MapLibreMap] onStyleLoadedCallback');
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('ControllerPage.dispose');
    super.dispose();
  }
}

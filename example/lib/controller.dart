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
                  onPressed: () => _controller.jumpTo(
                    center: Position(172.4714, -42.4862),
                    zoom: 4,
                  ),
                  child: const Text('Move to New Zealand'),
                ),
                OutlinedButton(
                  onPressed: () => _controller.flyTo(
                    center: Position(-18.6874, 64.9445),
                    zoom: 5,
                    bearing: -50,
                    pitch: 60,
                  ),
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
}

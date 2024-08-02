// ignore_for_file: prefer_single_quotes, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class CallbacksPage extends StatefulWidget {
  const CallbacksPage({super.key});

  static const location = '/callbacks';

  @override
  State<CallbacksPage> createState() => _CallbacksPageState();
}

class _CallbacksPageState extends State<CallbacksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapLibre Demo')),
      body: MapLibreMap(
        options: MapOptions(
          center: Position(9, 48),
          onClick: (Position point) =>
              debugPrint('onTap: ${point.lng}, ${point.lat}'),
          onDoubleClick: (point) =>
              debugPrint('onDoubleClick: ${point.lng}, ${point.lat}'),
          onSecondaryClick: (point) =>
              debugPrint('onSecondaryClick: ${point.lng}, ${point.lat}'),
        ),
        onMapCreated: (controller) {
          debugPrint('[MapLibreMap] onMapCreated');
        },
        onStyleLoadedCallback: () async {
          debugPrint('[MapLibreMap] onStyleLoadedCallback');
        },
      ),
    );
  }
}

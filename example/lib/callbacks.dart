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
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapLibre Demo')),
      body: MapLibreMap(
        options: MapOptions(
          center: Position(9, 48),
          onClick: (Position point) async {
            try {
              final offset = await _controller.toScreenLocation(point);
              debugPrint('onTap: ${point.lng}, ${point.lat}, offset: $offset');
            } catch (error, stack) {
              debugPrint(error.toString());
              debugPrintStack(stackTrace: stack);
            }
          },
          onDoubleClick: (point) =>
              debugPrint('onDoubleClick: ${point.lng}, ${point.lat}'),
          onSecondaryClick: (point) =>
              debugPrint('onSecondaryClick: ${point.lng}, ${point.lat}'),
        ),
        onMapCreated: (controller) {
          _controller = controller;
          debugPrint('[MapLibreMap] onMapCreated');
        },
        onStyleLoadedCallback: () async {
          debugPrint('[MapLibreMap] onStyleLoadedCallback');
        },
      ),
    );
  }
}

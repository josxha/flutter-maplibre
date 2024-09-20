import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  static const location = '/events';

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _lastEventMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(_lastEventMessage, textAlign: TextAlign.center),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(center: Position(9.17, 47.68)),
              onEvent: _onEvent,
            ),
          ),
        ],
      ),
    );
  }

  void _onEvent(MapEvent event) => switch (event) {
        MapEventMapCreated() => _print('map created'),
        MapEventStyleLoaded() => _print('style loaded'),
        MapEventCameraMoved() => _print(
            'camera moved: center ${_formatPosition(event.camera.center)}, '
            'zoom ${event.camera.zoom.toStringAsFixed(2)}, '
            'tilt ${event.camera.tilt.toStringAsFixed(2)}, '
            'bearing ${event.camera.bearing.toStringAsFixed(2)}',
          ),
        MapEventClicked() => _print('clicked: ${_formatPosition(event.point)}'),
        MapEventDoubleClicked() =>
          _print('double clicked: ${_formatPosition(event.point)}'),
        MapEventLongClicked() =>
          _print('long clicked: ${_formatPosition(event.point)}'),
        MapEventSecondaryClicked() =>
          _print('secondary clicked: ${_formatPosition(event.point)}'),
      };

  void _print(String message) {
    debugPrint('[MapLibreMap] $message');
    setState(() {
      _lastEventMessage = message;
    });
  }

  String _formatPosition(Position point) =>
      '${point.lng.toStringAsFixed(6)}, ${point.lat.toStringAsFixed(6)}';
}

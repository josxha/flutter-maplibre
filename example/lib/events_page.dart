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
  final _eventMessages = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: Stack(
        children: [
          MapLibreMap(
            options: MapOptions(center: Position(9.17, 47.68)),
            onEvent: _onEvent,
          ),
          IgnorePointer(
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.bottomLeft,
              child: Text(_eventMessages.join('\n')),
            ),
          ),
        ],
      ),
    );
  }

  void _onEvent(MapEvent event) => switch (event) {
        MapEventMapCreated() => _print('map created'),
        MapEventStyleLoaded() => _print('style loaded'),
        MapEventMoveCamera() => _print(
            'move camera: center ${_formatPosition(event.camera.center)}, '
            'zoom ${event.camera.zoom.toStringAsFixed(2)}, '
            'tilt ${event.camera.tilt.toStringAsFixed(2)}, '
            'bearing ${event.camera.bearing.toStringAsFixed(2)}',
          ),
        MapEventStartMoveCamera() =>
          _print('start move camera, reason: ${event.reason.name}'),
        MapEventClick() => _print('clicked: ${_formatPosition(event.point)}'),
        MapEventDoubleClick() =>
          _print('double clicked: ${_formatPosition(event.point)}'),
        MapEventLongClick() =>
          _print('long clicked: ${_formatPosition(event.point)}'),
        MapEventSecondaryClick() =>
          _print('secondary clicked: ${_formatPosition(event.point)}'),
        MapEventIdle() => _print('idle'),
        MapEventCameraIdle() => _print('camera idle'),
      };

  void _print(String message) {
    debugPrint('[MapLibreMap] $message');
    setState(() {
      _eventMessages.add(message);
      if (_eventMessages.length > 10) _eventMessages.removeAt(0);
    });
  }

  String _formatPosition(Position point) =>
      '${point.lng.toStringAsFixed(3)}, ${point.lat.toStringAsFixed(3)}';
}

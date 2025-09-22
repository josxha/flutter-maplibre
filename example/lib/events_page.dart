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
            options: const MapOptions(
              initCenter: Geographic(lon: 9.17, lat: 47.68),
            ),
            onEvent: _onEvent,
          ),
          IgnorePointer(
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.bottomLeft,
              child: Text(
                _eventMessages.join('\n'),
                style: const TextStyle(color: Colors.black),
              ),
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
      'move camera: center ${_formatGeographic(event.camera.center)}, '
      'zoom ${event.camera.zoom.toStringAsFixed(2)}, '
      'pitch ${event.camera.pitch.toStringAsFixed(2)}, '
      'bearing ${event.camera.bearing.toStringAsFixed(2)}',
    ),
    MapEventStartMoveCamera() => _print(
      'start move camera, reason: ${event.reason.name}',
    ),
    MapEventClick() => _print(
      'clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    ),
    MapEventDoubleClick() => _print(
      'double clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    ),
    MapEventLongClick() => _print(
      'long clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    ),
    MapEventSecondaryClick() => _print(
      'secondary clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    ),
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

  String _formatGeographic(Geographic point) =>
      '${point.lon.toStringAsFixed(3)}, ${point.lat.toStringAsFixed(3)}';

  String _formatOffset(Offset offset) =>
      '${offset.dx.toStringAsFixed(1)}, ${offset.dy.toStringAsFixed(1)}';
}

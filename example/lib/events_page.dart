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
  bool dragEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ChoiceChip(
              label: const Text('Drag'),
              selected: dragEnabled,
              onSelected:
                  (value) => setState(() {
                    dragEnabled = !dragEnabled;
                  }),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          MapLibreMap(
            options: MapOptions(
              initCenter: Position(9.17, 47.68),
              gestures: MapGestures.all(drag: dragEnabled),
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

  void _onEvent(MapEvent mapEvent) => switch (mapEvent) {
    MapEventMapCreated() => _print('map created'),
    MapEventStyleLoaded() => _print('style loaded'),
    MapEventMoveCamera() => _print(
      'move camera: center ${_formatPosition(mapEvent.camera.center)}, '
      'zoom ${mapEvent.camera.zoom.toStringAsFixed(2)}, '
      'pitch ${mapEvent.camera.pitch.toStringAsFixed(2)}, '
      'bearing ${mapEvent.camera.bearing.toStringAsFixed(2)}',
    ),
    MapEventStartMoveCamera() => _print(
      'start move camera, reason: ${mapEvent.reason.name}',
    ),
    MapEventClick() => _print('clicked: ${_formatPosition(mapEvent.point)}'),
    MapEventDoubleClick() => _print(
      'double clicked: ${_formatPosition(mapEvent.point)}',
    ),
    MapEventLongClick() => _print(
      'long clicked: ${_formatPosition(mapEvent.point)}',
    ),
    MapEventSecondaryClick() => _print(
      'secondary clicked: ${_formatPosition(mapEvent.point)}',
    ),
    MapEventIdle() => _print('idle'),
    MapEventCameraIdle() => _print('camera idle'),
    MapEventFeatureDrag() => _print(
      '${mapEvent.event.type} feature ${mapEvent.feature.id} at: ${_formatPosition(mapEvent.event.point)}',
    ),
    MapEventLongPress() => _print(
      '${mapEvent.type}: ${_formatPosition(mapEvent.point)}',
    ),
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

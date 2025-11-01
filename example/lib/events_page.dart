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
  final _events = <MapEvent>[];

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
          SafeArea(
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.bottomLeft,
                child: Text(
                  _events.map(eventToString).join('\n'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String eventToString(MapEvent event) => switch (event) {
    MapEventMapCreated() => 'map created',
    MapEventStyleLoaded() => 'style loaded',
    MapEventMoveCamera() =>
      'move camera: center ${_formatGeographic(event.camera.center)}, '
          'zoom ${event.camera.zoom.toStringAsFixed(2)}, '
          'pitch ${event.camera.pitch.toStringAsFixed(2)}, '
          'bearing ${event.camera.bearing.toStringAsFixed(2)}',
    MapEventStartMoveCamera() =>
      'start move camera, reason: ${event.reason.name}',
    MapEventClick() =>
      'clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    MapEventDoubleClick() =>
      'double clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    MapEventLongClick() =>
      'long clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    MapEventSecondaryClick() =>
      'secondary clicked: ${_formatGeographic(event.point)}, screen: ${_formatOffset(event.screenPoint)}',
    MapEventIdle() => 'idle',
    MapEventCameraIdle() => 'camera idle',
  };

  void _onEvent(MapEvent event) {
    debugPrint('[MapLibreMap] ${eventToString(event)}');
    if (event.runtimeType == _events.lastOrNull?.runtimeType) {
      setState(() {
        _events[_events.length - 1] = event;
      });
    } else {
      setState(() {
        _events.add(event);
        if (_events.length > 10) _events.removeAt(0);
      });
    }
  }

  String _formatGeographic(Geographic point) =>
      '${point.lon.toStringAsFixed(3)}, ${point.lat.toStringAsFixed(3)}';

  String _formatOffset(Offset offset) =>
      '${offset.dx.toStringAsFixed(1)}, ${offset.dy.toStringAsFixed(1)}';
}

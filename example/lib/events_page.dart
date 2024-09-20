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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: MapLibreMap(
        options: MapOptions(center: Position(9.17, 47.68)),
        onEvent: _onMapEvent,
      ),
    );
  }

  void _onMapEvent(MapEvent event) => switch (event) {
    MapEventStyleLoaded() => _print('style loaded'),
    MapEventMapCreated() => 'map created',
    MapEventMovementStopped() => 'movement stopped',
  };

  void _print(String message) {
    debugPrint('[MapLibreMap] $message');
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

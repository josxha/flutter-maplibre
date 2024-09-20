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
        MapEventMapCreated() => _print('map created'),
        MapEventStyleLoaded() => _print('style loaded'),
        MapEventMovementStopped() => _print('movement stopped'),
        MapEventClicked() =>
          _print('clicked: ${_positionToString(event.point)}'),
        MapEventDoubleClicked() =>
          _print('double clicked: ${_positionToString(event.point)}'),
        MapEventLongClicked() =>
          _print('long clicked: ${_positionToString(event.point)}'),
        MapEventSecondaryClicked() =>
          _print('secondary clicked: ${_positionToString(event.point)}'),
      };

  void _print(String message) {
    debugPrint('[MapLibreMap] $message');
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
        snackBarAnimationStyle: AnimationStyle(
          duration: const Duration(milliseconds: 100),
        ),
      );
  }

  String _positionToString(Position point) =>
      '${point.lng.toStringAsFixed(6)}, ${point.lat.toStringAsFixed(6)}';
}

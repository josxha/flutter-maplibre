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
      appBar: AppBar(title: const Text('Callbacks')),
      body: MapLibreMap(
        options: MapOptions(center: Position(9.17, 47.68)),
        onMapCreated: (controller) => _print('onMapCreated'),
        onStyleLoaded: () => _print('onStyleLoadedCallback'),
      ),
    );
  }

  void _print(String message) {
    debugPrint('[MapLibreMap] $message');
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

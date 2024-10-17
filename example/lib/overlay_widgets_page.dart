import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class OverlayWidgetsPage extends StatefulWidget {
  const OverlayWidgetsPage({super.key});

  static const location = '/overlay-widgets';

  @override
  State<OverlayWidgetsPage> createState() => _OverlayWidgetsPageState();
}

class _OverlayWidgetsPageState extends State<OverlayWidgetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overlay Widgets')),
      body: MapLibreMap(
        options: MapOptions(initZoom: 4, initCenter: Position(9.17, 47.68)),
        children: const [
          ZoomButtons(),
        ],
      ),
    );
  }
}

class ZoomButtons extends StatelessWidget {
  const ZoomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(12),
      child: Column(
        spacing: 8,
        children: [
          FloatingActionButton(
            onPressed: () => controller.animateCamera(zoom: controller.getCamera().zoom + 1),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => controller.animateCamera(zoom: controller.getCamera().zoom - 1),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

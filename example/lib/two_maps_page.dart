import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class TwoMapsPage extends StatefulWidget {
  const TwoMapsPage({super.key});

  static const location = '/two-maps';

  @override
  State<TwoMapsPage> createState() => _TwoMapsPageState();
}

class _TwoMapsPageState extends State<TwoMapsPage> {
  MapController? _controller1;
  MapController? _controller2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Two Maps')),
      body: Column(
        children: [
          _ButtonsWidget(controller: _controller1),
          Expanded(
            child: MapLibreMap(
              acceptLicense: true,
              options: MapOptions(initCenter: Position(9.17, 47.68)),
              onMapCreated: (controller) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _controller1 = controller);
                });
              },
            ),
          ),
          _ButtonsWidget(controller: _controller2),
          Expanded(
            child: MapLibreMap(
              acceptLicense: true,
              options: MapOptions(initCenter: Position(9.17, 47.68)),
              onMapCreated: (controller) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _controller2 = controller);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({required this.controller});

  final MapController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 2,
        children: [
          OutlinedButton(
            onPressed: () {
              controller?.moveCamera(
                center: Position(172.4714, -42.4862),
                zoom: 4,
                bearing: 0,
                pitch: 0,
              );
            },
            child: const Text('Move to New Zealand'),
          ),
          OutlinedButton(
            onPressed: () {
              controller?.animateCamera(
                center: Position(-18.6874, 64.9445),
                zoom: 5,
                bearing: -50,
                pitch: 60,
              );
            },
            child: const Text('Animate to Iceland'),
          ),
        ],
      ),
    );
  }
}

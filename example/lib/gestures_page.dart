import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class GesturesPage extends StatefulWidget {
  const GesturesPage({super.key});

  static const location = '/gestures';

  @override
  State<GesturesPage> createState() => _GesturesPageState();
}

class _GesturesPageState extends State<GesturesPage> {
  final _selections = List.generate(Gestures.values.length, (_) => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestures')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ToggleButtons(
                  isSelected: _selections,
                  onPressed: (index) => setState(() {
                    _selections[index] = !_selections[index];
                  }),
                  children: Gestures.values
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(e.name),
                        ),
                      )
                      .toList(growable: false),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                center: Position(9.17, 47.68),
                zoom: 3,
                gestures: MapGestures(
                  doubleClickZoom: _selections[0],
                  dragPan: _selections[1],
                  dragRotate: _selections[2],
                  keyboard: _selections[3],
                  pitchWithRotate: _selections[4],
                  scrollZoom: _selections[5],
                  touchPitch: _selections[6],
                  touchZoomRotate: _selections[7],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum Gestures {
  doubleClickZoom,
  dragPan,
  dragRotate,
  keyboard,
  pitchWithRotate,
  scrollZoom,
  touchPitch,
  touchZoomRotate;
}

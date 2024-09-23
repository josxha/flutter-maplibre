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
  final _selections = Map.fromEntries(
    Gestures.values.map((e) => MapEntry(e, false)),
  );

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
              children: Gestures.values
                  .map(
                    (e) =>
                    ChoiceChip(
                      label: Text(e.name),
                      selected: _selections[e]!,
                      onSelected: (value) => setState(() {
                        _selections[e] = !_selections[e]!;
                      }),
                    ),
              )
                  .toList(growable: false),
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                center: Position(9.17, 47.68),
                zoom: 3,
                gestures: MapGestures(
                  doubleClickZoom: _selections[Gestures.doubleClickZoom]!,
                  dragPan: _selections[Gestures.dragPan]!,
                  dragRotate: _selections[Gestures.dragRotate]!,
                  keyboard: _selections[Gestures.keyboard]!,
                  scrollZoom: _selections[Gestures.scrollZoom]!,
                  touchPitch: _selections[Gestures.touchPitch]!,
                  touchZoomRotate: _selections[Gestures.touchZoomRotate]!,
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
  scrollZoom,
  touchPitch,
  touchZoomRotate;
}

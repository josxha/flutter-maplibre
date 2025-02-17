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
              runSpacing: 2,
              children: Gestures.values
                  .map(
                    (e) => ChoiceChip(
                      label: Text(e.name),
                      selected: _selections[e]!,
                      onSelected:
                          (value) => setState(() {
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
                initCenter: Position(9.17, 47.68),
                initZoom: 3,
                gestures: MapGestures(
                  rotate: _selections[Gestures.rotate]!,
                  pan: _selections[Gestures.pan]!,
                  zoom: _selections[Gestures.zoom]!,
                  pitch: _selections[Gestures.tilt]!,
                  drag: _selections[Gestures.drag]!,
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
  rotate,
  pan,
  zoom,
  tilt,
  drag;
}

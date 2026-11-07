import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersHoverPage extends StatefulWidget {
  const LayersHoverPage({super.key});

  static const location = '/layers/hover';

  @override
  State<LayersHoverPage> createState() => _LayersHoverPageState();
}

class _LayersHoverPageState extends State<LayersHoverPage> {
  /// A grid of areas around Lake Constance.
  static final _areas = <Feature<Polygon>>[
    for (var row = 0; row < 4; row++)
      for (var column = 0; column < 5; column++)
        Feature(
          geometry: _square(8.4 + column * 0.4, 47.9 - row * 0.3),
          properties: {'name': 'Area ${row * 5 + column + 1}'},
        ),
  ];

  static Polygon _square(double lon, double lat) => Polygon.from([
    [
      Geographic(lon: lon, lat: lat),
      Geographic(lon: lon + 0.38, lat: lat),
      Geographic(lon: lon + 0.38, lat: lat - 0.28),
      Geographic(lon: lon, lat: lat - 0.28),
      Geographic(lon: lon, lat: lat),
    ],
  ]);

  int? _hovered;
  int? _selected;

  @override
  Widget build(BuildContext context) {
    final hovered = _hovered;
    final selected = _selected;
    return Scaffold(
      appBar: AppBar(title: const Text('Hover Features')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              selected == null
                  ? 'Hover over an area with the mouse, or tap one.'
                  : 'Selected ${_nameOf(selected)}.',
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: const MapOptions(
                initCamera: CameraUpdate.position(
                  zoom: 7,
                  center: Geographic(lon: 9.38, lat: 47.47),
                ),
              ),
              layers: [
                PolygonLayer(
                  polygons: _areas,
                  color: const .literal(Colors.blue),
                  opacity: const .literal(0.3),
                  outlineColor: const .literal(Colors.blue),
                  onEnter: (event) => setState(() => _hovered = event.index),
                  onLeave: (event) => setState(() {
                    if (_hovered == event.index) _hovered = null;
                  }),
                  onClick: (event) => setState(() => _selected = event.index),
                ),
                // The hovered and the selected area, drawn more opaque.
                PolygonLayer(
                  polygons: [
                    if (hovered != null) _areas[hovered],
                    if (selected != null && selected != hovered)
                      _areas[selected],
                  ],
                  color: const .literal(Colors.blue),
                  opacity: const .literal(0.6),
                  outlineColor: const .literal(Colors.indigo),
                ),
              ],
              children: const [SourceAttribution(), MapControlButtons()],
            ),
          ),
        ],
      ),
    );
  }

  String _nameOf(int index) => _areas[index].properties['name'] as String;
}

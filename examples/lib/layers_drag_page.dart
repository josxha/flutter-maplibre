import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersDragPage extends StatefulWidget {
  const LayersDragPage({super.key});

  static const location = '/layers/drag';

  @override
  State<LayersDragPage> createState() => _LayersDragPageState();
}

class _LayersDragPageState extends State<LayersDragPage> {
  final _circles = <Feature<Point>>[
    const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
    const Feature(geometry: Point(Geographic(lon: 9, lat: 48))),
    const Feature(geometry: Point(Geographic(lon: 9.5, lat: 48))),
  ];

  final _markers = <Feature<Point>>[
    const Feature(
      geometry: Point(Geographic(lon: 9.3, lat: 47.5)),
      properties: {'name': 'Marker 1'},
    ),
    const Feature(
      geometry: Point(Geographic(lon: 8.8, lat: 47.6)),
      properties: {'name': 'Marker 2'},
    ),
  ];

  bool _imageLoaded = false;

  String _status = 'Drag a circle or a marker.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drag Features')),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8), child: Text(_status)),
          Expanded(
            child: MapLibreMap(
              options: const MapOptions(
                initCamera: CameraUpdate.position(
                  zoom: 7,
                  center: Geographic(lon: 9.17, lat: 47.68),
                ),
              ),
              onStyleLoaded: (style) async {
                await style.addImageFromIconData(
                  id: 'marker',
                  iconData: Icons.location_on,
                  color: Colors.red,
                );
                setState(() => _imageLoaded = true);
              },
              layers: [
                CircleLayer(
                  points: _circles,
                  color: .literal(Colors.orange.withValues(alpha: 0.7)),
                  radius: const .literal(16),
                  strokeColor: const .literal(Colors.red),
                  strokeWidth: const .literal(2),
                  onDragStart: (event) => _startDrag(_circles, event),
                  onDrag: (event) => _move(_circles, event),
                  onDragEnd: (event) => _endDrag(_circles, event),
                ),
                MarkerLayer(
                  points: _markers,
                  textField: const .literal('{name}'),
                  textAllowOverlap: const .literal(true),
                  iconAllowOverlap: const .literal(true),
                  iconImage: _imageLoaded ? const .literal('marker') : null,
                  iconAnchor: const .literal(IconAnchor.bottom),
                  textOffset: const .literal(Offset(0, 1)),
                  onDragStart: (event) => _startDrag(_markers, event),
                  onDrag: (event) => _move(_markers, event),
                  onDragEnd: (event) => _endDrag(_markers, event),
                ),
              ],
              children: const [SourceAttribution(), MapControlButtons()],
            ),
          ),
        ],
      ),
    );
  }

  void _startDrag(List<Feature<Point>> features, LayerDragEvent event) =>
      setState(() => _status = 'Dragging ${_nameOf(features, event.index)}.');

  String _nameOf(List<Feature<Point>> features, int index) =>
      identical(features, _circles)
      ? 'circle ${index + 1}'
      : features[index].properties['name'] as String;

  /// Moves the feature to where it is dragged. The layer doesn't move it
  /// itself.
  void _move(List<Feature<Point>> features, LayerDragEvent event) {
    final feature = features[event.index];
    setState(() {
      features[event.index] = Feature(
        id: feature.id,
        geometry: Point(event.point),
        properties: feature.properties,
      );
    });
  }

  void _endDrag(List<Feature<Point>> features, LayerDragEvent event) {
    _move(features, event);
    final point = event.point;
    setState(() {
      _status =
          'Moved ${_nameOf(features, event.index)} to '
          '${point.lat.toStringAsFixed(3)}, '
          '${point.lon.toStringAsFixed(3)}.';
    });
  }
}

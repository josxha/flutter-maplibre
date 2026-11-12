import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

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
                  draggable: true,
                  onDragStart: (event) => _startDrag(_circles, event),
                  onDragEnd: (event) => _drop(_circles, event),
                ),
                MarkerLayer(
                  points: _markers,
                  textField: const .literal('{name}'),
                  textAllowOverlap: const .literal(true),
                  iconAllowOverlap: const .literal(true),
                  iconImage: _imageLoaded ? const .literal('marker') : null,
                  iconAnchor: const .literal(IconAnchor.bottom),
                  textOffset: const .literal(Offset(0, 1)),
                  draggable: true,
                  onDragStart: (event) => _startDrag(_markers, event),
                  onDragEnd: (event) => _drop(_markers, event),
                ),
              ],
              children: const [SourceAttribution(), MapControlButtons()],
            ),
          ),
        ],
      ),
    );
  }

  void _startDrag(List<Feature<Point>> features, LayerFeatureEvent event) =>
      setState(() => _status = 'Dragging ${_nameOf(features, event.index)}.');

  String _nameOf(List<Feature<Point>> features, int index) =>
      identical(features, _circles)
      ? 'circle ${index + 1}'
      : features[index].properties['name'] as String;

  /// Saves the feature where it was dropped. The layer moves it while it is
  /// dragged, and puts it back unless the list has it at its new place.
  void _drop(List<Feature<Point>> features, LayerFeatureEvent event) {
    final feature = features[event.index];
    final point = event.point;
    setState(() {
      features[event.index] = Feature(
        id: feature.id,
        geometry: Point(point),
        properties: feature.properties,
      );
      _status =
          'Moved ${_nameOf(features, event.index)} to '
          '${point.lat.toStringAsFixed(3)}, '
          '${point.lon.toStringAsFixed(3)}.';
    });
  }
}

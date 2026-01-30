import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersWidgetMarkerPage extends StatefulWidget {
  const LayersWidgetMarkerPage({super.key});

  static const location = '/layers/widget-marker';

  @override
  State<LayersWidgetMarkerPage> createState() => _LayersWidgetMarkerPageState();
}

class _LayersWidgetMarkerPageState extends State<LayersWidgetMarkerPage> {
  final _points = <Feature<Point>>[
    const Feature(
      geometry: Point(Geographic(lon: 9.17, lat: 47.68)),
      properties: {'name': 'Marker 1'},
    ),
    const Feature(
      geometry: Point(Geographic(lon: 9.17, lat: 48)),
      properties: {'name': 'Marker 2'},
    ),
    const Feature(
      geometry: Point(Geographic(lon: 9, lat: 48)),
      properties: {'name': 'Marker 3'},
    ),
    const Feature(
      geometry: Point(Geographic(lon: 9.5, lat: 48)),
      properties: {'name': 'Marker 4'},
    ),
  ];

  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Layers')),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 7,
          initCenter: Geographic(lon: 9.17, lat: 47.68),
        ),
        onEvent: (event) async {
          switch (event) {
            case MapEventStyleLoaded():
              // add marker image to map
              await event.style.addImageFromWidget(
                id: 'marker',
                widget: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red.shade700,
                      size: 48,
                    ),
                  ),
                ),
              );
              setState(() {
                _imageLoaded = true;
              });
            case MapEventClick():
              // add a new marker on click
              setState(() {
                _points.add(Feature(geometry: Point(event.point)));
              });
            default:
              // ignore all other events
              break;
          }
        },
        layers: [
          MarkerLayer(
            points: _points,
            textField: '{name}',
            textAllowOverlap: true,
            iconImage: _imageLoaded ? 'marker' : null,
            iconSize: 0.15,
            iconAnchor: IconAnchor.bottom,
            textOffset: const [0, 1],
          ),
        ],
      ),
    );
  }
}

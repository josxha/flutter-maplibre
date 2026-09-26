import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersMarkerPage extends StatefulWidget {
  const LayersMarkerPage({super.key});

  static const location = '/layers/marker';

  @override
  State<LayersMarkerPage> createState() => _LayersMarkerPageState();
}

class _LayersMarkerPageState extends State<LayersMarkerPage> {
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
  bool _cluster = false;
  MapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marker Layers'),
        actions: [
          IconButton(
            tooltip: _cluster ? 'Disable clustering' : 'Enable clustering',
            icon: Icon(_cluster ? Icons.scatter_plot : Icons.bubble_chart),
            onPressed: () => setState(() => _cluster = !_cluster),
          ),
        ],
      ),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 7,
          initCenter: Geographic(lon: 9.17, lat: 47.68),
        ),
        onEvent: (event) async {
          switch (event) {
            case MapEventMapCreated():
              _controller = event.mapController;
            case MapEventStyleLoaded():
              // add marker image to map
              await event.style.addImageFromIconData(
                id: 'marker',
                iconData: Icons.location_on,
                color: Colors.red,
              );
              setState(() {
                _imageLoaded = true;
              });
            case MapEventClick(:final point, :final screenPoint):
              final controller = _controller;
              // When a cluster is tapped, zoom into it instead of adding a
              // marker. Clusters carry a `point_count` property.
              var tappedCluster = false;
              if (controller != null && _cluster) {
                try {
                  tappedCluster = controller
                      .featuresAtPoint(screenPoint)
                      .any((f) => f.properties.containsKey('point_count'));
                } on Exception {
                  // featuresAtPoint is not supported on all platforms (e.g.
                  // the webview backend used on macOS and Windows).
                  tappedCluster = false;
                }
              }
              if (tappedCluster && controller != null) {
                await controller.animateCamera(
                  center: point,
                  zoom: controller.getCamera().zoom + 2,
                );
              } else {
                // add a new marker on click
                setState(() {
                  _points.add(Feature(geometry: Point(point)));
                });
              }
            default:
              // ignore all other events
              break;
          }
        },
        layers: [
          MarkerLayer(
            points: _points,
            textField: _cluster ? '' : '{name}',
            textAllowOverlap: true,
            iconImage: _imageLoaded ? 'marker' : null,
            iconSize: 0.15,
            iconAnchor: IconAnchor.bottom,
            textOffset: const [0, 1],
            cluster: _cluster,
          ),
        ],
      ),
    );
  }
}

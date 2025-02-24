import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/style_layers_symbol_page.dart';

@immutable
class LayersInteractivePage extends StatefulWidget {
  const LayersInteractivePage({super.key});

  static const location = '/layers/interactive';

  @override
  State<LayersInteractivePage> createState() => _LayersInteractivePageState();
}

class _LayersInteractivePageState extends State<LayersInteractivePage> {
  final _points = <Feature<Point>>[
    Feature(
      id: '0',
      geometry: Point(coordinates: Position(9.17, 47.68)),
      properties: {'Marker': 'Marker 0'},
    ),
    Feature(
      id: '1',
      geometry: Point(coordinates: Position(9.17, 48)),
      properties: {'Marker': 'Marker 1'},
    ),
    Feature(
      id: '2',
      geometry: Point(coordinates: Position(9, 48)),
      properties: {'Marker': 'Marker 2'},
    ),
    Feature(
      id: '3',
      geometry: Point(coordinates: Position(9.5, 48)),
      properties: {'Marker': 'Marker 3'},
    ),
  ];

  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Layers')),
      body: MapLibreMap(
        options: MapOptions(
          initZoom: 7,
          initCenter: Position(9.17, 47.68),
          gestures: const MapGestures.all(),
        ),
        onEvent: (event) async {
          switch (event) {
            case MapEventStyleLoaded():

              // add marker image to map
              final response = await http.get(
                Uri.parse(StyleLayersSymbolPage.imageUrl),
              );
              final bytes = response.bodyBytes;
              await event.style.addImage('marker', bytes);
              setState(() => _imageLoaded = true);

              event.style.getDraggableLayers().forEach((layer) {
                log('Draggable layer: ${layer.id}');
              });
            // case MapEventLongPress():
            // log('Long ${event.type} at ${event.point.lat}, ${event.point.lng}');
            case MapEventFeatureDrag():
              log(
                '${event.event.type} feature ${event.feature.id} at ${event.event.point.lat}, ${event.event.point.lng}',
              );

              if (event.event is MapEventLongPressMove) {
                await _updatePoint(
                  event.event.point,
                  event.feature.id.toString(),
                );
              }
            case MapEventClick():
              // add a new marker on click
              setState(() {
                _points.add(
                  Feature(
                    id: '${_points.length}',
                    geometry: Point(coordinates: event.point),
                    properties: {'Marker': 'Marker ${_points.length}'},
                  ),
                );
              });
            default:
              // ignore all other events
              break;
          }
        },
        layers: [
          MarkerLayer(
            sourceId: 'draggable-source',
            layerId: 'draggable-layer',
            iconAllowOverlap: true,
            markers: _points,
            textField: 'Marker',
            textAllowOverlap: true,
            iconImage: _imageLoaded ? 'marker' : null,
            iconSize: 0.08,
            iconAnchor: IconAnchor.bottom,
            textOffset: const [0, 1],
            draggable: true,
          ),
        ],
      ),
    );
  }

  Future<void> _updatePoint(Position newPosition, String featureId) async {
    setState(() {
      final index = _points.indexWhere((feature) => feature.id == featureId);
      if (index != -1) {
        _points[index].geometry = Point(coordinates: newPosition);
      }
    });
  }
}

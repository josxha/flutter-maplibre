import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/style_layers_symbol_page.dart';

@immutable
class StyleLayersInteractivePage extends StatefulWidget {
  const StyleLayersInteractivePage({super.key});

  static const location = '/style-layers/interactive';

  @override
  State<StyleLayersInteractivePage> createState() =>
      _StyleLayersInteractivePageState();
}

class _StyleLayersInteractivePageState
    extends State<StyleLayersInteractivePage> {
  late final StyleController _styleController;

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
              _styleController = event.style;

              // add marker image to map
              final response =
                  await http.get(Uri.parse(StyleLayersSymbolPage.imageUrl));
              final bytes = response.bodyBytes;
              await event.style.addImage('marker', bytes);

              await _styleController.addSource(
                GeoJsonSource(
                  id: 'draggable-source',
                  data:
                      jsonEncode(FeatureCollection(features: _points).toJson()),
                ),
              );

              await _styleController.addLayer(
                const SymbolStyleLayer(
                  id: 'draggable-layer',
                  sourceId: 'draggable-source',
                  layout: {
                    'icon-size': 0.08,
                    'text-offset': [0, 1],
                    'icon-image': 'marker',
                    'icon-anchor': 'bottom',
                    'icon-allow-overlap': true,
                    'text-allow-overlap': true,
                    'text-field': ['get', 'Marker'],
                  },
                  draggable: true,
                ),
              );

              _styleController.getDraggableLayers().forEach((layer) {
                log('Draggable layer: ${layer.id}');
              });
            // case MapEventLongPress():
            // log('Long ${event.type} at ${event.point.lat}, ${event.point.lng}');
            case MapEventFeatureDrag():
              log('${event.event.type} feature ${event.feature.id} at ${event.event.point.lat}, ${event.event.point.lng}');

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
      ),
    );
  }

  Future<void> _updatePoint(Position newPosition, String featureId) async {
    final index = _points.indexWhere((feature) => feature.id == featureId);
    if (index != -1) _points[index].geometry = Point(coordinates: newPosition);

    await _updateGeoJsonSource();
  }

  Future<void> _updateGeoJsonSource() async {
    await _styleController.updateGeoJsonSource(
      id: 'draggable-source',
      data: jsonEncode(FeatureCollection(features: _points).toJson()),
    );
  }
}

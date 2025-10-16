import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/style_layers_symbol_page.dart';

@immutable
class LayersMarkerPage extends StatefulWidget {
  const LayersMarkerPage({super.key});

  static const location = '/layers/marker';

  @override
  State<LayersMarkerPage> createState() => _LayersMarkerPageState();
}

class _LayersMarkerPageState extends State<LayersMarkerPage> {
  final _points = <Feature<Point>>[
    const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
    const Feature(geometry: Point(Geographic(lon: 9.17, lat: 48))),
    const Feature(geometry: Point(Geographic(lon: 9, lat: 48))),
    const Feature(geometry: Point(Geographic(lon: 9.5, lat: 48))),
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
              // add markers images to map
              final images = <String, Uint8List>{
                'red_pin': await http.readBytes(
                  Uri.parse(StyleLayersSymbolPage.redPinImageUrl),
                ),
                'black_pin': await http.readBytes(
                  Uri.parse(StyleLayersSymbolPage.blackPinImageUrl),
                ),
              };

              await event.style.addImages(images);
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
          // Each point is displayed as a layer of markers due to the
          // randomly generated 'iconImage' property.
          // Do not follow this approach, as it is not efficient.
          // Instead, use a single 'MarkerLayer' with a list of points.
          ..._points.indexed.map(
            (p) {
              return MarkerLayer(
                points: [p.$2],
                textField: 'Marker',
                textAllowOverlap: true,
                iconImage: _imageLoaded
                    ? p.$1.isEven
                          ? 'red_pin'
                          : 'black_pin'
                    : null,
                iconSize: 0.08,
                iconAnchor: IconAnchor.bottom,
                textOffset: const [0, 1],
              );
            },
          ),
        ],
      ),
    );
  }
}

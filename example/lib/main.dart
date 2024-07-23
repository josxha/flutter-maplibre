// ignore_for_file: prefer_single_quotes, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MapLibre Demo',
      home: MyHomePage(),
    );
  }
}

@immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapController _controller;

  final data = {
    "type": "FeatureCollection",
    "features": [
      {
        "type": "Feature",
        // "properties": {},
        "geometry": {
          "coordinates": [
            [
              [9.570030804704544, 47.61463633922685],
              [9.480843256293724, 47.672241812969105],
              [9.327726499163191, 47.68863413494472],
              [9.232866820776195, 47.75728613074429],
              [9.050020668502242, 47.832048274681114],
              [9.004690998277681, 47.80849716551975],
              [9.132521291255188, 47.734252360212196],
              [9.00613066412555, 47.74963207515458],
              [8.96100396895514, 47.754374971146405],
              [8.918799471729244, 47.72937978505783],
              [8.974321577483465, 47.6952900028987],
              [8.902162397192129, 47.66615907983159],
              [8.8360194797431, 47.669795326126064],
              [8.823598733316686, 47.653926669250694],
              [8.91811582992662, 47.629099959084215],
              [9.007037673370888, 47.6603556769127],
              [9.097142093689541, 47.65424981401924],
              [9.199817806710826, 47.63024641380167],
              [9.327187221144726, 47.57345598444377],
              [9.471422735903502, 47.46273744409069],
              [9.560081882751376, 47.469093157582876],
              [9.65108729682919, 47.438666000154825],
              [9.7877547618979, 47.50228193807155],
              [9.757092924438524, 47.54579541163386],
              [9.570030804704544, 47.61463633922685]
            ]
          ],
          "type": "Polygon"
        },
        "style": {"fill": "red", "stroke-width": "3", "fill-opacity": 0.6}
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapLibre Demo'),
      ),
      body: MapLibreMap(
        options: MapOptions(
          zoom: 4,
          center: Position(9, 48),
          controls: const [
            ScaleControl(),
            GeolocateControl(),
            FullscreenControl(),
            LogoControl(),
            NavigationControl(visualizePitch: true),
          ],
        ),
        onMapCreated: (controller) {
          debugPrint('[MapLibreMap] onMapCreated');
          _controller = controller;
        },
        onStyleLoadedCallback: () async {
          debugPrint('[MapLibreMap] onStyleLoadedCallback');
          // final marker = await _controller.addMarker(Marker(point: Position(9, 48)),);
          await Future.delayed(
            const Duration(seconds: 2),
            () async {
              await _controller.addGeoJson(id: 'test1', geoJson: data);
            },
          );
        },
      ),
    );
  }
}

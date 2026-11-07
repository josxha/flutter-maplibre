import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersHoverPage extends StatefulWidget {
  const LayersHoverPage({super.key});

  static const location = '/layers/hover';

  @override
  State<LayersHoverPage> createState() => _LayersHoverPageState();
}

class _LayersHoverPageState extends State<LayersHoverPage> {
  static const _url =
      'https://maplibre.org/maplibre-gl-js/docs/assets/us_states.geojson';
  static const _color = Color(0xFF627BC1);

  /// The polygons of the US states, one per part of a state.
  late final Future<List<Feature<Polygon>>> _states = _loadStates();

  String? _hovered;
  String? _selected;

  static Future<List<Feature<Polygon>>> _loadStates() async {
    final response = await get(Uri.parse(_url));
    return [
      for (final state in FeatureCollection.parse(response.body).features)
        // A layer of polygons takes a feature per polygon, so states of
        // several parts, such as Hawaii, become several features.
        for (final polygon in switch (state.geometry) {
          final Polygon polygon => [polygon],
          final MultiPolygon multi => multi.polygons,
          _ => const <Polygon>[],
        })
          Feature(
            geometry: polygon,
            properties: {'name': state.properties['STATE_NAME']},
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    return Scaffold(
      appBar: AppBar(title: const Text('Hover Features')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              selected == null
                  ? 'Hover over a state with the mouse, or tap one.'
                  : 'Selected $selected.',
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _states,
              builder: (context, snapshot) {
                final states = snapshot.data ?? const <Feature<Polygon>>[];
                return MapLibreMap(
                  options: const MapOptions(
                    initCamera: CameraUpdate.position(
                      zoom: 2,
                      center: Geographic(lon: -100.486052, lat: 37.830348),
                    ),
                  ),
                  layers: [
                    PolygonLayer(
                      polygons: states,
                      color: const .literal(_color),
                      opacity: const .literal(0.5),
                      outlineColor: const .literal(_color),
                      onEnter: (event) =>
                          setState(() => _hovered = _name(states[event.index])),
                      onLeave: (event) => setState(() {
                        if (_hovered == _name(states[event.index])) {
                          _hovered = null;
                        }
                      }),
                      onClick: (event) => setState(
                        () => _selected = _name(states[event.index]),
                      ),
                    ),
                    // Every part of the hovered and the selected state,
                    // drawn opaque.
                    PolygonLayer(
                      polygons: [
                        for (final state in states)
                          if (_name(state) case final name
                              when name == _hovered || name == _selected)
                            state,
                      ],
                      color: const .literal(_color),
                      outlineColor: const .literal(Color(0xFF3A4E8C)),
                    ),
                  ],
                  children: const [SourceAttribution(), MapControlButtons()],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static String? _name(Feature<Polygon> state) =>
      state.properties['name'] as String?;
}

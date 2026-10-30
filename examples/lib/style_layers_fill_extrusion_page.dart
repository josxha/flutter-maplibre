import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

@immutable
class StyleLayersFillExtrusionPage extends StatefulWidget {
  const StyleLayersFillExtrusionPage({super.key});

  static const location = '/style-layers/fill-extrusion';

  @override
  State<StyleLayersFillExtrusionPage> createState() =>
      _StyleLayersFillExtrusionPageState();
}

const _sourceId = 'floorplan';

class _StyleLayersFillExtrusionPageState
    extends State<StyleLayersFillExtrusionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill Extrusion Style Layer')),
      body: MapLibreMap(
        options: MapOptions(
          style: MapStyles.protomapsLight.style,
          initCamera: const InitialCamera.position(
            center: Geographic(lon: -87.61694, lat: 41.86625),
            zoom: 15.99,
            pitch: 40,
            bearing: 20,
          ),
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    await style.sources.add(
      const GeoJsonSource.url(
        id: _sourceId,
        url: 'https://maplibre.org/maplibre-gl-js/docs/assets/indoor-3d-map.geojson',
      ),
    );
    await style.layers.add(_fillExtrusionStyleLayer);
  }
}

final _fillExtrusionStyleLayer = FillExtrusionStyleLayer(
  id: 'room-extrusion',
  sourceId: _sourceId,
  // See the MapLibre Style Specification for details on data expressions.
  // https://maplibre.org/maplibre-style-spec/expressions/

  // Get the color from the source 'color' property.
  color: .get('color').convertToColor(),

  // Get the height from the source 'height' property.
  height: .get('height').asNumber(),

  // Get the base from the source 'base_height' property.
  base: .get('base_height').asNumber(),

  // Make extrusions slightly opaque for see through indoor walls.
  opacity: const .literal(0.5),
);

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';
import 'package:maplibre_example/utils/style_dropdown.dart';

@immutable
class StyledMapPage extends StatefulWidget {
  const StyledMapPage({super.key});

  static const location = '/styled-map';

  @override
  State<StyledMapPage> createState() => _StyledMapPageState();
}

class _StyledMapPageState extends State<StyledMapPage> {
  MapStyles _style = StyleDropdown.initStyle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Styles'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: StyleDropdown(
            // The map loads the new style of its options.
            onChanged: (style) => setState(() => _style = style),
          ),
        ),
      ),
      body: MapLibreMap(
        options: MapOptions(
          style: _style.style,
          initCamera: const InitialCamera.position(
            center: Geographic(lon: 9.17, lat: 47.68),
            zoom: 2,
          ),
        ),
        children: const [MapScalebar(), SourceAttribution(), MapCompass()],
        onStyleLoaded: (style) {
          style.setProjection(MapProjection.globe);
        },
      ),
    );
  }
}

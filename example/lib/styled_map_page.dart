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
  late MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Styles'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: StyleDropdown(
            onChanged: (style) {
              // update the segmented button
              setState(() => _style = style);
              // apply the new style on the map
              _controller.setStyle(style.uri);
            },
          ),
        ),
      ),
      body: MapLibreMap(
        options: MapOptions(
          initCenter: const Geographic(lon: 9.17, lat: 47.68),
          initZoom: 2,
          initStyle: _style.uri,
        ),
        children: const [
          MapScalebar(),
          SourceAttribution(),
          MapControlButtons(showTrackLocation: true),
          MapCompass(),
        ],
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: (style) {
          style.setProjection(MapProjection.globe);
        },
      ),
    );
  }
}

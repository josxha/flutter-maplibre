import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

@immutable
class StyledMapPage extends StatefulWidget {
  const StyledMapPage({super.key});

  static const location = '/styled-map';

  @override
  State<StyledMapPage> createState() => _StyledMapPageState();
}

class _StyledMapPageState extends State<StyledMapPage> {
  static const Map<String, String> _styles = {
    'MapTiler Streets': MapStyles.maptilerStreets,
    'Protomaps Light': MapStyles.protomapsLight,
    'Protomaps Dark': MapStyles.protomapsDark,
  };
  String _styleUrl = _styles.values.first;
  late MapController _controller;

  @override
  Widget build(BuildContext context) {
    final buttonSegments = _styles.entries
        .map((e) => ButtonSegment(value: e.value, label: Text(e.key)))
        .toList(growable: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Styled Map'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
            child: SegmentedButton<String>(
              segments: buttonSegments,
              selected: {_styleUrl},
              onSelectionChanged: (values) {
                // update the segmented button
                setState(() => _styleUrl = values.first);
                // apply the new style on the map
                _controller.setStyle(_styleUrl);
              },
            ),
          ),
        ),
      ),
      body: MapLibreMap(
        acceptLicense: true,
        options: MapOptions(
          initCenter: Position(9.17, 47.68),
          initZoom: 2,
          initStyle: _styleUrl,
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

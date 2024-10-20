import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class WebControlsPage extends StatefulWidget {
  const WebControlsPage({super.key});

  static const location = '/web-controls';

  @override
  State<WebControlsPage> createState() => _WebControlsPageState();
}

class _WebControlsPageState extends State<WebControlsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web Controls')),
      body: MapLibreMap(
        options: MapOptions(
          initZoom: 4,
          initCenter: Position(9.17, 47.68),
          webControls: const [
            WebScaleControl(),
            WebGeolocateControl(),
            WebFullscreenControl(),
            WebLogoControl(),
            WebNavigationControl(visualizePitch: true),
          ],
        ),
      ),
    );
  }
}

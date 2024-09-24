import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class KioskPage extends StatefulWidget {
  const KioskPage({super.key});

  static const location = '/kiosk';

  @override
  State<KioskPage> createState() => _KioskPageState();
}

class _KioskPageState extends State<KioskPage> {
  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  /// Protomaps offers free usage for non commercial projects and affordable
  /// pricing for commercial projects. Alternatively, you can host a tile
  /// server yourself. https://protomaps.com/
  static const _styleUrl =
      'https://api.protomaps.com/styles/v2/light.json?key=a6f9aebb3965458c';

  late final MapController _controller;
  final _locations = <_Location>[
    _Location(Position(5.7056, 21.9137), 2, 0, 0),
    _Location(Position(113.685084, 1.084979), 5, 0, 60),
    _Location(Position(174.7717, -36.8821), 12, -50, 60),
    _Location(Position(172.4714, -42.4862), 6, -100, 40),
  ];
  Timer? _timer;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLibreMap(
        options: MapOptions(style: _styleUrl, center: Position(0, 0)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: () {
          _timer = Timer.periodic(const Duration(seconds: 5), _onTimer);
        },
      ),
    );
  }

  void _onTimer(Timer timer) {
    final location = _locations[index];
    _controller.animateCamera(
      center: location.center,
      zoom: location.zoom,
      bearing: location.bearing,
      tilt: location.tilt,
    );
    index++;
    if (index >= _locations.length) index = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class _Location {
  const _Location(this.center, this.zoom, this.bearing, this.tilt);

  final Position center;
  final double zoom;
  final double bearing;
  final double tilt;
}

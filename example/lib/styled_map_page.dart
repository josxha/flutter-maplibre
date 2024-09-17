
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyledMapPage extends StatefulWidget {
  const StyledMapPage({super.key});

  static const location = '/styled-map';

  @override
  State<StyledMapPage> createState() => _StyledMapPageState();
}

class _StyledMapPageState extends State<StyledMapPage> {
  /// **Use your own key for your project!**
  /// This key will be rotated occasionally.
  /// Protomaps offers free usage for non commercial projects and affordable
  /// pricing for commercial projects. Alternatively, you can host a tile
  /// server yourself. https://protomaps.com/
  static const _styleUrl =
      'https://api.protomaps.com/styles/v2/light.json?key=a6f9aebb3965458c';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Styled Map')),
      body: MapLibreMap(
        options: MapOptions(
            center: Position(9.17, 47.68), zoom: 8, style: _styleUrl),
      ),
    );
  }
}

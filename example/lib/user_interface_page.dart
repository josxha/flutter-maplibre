import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

@immutable
class UserInterfacePage extends StatefulWidget {
  const UserInterfacePage({super.key});

  static const location = '/ui';

  @override
  State<UserInterfacePage> createState() => _UserInterfacePageState();
}

class _UserInterfacePageState extends State<UserInterfacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Interface')),
      body: MapLibreMap(
        acceptLicense: true,
        options: MapOptions(
          initZoom: 3,
          initCenter: Position(9.17, 47.68),
          initStyle: Theme.of(context).brightness == Brightness.light
              ? MapStyles.protomapsLight
              : MapStyles.protomapsDark,
        ),
        children: const [
          MapScalebar(),
          SourceAttribution(),
          MapControlButtons(
            showTrackLocation: true,
          ),
          MapCompass(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:maplibre_example/annotations_page.dart';
import 'package:maplibre_example/callbacks_page.dart';
import 'package:maplibre_example/controller_page.dart';
import 'package:maplibre_example/menu_page.dart';
import 'package:maplibre_example/styled_map_page.dart';
import 'package:maplibre_example/two_maps_page.dart';
import 'package:maplibre_example/web_controls_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapLibre Demo',
      initialRoute: MenuPage.location,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      routes: {
        MenuPage.location: (context) => const MenuPage(),
        StyledMapPage.location: (context) => const StyledMapPage(),
        WebControlsPage.location: (context) => const WebControlsPage(),
        AnnotationsPage.location: (context) => const AnnotationsPage(),
        CallbacksPage.location: (context) => const CallbacksPage(),
        ControllerPage.location: (context) => const ControllerPage(),
        TwoMapsPage.location: (context) => const TwoMapsPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:maplibre_example/annotations.dart';
import 'package:maplibre_example/callbacks.dart';
import 'package:maplibre_example/controls.dart';

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
      initialRoute: CallbacksPage.location,
      routes: {
        ControlsPage.location: (context) => const ControlsPage(),
        AnnotationsPage.location: (context) => const AnnotationsPage(),
        CallbacksPage.location: (context) => const CallbacksPage(),
      },
    );
  }
}

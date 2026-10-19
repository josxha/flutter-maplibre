import 'package:flutter/material.dart';
import 'package:maplibre_native/maplibre_native.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: Scaffold(
      body: MapLibreNativeView(
        styleUrl: 'https://demotiles.maplibre.org/style.json',
      ),
    ),
  );
}

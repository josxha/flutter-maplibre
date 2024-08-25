// ignore_for_file: prefer_single_quotes, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class TwoMapsPage extends StatefulWidget {
  const TwoMapsPage({super.key});

  static const location = '/two-maps';

  @override
  State<TwoMapsPage> createState() => _TwoMapsPageState();
}

class _TwoMapsPageState extends State<TwoMapsPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Two Maps')),
      body: Column(
        children: [
          Expanded(
            child: MapLibreMap(
              options: MapOptions(center: Position(9, 48)),
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(center: Position(9, 48)),
            ),
          ),
        ],
      ),
    );
  }
}

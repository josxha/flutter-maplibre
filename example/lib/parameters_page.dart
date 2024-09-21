import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class ParametersPage extends StatefulWidget {
  const ParametersPage({super.key});

  static const location = '/parameters';

  @override
  State<ParametersPage> createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  double _minZoom = 0;
  double _maxZoom = 22;
  double _minTilt = 0;
  double _maxTilt = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Parameters')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                _SliderWidget(
                  label: 'Zoom',
                  start: _minZoom,
                  end: _maxZoom,
                  max: 24,
                  onChanged: (range) => setState(() {
                    _minZoom = range.start;
                    _maxZoom = range.end;
                  }),
                ),
                _SliderWidget(
                  label: 'Tilt',
                  start: _minTilt,
                  end: _maxTilt,
                  max: 85,
                  onChanged: (range) => setState(() {
                    _minTilt = range.start;
                    _maxTilt = range.end;
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                center: Position(0, 0),
                minZoom: _minZoom,
                maxZoom: _maxZoom,
                minTilt: _minTilt,
                maxTilt: _maxTilt,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderWidget extends StatelessWidget {
  const _SliderWidget({
    required this.onChanged,
    required this.start,
    required this.end,
    required this.max,
    required this.label,
    this.min = 0,
  });

  final ValueChanged<RangeValues> onChanged;
  final double start;
  final double end;
  final double min;
  final double max;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Row(
        children: [
          Text(label),
          Expanded(
            child: RangeSlider(
              values: RangeValues(start, end),
              min: min,
              max: max,
              divisions: (max - min).toInt() + 1,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

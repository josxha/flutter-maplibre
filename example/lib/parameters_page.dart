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
  double _minPitch = 0;
  double _maxPitch = 60;
  LngLatBounds _lngLatBounds = const LngLatBounds(
    longitudeWest: -180,
    longitudeEast: 179,
    latitudeSouth: -90,
    latitudeNorth: 90,
  );

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
                  max: 22,
                  onChanged: (range) => setState(() {
                    _minZoom = range.start;
                    _maxZoom = range.end;
                  }),
                ),
                _SliderWidget(
                  label: 'Pitch',
                  start: _minPitch,
                  end: _maxPitch,
                  max: 85,
                  onChanged: (range) => setState(() {
                    _minPitch = range.start;
                    _maxPitch = range.end;
                  }),
                ),
                _SliderWidget(
                  label: 'Longitude',
                  start: _lngLatBounds.longitudeWest,
                  end: _lngLatBounds.longitudeEast,
                  min: -180,
                  max: 179,
                  onChanged: (range) => setState(() {
                    _lngLatBounds = _lngLatBounds.copyWith(
                      longitudeWest: range.start,
                      longitudeEast: range.end,
                    );
                  }),
                ),
                _SliderWidget(
                  label: 'Latitude',
                  start: _lngLatBounds.latitudeSouth,
                  end: _lngLatBounds.latitudeNorth,
                  min: -90,
                  max: 90,
                  onChanged: (range) => setState(() {
                    _lngLatBounds = _lngLatBounds.copyWith(
                      latitudeSouth: range.start,
                      latitudeNorth: range.end,
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(
                initCenter: Position(0, 0),
                initZoom: 3,
                minZoom: _minZoom,
                maxZoom: _maxZoom,
                minPitch: _minPitch,
                maxPitch: _maxPitch,
                maxBounds: _lngLatBounds,
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
              labels: RangeLabels(
                start.round().toString(),
                end.round().toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

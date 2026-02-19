import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  runApp(MaterialApp(
    builder: (context, child) => _createTestWidget(context),
  ));
}

const Geographic _point1 = Geographic(lat: 43.8, lon: 7.1);
const Geographic _point2 = Geographic(lat: 43.6, lon: 7.0);
const double _padding = 400;
late MapController _mapController;
int _control = 0;

Widget _createTestWidget(final BuildContext context) {
  return Stack(
    children: [
      MapLibreMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onEvent: (event) {
          if (event is MapEventClick) {
            if (_control == 0) { // first click will fit bounds so both points fit on the entire screen
              _mapController.fitBounds(bounds: LngLatBounds.fromPoints([_point1, _point2]), nativeDuration: Durations.medium2);
            } else if (_control == 1) { // second click will center camera on screen center (green circle)
              _mapController.moveCamera(center: _point2, zoom: 11);
            } else if (_control == 2) { // third click will fit bounds so both points fit on the padded region (red rectangle)
              _mapController.fitBounds(bounds: LngLatBounds.fromPoints([_point1, _point2]), nativeDuration: Durations.medium2, padding: EdgeInsets.only(bottom: _padding));
            } else if (_control == 3) { // fourth click should center camera on screen center (green circle), but actually centers camera on padded region (red rectangle)
              _mapController.moveCamera(center: _point2, zoom: 11);
            }
            _control = (_control + 1) % 4;
          }
        },
        options: const MapOptions(
          initCenter: _point2,
          initZoom: 11,
          minZoom: 8,
          maxZoom: 14,
          gestures: MapGestures.none(pan: true, zoom: true),
        ),
        layers: const [
          CircleLayer(
            points: [
              Feature(geometry: Point(_point1)),
              Feature(geometry: Point(_point2)),
            ],
            color: Colors.black,
            radius: 20,
          ),
        ],
      ),
      const IgnorePointer(
        child: Padding(
          padding: EdgeInsetsGeometry.only(bottom: _padding),
          child: DecoratedBox(
            decoration: BoxDecoration(border: Border.fromBorderSide(BorderSide(width: 3, color: Colors.red))),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 20,
                height: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      const Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 20,
          height: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    ],
  );
}
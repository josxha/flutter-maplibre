import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/expressions.dart';

import '../../apps/blank_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Background Style Layer', () {
    testWidgets('default values', (tester) async {
      await tester.pumpWidget(const BlankApp());
      await tester.pumpAndSettle();
      _testLayer();
    });
    testWidgets('custom values', (tester) async {
      await tester.pumpWidget(const BlankApp());
      await tester.pumpAndSettle();
      _testLayer(
        visible: false,
        color: const PropertyValue.value(Colors.red),
        opacity: const PropertyValue.value(0.5),
        pattern: const PropertyValue.value('pattern'),
        minZoom: 1,
        maxZoom: 10,
      );
    });
    testWidgets('custom expressions', (tester) async {
      await tester.pumpWidget(const BlankApp());
      await tester.pumpAndSettle();
      _testLayer(
        visible: false,
        color: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: [0, 10],
            stopOutputs: [Colors.red, Colors.blue],
          ),
        ),
        opacity: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const [0.5, 1.0],
          ),
        ),
        pattern: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const ['pattern1', 'pattern2'],
          ),
        ),
        minZoom: 1,
        maxZoom: 10,
      );
    });
  });
}

void _testLayer({
  String id = 'Layer ID 123',
  bool visible = StyleLayer.defaultVisible,
  PropertyValue<Color> color = BackgroundStyleLayer.defaultColor,
  PropertyValue<String>? pattern,
  PropertyValue<double> opacity = BackgroundStyleLayer.defaultOpacity,
  double minZoom = StyleLayer.defaultMinZoom,
  double maxZoom = StyleLayer.defaultMaxZoom,
}) {
  final layer = BackgroundStyleLayer(
    id: id,
    minZoom: minZoom,
    maxZoom: maxZoom,
    visible: visible,
    color: color,
    opacity: opacity,
    pattern: pattern,
  );
  expect(layer.id, equals(id));
  expect(layer.visible, equals(visible));
  expect(layer.minZoom, equals(minZoom));
  expect(layer.maxZoom, equals(maxZoom));
  expect(layer.pattern, equals(pattern));
  expect(layer.color, equals(color));
  expect(layer.opacity, equals(opacity));
}

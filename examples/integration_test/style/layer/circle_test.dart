import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import '../../apps/blank_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Circle Style Layer', () {
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
        color: PropertyValue.value(Colors.red.shade500),
        opacity: const PropertyValue.value(0.5),
        minZoom: 1,
        maxZoom: 10,
        translate: const PropertyValue.value(Offset(10, 20)),
        translateAnchor: const PropertyValue.value(.viewport),
        sortKey: const PropertyValue.value(3.5),
        radius: const PropertyValue.value(6.5),
        blur: const PropertyValue.value(0.5),
        pitchScale: const PropertyValue.value(.viewport),
        pitchAlignment: const PropertyValue.value(.map),
        strokeWidth: const PropertyValue.value(1.5),
        strokeColor: PropertyValue.value(Colors.blue.shade500),
        strokeOpacity: const PropertyValue.value(0.8),
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
            stopOutputs: ['#FF0000', '#0000FF'],
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
        minZoom: 1,
        maxZoom: 10,
        translate: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const [
              [0, 0],
              [10, 20],
            ],
          ),
        ),
        translateAnchor: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const ['map', 'viewport'],
          ),
        ),
        sortKey: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const [0.0, 5.0],
          ),
        ),
        radius: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const [1.0, 10.0],
          ),
        ),
        blur: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const [0.0, 1.0],
          ),
        ),
        pitchScale: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const <ReferenceSpace>[.map, .viewport],
          ),
        ),
        pitchAlignment: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const <ReferenceSpace>[.map, .viewport],
          ),
        ),
        strokeWidth: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const [0.0, 5.0],
          ),
        ),
        strokeColor: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: [Colors.red.shade500, Colors.blue.shade500],
          ),
        ),
        strokeOpacity: PropertyValue.expression(
          Expression.interpolate(
            type: InterpolationType.linear(),
            input: Expression.zoom(),
            stopInputs: const [0, 10],
            stopOutputs: const [0.0, 1.0],
          ),
        ),
        filter: Expression.all([
          Expression.equal(Expression.get('property1'), 'value1'),
        ]),
      );
    });
  });
}

void _testLayer({
  String id = 'Layer ID 123',
  String sourceId = 'Source ID 123',
  String? sourceLayerId,
  Expression? filter,
  bool visible = StyleLayer.defaultVisible,
  double minZoom = StyleLayer.defaultMinZoom,
  double maxZoom = StyleLayer.defaultMaxZoom,
  PropertyValue<Offset> translate = StyleLayerWithTranslate.defaultTranslate,
  PropertyValue<ReferenceSpace> translateAnchor =
      StyleLayerWithTranslate.defaultTranslateAnchor,
  PropertyValue<double>? sortKey,
  PropertyValue<double> radius = CircleStyleLayer.defaultRadius,
  PropertyValue<Color> color = CircleStyleLayer.defaultColor,
  PropertyValue<double> blur = CircleStyleLayer.defaultBlur,
  PropertyValue<double> opacity = CircleStyleLayer.defaultOpacity,
  PropertyValue<ReferenceSpace> pitchScale = CircleStyleLayer.defaultPitchScale,
  PropertyValue<ReferenceSpace> pitchAlignment =
      CircleStyleLayer.defaultPitchAlignment,
  PropertyValue<double> strokeWidth = CircleStyleLayer.defaultStrokeWidth,
  PropertyValue<Color> strokeColor = CircleStyleLayer.defaultStrokeColor,
  PropertyValue<double> strokeOpacity = CircleStyleLayer.defaultStrokeOpacity,
}) {
  final layer = CircleStyleLayer(
    id: id,
    sourceId: sourceId,
    sourceLayerId: sourceLayerId,
    filter: filter,
    visible: visible,
    minZoom: minZoom,
    maxZoom: maxZoom,
    translate: translate,
    translateAnchor: translateAnchor,
    sortKey: sortKey,
    radius: radius,
    color: color,
    blur: blur,
    opacity: opacity,
    pitchScale: pitchScale,
    pitchAlignment: pitchAlignment,
    strokeWidth: strokeWidth,
    strokeColor: strokeColor,
    strokeOpacity: strokeOpacity,
  );
  expect(layer.id, equals(id));
  expect(layer.sourceId, equals(sourceId));
  expect(layer.sourceLayerId, equals(sourceLayerId));
  expect(layer.filter, equals(filter));
  expect(layer.visible, equals(visible));
  expect(layer.minZoom, equals(minZoom));
  expect(layer.maxZoom, equals(maxZoom));
  expect(layer.translate, equals(translate));
  expect(layer.translateAnchor, equals(translateAnchor));
  expect(layer.sortKey, equals(sortKey));
  expect(layer.radius, equals(radius));
  expect(layer.color, equals(color));
  expect(layer.blur, equals(blur));
  expect(layer.opacity, equals(opacity));
  expect(layer.pitchScale, equals(pitchScale));
  expect(layer.pitchAlignment, equals(pitchAlignment));
  expect(layer.strokeWidth, equals(strokeWidth));
  expect(layer.strokeColor, equals(strokeColor));
  expect(layer.strokeOpacity, matchesPropertyValue(strokeOpacity));
}

/// Returns a [Matcher] which matches if the match argument is a
/// [PropertyValue].
Matcher matchesPropertyValue(PropertyValue property) =>
    _MatchesPropertyValue(property);

class _MatchesPropertyValue extends TypeMatcher<PropertyValue> {
  const _MatchesPropertyValue(this._property);

  final PropertyValue _property;

  @override
  bool matches(Object? item, Map<dynamic, dynamic> matchState) {
    if (item is! PropertyValue) return false;
    if (_property.isExpression) {
      return item.isExpression && item.expression == _property.expression;
    } else {
      if (item.isExpression) return false;
      switch (_property.value) {
        case final num value:
          final itemValue = item.value;
          if (itemValue is! num) return false;
          return (itemValue - value).abs() < 0.0001;
        default:
          return item.value == _property.value;
      }
    }
  }
}

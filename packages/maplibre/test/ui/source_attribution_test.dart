import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

MapCamera _camera(double zoom) => MapCamera(
  center: const Geographic(lon: 0, lat: 0),
  zoom: zoom,
  bearing: 0,
  pitch: 0,
);

void main() {
  group('SourceAttribution', () {
    late MockMapController controller;

    setUp(() {
      controller = MockMapController();
      final style = MockStyleController();
      when(() => controller.style).thenReturn(style);
      when(style.getAttributionsSync).thenReturn([
        'Plain Source',
        '<a href="https://maplibre.org">Linked Source</a>',
      ]);
    });

    Future<void> pump(
      WidgetTester tester, {
      double zoom = 5,
      SourceAttribution attribution = const SourceAttribution(),
    }) => tester.pumpWidget(
      App(
        camera: _camera(zoom),
        controller: controller,
        children: [attribution],
      ),
    );

    Finder text(String text) => find.textContaining(text, findRichText: true);

    testWidgets('lists MapLibre and the attributions of the style', (
      tester,
    ) async {
      await pump(tester);
      expect(text('MapLibre'), findsOneWidget);
      expect(text('Plain Source'), findsOneWidget);
      expect(text('Linked Source'), findsOneWidget);
      expect(text('<a'), findsNothing);
    });

    testWidgets('can leave out MapLibre', (tester) async {
      await pump(
        tester,
        attribution: const SourceAttribution(showMapLibre: false),
      );
      expect(text('MapLibre'), findsNothing);
      expect(text('Plain Source'), findsOneWidget);
    });

    testWidgets('collapses once the camera moves', (tester) async {
      await pump(tester);
      expect(text('Plain Source'), findsOneWidget);
      await pump(tester, zoom: 6);
      expect(text('Plain Source'), findsNothing);
      await tester.tap(find.byIcon(Icons.info));
      await tester.pump();
      expect(text('Plain Source'), findsOneWidget);
    });

    testWidgets('can stay expanded', (tester) async {
      const attribution = SourceAttribution(keepExpanded: true);
      await pump(tester, attribution: attribution);
      await pump(tester, zoom: 6, attribution: attribution);
      expect(text('Plain Source'), findsOneWidget);
    });

    testWidgets('the info button toggles the attributions', (tester) async {
      await pump(tester);
      await tester.tap(find.byIcon(Icons.info));
      await tester.pump();
      expect(text('Plain Source'), findsNothing);
      await tester.tap(find.byIcon(Icons.info));
      await tester.pump();
      expect(text('Plain Source'), findsOneWidget);
    });

    testWidgets('is placed by its alignment and padding', (tester) async {
      await pump(
        tester,
        attribution: const SourceAttribution(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(7),
        ),
      );
      final box = find.descendant(
        of: find.byType(SourceAttribution),
        matching: find.byType(DecoratedBox),
      );
      expect(tester.getTopLeft(box.first), const Offset(7, 7));
    });
  });
}

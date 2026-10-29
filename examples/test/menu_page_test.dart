import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_example/menu_page.dart';

void main() {
  // A window can be laid out at width 0, e.g. while Windows minimizes it.
  for (final size in const [Size(0, 600), Size(800, 0), Size.zero]) {
    testWidgets('the menu lays out at $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MaterialApp(home: MenuPage()));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the menu shows its pages', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MenuPage()));
    expect(find.text('Map Styles'), findsOneWidget);
  });
}

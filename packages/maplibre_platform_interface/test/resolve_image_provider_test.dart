import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

void main() {
  group('resolveImageProvider', () {
    testWidgets('loads the image of a provider', (tester) async {
      final image = await tester.runAsync(() async {
        return resolveImageProvider(MemoryImage(await _png(3, 2)));
      });
      expect(image!.width, 3);
      expect(image.height, 2);
      image.dispose();
    });

    testWidgets('fails for an image that cannot be decoded', (tester) async {
      final error = await tester.runAsync(() async {
        try {
          await resolveImageProvider(MemoryImage(Uint8List.fromList([1, 2])));
        } on Object catch (error) {
          return error;
        }
        return null;
      });
      expect(error, isNotNull);
    });
  });

  test('ImageSource constructors create their variants', () {
    const quad = LngLatQuad(
      bottomLeft: Geographic(lon: 0, lat: 0),
      bottomRight: Geographic(lon: 1, lat: 0),
      topLeft: Geographic(lon: 0, lat: 1),
      topRight: Geographic(lon: 1, lat: 1),
    );
    final sources = [
      const ImageSource.url(id: 'u', url: 'https://x/a.png', coordinates: quad),
      ImageSource.bytes(id: 'b', bytes: Uint8List(0), coordinates: quad),
      const ImageSource.provider(
        id: 'p',
        image: AssetImage('a.png'),
        coordinates: quad,
      ),
    ];
    expect(
      sources.map(
        (source) => switch (source) {
          ImageSourceUrl() => 'url',
          ImageSourceBytes() => 'bytes',
          ImageSourceProvider() => 'provider',
        },
      ),
      ['url', 'bytes', 'provider'],
    );
    expect(sources.map((source) => source.coordinates), everyElement(quad));
  });
}

Future<Uint8List> _png(int width, int height) async {
  final recorder = ui.PictureRecorder();
  ui.Canvas(recorder).drawRect(
    ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    ui.Paint()..color = const ui.Color(0xFFFF0000),
  );
  final image = await recorder.endRecording().toImage(width, height);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return data!.buffer.asUint8List();
}

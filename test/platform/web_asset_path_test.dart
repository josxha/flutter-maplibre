import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Web Asset Path Conversion', () {
    test('should convert asset paths to web-compatible paths', () {
      // This is a simple test to verify our conversion logic
      // Note: We can't easily test the actual MapLibreMapStateWeb class
      // since it depends on web-specific APIs, but we can test the logic

      String convertAssetPathForWeb(String style) {
        if (style.startsWith('assets/')) {
          return 'assets/$style';
        }
        return style;
      }

      // Test cases
      expect(
        convertAssetPathForWeb('assets/styles/protomaps-light.json'),
        equals('assets/assets/styles/protomaps-light.json'),
      );

      expect(
        convertAssetPathForWeb('assets/styles/style.json'),
        equals('assets/assets/styles/style.json'),
      );

      expect(
        convertAssetPathForWeb('https://example.com/style.json'),
        equals('https://example.com/style.json'),
      );

      expect(
        convertAssetPathForWeb('mapbox://styles/mapbox/streets-v11'),
        equals('mapbox://styles/mapbox/streets-v11'),
      );

      expect(
        convertAssetPathForWeb('some-other-path/style.json'),
        equals('some-other-path/style.json'),
      );
    });

    test('should handle edge cases', () {
      String convertAssetPathForWeb(String style) {
        if (style.startsWith('assets/')) {
          return 'assets/$style';
        }
        return style;
      }

      expect(
        convertAssetPathForWeb('assets/'),
        equals('assets/assets/'),
      );

      expect(
        convertAssetPathForWeb(''),
        equals(''),
      );

      expect(
        convertAssetPathForWeb('assets'),
        equals('assets'),
      );
    });
  });
}

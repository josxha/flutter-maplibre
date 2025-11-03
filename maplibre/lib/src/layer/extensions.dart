import 'dart:ui';

/// Extension methods on [Color].
extension ColorExtension on Color {
  /// Convert the [Color] object to an hex string without an optional opacity.
  String toHexString({bool hashSign = true, bool alpha = false}) {
    final alphaStr = (a * 255).toInt().toRadixString(16).padLeft(2, '0');
    final redStr = (r * 255).toInt().toRadixString(16).padLeft(2, '0');
    final greenStr = (g * 255).toInt().toRadixString(16).padLeft(2, '0');
    final blueStr = (b * 255).toInt().toRadixString(16).padLeft(2, '0');

    return '${hashSign ? '#' : ''}'
            '${alpha ? alphaStr : ''}'
            '$redStr$greenStr$blueStr'
        .toUpperCase();
  }
}

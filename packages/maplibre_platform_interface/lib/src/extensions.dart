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

/// Extension methods on [String].
extension StringExtension on String {
  /// Convert the hex string to a [Color] object.
  Color? toColor() {
    final regex = RegExp(
      r'rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d*\.?\d+))?\)',
    );
    final match = regex.firstMatch(this);
    if (match == null) return null;
    final r = int.parse(match.group(1)!);
    final g = int.parse(match.group(2)!);
    final b = int.parse(match.group(3)!);
    final a = match.group(4) != null
        ? (double.parse(match.group(4)!) * 255).round()
        : 255;
    return Color.fromARGB(a, r, g, b);
  }
}

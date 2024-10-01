import 'dart:ui';

/// Extension methods on [Color].
extension ColorExt on Color {
  /// Convert the [Color] object to an hex string without the opacity.
  String toHexStringNoOpacity() => '#${value.toRadixString(16).substring(2)}';
}

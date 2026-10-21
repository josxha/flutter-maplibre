import 'package:maplibre_platform_interface/src/platform_interface.dart';

/// Configures request headers added to MapLibre resource requests.
///
/// Headers are global to the MapLibre SDK process and scoped to one exact
/// request host. Callers should await updates before creating a map or changing
/// its style. Calling [setHeaders] again replaces all headers for that host,
/// which makes this API suitable for rotating short-lived tokens.
///
/// Android applies that host scope again on each redirect hop, and removes
/// these header names when the new host has none configured. iOS and web see
/// the request before it is sent. MapLibre Native's network delegate and
/// MapLibre GL JS `transformRequest` cannot change a redirect those platforms
/// follow afterwards.
abstract final class MapLibreRequestHeaders {
  /// Replaces the headers for [host].
  ///
  /// [host] must contain only a hostname or IP address, without a scheme, port,
  /// path, query, or fragment. International names must use their punycode
  /// form, such as `xn--mnchen-3ya.de`, because Android matches that ASCII
  /// host. Host matching is case-insensitive and does not include subdomains.
  /// An empty [headers] map has the same effect as [clearHeaders].
  static Future<void> setHeaders(String host, Map<String, String> headers) {
    final normalizedHost = _normalizeHost(host);
    final validatedHeaders = Map<String, String>.unmodifiable(
      headers.map((name, value) {
        _validateHeader(name, value);
        return MapEntry(name, value);
      }),
    );
    return MapLibrePlatform.instance.setRequestHeaders(
      normalizedHost,
      validatedHeaders,
    );
  }

  /// Clears all configured headers for [host].
  static Future<void> clearHeaders(String host) =>
      MapLibrePlatform.instance.clearRequestHeaders(_normalizeHost(host));

  static String _normalizeHost(String host) {
    final value = host.trim();
    final isBracketedIpv6 =
        value.startsWith('[') &&
        value.endsWith(']') &&
        value.substring(1, value.length - 1).contains(':');
    final containsPort = !isBracketedIpv6 && value.contains(':');
    final uri = Uri.tryParse('https://$value');
    if (value.isEmpty ||
        containsPort ||
        uri == null ||
        uri.host.isEmpty ||
        uri.hasPort ||
        uri.userInfo.isNotEmpty ||
        uri.path.isNotEmpty ||
        uri.hasQuery ||
        uri.hasFragment) {
      throw ArgumentError.value(host, 'host', 'Must be an exact host only.');
    }
    final normalizedHost = uri.host.toLowerCase();
    if (normalizedHost.contains('%')) {
      throw ArgumentError.value(
        host,
        'host',
        'Must be an ASCII host. Use punycode for international names.',
      );
    }
    return normalizedHost;
  }

  static void _validateHeader(String name, String value) {
    final validName = name.isNotEmpty && _headerName.hasMatch(name);
    final validValue = value.codeUnits.every(
      (codeUnit) => codeUnit == 0x09 || (codeUnit >= 0x20 && codeUnit <= 0x7E),
    );
    if (!validName) {
      throw ArgumentError.value(name, 'headers', 'Invalid header name.');
    }
    if (!validValue) {
      throw ArgumentError.value(value, 'headers', 'Invalid header value.');
    }
  }

  static final RegExp _headerName = RegExp(r"^[!#$%&'*+\-.^_`|~0-9A-Za-z]+$");
}

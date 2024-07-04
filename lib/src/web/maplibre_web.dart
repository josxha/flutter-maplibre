// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:ui_web';

import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:maplibre/src/maplibre_platform_interface.dart';
import 'package:web/web.dart' as web;

typedef OnPlatformViewCreated = void Function(int viewId);

/// A web implementation of the MaplibrePlatform of the Maplibre plugin.
class MapLibreWeb extends MapLibrePlatform {
  /// Constructs a MapLibreWeb
  MapLibreWeb();

  late web.HTMLDivElement _htmlElement;

  static void registerWith(Registrar registrar) {
    MapLibrePlatform.instance = MapLibreWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = web.window.navigator.userAgent;
    return version;
  }

  @override
  Widget buildWidget() {
    _registerViewFactory(hashCode);
    return HtmlElementView(viewType: 'plugins.flutter.io/maplibre_$hashCode');
  }

  void _registerViewFactory(int identifier) {
    platformViewRegistry.registerViewFactory(
      'plugins.flutter.io/maplibre_$identifier',
      (int viewId) {
        return _htmlElement = web.HTMLDivElement()
          ..style.position = 'absolute'
          ..style.top = '0'
          ..style.bottom = '0'
          ..style.height = '100%'
          ..style.width = '100%';
      },
    );
  }
}

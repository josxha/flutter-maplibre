import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/foundation.dart';
import 'package:maplibre_web/src/interop/interop.dart' as interop;
import 'package:maplibre_web/src/interop/pmtiles.dart' as pmtiles;
import 'package:web/web.dart';

/// The maplibre-gl-js version that is loaded if the app doesn't name one.
///
/// An npm version range, so that apps get the fixes of every v6 release but
/// never a major version with breaking changes.
const defaultMapLibreGlVersion = '^6.0.0';

/// The PMTiles version that is loaded if the app doesn't name one.
const defaultPmtilesVersion = '^4.0.0';

/// The CDN that serves npm packages and resolves npm version ranges.
const _cdn = 'https://cdn.jsdelivr.net/npm';

/// The major version of maplibre-gl-js that maplibre_web supports.
const _supportedMajorVersion = 6;

const _setupDocs =
    'https://flutter-maplibre.pages.dev/docs/getting-started/setup#setup-web';

Future<void>? _loading;

/// Whether [loadMapLibreGlJs] completed, so that maps can be created at once.
bool get isMapLibreGlJsLoaded => _loaded;
var _loaded = false;

/// Loads maplibre-gl-js and PMTiles, unless `web/index.html` already loaded
/// them, and adds the `pmtiles://` protocol.
///
/// The app can choose what is loaded with a `window.flutterMapLibre` object:
///
/// - `maplibreGlVersion`: an npm version or version range of maplibre-gl-js,
///   [defaultMapLibreGlVersion] if not set.
/// - `maplibreGlBaseUrl`: the URL of the folder that holds `maplibre-gl.mjs`
///   and `maplibre-gl.css`, instead of the CDN. Takes precedence over
///   `maplibreGlVersion`.
/// - `pmtilesVersion`: an npm version or version range of PMTiles,
///   [defaultPmtilesVersion] if not set.
/// - `pmtilesBaseUrl`: the URL of the folder that holds `pmtiles.js`, instead
///   of the CDN. Takes precedence over `pmtilesVersion`.
///
/// Every map waits for the same load. A failed load is tried again by the
/// next map.
Future<void> loadMapLibreGlJs() =>
    _loading ??= _load().catchError((Object error, StackTrace stackTrace) {
      _loading = null;
      Error.throwWithStackTrace(error, stackTrace);
    });

Future<void> _load() async {
  // Both load at the same time, and a failure of maplibre-gl-js is reported
  // as it is.
  final pmtilesLoaded = _loadPmtiles();
  await _loadMapLibreGl();
  if (await pmtilesLoaded) {
    try {
      interop.addProtocol('pmtiles', pmtiles.Protocol().tile);
    } catch (e) {
      debugPrint('[MapLibre] PMTiles support could not be added. $e');
    }
  }
  _loaded = true;
}

Future<void> _loadMapLibreGl() async {
  if (!globalContext.has('maplibregl')) {
    final baseUrl =
        _option('maplibreGlBaseUrl') ??
        _cdnUrl(
          'maplibre-gl',
          _option('maplibreGlVersion'),
          defaultMapLibreGlVersion,
        );
    final moduleUrl = '${_folder(baseUrl)}maplibre-gl.mjs';
    final stylesheet = _addStylesheet('${_folder(baseUrl)}maplibre-gl.css');
    final JSObject module;
    try {
      module = await importModule(moduleUrl.toJS).toDart;
    } catch (e) {
      throw StateError(
        '[MapLibre] maplibre-gl-js could not be loaded from $moduleUrl. '
        '$e\nSet maplibreGlVersion or maplibreGlBaseUrl of '
        'window.flutterMapLibre in web/index.html to load another version, '
        'or load maplibre-gl-js there yourself. See $_setupDocs',
      );
    }
    await stylesheet;
    globalContext['maplibregl'] = module;
  }
  final version = interop.getVersion();
  final major = int.tryParse(version.split('.').first);
  if (major != _supportedMajorVersion) {
    debugPrint(
      '[MapLibre] maplibre-gl-js $version is loaded, but maplibre_web '
      'supports only v$_supportedMajorVersion.',
    );
  }
}

/// Loads PMTiles, and returns whether it is available.
Future<bool> _loadPmtiles() async {
  if (globalContext.has('pmtiles')) return true;
  final baseUrl =
      _option('pmtilesBaseUrl') ??
      _cdnUrl('pmtiles', _option('pmtilesVersion'), defaultPmtilesVersion);
  final scriptUrl = '${_folder(baseUrl)}pmtiles.js';
  final script = HTMLScriptElement()..src = scriptUrl;
  final loaded = _onLoad(script);
  document.head!.appendChild(script);
  if (await loaded) return true;
  debugPrint('[MapLibre] PMTiles could not be loaded from $scriptUrl.');
  return false;
}

Future<void> _addStylesheet(String url) async {
  final link = HTMLLinkElement()
    ..rel = 'stylesheet'
    ..href = url;
  final loaded = _onLoad(link);
  document.head!.appendChild(link);
  if (!await loaded) {
    debugPrint(
      '[MapLibre] The maplibre-gl-js CSS could not be loaded from $url.',
    );
  }
}

/// Completes with true once [element] loaded, or with false if it failed.
Future<bool> _onLoad(HTMLElement element) {
  final completer = Completer<bool>();
  element
    ..onload = ((Event _) => completer.complete(true)).toJS
    ..onerror = ((Event _) => completer.complete(false)).toJS;
  return completer.future;
}

String _cdnUrl(String package, String? version, String defaultVersion) =>
    '$_cdn/$package@${Uri.encodeComponent(version ?? defaultVersion)}/dist/';

/// The absolute URL of the folder [url], which may be relative to the page.
String _folder(String url) =>
    URL(url.endsWith('/') ? url : '$url/', document.baseURI).href;

/// A string option of `window.flutterMapLibre`, or null if it isn't set.
String? _option(String name) {
  final options = globalContext['flutterMapLibre'];
  if (options == null || !options.isA<JSObject>()) return null;
  final value = (options as JSObject)[name];
  if (value == null || value.isUndefinedOrNull) return null;
  final string = value.dartify().toString().trim();
  return string.isEmpty ? null : string;
}

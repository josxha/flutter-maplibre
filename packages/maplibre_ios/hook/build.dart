import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

/// Compare two dotted version strings ("6.25.1" vs "6.25.0"). Positive if a > b.
int _cmpVersion(String a, String b) {
  final aParts = a.split('.').map(int.parse).toList();
  final bParts = b.split('.').map(int.parse).toList();
  for (var i = 0; i < aParts.length && i < bParts.length; i++) {
    if (aParts[i] != bParts[i]) return aParts[i] - bParts[i];
  }
  return aParts.length - bParts.length;
}

/// Scan the SwiftPM artifacts cache for an already-downloaded MapLibre
/// xcframework zip and return its version (or null when none found). SPM
/// names the cache entry after the URL with `:/.` → `_`, e.g.:
/// `https___github_com_maplibre_maplibre-native_releases_download_ios_v6_25_1_MapLibre_dynamic_xcframework_zip`.
String? _scanSpmCacheForMapLibreVersion() {
  final homeDir = Platform.environment['HOME'];
  if (homeDir == null || homeDir.isEmpty) return null;
  final cacheDir = Directory.fromUri(
    Uri.directory(homeDir).resolve('Library/Caches/org.swift.swiftpm/artifacts/'),
  );
  if (!cacheDir.existsSync()) return null;
  final pattern = RegExp(
    'maplibre.native_releases_download_ios_v'
    '([0-9]+_[0-9]+_[0-9]+)'
    '_MapLibre_dynamic_xcframework_zip',
  );
  String? best;
  for (final entry in cacheDir.listSync(followLinks: false)) {
    final name = entry.uri.pathSegments.where((s) => s.isNotEmpty).last;
    final m = pattern.firstMatch(name);
    if (m != null) {
      final v = m.group(1)!.replaceAll('_', '.');
      if (best == null || _cmpVersion(v, best) > 0) best = v;
    }
  }
  return best;
}

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;
    if (input.config.code.targetOS != OS.iOS) return;
    if (input.config.code.linkModePreference == LinkModePreference.static) {
      throw UnsupportedError('Static linking not supported.');
    }

    final frameworkPath = await _getMapLibreFrameworkPath(
      packageRoot: input.packageRoot,
      useSimulator: input.config.code.iOS.targetSdk == IOSSdk.iPhoneSimulator,
    );
    final headersDir = frameworkPath.resolve('MapLibre.framework/Headers');
    final builder = CBuilder.library(
      name: 'maplibre_ffi',
      assetName: 'src/maplibre_ffi.g.dart',
      sources: ['lib/src/maplibre_ffi.g.dart.m'],
      language: Language.objectiveC,
      includes: [headersDir.toFilePath()],
      // ARC is required by generated bindings; -F points clang at the xcframework slice.
      flags: ['-fobjc-arc', '-F${frameworkPath.toFilePath()}'],
      frameworks: ['Foundation', 'MapLibre'],
    );

    await builder.run(input: input, output: output);
  });
}

Future<Uri> _getMapLibreFrameworkPath({
  required Uri packageRoot,
  required bool useSimulator,
}) async {
  // Detect the MapLibre version. Preferred source: the app's `Package.resolved`
  // (it pins the exact version Swift Package Manager resolved). Fallbacks
  // ensure the hook still works in transient states where Flutter's iOS
  // pipeline has temporarily emptied that file -- which happens when
  // `FlutterGeneratedPluginSwiftPackage` declares no SPM dependencies and
  // `xcodebuild -resolvePackageDependencies` clears `xcshareddata`. In that
  // case we look at the SwiftPM artifact cache (highest cached version wins),
  // then fall back to the lower bound pinned in this package's own
  // `Package.swift`. The fallbacks are diagnostic-friendly: the original
  // exception is preserved as the cause when all paths fail.
  String? version;
  Object? lookupError;
  try {
    final resolvedSpmPackage = _getResolvedSpmPackagePath();
    final content = File(resolvedSpmPackage).readAsStringSync();
    final match = RegExp(
      r'"identity"\s*:\s*"maplibre-gl-native-distribution"[\s\S]*?"version"\s*:\s*"([0-9.]+)"',
    ).firstMatch(content);
    if (match != null && match.group(1) != null && match.group(1)!.isNotEmpty) {
      version = match.group(1);
    }
  } catch (err) {
    lookupError = err;
  }

  // Fallback 1: already-downloaded MapLibre framework zip in the SwiftPM cache.
  version ??= _scanSpmCacheForMapLibreVersion();

  // Fallback 2: parse this package's own Package.swift lower bound.
  if (version == null) {
    final ownPackageSwift = packageRoot.resolve('ios/maplibre_ios/Package.swift');
    if (File.fromUri(ownPackageSwift).existsSync()) {
      final swiftContent = File.fromUri(ownPackageSwift).readAsStringSync();
      final swiftMatch = RegExp(
        r'maplibre-gl-native-distribution[\s\S]*?upToNextMinor\(from:\s*"([0-9.]+)"\)',
      ).firstMatch(swiftContent);
      final pinned = swiftMatch?.group(1);
      if (pinned != null) {
        version = pinned;
      }
    }
  }

  if (version == null) {
    throw Exception(
      'Failed to detect MapLibre version. Tried (1) Package.resolved lookup, '
      '(2) SwiftPM artifacts cache scan, (3) Package.swift lower bound. '
      'Original Package.resolved error: ${lookupError ?? "(not reached)"}',
    );
  }

  final homeDir = Platform.environment['HOME'];
  if (homeDir == null || homeDir.isEmpty) {
    throw Exception('Environment variable HOME is not set.');
  }
  // Find the ZIP file for the detected version.
  final zipPath = Uri.directory(homeDir).resolve(
    'Library/Caches/org.swift.swiftpm/artifacts/'
    'https___github_com_maplibre_maplibre_native_releases_download_ios_v${version.replaceAll('.', '_')}_MapLibre_dynamic_xcframework_zip',
  );
  if (!File.fromUri(zipPath).existsSync()) {
    // SwiftPM populates the artifact cache during `xcodebuild build` for a
    // target that depends on the binary, but Flutter's `dart_build` Run
    // Script phase fires earlier in the build graph: if the cache is cold
    // (fresh checkout, `swift package purge-cache`, new MapLibre version)
    // the hook ran before SwiftPM had a chance to write the ZIP. Fetch
    // from the same release URL SwiftPM would have used so the first
    // build no longer requires manual cache-priming. The transitive
    // build still needs network access; offline failure surfaces as a
    // clearer download error rather than a stale-cache mystery.
    await _downloadMapLibreXcframeworkZip(version: version, dest: zipPath);
  }

  // extract resolved MapLibre ZIP from SPM artifacts if needed
  final extractionRoot = packageRoot.resolve(
    '.dart_tool/maplibre_xcframework/',
  );
  final versionPath = extractionRoot.resolve('version.txt');
  final versionFile = File.fromUri(versionPath);
  if (versionFile.existsSync()) {
    final existingVersion = versionFile.readAsStringSync();
    if (existingVersion != version) {
      await Directory.fromUri(extractionRoot).delete(recursive: true);
    }
  }
  if (!Directory.fromUri(extractionRoot).existsSync()) {
    await Directory.fromUri(extractionRoot).create(recursive: true);
    final unzipResult = await Process.run('unzip', [
      '-o',
      zipPath.toFilePath(),
      '-d',
      extractionRoot.toFilePath(),
    ]);
    if (unzipResult.exitCode != 0) {
      throw Exception('Failed to extract MapLibre zip: ${unzipResult.stderr}');
    }
    await File.fromUri(versionPath).writeAsString(version);
  }

  // Return paths to headers and framework for the desired architecture.
  final archSegment = useSimulator ? 'ios-arm64_x86_64-simulator' : 'ios-arm64';
  final frameworkDir = extractionRoot.resolve(
    'MapLibre.xcframework/$archSegment/',
  );
  if (!Directory.fromUri(frameworkDir).existsSync()) {
    throw Exception(
      'Expected MapLibre framework directory not found at '
      '${frameworkDir.toFilePath()}',
    );
  }
  return frameworkDir;
}

Future<void> _downloadMapLibreXcframeworkZip({
  required String version,
  required Uri dest,
}) async {
  final url = Uri.parse(
    'https://github.com/maplibre/maplibre-native/releases/download/'
    'ios-v$version/MapLibre.dynamic.xcframework.zip',
  );
  await Directory.fromUri(dest.resolve('./')).create(recursive: true);
  // Write through a `.part` file and rename atomically so a partial
  // download from a crashed/interrupted build can't masquerade as a
  // valid cache entry on the next run.
  final partFile = File('${dest.toFilePath()}.part');
  // ignore: avoid_print
  print('[maplibre_ios] downloading MapLibre xcframework v$version from $url');
  final client = HttpClient();
  try {
    final request = await client.getUrl(url);
    final response = await request.close();
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to download MapLibre xcframework: '
        'HTTP ${response.statusCode} from $url',
      );
    }
    final sink = partFile.openWrite();
    await response.pipe(sink);
  } finally {
    client.close(force: true);
  }
  await partFile.rename(dest.toFilePath());
}

String _getResolvedSpmPackagePath() {
  // Determine the root of the app the package is used in
  final root = Platform.script.resolve('../../../../');
  const packageResolvedLocation =
      'ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved';
  // default app structure
  final defaultUri = root.resolve(packageResolvedLocation);
  if (File.fromUri(defaultUri).existsSync()) {
    return defaultUri.toFilePath();
  }
  // pub workspace structure
  final pubspecUri = root.resolve('pubspec.yaml');
  if (!File.fromUri(pubspecUri).existsSync()) {
    throw Exception('Failed to find pubspec.yaml at $pubspecUri');
  }

  final pubspec = Pubspec.parse(File.fromUri(pubspecUri).readAsStringSync());
  final paths = <String>[];
  for (final package in pubspec.workspace ?? const <String>[]) {
    final uri = root.resolve('$package/$packageResolvedLocation');
    if (File.fromUri(uri).existsSync()) {
      // we assume that the first package containing a Package.resolved is the correct one
      return uri.toFilePath();
    }
    paths.add(uri.toFilePath());
  }
  throw Exception(
    'Failed to find Package.resolved in default or workspace locations. '
    'Tried the following paths:\n${[defaultUri.toFilePath(), ...paths].join('\n')}',
  );
}

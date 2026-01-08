import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;
    // if (input.config.code.targetOS != OS.iOS) return;
    if (input.config.code.linkModePreference == LinkModePreference.static) {
      throw UnsupportedError('Static linking not supported.');
    }
    throw Exception('### Platform.script: ${Platform.script}');

    final frameworkPath = await _getMapLibreFrameworkPath(
      packageRoot: input.packageRoot.toFilePath(),
      useSimulator: input.config.code.iOS.targetSdk == IOSSdk.iPhoneSimulator,
    );
    final headersDir = p.join(frameworkPath, 'MapLibre.framework', 'Headers');
    final builder = CBuilder.library(
      name: 'maplibre_ffi',
      assetName: 'maplibre_ffi.g.dart',
      sources: ['lib/maplibre_ffi.g.dart.m'],
      language: Language.objectiveC,
      includes: [headersDir],
      // ARC is required by generated bindings; -F points clang at the xcframework slice.
      flags: ['-fobjc-arc', '-F$frameworkPath'],
      frameworks: ['Foundation', 'MapLibre'],
    );

    await builder.run(input: input, output: output);
  });
}

Future<String> _getMapLibreFrameworkPath({
  required String packageRoot,
  required bool useSimulator,
}) async {
  // Try to detect desired MapLibre version from Package.resolved in the package.
  // TODO resolve the app root path dynamically
  const appRoot = '/Users/joscha/Documents/GitHub/flutter-maplibre/example';
  final resolvedSpmPackage = p.join(
    appRoot,
    'ios',
    'Runner.xcworkspace',
    'xcshareddata',
    'swiftpm',
    'Package.resolved',
  );
  final content = File(resolvedSpmPackage).readAsStringSync();
  final match = RegExp(
    r'"identity"\s*:\s*"maplibre-gl-native-distribution"[\s\S]*?"version"\s*:\s*"([0-9.]+)"',
  ).firstMatch(content);

  if (match == null || match.group(1) == null) {
    throw Exception(
      'Failed to detect MapLibre version from Package.resolved at $resolvedSpmPackage',
    );
  }
  final version = match.group(1)!;

  // Find the ZIP file for the detected version.
  final zipPath = p.join(
    Platform.environment['HOME'] ?? '',
    'Library/Caches/org.swift.swiftpm/artifacts',
    'https___github_com_maplibre_maplibre_native_releases_download_ios_v${version.replaceAll('.', '_')}_MapLibre_dynamic_xcframework_zip',
  );
  if (!File(zipPath).existsSync()) {
    throw Exception('Expected MapLibre ZIP not found at $zipPath');
  }

  // extract resolved MapLibre ZIP from SPM artifacts if needed
  final extractionRoot = p.join(
    packageRoot,
    '.dart_tool',
    'maplibre_xcframework',
  );
  final versionPath = p.join(extractionRoot, 'version.txt');
  if (File(versionPath).existsSync()) {
    final existingVersion = File(versionPath).readAsStringSync();
    if (existingVersion != version) {
      await Directory(extractionRoot).delete(recursive: true);
    }
  }
  if (!Directory(extractionRoot).existsSync()) {
    await Directory(extractionRoot).create(recursive: true);
    final unzipResult = await Process.run('unzip', [
      '-o',
      zipPath,
      '-d',
      extractionRoot,
    ]);
    if (unzipResult.exitCode != 0) {
      throw Exception('Failed to extract MapLibre zip: ${unzipResult.stderr}');
    }
    await File(versionPath).writeAsString(version);
  }

  // Return paths to headers and framework for the desired architecture.
  final archSegment = useSimulator ? 'ios-arm64_x86_64-simulator' : 'ios-arm64';
  final frameworkDir = p.join(
    extractionRoot,
    'MapLibre.xcframework',
    archSegment,
  );
  if (!Directory(frameworkDir).existsSync()) {
    throw Exception(
      'Expected MapLibre framework directory not found at $frameworkDir',
    );
  }
  return frameworkDir;
}

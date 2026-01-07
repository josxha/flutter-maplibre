import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;
    if (input.config.code.targetOS != OS.iOS) return;

    if (input.config.code.linkModePreference == LinkModePreference.static) {
      throw UnsupportedError('Static linking not supported.');
    }

    final spm = await _resolveSpmPaths(
      useSimulator: input.config.code.iOS.targetSdk == IOSSdk.iPhoneSimulator,
    );
    final builder = CBuilder.library(
      name: 'maplibre_ffi',
      assetName: 'maplibre_ffi.g.dart',
      sources: ['lib/maplibre_ffi.g.dart.m'],
      language: Language.objectiveC,
      includes: [spm.headersDir],
      // ARC is required by generated bindings; -F points clang at the xcframework slice.
      flags: ['-fobjc-arc', '-F${spm.frameworkDir}'],
      frameworks: ['Foundation', 'MapLibre'],
    );

    await builder.run(input: input, output: output);
  });
}

class _SpmPaths {
  _SpmPaths(this.headersDir, this.frameworkDir);

  final String headersDir;
  final String frameworkDir;
}

Future<_SpmPaths> _resolveSpmPaths({required bool useSimulator}) async {
  final envHeaders = Platform.environment['MAPLIBRE_SPM_HEADERS'];
  final envFramework = Platform.environment['MAPLIBRE_SPM_FRAMEWORK'];
  if (envHeaders != null && envFramework != null) {
    final normalizedFrameworkDir = envFramework.endsWith('MapLibre.framework')
        ? Directory(envFramework).parent.path
        : envFramework;
    return _SpmPaths(envHeaders, normalizedFrameworkDir);
  }

  final derivedData = p.join(
    Platform.environment['HOME'] ?? '',
    'Library/Developer/Xcode/DerivedData',
  );
  final archSegment = useSimulator ? 'ios-arm64_x86_64-simulator' : 'ios-arm64';
  final findArgs = [
    derivedData,
    '-path',
    '*/SourcePackages/artifacts/maplibre-gl-native-distribution/MapLibre/MapLibre.xcframework/$archSegment/MapLibre.framework/Headers',
    '-type',
    'd',
  ];

  final result = await Process.run('find', findArgs);
  if (result.exitCode != 0) {
    throw Exception(
      'Failed to locate MapLibre.xcframework headers: ${result.stderr}',
    );
  }

  final candidates = (result.stdout as String)
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList(growable: false);

  if (candidates.isEmpty) {
    throw Exception(
      'MapLibre.xcframework headers not found in DerivedData. '
      'Set MAPLIBRE_SPM_HEADERS and MAPLIBRE_SPM_FRAMEWORK (directory containing MapLibre.framework).',
    );
  }

  candidates.sort((a, b) {
    final sa = FileStat.statSync(a).modified;
    final sb = FileStat.statSync(b).modified;
    return sb.compareTo(sa);
  });

  final headersDir = candidates.first;
  final frameworkDir = Directory(headersDir).parent.parent.path; // …/ios-arm64
  return _SpmPaths(headersDir, frameworkDir);
}

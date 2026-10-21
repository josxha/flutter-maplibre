// Generates the Dart bindings to the C APIs of the maplibre_native Windows
// plugin and of the iOS and macOS plugin. Run it after changing a header:
//
//   cd tool/codegen && dart run ffigen.dart

import 'dart:io';

import 'package:ffigen/ffigen.dart';

Future<void> main() async {
  final package = Platform.script.resolve('../../packages/maplibre_native/');
  await _generate(
    header: package.resolve(
      'windows/include/maplibre_native/maplibre_native_api.h',
    ),
    output: package.resolve('lib/src/windows/bindings.g.dart'),
    wrapperName: 'MaplibreNativeWindowsBindings',
    wrapperDocComment:
        'Bindings to the C API of the maplibre_native Windows plugin, '
        'in `windows/include/maplibre_native/maplibre_native_api.h`.',
  );
  await _generate(
    header: package.resolve(
      'darwin/maplibre_native/Sources/maplibre_native/include/'
      'maplibre_native/maplibre_native_api.h',
    ),
    output: package.resolve('lib/src/darwin/bindings.g.dart'),
    wrapperName: 'MaplibreNativeDarwinBindings',
    wrapperDocComment:
        'Bindings to the C API of the maplibre_native iOS and macOS plugin, '
        'in `darwin/maplibre_native/Sources/maplibre_native/include/'
        'maplibre_native/maplibre_native_api.h`.',
  );
}

Future<void> _generate({
  required Uri header,
  required Uri output,
  required String wrapperName,
  required String wrapperDocComment,
}) async {
  bool ours(String name) =>
      name.startsWith('maplibre_native_') || name.startsWith('MaplibreNative');
  await FfiGenerator(
    output: Output(
      dart: DartOutput(path: output),
      style: DynamicLibraryBindings(
        wrapperName: wrapperName,
        wrapperDocComment: wrapperDocComment,
      ),
    ),
    input: Input(entryPoints: [header]),
    visitors: [
      Visitor(
        func: (node) => node.isIncluded = ours(node.originalName),
        struct: (node) => node.isIncluded = ours(node.originalName),
      ),
    ],
  ).generate();
}

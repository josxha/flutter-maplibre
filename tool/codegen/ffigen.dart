// Generates the Dart bindings to the C API of the maplibre_native Windows
// plugin. Run it after changing the header:
//
//   cd tool/codegen && dart run ffigen.dart

import 'dart:io';

import 'package:ffigen/ffigen.dart';

Future<void> main() async {
  final package = Platform.script.resolve('../../packages/maplibre_native/');
  bool ours(String name) =>
      name.startsWith('maplibre_native_') || name.startsWith('MaplibreNative');
  await FfiGenerator(
    output: Output(
      dart: DartOutput(
        path: package.resolve('lib/src/windows/bindings.g.dart'),
      ),
      style: const DynamicLibraryBindings(
        wrapperName: 'MaplibreNativeWindowsBindings',
        wrapperDocComment:
            'Bindings to the C API of the maplibre_native Windows plugin, '
            'in `windows/include/maplibre_native/maplibre_native_api.h`.',
      ),
    ),
    input: Input(
      entryPoints: [
        package.resolve(
          'windows/include/maplibre_native/maplibre_native_api.h',
        ),
      ],
    ),
    visitors: [
      Visitor(
        func: (node) => node.isIncluded = ours(node.originalName),
        struct: (node) => node.isIncluded = ours(node.originalName),
      ),
    ],
  ).generate();
}

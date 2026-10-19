// Generates the Dart bindings to the Kotlin API of the maplibre_native Android
// plugin. Build the example app for Android in release mode first, so Gradle
// has compiled the plugin, then run:
//
//   cd tool/codegen && dart run jnigen.dart

import 'dart:io';

import 'package:jnigen/jnigen.dart';

Future<void> main() async {
  final root = Platform.script.resolve('../../');
  final package = root.resolve('packages/maplibre_native/');
  await JniGenerator(
    input: Input(
      classes: [
        'com.github.josxha.maplibre_native.MaplibreNativeApi',
        'com.github.josxha.maplibre_native.SurfaceListener',
      ],
      backend: SummarizerBackend.asm,
      androidSdk: AndroidSdk(
        addGradleDeps: true,
        androidExample: root.resolve('examples/'),
      ),
    ),
    output: Output(
      dart: DartOutput(
        path: package.resolve('lib/src/android/bindings.g.dart'),
        structure: OutputStructure.singleFile,
      ),
    ),
  ).generate();
}

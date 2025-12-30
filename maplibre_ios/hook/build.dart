import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    if (!input.config.buildCodeAssets) return;
    if (input.config.code.targetOS != OS.iOS) return;

    if (input.config.code.linkModePreference == LinkModePreference.static) {
      throw UnsupportedError('Static linking not supported.');
    }

    final builder = CBuilder.library(
      name: 'maplibre_ffi',
      assetName: 'maplibre_ffi.dylib',
      sources: ['lib/maplibre_ffi.g.dart.m'],
      language: Language.objectiveC,
    );

    await builder.run(input: input, output: output);

    output.assets.code.add(
      CodeAsset(
        package: input.packageName,
        name: 'maplibre_ffi.dylib',
        file: input.outputDirectory.resolve('maplibre_ffi.dylib'),
        linkMode: DynamicLoadingBundled(),
      ),
    );
  });
}

import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    final builder = CBuilder.library(
      name: 'maplibre_ffi',
      assetName: 'lib/maplibre_ffi.g.dart',
      sources: ['lib/maplibre_ffi.g.dart.m'],
    );
    await builder.run(input: input, output: output);
  });
}

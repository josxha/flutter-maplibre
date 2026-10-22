// Points the build hook of maplibre_native_ffi at a locally built MapLibre
// Native C library, or back at the published snapshot.
//
// The hook takes one install prefix and verifies that it was built for the
// target, so switch it to the preset of the platform you build for next:
//
//   dart tool/use_native_build.dart windows-x64-vulkan
//   dart tool/use_native_build.dart linux-gnu-x64-vulkan
//   dart tool/use_native_build.dart android-arm64-egl  # devices
//   dart tool/use_native_build.dart android-x64-egl    # emulators
//   dart tool/use_native_build.dart macos-arm64-metal
//   dart tool/use_native_build.dart ios-simulator-arm64-metal
//   dart tool/use_native_build.dart ios-arm64-metal    # iOS devices
//   dart tool/use_native_build.dart --download
//
// The android-*-vulkan presets build the Vulkan opt-in.
//
// Run it from the repository root, whose package does not depend on the
// binding, so the hook does not run for the host first and reject a prefix
// of another platform. An Android build then needs the matching ABI only,
// e.g. `flutter run -d <device>` or
// `flutter build apk --target-platform android-arm64`.

import 'dart:io';

void main(List<String> arguments) {
  final ffi = Directory.fromUri(
    Platform.script.resolve(
      '../packages/maplibre_native/vendor/maplibre-native-ffi/',
    ),
  );
  final pointer = File.fromUri(
    ffi.uri.resolve('bindings/dart/.dart_tool/maplibre_native_install_dir'),
  );

  if (arguments.length != 1) {
    stderr.writeln(
      'Usage: dart tool/use_native_build.dart <preset> | --download',
    );
    exitCode = 64;
    return;
  }

  if (arguments.single == '--download') {
    if (pointer.existsSync()) pointer.deleteSync();
    stdout.writeln('The build hook downloads the published snapshot again.');
    return;
  }

  final preset = arguments.single;
  final install = Directory.fromUri(ffi.uri.resolve('build/$preset/install/'));
  final descriptor = File.fromUri(
    install.uri.resolve('share/maplibre-native-c/artifact.json'),
  );
  if (!descriptor.existsSync()) {
    stderr.writeln(
      'No build of $preset at ${install.path}. Build it first; see '
      'CONTRIBUTING.md.',
    );
    exitCode = 1;
    return;
  }

  pointer.parent.createSync(recursive: true);
  final path = install.absolute.path.replaceAll(r'\', '/');
  pointer.writeAsStringSync('$path\n');
  stdout.writeln('The build hook uses $path.');
}

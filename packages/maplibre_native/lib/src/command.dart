import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Awaits a C API command and throws when it did not commit.
Future<void> checkCommand(Future<CommandCompletion> command) async {
  final completion = await command;
  if (completion.status != Status.ok ||
      completion.disposition == CommandDisposition.failed) {
    throw StateError(
      'MapLibre Native command failed: ${completion.status} '
      '${completion.diagnostic}',
    );
  }
}

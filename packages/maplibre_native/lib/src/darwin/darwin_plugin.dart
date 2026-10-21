import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:maplibre_native/src/darwin/bindings.g.dart';
import 'package:maplibre_native/src/plugin_error.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// The most ring slots a GPU texture has, the C API's deepest ring.
const _maxSlots = 3;

/// A zero-copy texture: its Flutter texture id and its ring of Metal
/// textures.
typedef MetalGpuTexture = ({int textureId, List<MetalBorrowedTexture> slots});

/// The maplibre_native iOS and macOS plugin, called through its C API in
/// `darwin/maplibre_native/Sources/maplibre_native/include/maplibre_native/maplibre_native_api.h`.
final class DarwinPlugin {
  DarwinPlugin._();

  static final _bindings = MaplibreNativeDarwinBindings.fromLookup(
    _symbolLookup(),
  );

  /// Looks the C API up in the table of `+[MaplibreNativePlugin symbols]`.
  ///
  /// The plugin may be linked statically into the app, whose release builds
  /// strip global symbols, so `DynamicLibrary.process()` can't find its
  /// functions. The Objective-C runtime finds the class by name regardless.
  static Pointer<T> Function<T extends NativeType>(String) _symbolLookup() {
    final process = DynamicLibrary.process();
    final getClass = process
        .lookupFunction<
          Pointer<Void> Function(Pointer<Utf8>),
          Pointer<Void> Function(Pointer<Utf8>)
        >('objc_getClass');
    final registerName = process
        .lookupFunction<
          Pointer<Void> Function(Pointer<Utf8>),
          Pointer<Void> Function(Pointer<Utf8>)
        >('sel_registerName');
    // objc_msgSend takes the signature of the method it calls.
    final sendSymbols = process
        .lookupFunction<
          Pointer<MaplibreNativeSymbol> Function(Pointer<Void>, Pointer<Void>),
          Pointer<MaplibreNativeSymbol> Function(Pointer<Void>, Pointer<Void>)
        >('objc_msgSend');

    final symbols = using((arena) {
      final pluginClass = getClass(
        'MaplibreNativePlugin'.toNativeUtf8(allocator: arena),
      );
      if (pluginClass == nullptr) {
        throw StateError('The maplibre_native plugin is not linked.');
      }
      final table = sendSymbols(
        pluginClass,
        registerName('symbols'.toNativeUtf8(allocator: arena)),
      );
      return {
        for (var i = 0; table[i].name != nullptr; i++)
          table[i].name.cast<Utf8>().toDartString(): table[i].address,
      };
    });
    return <T extends NativeType>(String name) {
      final address = symbols[name];
      if (address == null) {
        throw ArgumentError.value(name, 'name', 'Not in the plugin C API');
      }
      return address.cast<T>();
    };
  }

  /// Registers a zero-copy texture of [width] x [height] device pixels with a
  /// ring of [slotCount] BGRA8 Metal textures.
  static MetalGpuTexture createGpuTexture(
    int width,
    int height,
    int slotCount,
  ) => using((arena) {
    final slots = arena<Uint64>(_maxSlots);
    final error = arena<Char>(pluginErrorSize);
    final id = _bindings.maplibre_native_create_gpu_texture(
      width,
      height,
      slotCount,
      slots,
      _maxSlots,
      error,
      pluginErrorSize,
    );
    if (id < 0) throw StateError(_message(error));
    return (textureId: id, slots: _slots(slots, slotCount));
  });

  /// Replaces a GPU texture's ring with one of the new size. The old ring
  /// stays valid until [releaseRetiredSlots].
  static List<MetalBorrowedTexture> resizeGpuTexture(
    int textureId,
    int width,
    int height,
    int slotCount,
  ) => using((arena) {
    final slots = arena<Uint64>(_maxSlots);
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_resize_gpu_texture(
      textureId,
      width,
      height,
      slots,
      _maxSlots,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
    return _slots(slots, slotCount);
  });

  /// Releases the rings that resizes replaced.
  static void releaseRetiredSlots(int textureId) =>
      _bindings.maplibre_native_release_retired_slots(textureId);

  /// Copies the finished frame in [slot] into the pixel buffer Flutter shows
  /// next, and waits for the copy.
  static void presentGpuTexture(int textureId, int slot) => using((arena) {
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_present_gpu_texture(
      textureId,
      slot,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
  });

  /// Unregisters a texture.
  static void disposeTexture(int textureId) =>
      _bindings.maplibre_native_dispose_texture(textureId);

  static List<MetalBorrowedTexture> _slots(Pointer<Uint64> slots, int count) =>
      [
        for (var i = 0; i < count; i++)
          MetalBorrowedTexture(texture: NativePointer(slots[i])),
      ];

  static String _message(Pointer<Char> error) => pluginErrorMessage(error);
}

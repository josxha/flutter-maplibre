import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Converts a resource kind of the C API.
extension MlnResourceKindExt on mln.ResourceKind {
  /// The [MapResourceKind] of this kind.
  MapResourceKind toMapResourceKind() => switch (this) {
    mln.ResourceKind.style => MapResourceKind.style,
    mln.ResourceKind.source => MapResourceKind.source,
    mln.ResourceKind.tile => MapResourceKind.tile,
    mln.ResourceKind.glyphs => MapResourceKind.glyphs,
    mln.ResourceKind.spriteImage => MapResourceKind.spriteImage,
    mln.ResourceKind.spriteJson => MapResourceKind.spriteJson,
    mln.ResourceKind.image => MapResourceKind.image,
    _ => MapResourceKind.unknown,
  };
}

/// Converts a resource kind to the C API.
extension MapResourceKindExt on MapResourceKind {
  /// The flag of this kind.
  mln.ResourceKindFlag toMln() => switch (this) {
    MapResourceKind.unknown => mln.ResourceKindFlag.unknown,
    MapResourceKind.style => mln.ResourceKindFlag.style,
    MapResourceKind.source => mln.ResourceKindFlag.source,
    MapResourceKind.tile => mln.ResourceKindFlag.tile,
    MapResourceKind.glyphs => mln.ResourceKindFlag.glyphs,
    MapResourceKind.spriteImage => mln.ResourceKindFlag.spriteImage,
    MapResourceKind.spriteJson => mln.ResourceKindFlag.spriteJson,
    MapResourceKind.image => mln.ResourceKindFlag.image,
  };
}

/// Converts request headers to the C API.
extension RequestHeadersExt on RequestHeaders {
  /// The header rule of these headers. Leave out ones with no [kinds],
  /// which match nothing.
  mln.HttpHeaderRule toMln() => mln.HttpHeaderRule(
    // No flags select every kind. An empty set of kinds matches nothing,
    // so it has no rule.
    kinds: switch (kinds) {
      null => mln.ResourceKindFlag.none,
      final kinds => kinds.fold(
        mln.ResourceKindFlag.none,
        (flags, kind) => flags | kind.toMln(),
      ),
    },
    flags: mln.UrlMatchFlag.glob,
    url: url,
    headers: [
      for (final MapEntry(:key, :value) in headers.entries)
        mln.HttpHeader(name: key, value: value),
    ],
  );
}

// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: annotate_overrides
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: doc_directive_unknown
// ignore_for_file: file_names
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: only_throw_errors
// ignore_for_file: overridden_fields
// ignore_for_file: prefer_double_quotes
// ignore_for_file: unnecessary_cast
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:ffi' as ffi;
import 'dart:isolate' show ReceivePort;

import 'package:jni/internal_helpers_for_jnigen.dart';
import 'package:jni/jni.dart' as jni;

/// from: `org.maplibre.android.text.LocalGlyphRasterizer`
class LocalGlyphRasterizer extends jni.JObject {
  @override
  late final jni.JObjType<LocalGlyphRasterizer> $type = type;

  LocalGlyphRasterizer.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/text/LocalGlyphRasterizer');

  /// The type which includes information such as the signature of this class.
  static const type = $LocalGlyphRasterizerType();
  static final _id_drawGlyphBitmap = _class.instanceMethodId(
    r'drawGlyphBitmap',
    r'(Ljava/lang/String;ZC)Landroid/graphics/Bitmap;',
  );

  static final _drawGlyphBitmap = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, $Int32, $Int32)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int, int)>();

  /// from: `protected android.graphics.Bitmap drawGlyphBitmap(java.lang.String string, boolean z, char c)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject drawGlyphBitmap(
    jni.JString string,
    bool z,
    int c,
  ) {
    return _drawGlyphBitmap(
            reference.pointer,
            _id_drawGlyphBitmap as jni.JMethodIDPtr,
            string.reference.pointer,
            z ? 1 : 0,
            c)
        .object(const jni.JObjectType());
  }
}

final class $LocalGlyphRasterizerType
    extends jni.JObjType<LocalGlyphRasterizer> {
  const $LocalGlyphRasterizerType();

  @override
  String get signature => r'Lorg/maplibre/android/text/LocalGlyphRasterizer;';

  @override
  LocalGlyphRasterizer fromReference(jni.JReference reference) =>
      LocalGlyphRasterizer.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($LocalGlyphRasterizerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($LocalGlyphRasterizerType) &&
        other is $LocalGlyphRasterizerType;
  }
}

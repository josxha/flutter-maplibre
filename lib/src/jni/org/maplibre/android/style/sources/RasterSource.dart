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

import 'Source.dart' as source_;

import 'TileSet.dart' as tileset_;

/// from: `org.maplibre.android.style.sources.RasterSource$Companion`
class RasterSource_Companion extends jni.JObject {
  @override
  late final jni.JObjType<RasterSource_Companion> $type = type;

  RasterSource_Companion.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/sources/RasterSource$Companion');

  /// The type which includes information such as the signature of this class.
  static const type = $RasterSource_CompanionType();
  static final _id_new0 = _class.constructorId(
    r'(Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource_Companion(
    jni.JObject defaultConstructorMarker,
  ) {
    return RasterSource_Companion.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $RasterSource_CompanionType
    extends jni.JObjType<RasterSource_Companion> {
  const $RasterSource_CompanionType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/RasterSource$Companion;';

  @override
  RasterSource_Companion fromReference(jni.JReference reference) =>
      RasterSource_Companion.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($RasterSource_CompanionType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterSource_CompanionType) &&
        other is $RasterSource_CompanionType;
  }
}

/// from: `org.maplibre.android.style.sources.RasterSource`
class RasterSource extends source_.Source {
  @override
  late final jni.JObjType<RasterSource> $type = type;

  RasterSource.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/style/sources/RasterSource');

  /// The type which includes information such as the signature of this class.
  static const type = $RasterSourceType();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/style/sources/RasterSource$Companion;',
  );

  /// from: `static public final org.maplibre.android.style.sources.RasterSource$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static RasterSource_Companion get Companion =>
      _id_Companion.get(_class, const $RasterSource_CompanionType());

  /// from: `static public final int DEFAULT_TILE_SIZE`
  static const DEFAULT_TILE_SIZE = 512;
  static final _id_new0 = _class.constructorId(
    r'(J)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Int64,)>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public void <init>(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource(
    int j,
  ) {
    return RasterSource.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr, j)
            .reference);
  }

  static final _id_new2 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URL;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.net.URL uRL)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new2(
    jni.JString string,
    jni.JObject uRL,
  ) {
    return RasterSource.fromReference(_new2(
            _class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr,
            string.reference.pointer,
            uRL.reference.pointer)
        .reference);
  }

  static final _id_new3 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URI;)V',
  );

  static final _new3 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.net.URI uRI)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new3(
    jni.JString string,
    jni.JObject uRI,
  ) {
    return RasterSource.fromReference(_new3(
            _class.reference.pointer,
            _id_new3 as jni.JMethodIDPtr,
            string.reference.pointer,
            uRI.reference.pointer)
        .reference);
  }

  static final _id_new4 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new4 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new4(
    jni.JString string,
    jni.JString string1,
  ) {
    return RasterSource.fromReference(_new4(
            _class.reference.pointer,
            _id_new4 as jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer)
        .reference);
  }

  static final _id_new5 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;I)V',
  );

  static final _new5 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        $Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new5(
    jni.JString string,
    jni.JString string1,
    int i,
  ) {
    return RasterSource.fromReference(_new5(
            _class.reference.pointer,
            _id_new5 as jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer,
            i)
        .reference);
  }

  static final _id_new6 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/TileSet;)V',
  );

  static final _new6 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.TileSet tileSet)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new6(
    jni.JString string,
    tileset_.TileSet tileSet,
  ) {
    return RasterSource.fromReference(_new6(
            _class.reference.pointer,
            _id_new6 as jni.JMethodIDPtr,
            string.reference.pointer,
            tileSet.reference.pointer)
        .reference);
  }

  static final _id_new7 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/TileSet;I)V',
  );

  static final _new7 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        $Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.TileSet tileSet, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new7(
    jni.JString string,
    tileset_.TileSet tileSet,
    int i,
  ) {
    return RasterSource.fromReference(_new7(
            _class.reference.pointer,
            _id_new7 as jni.JMethodIDPtr,
            string.reference.pointer,
            tileSet.reference.pointer,
            i)
        .reference);
  }

  static final _id_getUrl = _class.instanceMethodId(
    r'getUrl',
    r'()Ljava/lang/String;',
  );

  static final _getUrl = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public final java.lang.String getUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getUrl() {
    return _getUrl(reference.pointer, _id_getUrl as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_getUri = _class.instanceMethodId(
    r'getUri',
    r'()Ljava/lang/String;',
  );

  static final _getUri = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public final java.lang.String getUri()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getUri() {
    return _getUri(reference.pointer, _id_getUri as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_initialize = _class.instanceMethodId(
    r'initialize',
    r'(Ljava/lang/String;Ljava/lang/Object;I)V',
  );

  static final _initialize = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        $Int32
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  /// from: `protected native final void initialize(java.lang.String string, java.lang.Object object, int i)`
  void initialize(
    jni.JString string,
    jni.JObject object,
    int i,
  ) {
    _initialize(reference.pointer, _id_initialize as jni.JMethodIDPtr,
            string.reference.pointer, object.reference.pointer, i)
        .check();
  }

  static final _id_finalize = _class.instanceMethodId(
    r'finalize',
    r'()V',
  );

  static final _finalize = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected native final void finalize()`
  void finalize() {
    _finalize(reference.pointer, _id_finalize as jni.JMethodIDPtr).check();
  }

  static final _id_nativeGetUrl = _class.instanceMethodId(
    r'nativeGetUrl',
    r'()Ljava/lang/String;',
  );

  static final _nativeGetUrl = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `protected native final java.lang.String nativeGetUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString nativeGetUrl() {
    return _nativeGetUrl(
            reference.pointer, _id_nativeGetUrl as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }
}

final class $RasterSourceType extends jni.JObjType<RasterSource> {
  const $RasterSourceType();

  @override
  String get signature => r'Lorg/maplibre/android/style/sources/RasterSource;';

  @override
  RasterSource fromReference(jni.JReference reference) =>
      RasterSource.fromReference(reference);

  @override
  jni.JObjType get superType => const source_.$SourceType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($RasterSourceType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterSourceType) &&
        other is $RasterSourceType;
  }
}

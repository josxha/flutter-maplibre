// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: public_member_api_docs
// ignore_for_file: require_trailing_commas
// ignore_for_file: unnecessary_raw_strings
// ignore_for_file: avoid_field_initializers_in_const_classes
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
// ignore_for_file: sort_constructors_first
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: sort_unnamed_constructors_first
// ignore_for_file: always_use_package_imports
// ignore_for_file: use_late_for_private_fields_and_variables
// ignore_for_file: one_member_abstracts
// ignore_for_file: always_put_required_named_parameters_first

// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: annotate_overrides
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: doc_directive_unknown
// ignore_for_file: file_names
// ignore_for_file: inference_failure_on_untyped_parameter
// ignore_for_file: invalid_internal_annotation
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: library_prefixes
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: no_leading_underscores_for_library_prefixes
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: only_throw_errors
// ignore_for_file: overridden_fields
// ignore_for_file: prefer_double_quotes
// ignore_for_file: unintended_html_in_doc_comment
// ignore_for_file: unnecessary_cast
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:core' show Object, String, bool, double, int;
import 'dart:core' as _$core;

import 'package:jni/_internal.dart' as _$jni;
import 'package:jni/jni.dart' as _$jni;

import '../../../../../java/net/URI.dart' as uri_;

import '../../../../../java/net/URL.dart' as url_;

import 'Source.dart' as source_;

import 'TileSet.dart' as tileset_;

/// from: `org.maplibre.android.style.sources.RasterSource$Companion`
class RasterSource_Companion extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<RasterSource_Companion> $type;

  @_$jni.internal
  RasterSource_Companion.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/style/sources/RasterSource$Companion');

  /// The type which includes information such as the signature of this class.
  static const type = $RasterSource_Companion$Type();
  static final _id_new$ = _class.constructorId(
    r'(Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `synthetic public void <init>(kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource_Companion(
    _$jni.JObject defaultConstructorMarker,
  ) {
    return RasterSource_Companion.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as _$jni.JMethodIDPtr,
            defaultConstructorMarker.reference.pointer)
        .reference);
  }
}

final class $RasterSource_Companion$Type
    extends _$jni.JObjType<RasterSource_Companion> {
  @_$jni.internal
  const $RasterSource_Companion$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/RasterSource$Companion;';

  @_$jni.internal
  @_$core.override
  RasterSource_Companion fromReference(_$jni.JReference reference) =>
      RasterSource_Companion.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($RasterSource_Companion$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterSource_Companion$Type) &&
        other is $RasterSource_Companion$Type;
  }
}

/// from: `org.maplibre.android.style.sources.RasterSource`
class RasterSource extends source_.Source {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<RasterSource> $type;

  @_$jni.internal
  RasterSource.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'org/maplibre/android/style/sources/RasterSource');

  /// The type which includes information such as the signature of this class.
  static const type = $RasterSource$Type();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/style/sources/RasterSource$Companion;',
  );

  /// from: `static public final org.maplibre.android.style.sources.RasterSource$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static RasterSource_Companion get Companion =>
      _id_Companion.get(_class, const $RasterSource_Companion$Type());

  /// from: `static public final int DEFAULT_TILE_SIZE`
  static const DEFAULT_TILE_SIZE = 512;
  static final _id_new$ = _class.constructorId(
    r'(J)V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int64,)>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public void <init>(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource(
    int j,
  ) {
    return RasterSource.fromReference(
        _new$(_class.reference.pointer, _id_new$ as _$jni.JMethodIDPtr, j)
            .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URL;)V',
  );

  static final _new$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.net.URL uRL)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new$1(
    _$jni.JString string,
    url_.URL uRL,
  ) {
    return RasterSource.fromReference(_new$1(
            _class.reference.pointer,
            _id_new$1 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            uRL.reference.pointer)
        .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URI;)V',
  );

  static final _new$2 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.net.URI uRI)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new$2(
    _$jni.JString string,
    uri_.URI uRI,
  ) {
    return RasterSource.fromReference(_new$2(
            _class.reference.pointer,
            _id_new$2 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            uRI.reference.pointer)
        .reference);
  }

  static final _id_new$3 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$3 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new$3(
    _$jni.JString string,
    _$jni.JString string1,
  ) {
    return RasterSource.fromReference(_new$3(
            _class.reference.pointer,
            _id_new$3 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer)
        .reference);
  }

  static final _id_new$4 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;I)V',
  );

  static final _new$4 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              int)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new$4(
    _$jni.JString string,
    _$jni.JString string1,
    int i,
  ) {
    return RasterSource.fromReference(_new$4(
            _class.reference.pointer,
            _id_new$4 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer,
            i)
        .reference);
  }

  static final _id_new$5 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/TileSet;)V',
  );

  static final _new$5 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.TileSet tileSet)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new$5(
    _$jni.JString string,
    tileset_.TileSet tileSet,
  ) {
    return RasterSource.fromReference(_new$5(
            _class.reference.pointer,
            _id_new$5 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            tileSet.reference.pointer)
        .reference);
  }

  static final _id_new$6 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/TileSet;I)V',
  );

  static final _new$6 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>,
              int)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.TileSet tileSet, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterSource.new$6(
    _$jni.JString string,
    tileset_.TileSet tileSet,
    int i,
  ) {
    return RasterSource.fromReference(_new$6(
            _class.reference.pointer,
            _id_new$6 as _$jni.JMethodIDPtr,
            string.reference.pointer,
            tileSet.reference.pointer,
            i)
        .reference);
  }

  static final _id_getUrl = _class.instanceMethodId(
    r'getUrl',
    r'()Ljava/lang/String;',
  );

  static final _getUrl = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public final java.lang.String getUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getUrl() {
    return _getUrl(reference.pointer, _id_getUrl as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }

  static final _id_getUri = _class.instanceMethodId(
    r'getUri',
    r'()Ljava/lang/String;',
  );

  static final _getUri = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public final java.lang.String getUri()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JString getUri() {
    return _getUri(reference.pointer, _id_getUri as _$jni.JMethodIDPtr)
        .object(const _$jni.JStringType());
  }
}

final class $RasterSource$Type extends _$jni.JObjType<RasterSource> {
  @_$jni.internal
  const $RasterSource$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lorg/maplibre/android/style/sources/RasterSource;';

  @_$jni.internal
  @_$core.override
  RasterSource fromReference(_$jni.JReference reference) =>
      RasterSource.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const source_.$Source$Type();

  @_$jni.internal
  @_$core.override
  final superCount = 2;

  @_$core.override
  int get hashCode => ($RasterSource$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterSource$Type) &&
        other is $RasterSource$Type;
  }
}

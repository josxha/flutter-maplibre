// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: document_ignores
// ignore_for_file: avoid_catches_without_on_clauses
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
// ignore_for_file: unnecessary_non_null_assertion
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import 'dart:core' show Object, String, bool, double, int;
import 'dart:core' as core$_;

import 'package:jni/_internal.dart' as jni$_;
import 'package:jni/jni.dart' as jni$_;

import '../../../../../java/net/URI.dart' as uri$_;

import '../../../../../java/net/URL.dart' as url$_;

import 'Source.dart' as source$_;

import 'TileSet.dart' as tileset$_;

/// from: `org.maplibre.android.style.sources.RasterDemSource$Companion`
class RasterDemSource$Companion extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<RasterDemSource$Companion> $type;

  @jni$_.internal
  RasterDemSource$Companion.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/style/sources/RasterDemSource$Companion');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $RasterDemSource$Companion$NullableType();
  static const type = $RasterDemSource$Companion$Type();
  static final _id_new$ = _class.constructorId(
    r'(Lkotlin/jvm/internal/DefaultConstructorMarker;)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `synthetic public void <init>(kotlin.jvm.internal.DefaultConstructorMarker defaultConstructorMarker)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource$Companion(
    jni$_.JObject? defaultConstructorMarker,
  ) {
    final _$defaultConstructorMarker =
        defaultConstructorMarker?.reference ?? jni$_.jNullReference;
    return RasterDemSource$Companion.fromReference(_new$(
            _class.reference.pointer,
            _id_new$ as jni$_.JMethodIDPtr,
            _$defaultConstructorMarker.pointer)
        .reference);
  }
}

final class $RasterDemSource$Companion$NullableType
    extends jni$_.JObjType<RasterDemSource$Companion?> {
  @jni$_.internal
  const $RasterDemSource$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/RasterDemSource$Companion;';

  @jni$_.internal
  @core$_.override
  RasterDemSource$Companion? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : RasterDemSource$Companion.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RasterDemSource$Companion?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($RasterDemSource$Companion$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterDemSource$Companion$NullableType) &&
        other is $RasterDemSource$Companion$NullableType;
  }
}

final class $RasterDemSource$Companion$Type
    extends jni$_.JObjType<RasterDemSource$Companion> {
  @jni$_.internal
  const $RasterDemSource$Companion$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/RasterDemSource$Companion;';

  @jni$_.internal
  @core$_.override
  RasterDemSource$Companion fromReference(jni$_.JReference reference) =>
      RasterDemSource$Companion.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RasterDemSource$Companion?> get nullableType =>
      const $RasterDemSource$Companion$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($RasterDemSource$Companion$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterDemSource$Companion$Type) &&
        other is $RasterDemSource$Companion$Type;
  }
}

/// from: `org.maplibre.android.style.sources.RasterDemSource`
class RasterDemSource extends source$_.Source {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<RasterDemSource> $type;

  @jni$_.internal
  RasterDemSource.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/style/sources/RasterDemSource');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $RasterDemSource$NullableType();
  static const type = $RasterDemSource$Type();
  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lorg/maplibre/android/style/sources/RasterDemSource$Companion;',
  );

  /// from: `static public final org.maplibre.android.style.sources.RasterDemSource$Companion Companion`
  /// The returned object must be released after use, by calling the [release] method.
  static RasterDemSource$Companion get Companion =>
      _id_Companion.get(_class, const $RasterDemSource$Companion$Type());

  /// from: `static public final int DEFAULT_TILE_SIZE`
  static const DEFAULT_TILE_SIZE = 512;
  static final _id_new$ = _class.constructorId(
    r'(J)V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int64,)>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public void <init>(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource(
    int j,
  ) {
    return RasterDemSource.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr, j)
            .reference);
  }

  static final _id_new$1 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URL;)V',
  );

  static final _new$1 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.net.URL uRL)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource.new$1(
    jni$_.JString? string,
    url$_.URL uRL,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$uRL = uRL.reference;
    return RasterDemSource.fromReference(_new$1(_class.reference.pointer,
            _id_new$1 as jni$_.JMethodIDPtr, _$string.pointer, _$uRL.pointer)
        .reference);
  }

  static final _id_new$2 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/net/URI;)V',
  );

  static final _new$2 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.net.URI uRI)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource.new$2(
    jni$_.JString? string,
    uri$_.URI uRI,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$uRI = uRI.reference;
    return RasterDemSource.fromReference(_new$2(_class.reference.pointer,
            _id_new$2 as jni$_.JMethodIDPtr, _$string.pointer, _$uRI.pointer)
        .reference);
  }

  static final _id_new$3 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;)V',
  );

  static final _new$3 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource.new$3(
    jni$_.JString? string,
    jni$_.JString? string1,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    return RasterDemSource.fromReference(_new$3(
            _class.reference.pointer,
            _id_new$3 as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$string1.pointer)
        .reference);
  }

  static final _id_new$4 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/String;I)V',
  );

  static final _new$4 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int)>();

  /// from: `public void <init>(java.lang.String string, java.lang.String string1, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource.new$4(
    jni$_.JString? string,
    jni$_.JString? string1,
    int i,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$string1 = string1?.reference ?? jni$_.jNullReference;
    return RasterDemSource.fromReference(_new$4(
            _class.reference.pointer,
            _id_new$4 as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$string1.pointer,
            i)
        .reference);
  }

  static final _id_new$5 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/TileSet;)V',
  );

  static final _new$5 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.TileSet tileSet)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource.new$5(
    jni$_.JString? string,
    tileset$_.TileSet tileSet,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$tileSet = tileSet.reference;
    return RasterDemSource.fromReference(_new$5(
            _class.reference.pointer,
            _id_new$5 as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$tileSet.pointer)
        .reference);
  }

  static final _id_new$6 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/style/sources/TileSet;I)V',
  );

  static final _new$6 = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              int)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.style.sources.TileSet tileSet, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory RasterDemSource.new$6(
    jni$_.JString? string,
    tileset$_.TileSet tileSet,
    int i,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$tileSet = tileSet.reference;
    return RasterDemSource.fromReference(_new$6(
            _class.reference.pointer,
            _id_new$6 as jni$_.JMethodIDPtr,
            _$string.pointer,
            _$tileSet.pointer,
            i)
        .reference);
  }

  static final _id_getUrl = _class.instanceMethodId(
    r'getUrl',
    r'()Ljava/lang/String;',
  );

  static final _getUrl = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public final java.lang.String getUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getUrl() {
    return _getUrl(reference.pointer, _id_getUrl as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }

  static final _id_getUri = _class.instanceMethodId(
    r'getUri',
    r'()Ljava/lang/String;',
  );

  static final _getUri = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public final java.lang.String getUri()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JString? getUri() {
    return _getUri(reference.pointer, _id_getUri as jni$_.JMethodIDPtr)
        .object<jni$_.JString?>(const jni$_.JStringNullableType());
  }
}

final class $RasterDemSource$NullableType
    extends jni$_.JObjType<RasterDemSource?> {
  @jni$_.internal
  const $RasterDemSource$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/RasterDemSource;';

  @jni$_.internal
  @core$_.override
  RasterDemSource? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : RasterDemSource.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const source$_.$Source$Type();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RasterDemSource?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($RasterDemSource$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterDemSource$NullableType) &&
        other is $RasterDemSource$NullableType;
  }
}

final class $RasterDemSource$Type extends jni$_.JObjType<RasterDemSource> {
  @jni$_.internal
  const $RasterDemSource$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/RasterDemSource;';

  @jni$_.internal
  @core$_.override
  RasterDemSource fromReference(jni$_.JReference reference) =>
      RasterDemSource.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const source$_.$Source$Type();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RasterDemSource?> get nullableType =>
      const $RasterDemSource$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 2;

  @core$_.override
  int get hashCode => ($RasterDemSource$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RasterDemSource$Type) &&
        other is $RasterDemSource$Type;
  }
}

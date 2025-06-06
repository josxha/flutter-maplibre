// AUTO GENERATED BY JNIGEN 0.14.2. DO NOT EDIT!

// ignore_for_file: type=lint

// ignore_for_file: annotate_overrides
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: comment_references
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

import '../../../../org/maplibre/android/geometry/LatLngBounds.dart'
    as latlngbounds$_;

/// from: `com.github.josxha.maplibre.Helpers`
class Helpers extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<Helpers> $type;

  @jni$_.internal
  Helpers.fromReference(jni$_.JReference reference)
    : $type = type,
      super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
    r'com/github/josxha/maplibre/Helpers',
  );

  /// The type which includes information such as the signature of this class.
  static const nullableType = $Helpers$NullableType();
  static const type = $Helpers$Type();
  static final _id_INSTANCE = _class.staticFieldId(
    r'INSTANCE',
    r'Lcom/github/josxha/maplibre/Helpers;',
  );

  /// from: `static public final com.github.josxha.maplibre.Helpers INSTANCE`
  /// The returned object must be released after use, by calling the [release] method.
  static Helpers get INSTANCE =>
      _id_INSTANCE.get(_class, const $Helpers$Type());

  static final _id_createOfflineTilePyramidRegionDefinition = _class
      .instanceMethodId(
        r'createOfflineTilePyramidRegionDefinition',
        r'(Ljava/lang/String;Lorg/maplibre/android/geometry/LatLngBounds;DDF)Lorg/maplibre/android/offline/OfflineTilePyramidRegionDefinition;',
      );

  static final _createOfflineTilePyramidRegionDefinition =
      jni$_.ProtectedJniExtensions.lookup<
            jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
                jni$_.VarArgs<
                  (
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Pointer<jni$_.Void>,
                    jni$_.Double,
                    jni$_.Double,
                    jni$_.Double,
                  )
                >,
              )
            >
          >('globalEnv_CallObjectMethod')
          .asFunction<
            jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>,
              double,
              double,
              double,
            )
          >();

  /// from: `public final org.maplibre.android.offline.OfflineTilePyramidRegionDefinition createOfflineTilePyramidRegionDefinition(java.lang.String string, org.maplibre.android.geometry.LatLngBounds latLngBounds, double d, double d1, float f)`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject createOfflineTilePyramidRegionDefinition(
    jni$_.JString? string,
    latlngbounds$_.LatLngBounds latLngBounds,
    double d,
    double d1,
    double f,
  ) {
    final _$string = string?.reference ?? jni$_.jNullReference;
    final _$latLngBounds = latLngBounds.reference;
    return _createOfflineTilePyramidRegionDefinition(
      reference.pointer,
      _id_createOfflineTilePyramidRegionDefinition as jni$_.JMethodIDPtr,
      _$string.pointer,
      _$latLngBounds.pointer,
      d,
      d1,
      f,
    ).object<jni$_.JObject>(const jni$_.JObjectType());
  }
}

final class $Helpers$NullableType extends jni$_.JObjType<Helpers?> {
  @jni$_.internal
  const $Helpers$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lcom/github/josxha/maplibre/Helpers;';

  @jni$_.internal
  @core$_.override
  Helpers? fromReference(jni$_.JReference reference) =>
      reference.isNull ? null : Helpers.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Helpers?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Helpers$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Helpers$NullableType) &&
        other is $Helpers$NullableType;
  }
}

final class $Helpers$Type extends jni$_.JObjType<Helpers> {
  @jni$_.internal
  const $Helpers$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lcom/github/josxha/maplibre/Helpers;';

  @jni$_.internal
  @core$_.override
  Helpers fromReference(jni$_.JReference reference) =>
      Helpers.fromReference(reference);
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<Helpers?> get nullableType => const $Helpers$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($Helpers$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($Helpers$Type) && other is $Helpers$Type;
  }
}

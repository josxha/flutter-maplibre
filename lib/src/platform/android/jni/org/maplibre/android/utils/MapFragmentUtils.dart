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

import '../maps/MapLibreMapOptions.dart' as maplibremapoptions$_;

/// from: `org.maplibre.android.utils.MapFragmentUtils`
class MapFragmentUtils extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapFragmentUtils> $type;

  @jni$_.internal
  MapFragmentUtils.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/utils/MapFragmentUtils');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapFragmentUtils$NullableType();
  static const type = $MapFragmentUtils$Type();
  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapFragmentUtils() {
    return MapFragmentUtils.fromReference(
        _new$(_class.reference.pointer, _id_new$ as jni$_.JMethodIDPtr)
            .reference);
  }

  static final _id_createFragmentArgs = _class.staticMethodId(
    r'createFragmentArgs',
    r'(Lorg/maplibre/android/maps/MapLibreMapOptions;)Landroid/os/Bundle;',
  );

  static final _createFragmentArgs = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JniResult Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public android.os.Bundle createFragmentArgs(org.maplibre.android.maps.MapLibreMapOptions mapLibreMapOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni$_.JObject? createFragmentArgs(
    maplibremapoptions$_.MapLibreMapOptions? mapLibreMapOptions,
  ) {
    final _$mapLibreMapOptions =
        mapLibreMapOptions?.reference ?? jni$_.jNullReference;
    return _createFragmentArgs(
            _class.reference.pointer,
            _id_createFragmentArgs as jni$_.JMethodIDPtr,
            _$mapLibreMapOptions.pointer)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_resolveArgs = _class.staticMethodId(
    r'resolveArgs',
    r'(Landroid/content/Context;Landroid/os/Bundle;)Lorg/maplibre/android/maps/MapLibreMapOptions;',
  );

  static final _resolveArgs = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `static public org.maplibre.android.maps.MapLibreMapOptions resolveArgs(android.content.Context context, android.os.Bundle bundle)`
  /// The returned object must be released after use, by calling the [release] method.
  static maplibremapoptions$_.MapLibreMapOptions? resolveArgs(
    jni$_.JObject? context,
    jni$_.JObject? bundle,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    final _$bundle = bundle?.reference ?? jni$_.jNullReference;
    return _resolveArgs(
            _class.reference.pointer,
            _id_resolveArgs as jni$_.JMethodIDPtr,
            _$context.pointer,
            _$bundle.pointer)
        .object<maplibremapoptions$_.MapLibreMapOptions?>(
            const maplibremapoptions$_.$MapLibreMapOptions$NullableType());
  }
}

final class $MapFragmentUtils$NullableType
    extends jni$_.JObjType<MapFragmentUtils?> {
  @jni$_.internal
  const $MapFragmentUtils$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/MapFragmentUtils;';

  @jni$_.internal
  @core$_.override
  MapFragmentUtils? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : MapFragmentUtils.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapFragmentUtils?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapFragmentUtils$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapFragmentUtils$NullableType) &&
        other is $MapFragmentUtils$NullableType;
  }
}

final class $MapFragmentUtils$Type extends jni$_.JObjType<MapFragmentUtils> {
  @jni$_.internal
  const $MapFragmentUtils$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/utils/MapFragmentUtils;';

  @jni$_.internal
  @core$_.override
  MapFragmentUtils fromReference(jni$_.JReference reference) =>
      MapFragmentUtils.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapFragmentUtils?> get nullableType =>
      const $MapFragmentUtils$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapFragmentUtils$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapFragmentUtils$Type) &&
        other is $MapFragmentUtils$Type;
  }
}

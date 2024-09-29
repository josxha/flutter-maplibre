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

import '../maps/MapLibreMapOptions.dart' as maplibremapoptions_;

/// from: `org.maplibre.android.utils.MapFragmentUtils`
class MapFragmentUtils extends jni.JObject {
  @override
  late final jni.JObjType<MapFragmentUtils> $type = type;

  MapFragmentUtils.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/utils/MapFragmentUtils');

  /// The type which includes information such as the signature of this class.
  static const type = $MapFragmentUtilsType();
  static final _id_new0 = _class.constructorId(
    r'()V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapFragmentUtils() {
    return MapFragmentUtils.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_createFragmentArgs = _class.staticMethodId(
    r'createFragmentArgs',
    r'(Lorg/maplibre/android/maps/MapLibreMapOptions;)Landroid/os/Bundle;',
  );

  static final _createFragmentArgs = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public android.os.Bundle createFragmentArgs(org.maplibre.android.maps.MapLibreMapOptions mapLibreMapOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JObject createFragmentArgs(
    maplibremapoptions_.MapLibreMapOptions mapLibreMapOptions,
  ) {
    return _createFragmentArgs(
            _class.reference.pointer,
            _id_createFragmentArgs as jni.JMethodIDPtr,
            mapLibreMapOptions.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_resolveArgs = _class.staticMethodId(
    r'resolveArgs',
    r'(Landroid/content/Context;Landroid/os/Bundle;)Lorg/maplibre/android/maps/MapLibreMapOptions;',
  );

  static final _resolveArgs = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `static public org.maplibre.android.maps.MapLibreMapOptions resolveArgs(android.content.Context context, android.os.Bundle bundle)`
  /// The returned object must be released after use, by calling the [release] method.
  static maplibremapoptions_.MapLibreMapOptions resolveArgs(
    jni.JObject context,
    jni.JObject bundle,
  ) {
    return _resolveArgs(
            _class.reference.pointer,
            _id_resolveArgs as jni.JMethodIDPtr,
            context.reference.pointer,
            bundle.reference.pointer)
        .object(const maplibremapoptions_.$MapLibreMapOptionsType());
  }
}

final class $MapFragmentUtilsType extends jni.JObjType<MapFragmentUtils> {
  const $MapFragmentUtilsType();

  @override
  String get signature => r'Lorg/maplibre/android/utils/MapFragmentUtils;';

  @override
  MapFragmentUtils fromReference(jni.JReference reference) =>
      MapFragmentUtils.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapFragmentUtilsType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapFragmentUtilsType) &&
        other is $MapFragmentUtilsType;
  }
}
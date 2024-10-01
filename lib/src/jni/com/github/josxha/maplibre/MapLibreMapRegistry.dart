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

import '../../../../org/maplibre/android/maps/MapLibreMap.dart' as maplibremap_;

/// from: `com.github.josxha.maplibre.MapLibreMapRegistry`
class MapLibreMapRegistry extends jni.JObject {
  @override
  late final jni.JObjType<MapLibreMapRegistry> $type = type;

  MapLibreMapRegistry.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'com/github/josxha/maplibre/MapLibreMapRegistry');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibreMapRegistryType();
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
  factory MapLibreMapRegistry() {
    return MapLibreMapRegistry.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_get0 = _class.staticMethodId(
    r'get',
    r'(I)Lorg/maplibre/android/maps/MapLibreMap;',
  );

  static final _get0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `static public org.maplibre.android.maps.MapLibreMap get(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  static maplibremap_.MapLibreMap get0(
    int i,
  ) {
    return _get0(_class.reference.pointer, _id_get0 as jni.JMethodIDPtr, i)
        .object(const maplibremap_.$MapLibreMapType());
  }

  static final _id_add = _class.staticMethodId(
    r'add',
    r'(ILorg/maplibre/android/maps/MapLibreMap;)V',
  );

  static final _add = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<($Int32, ffi.Pointer<ffi.Void>)>)>>(
          'globalEnv_CallStaticVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              int, ffi.Pointer<ffi.Void>)>();

  /// from: `static public void add(int i, org.maplibre.android.maps.MapLibreMap mapLibreMap)`
  static void add(
    int i,
    maplibremap_.MapLibreMap mapLibreMap,
  ) {
    _add(_class.reference.pointer, _id_add as jni.JMethodIDPtr, i,
            mapLibreMap.reference.pointer)
        .check();
  }
}

final class $MapLibreMapRegistryType extends jni.JObjType<MapLibreMapRegistry> {
  const $MapLibreMapRegistryType();

  @override
  String get signature => r'Lcom/github/josxha/maplibre/MapLibreMapRegistry;';

  @override
  MapLibreMapRegistry fromReference(jni.JReference reference) =>
      MapLibreMapRegistry.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapLibreMapRegistryType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreMapRegistryType) &&
        other is $MapLibreMapRegistryType;
  }
}

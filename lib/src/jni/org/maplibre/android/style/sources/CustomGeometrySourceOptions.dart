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

/// from: `org.maplibre.android.style.sources.CustomGeometrySourceOptions`
class CustomGeometrySourceOptions extends jni.JObject {
  @override
  late final jni.JObjType<CustomGeometrySourceOptions> $type = type;

  CustomGeometrySourceOptions.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/sources/CustomGeometrySourceOptions');

  /// The type which includes information such as the signature of this class.
  static const type = $CustomGeometrySourceOptionsType();
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
  factory CustomGeometrySourceOptions() {
    return CustomGeometrySourceOptions.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_withWrap = _class.instanceMethodId(
    r'withWrap',
    r'(Z)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withWrap = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withWrap(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withWrap(
    bool z,
  ) {
    return _withWrap(
            reference.pointer, _id_withWrap as jni.JMethodIDPtr, z ? 1 : 0)
        .object(const $CustomGeometrySourceOptionsType());
  }

  static final _id_withClip = _class.instanceMethodId(
    r'withClip',
    r'(Z)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withClip = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withClip(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withClip(
    bool z,
  ) {
    return _withClip(
            reference.pointer, _id_withClip as jni.JMethodIDPtr, z ? 1 : 0)
        .object(const $CustomGeometrySourceOptionsType());
  }

  static final _id_withMinZoom = _class.instanceMethodId(
    r'withMinZoom',
    r'(I)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withMinZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withMinZoom(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withMinZoom(
    int i,
  ) {
    return _withMinZoom(
            reference.pointer, _id_withMinZoom as jni.JMethodIDPtr, i)
        .object(const $CustomGeometrySourceOptionsType());
  }

  static final _id_withMaxZoom = _class.instanceMethodId(
    r'withMaxZoom',
    r'(I)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withMaxZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withMaxZoom(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withMaxZoom(
    int i,
  ) {
    return _withMaxZoom(
            reference.pointer, _id_withMaxZoom as jni.JMethodIDPtr, i)
        .object(const $CustomGeometrySourceOptionsType());
  }

  static final _id_withBuffer = _class.instanceMethodId(
    r'withBuffer',
    r'(I)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withBuffer = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withBuffer(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withBuffer(
    int i,
  ) {
    return _withBuffer(reference.pointer, _id_withBuffer as jni.JMethodIDPtr, i)
        .object(const $CustomGeometrySourceOptionsType());
  }

  static final _id_withTolerance = _class.instanceMethodId(
    r'withTolerance',
    r'(F)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withTolerance = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withTolerance(float f)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withTolerance(
    double f,
  ) {
    return _withTolerance(
            reference.pointer, _id_withTolerance as jni.JMethodIDPtr, f)
        .object(const $CustomGeometrySourceOptionsType());
  }

  static final _id_getSize = _class.instanceMethodId(
    r'getSize',
    r'()I',
  );

  static final _getSize = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public int getSize()`
  int getSize() {
    return _getSize(reference.pointer, _id_getSize as jni.JMethodIDPtr).integer;
  }

  static final _id_size = _class.instanceMethodId(
    r'size',
    r'()I',
  );

  static final _size = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public final int size()`
  int size() {
    return _size(reference.pointer, _id_size as jni.JMethodIDPtr).integer;
  }

  static final _id_get0 = _class.instanceMethodId(
    r'get',
    r'(Ljava/lang/String;)Ljava/lang/Object;',
  );

  static final _get0 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public java.lang.Object get(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject get0(
    jni.JString string,
  ) {
    return _get0(reference.pointer, _id_get0 as jni.JMethodIDPtr,
            string.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_get1 = _class.instanceMethodId(
    r'get',
    r'(Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _get1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final java.lang.Object get(java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject get1(
    jni.JObject object,
  ) {
    return _get1(reference.pointer, _id_get1 as jni.JMethodIDPtr,
            object.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_containsKey = _class.instanceMethodId(
    r'containsKey',
    r'(Ljava/lang/String;)Z',
  );

  static final _containsKey = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public boolean containsKey(java.lang.String string)`
  bool containsKey(
    jni.JString string,
  ) {
    return _containsKey(reference.pointer, _id_containsKey as jni.JMethodIDPtr,
            string.reference.pointer)
        .boolean;
  }

  static final _id_containsKey1 = _class.instanceMethodId(
    r'containsKey',
    r'(Ljava/lang/Object;)Z',
  );

  static final _containsKey1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final boolean containsKey(java.lang.Object object)`
  bool containsKey1(
    jni.JObject object,
  ) {
    return _containsKey1(reference.pointer,
            _id_containsKey1 as jni.JMethodIDPtr, object.reference.pointer)
        .boolean;
  }

  static final _id_remove = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/String;)Ljava/lang/Object;',
  );

  static final _remove = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public java.lang.Object remove(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject remove(
    jni.JString string,
  ) {
    return _remove(reference.pointer, _id_remove as jni.JMethodIDPtr,
            string.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_remove1 = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _remove1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final java.lang.Object remove(java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject remove1(
    jni.JObject object,
  ) {
    return _remove1(reference.pointer, _id_remove1 as jni.JMethodIDPtr,
            object.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_remove2 = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/String;Ljava/lang/Object;)Z',
  );

  static final _remove2 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public boolean remove(java.lang.String string, java.lang.Object object)`
  bool remove2(
    jni.JString string,
    jni.JObject object,
  ) {
    return _remove2(reference.pointer, _id_remove2 as jni.JMethodIDPtr,
            string.reference.pointer, object.reference.pointer)
        .boolean;
  }

  static final _id_remove3 = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/Object;Ljava/lang/Object;)Z',
  );

  static final _remove3 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public final boolean remove(java.lang.Object object, java.lang.Object object1)`
  bool remove3(
    jni.JObject object,
    jni.JObject object1,
  ) {
    return _remove3(reference.pointer, _id_remove3 as jni.JMethodIDPtr,
            object.reference.pointer, object1.reference.pointer)
        .boolean;
  }

  static final _id_getValues = _class.instanceMethodId(
    r'getValues',
    r'()Ljava/util/Collection;',
  );

  static final _getValues = ProtectedJniExtensions.lookup<
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

  /// from: `public java.util.Collection getValues()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getValues() {
    return _getValues(reference.pointer, _id_getValues as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }

  static final _id_values = _class.instanceMethodId(
    r'values',
    r'()Ljava/util/Collection;',
  );

  static final _values = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.util.Collection values()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject values() {
    return _values(reference.pointer, _id_values as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }

  static final _id_getOrDefault = _class.instanceMethodId(
    r'getOrDefault',
    r'(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _getOrDefault = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public java.lang.Object getOrDefault(java.lang.String string, java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getOrDefault(
    jni.JString string,
    jni.JObject object,
  ) {
    return _getOrDefault(
            reference.pointer,
            _id_getOrDefault as jni.JMethodIDPtr,
            string.reference.pointer,
            object.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_getOrDefault1 = _class.instanceMethodId(
    r'getOrDefault',
    r'(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _getOrDefault1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `public final java.lang.Object getOrDefault(java.lang.Object object, java.lang.Object object1)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getOrDefault1(
    jni.JObject object,
    jni.JObject object1,
  ) {
    return _getOrDefault1(
            reference.pointer,
            _id_getOrDefault1 as jni.JMethodIDPtr,
            object.reference.pointer,
            object1.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_getEntries = _class.instanceMethodId(
    r'getEntries',
    r'()Ljava/util/Set;',
  );

  static final _getEntries = ProtectedJniExtensions.lookup<
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

  /// from: `public java.util.Set getEntries()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JSet<jni.JObject> getEntries() {
    return _getEntries(reference.pointer, _id_getEntries as jni.JMethodIDPtr)
        .object(const jni.JSetType(jni.JObjectType()));
  }

  static final _id_entrySet = _class.instanceMethodId(
    r'entrySet',
    r'()Ljava/util/Set;',
  );

  static final _entrySet = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.util.Set entrySet()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JSet<jni.JObject> entrySet() {
    return _entrySet(reference.pointer, _id_entrySet as jni.JMethodIDPtr)
        .object(const jni.JSetType(jni.JObjectType()));
  }

  static final _id_getKeys = _class.instanceMethodId(
    r'getKeys',
    r'()Ljava/util/Set;',
  );

  static final _getKeys = ProtectedJniExtensions.lookup<
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

  /// from: `public java.util.Set getKeys()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JSet<jni.JString> getKeys() {
    return _getKeys(reference.pointer, _id_getKeys as jni.JMethodIDPtr)
        .object(const jni.JSetType(jni.JStringType()));
  }

  static final _id_keySet = _class.instanceMethodId(
    r'keySet',
    r'()Ljava/util/Set;',
  );

  static final _keySet = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.util.Set keySet()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JSet<jni.JString> keySet() {
    return _keySet(reference.pointer, _id_keySet as jni.JMethodIDPtr)
        .object(const jni.JSetType(jni.JStringType()));
  }
}

final class $CustomGeometrySourceOptionsType
    extends jni.JObjType<CustomGeometrySourceOptions> {
  const $CustomGeometrySourceOptionsType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;';

  @override
  CustomGeometrySourceOptions fromReference(jni.JReference reference) =>
      CustomGeometrySourceOptions.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($CustomGeometrySourceOptionsType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($CustomGeometrySourceOptionsType) &&
        other is $CustomGeometrySourceOptionsType;
  }
}

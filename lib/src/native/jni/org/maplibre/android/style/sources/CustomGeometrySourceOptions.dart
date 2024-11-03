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

/// from: `org.maplibre.android.style.sources.CustomGeometrySourceOptions`
class CustomGeometrySourceOptions extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<CustomGeometrySourceOptions> $type;

  @_$jni.internal
  CustomGeometrySourceOptions.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/style/sources/CustomGeometrySourceOptions');

  /// The type which includes information such as the signature of this class.
  static const type = $CustomGeometrySourceOptions$Type();
  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory CustomGeometrySourceOptions() {
    return CustomGeometrySourceOptions.fromReference(
        _new$(_class.reference.pointer, _id_new$ as _$jni.JMethodIDPtr)
            .reference);
  }

  static final _id_withWrap = _class.instanceMethodId(
    r'withWrap',
    r'(Z)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withWrap = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withWrap(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withWrap(
    bool z,
  ) {
    return _withWrap(
            reference.pointer, _id_withWrap as _$jni.JMethodIDPtr, z ? 1 : 0)
        .object(const $CustomGeometrySourceOptions$Type());
  }

  static final _id_withClip = _class.instanceMethodId(
    r'withClip',
    r'(Z)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withClip = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withClip(boolean z)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withClip(
    bool z,
  ) {
    return _withClip(
            reference.pointer, _id_withClip as _$jni.JMethodIDPtr, z ? 1 : 0)
        .object(const $CustomGeometrySourceOptions$Type());
  }

  static final _id_withMinZoom = _class.instanceMethodId(
    r'withMinZoom',
    r'(I)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withMinZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withMinZoom(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withMinZoom(
    int i,
  ) {
    return _withMinZoom(
            reference.pointer, _id_withMinZoom as _$jni.JMethodIDPtr, i)
        .object(const $CustomGeometrySourceOptions$Type());
  }

  static final _id_withMaxZoom = _class.instanceMethodId(
    r'withMaxZoom',
    r'(I)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withMaxZoom = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withMaxZoom(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withMaxZoom(
    int i,
  ) {
    return _withMaxZoom(
            reference.pointer, _id_withMaxZoom as _$jni.JMethodIDPtr, i)
        .object(const $CustomGeometrySourceOptions$Type());
  }

  static final _id_withBuffer = _class.instanceMethodId(
    r'withBuffer',
    r'(I)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withBuffer = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withBuffer(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withBuffer(
    int i,
  ) {
    return _withBuffer(
            reference.pointer, _id_withBuffer as _$jni.JMethodIDPtr, i)
        .object(const $CustomGeometrySourceOptions$Type());
  }

  static final _id_withTolerance = _class.instanceMethodId(
    r'withTolerance',
    r'(F)Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;',
  );

  static final _withTolerance = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni
                      .VarArgs<(_$jni.Double,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, double)>();

  /// from: `public final org.maplibre.android.style.sources.CustomGeometrySourceOptions withTolerance(float f)`
  /// The returned object must be released after use, by calling the [release] method.
  CustomGeometrySourceOptions withTolerance(
    double f,
  ) {
    return _withTolerance(
            reference.pointer, _id_withTolerance as _$jni.JMethodIDPtr, f)
        .object(const $CustomGeometrySourceOptions$Type());
  }

  static final _id_getSize = _class.instanceMethodId(
    r'getSize',
    r'()I',
  );

  static final _getSize = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public bridge int getSize()`
  int getSize() {
    return _getSize(reference.pointer, _id_getSize as _$jni.JMethodIDPtr)
        .integer;
  }

  static final _id_size = _class.instanceMethodId(
    r'size',
    r'()I',
  );

  static final _size = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          _$jni.JniResult Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public final bridge int size()`
  int size() {
    return _size(reference.pointer, _id_size as _$jni.JMethodIDPtr).integer;
  }

  static final _id_get = _class.instanceMethodId(
    r'get',
    r'(Ljava/lang/String;)Ljava/lang/Object;',
  );

  static final _get = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public bridge java.lang.Object get(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject get(
    _$jni.JString string,
  ) {
    return _get(reference.pointer, _id_get as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_get$1 = _class.instanceMethodId(
    r'get',
    r'(Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _get$1 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final bridge java.lang.Object get(java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject get$1(
    _$jni.JObject object,
  ) {
    return _get$1(reference.pointer, _id_get$1 as _$jni.JMethodIDPtr,
            object.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_containsKey = _class.instanceMethodId(
    r'containsKey',
    r'(Ljava/lang/String;)Z',
  );

  static final _containsKey = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public bridge boolean containsKey(java.lang.String string)`
  bool containsKey(
    _$jni.JString string,
  ) {
    return _containsKey(reference.pointer,
            _id_containsKey as _$jni.JMethodIDPtr, string.reference.pointer)
        .boolean;
  }

  static final _id_containsKey$1 = _class.instanceMethodId(
    r'containsKey',
    r'(Ljava/lang/Object;)Z',
  );

  static final _containsKey$1 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final bridge boolean containsKey(java.lang.Object object)`
  bool containsKey$1(
    _$jni.JObject object,
  ) {
    return _containsKey$1(reference.pointer,
            _id_containsKey$1 as _$jni.JMethodIDPtr, object.reference.pointer)
        .boolean;
  }

  static final _id_remove = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/String;)Ljava/lang/Object;',
  );

  static final _remove = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public bridge java.lang.Object remove(java.lang.String string)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject remove(
    _$jni.JString string,
  ) {
    return _remove(reference.pointer, _id_remove as _$jni.JMethodIDPtr,
            string.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_remove$1 = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _remove$1 = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JniResult Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final bridge java.lang.Object remove(java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject remove$1(
    _$jni.JObject object,
  ) {
    return _remove$1(reference.pointer, _id_remove$1 as _$jni.JMethodIDPtr,
            object.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_remove$2 = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/String;Ljava/lang/Object;)Z',
  );

  static final _remove$2 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public bridge boolean remove(java.lang.String string, java.lang.Object object)`
  bool remove$2(
    _$jni.JString string,
    _$jni.JObject object,
  ) {
    return _remove$2(reference.pointer, _id_remove$2 as _$jni.JMethodIDPtr,
            string.reference.pointer, object.reference.pointer)
        .boolean;
  }

  static final _id_remove$3 = _class.instanceMethodId(
    r'remove',
    r'(Ljava/lang/Object;Ljava/lang/Object;)Z',
  );

  static final _remove$3 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallBooleanMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final bridge boolean remove(java.lang.Object object, java.lang.Object object1)`
  bool remove$3(
    _$jni.JObject object,
    _$jni.JObject object1,
  ) {
    return _remove$3(reference.pointer, _id_remove$3 as _$jni.JMethodIDPtr,
            object.reference.pointer, object1.reference.pointer)
        .boolean;
  }

  static final _id_getValues = _class.instanceMethodId(
    r'getValues',
    r'()Ljava/util/Collection;',
  );

  static final _getValues = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public bridge java.util.Collection getValues()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getValues() {
    return _getValues(reference.pointer, _id_getValues as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_values = _class.instanceMethodId(
    r'values',
    r'()Ljava/util/Collection;',
  );

  static final _values = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final bridge java.util.Collection values()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject values() {
    return _values(reference.pointer, _id_values as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_getOrDefault = _class.instanceMethodId(
    r'getOrDefault',
    r'(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _getOrDefault = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public bridge java.lang.Object getOrDefault(java.lang.String string, java.lang.Object object)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getOrDefault(
    _$jni.JString string,
    _$jni.JObject object,
  ) {
    return _getOrDefault(
            reference.pointer,
            _id_getOrDefault as _$jni.JMethodIDPtr,
            string.reference.pointer,
            object.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_getOrDefault$1 = _class.instanceMethodId(
    r'getOrDefault',
    r'(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;',
  );

  static final _getOrDefault$1 = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<
                      (
                        _$jni.Pointer<_$jni.Void>,
                        _$jni.Pointer<_$jni.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr,
              _$jni.Pointer<_$jni.Void>,
              _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final bridge java.lang.Object getOrDefault(java.lang.Object object, java.lang.Object object1)`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getOrDefault$1(
    _$jni.JObject object,
    _$jni.JObject object1,
  ) {
    return _getOrDefault$1(
            reference.pointer,
            _id_getOrDefault$1 as _$jni.JMethodIDPtr,
            object.reference.pointer,
            object1.reference.pointer)
        .object(const _$jni.JObjectType());
  }

  static final _id_getEntries = _class.instanceMethodId(
    r'getEntries',
    r'()Ljava/util/Set;',
  );

  static final _getEntries = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public bridge java.util.Set getEntries()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JSet<_$jni.JObject> getEntries() {
    return _getEntries(reference.pointer, _id_getEntries as _$jni.JMethodIDPtr)
        .object(const _$jni.JSetType(_$jni.JObjectType()));
  }

  static final _id_entrySet = _class.instanceMethodId(
    r'entrySet',
    r'()Ljava/util/Set;',
  );

  static final _entrySet = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final bridge java.util.Set entrySet()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JSet<_$jni.JObject> entrySet() {
    return _entrySet(reference.pointer, _id_entrySet as _$jni.JMethodIDPtr)
        .object(const _$jni.JSetType(_$jni.JObjectType()));
  }

  static final _id_getKeys = _class.instanceMethodId(
    r'getKeys',
    r'()Ljava/util/Set;',
  );

  static final _getKeys = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public bridge java.util.Set getKeys()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JSet<_$jni.JString> getKeys() {
    return _getKeys(reference.pointer, _id_getKeys as _$jni.JMethodIDPtr)
        .object(const _$jni.JSetType(_$jni.JStringType()));
  }

  static final _id_keySet = _class.instanceMethodId(
    r'keySet',
    r'()Ljava/util/Set;',
  );

  static final _keySet = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final bridge java.util.Set keySet()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JSet<_$jni.JString> keySet() {
    return _keySet(reference.pointer, _id_keySet as _$jni.JMethodIDPtr)
        .object(const _$jni.JSetType(_$jni.JStringType()));
  }
}

final class $CustomGeometrySourceOptions$Type
    extends _$jni.JObjType<CustomGeometrySourceOptions> {
  @_$jni.internal
  const $CustomGeometrySourceOptions$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/style/sources/CustomGeometrySourceOptions;';

  @_$jni.internal
  @_$core.override
  CustomGeometrySourceOptions fromReference(_$jni.JReference reference) =>
      CustomGeometrySourceOptions.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($CustomGeometrySourceOptions$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CustomGeometrySourceOptions$Type) &&
        other is $CustomGeometrySourceOptions$Type;
  }
}

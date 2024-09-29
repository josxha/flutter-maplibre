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

import '../../geometry/LatLng.dart' as latlng_;

import '../../geometry/LatLngBounds.dart' as latlngbounds_;

/// from: `org.maplibre.android.style.sources.TileSet`
class TileSet extends jni.JObject {
  @override
  late final jni.JObjType<TileSet> $type = type;

  TileSet.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/style/sources/TileSet');

  /// The type which includes information such as the signature of this class.
  static const type = $TileSetType();
  static final _id_minZoom = _class.instanceFieldId(
    r'minZoom',
    r'Ljava/lang/Float;',
  );

  /// from: `public java.lang.Float minZoom`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JFloat get minZoom => _id_minZoom.get(this, const jni.JFloatType());

  /// from: `public java.lang.Float minZoom`
  /// The returned object must be released after use, by calling the [release] method.
  set minZoom(jni.JFloat value) =>
      _id_minZoom.set(this, const jni.JFloatType(), value);

  static final _id_maxZoom = _class.instanceFieldId(
    r'maxZoom',
    r'Ljava/lang/Float;',
  );

  /// from: `public java.lang.Float maxZoom`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JFloat get maxZoom => _id_maxZoom.get(this, const jni.JFloatType());

  /// from: `public java.lang.Float maxZoom`
  /// The returned object must be released after use, by calling the [release] method.
  set maxZoom(jni.JFloat value) =>
      _id_maxZoom.set(this, const jni.JFloatType(), value);

  static final _id_new0 = _class.constructorId(
    r'(Ljava/lang/String;[Ljava/lang/String;)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, java.lang.String[] strings)`
  /// The returned object must be released after use, by calling the [release] method.
  factory TileSet(
    jni.JString string,
    jni.JArray<jni.JString> strings,
  ) {
    return TileSet.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            string.reference.pointer,
            strings.reference.pointer)
        .reference);
  }

  static final _id_getTilejson = _class.instanceMethodId(
    r'getTilejson',
    r'()Ljava/lang/String;',
  );

  static final _getTilejson = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getTilejson()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getTilejson() {
    return _getTilejson(reference.pointer, _id_getTilejson as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_getName = _class.instanceMethodId(
    r'getName',
    r'()Ljava/lang/String;',
  );

  static final _getName = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getName()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getName() {
    return _getName(reference.pointer, _id_getName as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setName = _class.instanceMethodId(
    r'setName',
    r'(Ljava/lang/String;)V',
  );

  static final _setName = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setName(java.lang.String string)`
  void setName(
    jni.JString string,
  ) {
    _setName(reference.pointer, _id_setName as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getDescription = _class.instanceMethodId(
    r'getDescription',
    r'()Ljava/lang/String;',
  );

  static final _getDescription = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getDescription()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getDescription() {
    return _getDescription(
            reference.pointer, _id_getDescription as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setDescription = _class.instanceMethodId(
    r'setDescription',
    r'(Ljava/lang/String;)V',
  );

  static final _setDescription = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setDescription(java.lang.String string)`
  void setDescription(
    jni.JString string,
  ) {
    _setDescription(reference.pointer, _id_setDescription as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getVersion = _class.instanceMethodId(
    r'getVersion',
    r'()Ljava/lang/String;',
  );

  static final _getVersion = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getVersion()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getVersion() {
    return _getVersion(reference.pointer, _id_getVersion as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setVersion = _class.instanceMethodId(
    r'setVersion',
    r'(Ljava/lang/String;)V',
  );

  static final _setVersion = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setVersion(java.lang.String string)`
  void setVersion(
    jni.JString string,
  ) {
    _setVersion(reference.pointer, _id_setVersion as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getAttribution = _class.instanceMethodId(
    r'getAttribution',
    r'()Ljava/lang/String;',
  );

  static final _getAttribution = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getAttribution()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getAttribution() {
    return _getAttribution(
            reference.pointer, _id_getAttribution as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setAttribution = _class.instanceMethodId(
    r'setAttribution',
    r'(Ljava/lang/String;)V',
  );

  static final _setAttribution = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setAttribution(java.lang.String string)`
  void setAttribution(
    jni.JString string,
  ) {
    _setAttribution(reference.pointer, _id_setAttribution as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getTemplate = _class.instanceMethodId(
    r'getTemplate',
    r'()Ljava/lang/String;',
  );

  static final _getTemplate = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getTemplate()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getTemplate() {
    return _getTemplate(reference.pointer, _id_getTemplate as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setTemplate = _class.instanceMethodId(
    r'setTemplate',
    r'(Ljava/lang/String;)V',
  );

  static final _setTemplate = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setTemplate(java.lang.String string)`
  void setTemplate(
    jni.JString string,
  ) {
    _setTemplate(reference.pointer, _id_setTemplate as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getLegend = _class.instanceMethodId(
    r'getLegend',
    r'()Ljava/lang/String;',
  );

  static final _getLegend = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getLegend()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getLegend() {
    return _getLegend(reference.pointer, _id_getLegend as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setLegend = _class.instanceMethodId(
    r'setLegend',
    r'(Ljava/lang/String;)V',
  );

  static final _setLegend = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setLegend(java.lang.String string)`
  void setLegend(
    jni.JString string,
  ) {
    _setLegend(reference.pointer, _id_setLegend as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getScheme = _class.instanceMethodId(
    r'getScheme',
    r'()Ljava/lang/String;',
  );

  static final _getScheme = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getScheme()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getScheme() {
    return _getScheme(reference.pointer, _id_getScheme as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setScheme = _class.instanceMethodId(
    r'setScheme',
    r'(Ljava/lang/String;)V',
  );

  static final _setScheme = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setScheme(java.lang.String string)`
  void setScheme(
    jni.JString string,
  ) {
    _setScheme(reference.pointer, _id_setScheme as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_getTiles = _class.instanceMethodId(
    r'getTiles',
    r'()[Ljava/lang/String;',
  );

  static final _getTiles = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String[] getTiles()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JArray<jni.JString> getTiles() {
    return _getTiles(reference.pointer, _id_getTiles as jni.JMethodIDPtr)
        .object(const jni.JArrayType(jni.JStringType()));
  }

  static final _id_getGrids = _class.instanceMethodId(
    r'getGrids',
    r'()[Ljava/lang/String;',
  );

  static final _getGrids = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String[] getGrids()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JArray<jni.JString> getGrids() {
    return _getGrids(reference.pointer, _id_getGrids as jni.JMethodIDPtr)
        .object(const jni.JArrayType(jni.JStringType()));
  }

  static final _id_getData = _class.instanceMethodId(
    r'getData',
    r'()[Ljava/lang/String;',
  );

  static final _getData = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String[] getData()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JArray<jni.JString> getData() {
    return _getData(reference.pointer, _id_getData as jni.JMethodIDPtr)
        .object(const jni.JArrayType(jni.JStringType()));
  }

  static final _id_getBounds = _class.instanceMethodId(
    r'getBounds',
    r'()[Ljava/lang/Float;',
  );

  static final _getBounds = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.Float[] getBounds()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JArray<jni.JFloat> getBounds() {
    return _getBounds(reference.pointer, _id_getBounds as jni.JMethodIDPtr)
        .object(const jni.JArrayType(jni.JFloatType()));
  }

  static final _id_getCenter = _class.instanceMethodId(
    r'getCenter',
    r'()[Ljava/lang/Float;',
  );

  static final _getCenter = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.Float[] getCenter()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JArray<jni.JFloat> getCenter() {
    return _getCenter(reference.pointer, _id_getCenter as jni.JMethodIDPtr)
        .object(const jni.JArrayType(jni.JFloatType()));
  }

  static final _id_getEncoding = _class.instanceMethodId(
    r'getEncoding',
    r'()Ljava/lang/String;',
  );

  static final _getEncoding = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getEncoding()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getEncoding() {
    return _getEncoding(reference.pointer, _id_getEncoding as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setEncoding = _class.instanceMethodId(
    r'setEncoding',
    r'(Ljava/lang/String;)V',
  );

  static final _setEncoding = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setEncoding(java.lang.String string)`
  void setEncoding(
    jni.JString string,
  ) {
    _setEncoding(reference.pointer, _id_setEncoding as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_setGrids = _class.instanceMethodId(
    r'setGrids',
    r'([Ljava/lang/String;)V',
  );

  static final _setGrids = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setGrids(java.lang.String[] strings)`
  void setGrids(
    jni.JArray<jni.JString> strings,
  ) {
    _setGrids(reference.pointer, _id_setGrids as jni.JMethodIDPtr,
            strings.reference.pointer)
        .check();
  }

  static final _id_setData = _class.instanceMethodId(
    r'setData',
    r'([Ljava/lang/String;)V',
  );

  static final _setData = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setData(java.lang.String[] strings)`
  void setData(
    jni.JArray<jni.JString> strings,
  ) {
    _setData(reference.pointer, _id_setData as jni.JMethodIDPtr,
            strings.reference.pointer)
        .check();
  }

  static final _id_getMinZoom = _class.instanceMethodId(
    r'getMinZoom',
    r'()F',
  );

  static final _getMinZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public final float getMinZoom()`
  double getMinZoom() {
    return _getMinZoom(reference.pointer, _id_getMinZoom as jni.JMethodIDPtr)
        .float;
  }

  static final _id_setMinZoom = _class.instanceMethodId(
    r'setMinZoom',
    r'(F)V',
  );

  static final _setMinZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public final void setMinZoom(float f)`
  void setMinZoom(
    double f,
  ) {
    _setMinZoom(reference.pointer, _id_setMinZoom as jni.JMethodIDPtr, f)
        .check();
  }

  static final _id_getMaxZoom = _class.instanceMethodId(
    r'getMaxZoom',
    r'()F',
  );

  static final _getMaxZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public final float getMaxZoom()`
  double getMaxZoom() {
    return _getMaxZoom(reference.pointer, _id_getMaxZoom as jni.JMethodIDPtr)
        .float;
  }

  static final _id_setMaxZoom = _class.instanceMethodId(
    r'setMaxZoom',
    r'(F)V',
  );

  static final _setMaxZoom = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public final void setMaxZoom(float f)`
  void setMaxZoom(
    double f,
  ) {
    _setMaxZoom(reference.pointer, _id_setMaxZoom as jni.JMethodIDPtr, f)
        .check();
  }

  static final _id_setBounds = _class.instanceMethodId(
    r'setBounds',
    r'([F)V',
  );

  static final _setBounds = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setBounds(float[] fs)`
  void setBounds(
    jni.JArray<jni.jfloat> fs,
  ) {
    _setBounds(reference.pointer, _id_setBounds as jni.JMethodIDPtr,
            fs.reference.pointer)
        .check();
  }

  static final _id_setBounds1 = _class.instanceMethodId(
    r'setBounds',
    r'(FFFF)V',
  );

  static final _setBounds1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Double,
                        ffi.Double,
                        ffi.Double,
                        ffi.Double
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              double, double, double, double)>();

  /// from: `public final void setBounds(float f, float f1, float f2, float f3)`
  void setBounds1(
    double f,
    double f1,
    double f2,
    double f3,
  ) {
    _setBounds1(reference.pointer, _id_setBounds1 as jni.JMethodIDPtr, f, f1,
            f2, f3)
        .check();
  }

  static final _id_setBounds2 = _class.instanceMethodId(
    r'setBounds',
    r'([Ljava/lang/Float;)V',
  );

  static final _setBounds2 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setBounds(java.lang.Float[] floats)`
  void setBounds2(
    jni.JArray<jni.JFloat> floats,
  ) {
    _setBounds2(reference.pointer, _id_setBounds2 as jni.JMethodIDPtr,
            floats.reference.pointer)
        .check();
  }

  static final _id_setBounds3 = _class.instanceMethodId(
    r'setBounds',
    r'(Lorg/maplibre/android/geometry/LatLngBounds;)V',
  );

  static final _setBounds3 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setBounds(org.maplibre.android.geometry.LatLngBounds latLngBounds)`
  void setBounds3(
    latlngbounds_.LatLngBounds latLngBounds,
  ) {
    _setBounds3(reference.pointer, _id_setBounds3 as jni.JMethodIDPtr,
            latLngBounds.reference.pointer)
        .check();
  }

  static final _id_setCenter = _class.instanceMethodId(
    r'setCenter',
    r'([F)V',
  );

  static final _setCenter = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setCenter(float[] fs)`
  void setCenter(
    jni.JArray<jni.jfloat> fs,
  ) {
    _setCenter(reference.pointer, _id_setCenter as jni.JMethodIDPtr,
            fs.reference.pointer)
        .check();
  }

  static final _id_setCenter1 = _class.instanceMethodId(
    r'setCenter',
    r'(Lorg/maplibre/android/geometry/LatLng;)V',
  );

  static final _setCenter1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setCenter(org.maplibre.android.geometry.LatLng latLng)`
  void setCenter1(
    latlng_.LatLng latLng,
  ) {
    _setCenter1(reference.pointer, _id_setCenter1 as jni.JMethodIDPtr,
            latLng.reference.pointer)
        .check();
  }

  static final _id_toValueObject = _class.instanceMethodId(
    r'toValueObject',
    r'()Ljava/util/Map;',
  );

  static final _toValueObject = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.util.Map toValueObject()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JMap<jni.JString, jni.JObject> toValueObject() {
    return _toValueObject(
            reference.pointer, _id_toValueObject as jni.JMethodIDPtr)
        .object(const jni.JMapType(jni.JStringType(), jni.JObjectType()));
  }
}

final class $TileSetType extends jni.JObjType<TileSet> {
  const $TileSetType();

  @override
  String get signature => r'Lorg/maplibre/android/style/sources/TileSet;';

  @override
  TileSet fromReference(jni.JReference reference) =>
      TileSet.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($TileSetType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($TileSetType) && other is $TileSetType;
  }
}

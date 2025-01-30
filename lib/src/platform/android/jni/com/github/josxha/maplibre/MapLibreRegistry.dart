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

import '../../../../org/maplibre/android/maps/MapLibreMap.dart'
    as maplibremap$_;

/// from: `com.github.josxha.maplibre.MapLibreRegistry`
class MapLibreRegistry extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<MapLibreRegistry> $type;

  @jni$_.internal
  MapLibreRegistry.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'com/github/josxha/maplibre/MapLibreRegistry');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $MapLibreRegistry$NullableType();
  static const type = $MapLibreRegistry$Type();
  static final _id_INSTANCE = _class.staticFieldId(
    r'INSTANCE',
    r'Lcom/github/josxha/maplibre/MapLibreRegistry;',
  );

  /// from: `static public final com.github.josxha.maplibre.MapLibreRegistry INSTANCE`
  /// The returned object must be released after use, by calling the [release] method.
  static MapLibreRegistry get INSTANCE =>
      _id_INSTANCE.get(_class, const $MapLibreRegistry$Type());

  static final _id_getMap = _class.instanceMethodId(
    r'getMap',
    r'(I)Lorg/maplibre/android/maps/MapLibreMap;',
  );

  static final _getMap = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.maps.MapLibreMap getMap(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  maplibremap$_.MapLibreMap? getMap(
    int i,
  ) {
    return _getMap(reference.pointer, _id_getMap as jni$_.JMethodIDPtr, i)
        .object<maplibremap$_.MapLibreMap?>(
            const maplibremap$_.$MapLibreMap$NullableType());
  }

  static final _id_addMap = _class.instanceMethodId(
    r'addMap',
    r'(ILorg/maplibre/android/maps/MapLibreMap;)V',
  );

  static final _addMap = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_
                          .VarArgs<(jni$_.Int32, jni$_.Pointer<jni$_.Void>)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, int, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final void addMap(int i, org.maplibre.android.maps.MapLibreMap mapLibreMap)`
  void addMap(
    int i,
    maplibremap$_.MapLibreMap mapLibreMap,
  ) {
    final _$mapLibreMap = mapLibreMap.reference;
    _addMap(reference.pointer, _id_addMap as jni$_.JMethodIDPtr, i,
            _$mapLibreMap.pointer)
        .check();
  }

  static final _id_getActivity = _class.instanceMethodId(
    r'getActivity',
    r'()Landroid/app/Activity;',
  );

  static final _getActivity = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public final android.app.Activity getActivity()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getActivity() {
    return _getActivity(
            reference.pointer, _id_getActivity as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_setActivity = _class.instanceMethodId(
    r'setActivity',
    r'(Landroid/app/Activity;)V',
  );

  static final _setActivity = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final void setActivity(android.app.Activity activity)`
  void setActivity(
    jni$_.JObject? activity,
  ) {
    final _$activity = activity?.reference ?? jni$_.jNullReference;
    _setActivity(reference.pointer, _id_setActivity as jni$_.JMethodIDPtr,
            _$activity.pointer)
        .check();
  }

  static final _id_getContext = _class.instanceMethodId(
    r'getContext',
    r'()Landroid/content/Context;',
  );

  static final _getContext = jni$_.ProtectedJniExtensions.lookup<
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

  /// from: `public final android.content.Context getContext()`
  /// The returned object must be released after use, by calling the [release] method.
  jni$_.JObject? getContext() {
    return _getContext(reference.pointer, _id_getContext as jni$_.JMethodIDPtr)
        .object<jni$_.JObject?>(const jni$_.JObjectNullableType());
  }

  static final _id_setContext = _class.instanceMethodId(
    r'setContext',
    r'(Landroid/content/Context;)V',
  );

  static final _setContext = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_.VarArgs<(jni$_.Pointer<jni$_.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final void setContext(android.content.Context context)`
  void setContext(
    jni$_.JObject? context,
  ) {
    final _$context = context?.reference ?? jni$_.jNullReference;
    _setContext(reference.pointer, _id_setContext as jni$_.JMethodIDPtr,
            _$context.pointer)
        .check();
  }
}

final class $MapLibreRegistry$NullableType
    extends jni$_.JObjType<MapLibreRegistry?> {
  @jni$_.internal
  const $MapLibreRegistry$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lcom/github/josxha/maplibre/MapLibreRegistry;';

  @jni$_.internal
  @core$_.override
  MapLibreRegistry? fromReference(jni$_.JReference reference) =>
      reference.isNull
          ? null
          : MapLibreRegistry.fromReference(
              reference,
            );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreRegistry?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreRegistry$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreRegistry$NullableType) &&
        other is $MapLibreRegistry$NullableType;
  }
}

final class $MapLibreRegistry$Type extends jni$_.JObjType<MapLibreRegistry> {
  @jni$_.internal
  const $MapLibreRegistry$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lcom/github/josxha/maplibre/MapLibreRegistry;';

  @jni$_.internal
  @core$_.override
  MapLibreRegistry fromReference(jni$_.JReference reference) =>
      MapLibreRegistry.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<MapLibreRegistry?> get nullableType =>
      const $MapLibreRegistry$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($MapLibreRegistry$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreRegistry$Type) &&
        other is $MapLibreRegistry$Type;
  }
}

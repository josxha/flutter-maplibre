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

import '../../../../org/maplibre/android/maps/MapLibreMap.dart' as maplibremap_;

/// from: `com.github.josxha.maplibre.MapLibreRegistry`
class MapLibreRegistry extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<MapLibreRegistry> $type;

  @_$jni.internal
  MapLibreRegistry.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      _$jni.JClass.forName(r'com/github/josxha/maplibre/MapLibreRegistry');

  /// The type which includes information such as the signature of this class.
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

  static final _getMap = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JniResult Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          _$jni.JniResult Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public final org.maplibre.android.maps.MapLibreMap getMap(int i)`
  /// The returned object must be released after use, by calling the [release] method.
  maplibremap_.MapLibreMap getMap(
    int i,
  ) {
    return _getMap(reference.pointer, _id_getMap as _$jni.JMethodIDPtr, i)
        .object(const maplibremap_.$MapLibreMap$Type());
  }

  static final _id_addMap = _class.instanceMethodId(
    r'addMap',
    r'(ILorg/maplibre/android/maps/MapLibreMap;)V',
  );

  static final _addMap = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni
                          .VarArgs<(_$jni.Int32, _$jni.Pointer<_$jni.Void>)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, int, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void addMap(int i, org.maplibre.android.maps.MapLibreMap mapLibreMap)`
  void addMap(
    int i,
    maplibremap_.MapLibreMap mapLibreMap,
  ) {
    _addMap(reference.pointer, _id_addMap as _$jni.JMethodIDPtr, i,
            mapLibreMap.reference.pointer)
        .check();
  }

  static final _id_getActivityPluginBinding = _class.instanceMethodId(
    r'getActivityPluginBinding',
    r'()Lio/flutter/embedding/engine/plugins/activity/ActivityPluginBinding;',
  );

  static final _getActivityPluginBinding = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding getActivityPluginBinding()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getActivityPluginBinding() {
    return _getActivityPluginBinding(reference.pointer,
            _id_getActivityPluginBinding as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_setActivityPluginBinding = _class.instanceMethodId(
    r'setActivityPluginBinding',
    r'(Lio/flutter/embedding/engine/plugins/activity/ActivityPluginBinding;)V',
  );

  static final _setActivityPluginBinding = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setActivityPluginBinding(io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding activityPluginBinding)`
  void setActivityPluginBinding(
    _$jni.JObject activityPluginBinding,
  ) {
    _setActivityPluginBinding(
            reference.pointer,
            _id_setActivityPluginBinding as _$jni.JMethodIDPtr,
            activityPluginBinding.reference.pointer)
        .check();
  }

  static final _id_getActivity = _class.instanceMethodId(
    r'getActivity',
    r'()Landroid/app/Activity;',
  );

  static final _getActivity = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final android.app.Activity getActivity()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getActivity() {
    return _getActivity(
            reference.pointer, _id_getActivity as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_setActivity = _class.instanceMethodId(
    r'setActivity',
    r'(Landroid/app/Activity;)V',
  );

  static final _setActivity = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setActivity(android.app.Activity activity)`
  void setActivity(
    _$jni.JObject activity,
  ) {
    _setActivity(reference.pointer, _id_setActivity as _$jni.JMethodIDPtr,
            activity.reference.pointer)
        .check();
  }

  static final _id_getContext = _class.instanceMethodId(
    r'getContext',
    r'()Landroid/content/Context;',
  );

  static final _getContext = _$jni.ProtectedJniExtensions.lookup<
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

  /// from: `public final android.content.Context getContext()`
  /// The returned object must be released after use, by calling the [release] method.
  _$jni.JObject getContext() {
    return _getContext(reference.pointer, _id_getContext as _$jni.JMethodIDPtr)
        .object(const _$jni.JObjectType());
  }

  static final _id_setContext = _class.instanceMethodId(
    r'setContext',
    r'(Landroid/content/Context;)V',
  );

  static final _setContext = _$jni.ProtectedJniExtensions.lookup<
              _$jni.NativeFunction<
                  _$jni.JThrowablePtr Function(
                      _$jni.Pointer<_$jni.Void>,
                      _$jni.JMethodIDPtr,
                      _$jni.VarArgs<(_$jni.Pointer<_$jni.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(_$jni.Pointer<_$jni.Void>,
              _$jni.JMethodIDPtr, _$jni.Pointer<_$jni.Void>)>();

  /// from: `public final void setContext(android.content.Context context)`
  void setContext(
    _$jni.JObject context,
  ) {
    _setContext(reference.pointer, _id_setContext as _$jni.JMethodIDPtr,
            context.reference.pointer)
        .check();
  }
}

final class $MapLibreRegistry$Type extends _$jni.JObjType<MapLibreRegistry> {
  @_$jni.internal
  const $MapLibreRegistry$Type();

  @_$jni.internal
  @_$core.override
  String get signature => r'Lcom/github/josxha/maplibre/MapLibreRegistry;';

  @_$jni.internal
  @_$core.override
  MapLibreRegistry fromReference(_$jni.JReference reference) =>
      MapLibreRegistry.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($MapLibreRegistry$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibreRegistry$Type) &&
        other is $MapLibreRegistry$Type;
  }
}

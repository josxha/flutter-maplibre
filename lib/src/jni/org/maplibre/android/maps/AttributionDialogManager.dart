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

import 'MapLibreMap.dart' as maplibremap_;

/// from: `org.maplibre.android.maps.AttributionDialogManager`
class AttributionDialogManager extends jni.JObject {
  @override
  late final jni.JObjType<AttributionDialogManager> $type = type;

  AttributionDialogManager.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/maps/AttributionDialogManager');

  /// The type which includes information such as the signature of this class.
  static const type = $AttributionDialogManagerType();
  static final _id_new0 = _class.constructorId(
    r'(Landroid/content/Context;Lorg/maplibre/android/maps/MapLibreMap;)V',
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

  /// from: `public void <init>(android.content.Context context, org.maplibre.android.maps.MapLibreMap mapLibreMap)`
  /// The returned object must be released after use, by calling the [release] method.
  factory AttributionDialogManager(
    jni.JObject context,
    maplibremap_.MapLibreMap mapLibreMap,
  ) {
    return AttributionDialogManager.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            context.reference.pointer,
            mapLibreMap.reference.pointer)
        .reference);
  }

  static final _id_onClick = _class.instanceMethodId(
    r'onClick',
    r'(Landroid/view/View;)V',
  );

  static final _onClick = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void onClick(android.view.View view)`
  void onClick(
    jni.JObject view,
  ) {
    _onClick(reference.pointer, _id_onClick as jni.JMethodIDPtr,
            view.reference.pointer)
        .check();
  }

  static final _id_showAttributionDialog = _class.instanceMethodId(
    r'showAttributionDialog',
    r'([Ljava/lang/String;)V',
  );

  static final _showAttributionDialog = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `protected void showAttributionDialog(java.lang.String[] strings)`
  void showAttributionDialog(
    jni.JArray<jni.JString> strings,
  ) {
    _showAttributionDialog(
            reference.pointer,
            _id_showAttributionDialog as jni.JMethodIDPtr,
            strings.reference.pointer)
        .check();
  }

  static final _id_onClick1 = _class.instanceMethodId(
    r'onClick',
    r'(Landroid/content/DialogInterface;I)V',
  );

  static final _onClick1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, $Int32)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int)>();

  /// from: `public void onClick(android.content.DialogInterface dialogInterface, int i)`
  void onClick1(
    jni.JObject dialogInterface,
    int i,
  ) {
    _onClick1(reference.pointer, _id_onClick1 as jni.JMethodIDPtr,
            dialogInterface.reference.pointer, i)
        .check();
  }

  static final _id_onStop = _class.instanceMethodId(
    r'onStop',
    r'()V',
  );

  static final _onStop = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void onStop()`
  void onStop() {
    _onStop(reference.pointer, _id_onStop as jni.JMethodIDPtr).check();
  }
}

final class $AttributionDialogManagerType
    extends jni.JObjType<AttributionDialogManager> {
  const $AttributionDialogManagerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/AttributionDialogManager;';

  @override
  AttributionDialogManager fromReference(jni.JReference reference) =>
      AttributionDialogManager.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($AttributionDialogManagerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionDialogManagerType) &&
        other is $AttributionDialogManagerType;
  }
}

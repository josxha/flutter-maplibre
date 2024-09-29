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

/// from: `org.maplibre.android.location.OnRenderModeChangedListener`
class OnRenderModeChangedListener extends jni.JObject {
  @override
  late final jni.JObjType<OnRenderModeChangedListener> $type = type;

  OnRenderModeChangedListener.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/OnRenderModeChangedListener');

  /// The type which includes information such as the signature of this class.
  static const type = $OnRenderModeChangedListenerType();
  static final _id_onRenderModeChanged = _class.instanceMethodId(
    r'onRenderModeChanged',
    r'(I)V',
  );

  static final _onRenderModeChanged = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public abstract void onRenderModeChanged(int i)`
  void onRenderModeChanged(
    int i,
  ) {
    _onRenderModeChanged(
            reference.pointer, _id_onRenderModeChanged as jni.JMethodIDPtr, i)
        .check();
  }
}

final class $OnRenderModeChangedListenerType
    extends jni.JObjType<OnRenderModeChangedListener> {
  const $OnRenderModeChangedListenerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/OnRenderModeChangedListener;';

  @override
  OnRenderModeChangedListener fromReference(jni.JReference reference) =>
      OnRenderModeChangedListener.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($OnRenderModeChangedListenerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($OnRenderModeChangedListenerType) &&
        other is $OnRenderModeChangedListenerType;
  }
}

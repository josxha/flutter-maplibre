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

import 'PropertyValue.dart' as propertyvalue_;

/// from: `org.maplibre.android.style.layers.PaintPropertyValue`
class PaintPropertyValue<$T extends jni.JObject>
    extends propertyvalue_.PropertyValue<$T> {
  @override
  late final jni.JObjType<PaintPropertyValue<$T>> $type = type(T);

  final jni.JObjType<$T> T;

  PaintPropertyValue.fromReference(
    this.T,
    jni.JReference reference,
  ) : super.fromReference(T, reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/style/layers/PaintPropertyValue');

  /// The type which includes information such as the signature of this class.
  static $PaintPropertyValueType<$T> type<$T extends jni.JObject>(
    jni.JObjType<$T> T,
  ) {
    return $PaintPropertyValueType(
      T,
    );
  }

  static final _id_new0 = _class.constructorId(
    r'(Ljava/lang/String;Ljava/lang/Object;)V',
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

  /// from: `public void <init>(java.lang.String string, T object)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PaintPropertyValue(
    jni.JString string,
    $T object, {
    jni.JObjType<$T>? T,
  }) {
    T ??= jni.lowestCommonSuperType([
      object.$type,
    ]) as jni.JObjType<$T>;
    return PaintPropertyValue.fromReference(
        T,
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr,
                string.reference.pointer, object.reference.pointer)
            .reference);
  }
}

final class $PaintPropertyValueType<$T extends jni.JObject>
    extends jni.JObjType<PaintPropertyValue<$T>> {
  final jni.JObjType<$T> T;

  const $PaintPropertyValueType(
    this.T,
  );

  @override
  String get signature =>
      r'Lorg/maplibre/android/style/layers/PaintPropertyValue;';

  @override
  PaintPropertyValue<$T> fromReference(jni.JReference reference) =>
      PaintPropertyValue.fromReference(T, reference);

  @override
  jni.JObjType get superType => propertyvalue_.$PropertyValueType(T);

  @override
  final superCount = 2;

  @override
  int get hashCode => Object.hash($PaintPropertyValueType, T);

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($PaintPropertyValueType<$T>) &&
        other is $PaintPropertyValueType<$T> &&
        T == other.T;
  }
}
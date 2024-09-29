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

import '../maps/MapLibreMap.dart' as maplibremap_;

import 'MapLibreAnimator.dart' as maplibreanimator_;

/// from: `org.maplibre.android.location.MapLibrePaddingAnimator`
class MapLibrePaddingAnimator
    extends maplibreanimator_.MapLibreAnimator<jni.JArray<jni.jdouble>> {
  @override
  late final jni.JObjType<MapLibrePaddingAnimator> $type = type;

  MapLibrePaddingAnimator.fromReference(
    jni.JReference reference,
  ) : super.fromReference(const jni.JArrayType(jni.jdoubleType()), reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/MapLibrePaddingAnimator');

  /// The type which includes information such as the signature of this class.
  static const type = $MapLibrePaddingAnimatorType();
  static final _id_new2 = _class.constructorId(
    r'([[DLorg/maplibre/android/location/MapLibreAnimator$AnimationsValueChangeListener;Lorg/maplibre/android/maps/MapLibreMap$CancelableCallback;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(java.lang.Object[] ds, org.maplibre.android.location.MapLibreAnimator$AnimationsValueChangeListener animationsValueChangeListener, org.maplibre.android.maps.MapLibreMap$CancelableCallback cancelableCallback)`
  /// The returned object must be released after use, by calling the [release] method.
  factory MapLibrePaddingAnimator.new2(
    jni.JArray<jni.JArray<jni.jdouble>> ds,
    jni.JObject animationsValueChangeListener,
    maplibremap_.MapLibreMap_CancelableCallback cancelableCallback,
  ) {
    return MapLibrePaddingAnimator.fromReference(_new2(
            _class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr,
            ds.reference.pointer,
            animationsValueChangeListener.reference.pointer,
            cancelableCallback.reference.pointer)
        .reference);
  }

  static final _id_provideEvaluator = _class.instanceMethodId(
    r'provideEvaluator',
    r'()Landroid/animation/TypeEvaluator;',
  );

  static final _provideEvaluator = ProtectedJniExtensions.lookup<
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

  /// from: `public android.animation.TypeEvaluator provideEvaluator()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject provideEvaluator() {
    return _provideEvaluator(
            reference.pointer, _id_provideEvaluator as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }
}

final class $MapLibrePaddingAnimatorType
    extends jni.JObjType<MapLibrePaddingAnimator> {
  const $MapLibrePaddingAnimatorType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/MapLibrePaddingAnimator;';

  @override
  MapLibrePaddingAnimator fromReference(jni.JReference reference) =>
      MapLibrePaddingAnimator.fromReference(reference);

  @override
  jni.JObjType get superType => const maplibreanimator_.$MapLibreAnimatorType(
      jni.JArrayType(jni.jdoubleType()));

  @override
  final superCount = 2;

  @override
  int get hashCode => ($MapLibrePaddingAnimatorType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapLibrePaddingAnimatorType) &&
        other is $MapLibrePaddingAnimatorType;
  }
}

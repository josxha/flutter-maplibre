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

/// from: `org.maplibre.android.location.PulsingLocationCircleAnimator`
class PulsingLocationCircleAnimator extends jni.JObject {
  @override
  late final jni.JObjType<PulsingLocationCircleAnimator> $type = type;

  PulsingLocationCircleAnimator.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/PulsingLocationCircleAnimator');

  /// The type which includes information such as the signature of this class.
  static const type = $PulsingLocationCircleAnimatorType();
  static final _id_new0 = _class.constructorId(
    r'(Lorg/maplibre/android/location/MapLibreAnimator$AnimationsValueChangeListener;IF)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        $Int32,
                        ffi.Double
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int, double)>();

  /// from: `public void <init>(org.maplibre.android.location.MapLibreAnimator$AnimationsValueChangeListener animationsValueChangeListener, int i, float f)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PulsingLocationCircleAnimator(
    jni.JObject animationsValueChangeListener,
    int i,
    double f,
  ) {
    return PulsingLocationCircleAnimator.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            animationsValueChangeListener.reference.pointer,
            i,
            f)
        .reference);
  }
}

final class $PulsingLocationCircleAnimatorType
    extends jni.JObjType<PulsingLocationCircleAnimator> {
  const $PulsingLocationCircleAnimatorType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/PulsingLocationCircleAnimator;';

  @override
  PulsingLocationCircleAnimator fromReference(jni.JReference reference) =>
      PulsingLocationCircleAnimator.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($PulsingLocationCircleAnimatorType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($PulsingLocationCircleAnimatorType) &&
        other is $PulsingLocationCircleAnimatorType;
  }
}

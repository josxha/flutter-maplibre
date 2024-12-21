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

/// from: `org.maplibre.android.location.CompassListener`
class CompassListener extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<CompassListener> $type;

  @jni$_.internal
  CompassListener.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/location/CompassListener');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $CompassListener$NullableType();
  static const type = $CompassListener$Type();
  static final _id_onCompassChanged = _class.instanceMethodId(
    r'onCompassChanged',
    r'(F)V',
  );

  static final _onCompassChanged = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Double,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, double)>();

  /// from: `public abstract void onCompassChanged(float f)`
  void onCompassChanged(
    double f,
  ) {
    _onCompassChanged(
            reference.pointer, _id_onCompassChanged as jni$_.JMethodIDPtr, f)
        .check();
  }

  static final _id_onCompassAccuracyChange = _class.instanceMethodId(
    r'onCompassAccuracyChange',
    r'(I)V',
  );

  static final _onCompassAccuracyChange = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JThrowablePtr Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<(jni$_.Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(
              jni$_.Pointer<jni$_.Void>, jni$_.JMethodIDPtr, int)>();

  /// from: `public abstract void onCompassAccuracyChange(int i)`
  void onCompassAccuracyChange(
    int i,
  ) {
    _onCompassAccuracyChange(reference.pointer,
            _id_onCompassAccuracyChange as jni$_.JMethodIDPtr, i)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $CompassListener> _$impls = {};
  static jni$_.JObjectPtr _$invoke(
    int port,
    jni$_.JObjectPtr descriptor,
    jni$_.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      jni$_.MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final jni$_.Pointer<
          jni$_.NativeFunction<
              jni$_.JObjectPtr Function(
                  jni$_.Int64, jni$_.JObjectPtr, jni$_.JObjectPtr)>>
      _$invokePointer = jni$_.Pointer.fromFunction(_$invoke);

  static jni$_.Pointer<jni$_.Void> _$invokeMethod(
    int $p,
    jni$_.MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onCompassChanged(F)V') {
        _$impls[$p]!.onCompassChanged(
          $a![0]!
              .as(const jni$_.JFloatType(), releaseOriginal: true)
              .floatValue(releaseOriginal: true),
        );
        return jni$_.nullptr;
      }
      if ($d == r'onCompassAccuracyChange(I)V') {
        _$impls[$p]!.onCompassAccuracyChange(
          $a![0]!
              .as(const jni$_.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
        );
        return jni$_.nullptr;
      }
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn(
    jni$_.JImplementer implementer,
    $CompassListener $impl,
  ) {
    late final jni$_.RawReceivePort $p;
    $p = jni$_.RawReceivePort(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = jni$_.MethodInvocation.fromMessage($m);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      jni$_.ProtectedJniExtensions.returnResult($i.result, $r);
    });
    implementer.add(
      r'org.maplibre.android.location.CompassListener',
      $p,
      _$invokePointer,
      [
        if ($impl.onCompassChanged$async) r'onCompassChanged(F)V',
        if ($impl.onCompassAccuracyChange$async) r'onCompassAccuracyChange(I)V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory CompassListener.implement(
    $CompassListener $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return CompassListener.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $CompassListener {
  factory $CompassListener({
    required void Function(double f) onCompassChanged,
    bool onCompassChanged$async,
    required void Function(int i) onCompassAccuracyChange,
    bool onCompassAccuracyChange$async,
  }) = _$CompassListener;

  void onCompassChanged(double f);
  bool get onCompassChanged$async => false;
  void onCompassAccuracyChange(int i);
  bool get onCompassAccuracyChange$async => false;
}

final class _$CompassListener with $CompassListener {
  _$CompassListener({
    required void Function(double f) onCompassChanged,
    this.onCompassChanged$async = false,
    required void Function(int i) onCompassAccuracyChange,
    this.onCompassAccuracyChange$async = false,
  })  : _onCompassChanged = onCompassChanged,
        _onCompassAccuracyChange = onCompassAccuracyChange;

  final void Function(double f) _onCompassChanged;
  final bool onCompassChanged$async;
  final void Function(int i) _onCompassAccuracyChange;
  final bool onCompassAccuracyChange$async;

  void onCompassChanged(double f) {
    return _onCompassChanged(f);
  }

  void onCompassAccuracyChange(int i) {
    return _onCompassAccuracyChange(i);
  }
}

final class $CompassListener$NullableType
    extends jni$_.JObjType<CompassListener?> {
  @jni$_.internal
  const $CompassListener$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/CompassListener;';

  @jni$_.internal
  @core$_.override
  CompassListener? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : CompassListener.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CompassListener?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CompassListener$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CompassListener$NullableType) &&
        other is $CompassListener$NullableType;
  }
}

final class $CompassListener$Type extends jni$_.JObjType<CompassListener> {
  @jni$_.internal
  const $CompassListener$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/CompassListener;';

  @jni$_.internal
  @core$_.override
  CompassListener fromReference(jni$_.JReference reference) =>
      CompassListener.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CompassListener?> get nullableType =>
      const $CompassListener$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CompassListener$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CompassListener$Type) &&
        other is $CompassListener$Type;
  }
}
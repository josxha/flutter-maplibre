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

/// from: `org.maplibre.android.location.OnCameraTrackingChangedListener`
class OnCameraTrackingChangedListener extends _$jni.JObject {
  @_$jni.internal
  @_$core.override
  final _$jni.JObjType<OnCameraTrackingChangedListener> $type;

  @_$jni.internal
  OnCameraTrackingChangedListener.fromReference(
    _$jni.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = _$jni.JClass.forName(
      r'org/maplibre/android/location/OnCameraTrackingChangedListener');

  /// The type which includes information such as the signature of this class.
  static const type = $OnCameraTrackingChangedListener$Type();
  static final _id_onCameraTrackingDismissed = _class.instanceMethodId(
    r'onCameraTrackingDismissed',
    r'()V',
  );

  static final _onCameraTrackingDismissed = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                _$jni.Pointer<_$jni.Void>,
                _$jni.JMethodIDPtr,
              )>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
            _$jni.Pointer<_$jni.Void>,
            _$jni.JMethodIDPtr,
          )>();

  /// from: `public abstract void onCameraTrackingDismissed()`
  void onCameraTrackingDismissed() {
    _onCameraTrackingDismissed(reference.pointer,
            _id_onCameraTrackingDismissed as _$jni.JMethodIDPtr)
        .check();
  }

  static final _id_onCameraTrackingChanged = _class.instanceMethodId(
    r'onCameraTrackingChanged',
    r'(I)V',
  );

  static final _onCameraTrackingChanged = _$jni.ProtectedJniExtensions.lookup<
          _$jni.NativeFunction<
              _$jni.JThrowablePtr Function(
                  _$jni.Pointer<_$jni.Void>,
                  _$jni.JMethodIDPtr,
                  _$jni.VarArgs<(_$jni.Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          _$jni.JThrowablePtr Function(
              _$jni.Pointer<_$jni.Void>, _$jni.JMethodIDPtr, int)>();

  /// from: `public abstract void onCameraTrackingChanged(int i)`
  void onCameraTrackingChanged(
    int i,
  ) {
    _onCameraTrackingChanged(reference.pointer,
            _id_onCameraTrackingChanged as _$jni.JMethodIDPtr, i)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final _$core.Map<int, $OnCameraTrackingChangedListener> _$impls = {};
  static _$jni.JObjectPtr _$invoke(
    int port,
    _$jni.JObjectPtr descriptor,
    _$jni.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      _$jni.MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final _$jni.Pointer<
          _$jni.NativeFunction<
              _$jni.JObjectPtr Function(
                  _$jni.Int64, _$jni.JObjectPtr, _$jni.JObjectPtr)>>
      _$invokePointer = _$jni.Pointer.fromFunction(_$invoke);

  static _$jni.Pointer<_$jni.Void> _$invokeMethod(
    int $p,
    _$jni.MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onCameraTrackingDismissed()V') {
        _$impls[$p]!.onCameraTrackingDismissed();
        return _$jni.nullptr;
      }
      if ($d == r'onCameraTrackingChanged(I)V') {
        _$impls[$p]!.onCameraTrackingChanged(
          $a[0]
              .as(const _$jni.JIntegerType(), releaseOriginal: true)
              .intValue(releaseOriginal: true),
        );
        return _$jni.nullptr;
      }
    } catch (e) {
      return _$jni.ProtectedJniExtensions.newDartException(e);
    }
    return _$jni.nullptr;
  }

  static void implementIn(
    _$jni.JImplementer implementer,
    $OnCameraTrackingChangedListener $impl,
  ) {
    late final _$jni.RawReceivePort $p;
    $p = _$jni.RawReceivePort(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = _$jni.MethodInvocation.fromMessage($m);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      _$jni.ProtectedJniExtensions.returnResult($i.result, $r);
    });
    implementer.add(
      r'org.maplibre.android.location.OnCameraTrackingChangedListener',
      $p,
      _$invokePointer,
      [
        if ($impl.onCameraTrackingDismissed$async)
          r'onCameraTrackingDismissed()V',
        if ($impl.onCameraTrackingChanged$async) r'onCameraTrackingChanged(I)V',
      ],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory OnCameraTrackingChangedListener.implement(
    $OnCameraTrackingChangedListener $impl,
  ) {
    final $i = _$jni.JImplementer();
    implementIn($i, $impl);
    return OnCameraTrackingChangedListener.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $OnCameraTrackingChangedListener {
  factory $OnCameraTrackingChangedListener({
    required void Function() onCameraTrackingDismissed,
    bool onCameraTrackingDismissed$async,
    required void Function(int i) onCameraTrackingChanged,
    bool onCameraTrackingChanged$async,
  }) = _$OnCameraTrackingChangedListener;

  void onCameraTrackingDismissed();
  bool get onCameraTrackingDismissed$async => false;
  void onCameraTrackingChanged(int i);
  bool get onCameraTrackingChanged$async => false;
}

final class _$OnCameraTrackingChangedListener
    with $OnCameraTrackingChangedListener {
  _$OnCameraTrackingChangedListener({
    required void Function() onCameraTrackingDismissed,
    this.onCameraTrackingDismissed$async = false,
    required void Function(int i) onCameraTrackingChanged,
    this.onCameraTrackingChanged$async = false,
  })  : _onCameraTrackingDismissed = onCameraTrackingDismissed,
        _onCameraTrackingChanged = onCameraTrackingChanged;

  final void Function() _onCameraTrackingDismissed;
  final bool onCameraTrackingDismissed$async;
  final void Function(int i) _onCameraTrackingChanged;
  final bool onCameraTrackingChanged$async;

  void onCameraTrackingDismissed() {
    return _onCameraTrackingDismissed();
  }

  void onCameraTrackingChanged(int i) {
    return _onCameraTrackingChanged(i);
  }
}

final class $OnCameraTrackingChangedListener$Type
    extends _$jni.JObjType<OnCameraTrackingChangedListener> {
  @_$jni.internal
  const $OnCameraTrackingChangedListener$Type();

  @_$jni.internal
  @_$core.override
  String get signature =>
      r'Lorg/maplibre/android/location/OnCameraTrackingChangedListener;';

  @_$jni.internal
  @_$core.override
  OnCameraTrackingChangedListener fromReference(_$jni.JReference reference) =>
      OnCameraTrackingChangedListener.fromReference(reference);

  @_$jni.internal
  @_$core.override
  _$jni.JObjType get superType => const _$jni.JObjectType();

  @_$jni.internal
  @_$core.override
  final superCount = 1;

  @_$core.override
  int get hashCode => ($OnCameraTrackingChangedListener$Type).hashCode;

  @_$core.override
  bool operator ==(Object other) {
    return other.runtimeType == ($OnCameraTrackingChangedListener$Type) &&
        other is $OnCameraTrackingChangedListener$Type;
  }
}
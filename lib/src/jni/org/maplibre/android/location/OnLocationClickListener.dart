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

/// from: `org.maplibre.android.location.OnLocationClickListener`
class OnLocationClickListener extends jni.JObject {
  @override
  late final jni.JObjType<OnLocationClickListener> $type = type;

  OnLocationClickListener.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/OnLocationClickListener');

  /// The type which includes information such as the signature of this class.
  static const type = $OnLocationClickListenerType();
  static final _id_onLocationComponentClick = _class.instanceMethodId(
    r'onLocationComponentClick',
    r'()V',
  );

  static final _onLocationComponentClick = ProtectedJniExtensions.lookup<
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

  /// from: `public abstract void onLocationComponentClick()`
  void onLocationComponentClick() {
    _onLocationComponentClick(
            reference.pointer, _id_onLocationComponentClick as jni.JMethodIDPtr)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $OnLocationClickListenerImpl> _$impls = {};
  ReceivePort? _$p;

  static jni.JObjectPtr _$invoke(
    int port,
    jni.JObjectPtr descriptor,
    jni.JObjectPtr args,
  ) {
    return _$invokeMethod(
      port,
      $MethodInvocation.fromAddresses(
        0,
        descriptor.address,
        args.address,
      ),
    );
  }

  static final ffi.Pointer<
          ffi.NativeFunction<
              jni.JObjectPtr Function(
                  ffi.Uint64, jni.JObjectPtr, jni.JObjectPtr)>>
      _$invokePointer = ffi.Pointer.fromFunction(_$invoke);

  static ffi.Pointer<ffi.Void> _$invokeMethod(
    int $p,
    $MethodInvocation $i,
  ) {
    try {
      final $d = $i.methodDescriptor.toDartString(releaseOriginal: true);
      final $a = $i.args;
      if ($d == r'onLocationComponentClick()V') {
        _$impls[$p]!.onLocationComponentClick();
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory OnLocationClickListener.implement(
    $OnLocationClickListenerImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = OnLocationClickListener.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.location.OnLocationClickListener',
        $p,
        _$invokePointer,
      ),
    ).._$p = $p;
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
    $p.listen(($m) {
      if ($m == null) {
        _$impls.remove($p.sendPort.nativePort);
        $p.close();
        return;
      }
      final $i = $MethodInvocation.fromMessage($m as List<dynamic>);
      final $r = _$invokeMethod($p.sendPort.nativePort, $i);
      ProtectedJniExtensions.returnResult($i.result, $r);
    });
    return $x;
  }
}

abstract interface class $OnLocationClickListenerImpl {
  factory $OnLocationClickListenerImpl({
    required void Function() onLocationComponentClick,
  }) = _$OnLocationClickListenerImpl;

  void onLocationComponentClick();
}

class _$OnLocationClickListenerImpl implements $OnLocationClickListenerImpl {
  _$OnLocationClickListenerImpl({
    required void Function() onLocationComponentClick,
  }) : _onLocationComponentClick = onLocationComponentClick;

  final void Function() _onLocationComponentClick;

  void onLocationComponentClick() {
    return _onLocationComponentClick();
  }
}

final class $OnLocationClickListenerType
    extends jni.JObjType<OnLocationClickListener> {
  const $OnLocationClickListenerType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/OnLocationClickListener;';

  @override
  OnLocationClickListener fromReference(jni.JReference reference) =>
      OnLocationClickListener.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($OnLocationClickListenerType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($OnLocationClickListenerType) &&
        other is $OnLocationClickListenerType;
  }
}

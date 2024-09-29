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

/// from: `org.maplibre.android.location.modes.RenderMode$Mode`
class RenderMode_Mode extends jni.JObject {
  @override
  late final jni.JObjType<RenderMode_Mode> $type = type;

  RenderMode_Mode.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/location/modes/RenderMode$Mode');

  /// The type which includes information such as the signature of this class.
  static const type = $RenderMode_ModeType();

  /// Maps a specific port to the implemented interface.
  static final Map<int, $RenderMode_ModeImpl> _$impls = {};
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
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory RenderMode_Mode.implement(
    $RenderMode_ModeImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = RenderMode_Mode.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.location.modes.RenderMode$Mode',
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

abstract interface class $RenderMode_ModeImpl {
  factory $RenderMode_ModeImpl() = _$RenderMode_ModeImpl;
}

class _$RenderMode_ModeImpl implements $RenderMode_ModeImpl {
  _$RenderMode_ModeImpl();
}

final class $RenderMode_ModeType extends jni.JObjType<RenderMode_Mode> {
  const $RenderMode_ModeType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/location/modes/RenderMode$Mode;';

  @override
  RenderMode_Mode fromReference(jni.JReference reference) =>
      RenderMode_Mode.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($RenderMode_ModeType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($RenderMode_ModeType) &&
        other is $RenderMode_ModeType;
  }
}

/// from: `org.maplibre.android.location.modes.RenderMode`
class RenderMode extends jni.JObject {
  @override
  late final jni.JObjType<RenderMode> $type = type;

  RenderMode.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/location/modes/RenderMode');

  /// The type which includes information such as the signature of this class.
  static const type = $RenderModeType();

  /// from: `static public final int NORMAL`
  static const NORMAL = 18;

  /// from: `static public final int COMPASS`
  static const COMPASS = 4;

  /// from: `static public final int GPS`
  static const GPS = 8;
}

final class $RenderModeType extends jni.JObjType<RenderMode> {
  const $RenderModeType();

  @override
  String get signature => r'Lorg/maplibre/android/location/modes/RenderMode;';

  @override
  RenderMode fromReference(jni.JReference reference) =>
      RenderMode.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($RenderModeType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($RenderModeType) && other is $RenderModeType;
  }
}

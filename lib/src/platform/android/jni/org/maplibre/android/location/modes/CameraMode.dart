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

/// from: `org.maplibre.android.location.modes.CameraMode$Mode`
class CameraMode$Mode extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<CameraMode$Mode> $type;

  @jni$_.internal
  CameraMode$Mode.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/location/modes/CameraMode$Mode');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $CameraMode$Mode$NullableType();
  static const type = $CameraMode$Mode$Type();

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $CameraMode$Mode> _$impls = {};
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
    } catch (e) {
      return jni$_.ProtectedJniExtensions.newDartException(e);
    }
    return jni$_.nullptr;
  }

  static void implementIn(
    jni$_.JImplementer implementer,
    $CameraMode$Mode $impl,
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
      r'org.maplibre.android.location.modes.CameraMode$Mode',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory CameraMode$Mode.implement(
    $CameraMode$Mode $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return CameraMode$Mode.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $CameraMode$Mode {
  factory $CameraMode$Mode() = _$CameraMode$Mode;
}

final class _$CameraMode$Mode with $CameraMode$Mode {
  _$CameraMode$Mode();
}

final class $CameraMode$Mode$NullableType
    extends jni$_.JObjType<CameraMode$Mode?> {
  @jni$_.internal
  const $CameraMode$Mode$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/modes/CameraMode$Mode;';

  @jni$_.internal
  @core$_.override
  CameraMode$Mode? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : CameraMode$Mode.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CameraMode$Mode?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CameraMode$Mode$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CameraMode$Mode$NullableType) &&
        other is $CameraMode$Mode$NullableType;
  }
}

final class $CameraMode$Mode$Type extends jni$_.JObjType<CameraMode$Mode> {
  @jni$_.internal
  const $CameraMode$Mode$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/modes/CameraMode$Mode;';

  @jni$_.internal
  @core$_.override
  CameraMode$Mode fromReference(jni$_.JReference reference) =>
      CameraMode$Mode.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CameraMode$Mode?> get nullableType =>
      const $CameraMode$Mode$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CameraMode$Mode$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CameraMode$Mode$Type) &&
        other is $CameraMode$Mode$Type;
  }
}

/// from: `org.maplibre.android.location.modes.CameraMode`
class CameraMode extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<CameraMode> $type;

  @jni$_.internal
  CameraMode.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/location/modes/CameraMode');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $CameraMode$NullableType();
  static const type = $CameraMode$Type();

  /// from: `static public final int NONE`
  static const NONE = 8;

  /// from: `static public final int NONE_COMPASS`
  static const NONE_COMPASS = 16;

  /// from: `static public final int NONE_GPS`
  static const NONE_GPS = 22;

  /// from: `static public final int TRACKING`
  static const TRACKING = 24;

  /// from: `static public final int TRACKING_COMPASS`
  static const TRACKING_COMPASS = 32;

  /// from: `static public final int TRACKING_GPS`
  static const TRACKING_GPS = 34;

  /// from: `static public final int TRACKING_GPS_NORTH`
  static const TRACKING_GPS_NORTH = 36;
}

final class $CameraMode$NullableType extends jni$_.JObjType<CameraMode?> {
  @jni$_.internal
  const $CameraMode$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/modes/CameraMode;';

  @jni$_.internal
  @core$_.override
  CameraMode? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : CameraMode.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CameraMode?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CameraMode$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CameraMode$NullableType) &&
        other is $CameraMode$NullableType;
  }
}

final class $CameraMode$Type extends jni$_.JObjType<CameraMode> {
  @jni$_.internal
  const $CameraMode$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/modes/CameraMode;';

  @jni$_.internal
  @core$_.override
  CameraMode fromReference(jni$_.JReference reference) =>
      CameraMode.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<CameraMode?> get nullableType =>
      const $CameraMode$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($CameraMode$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($CameraMode$Type) && other is $CameraMode$Type;
  }
}

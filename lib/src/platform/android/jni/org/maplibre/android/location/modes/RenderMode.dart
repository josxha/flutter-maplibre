// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: document_ignores
// ignore_for_file: avoid_catches_without_on_clauses
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

/// from: `org.maplibre.android.location.modes.RenderMode$Mode`
class RenderMode$Mode extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<RenderMode$Mode> $type;

  @jni$_.internal
  RenderMode$Mode.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class = jni$_.JClass.forName(
      r'org/maplibre/android/location/modes/RenderMode$Mode');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $RenderMode$Mode$NullableType();
  static const type = $RenderMode$Mode$Type();

  /// Maps a specific port to the implemented interface.
  static final core$_.Map<int, $RenderMode$Mode> _$impls = {};
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
    $RenderMode$Mode $impl,
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
      r'org.maplibre.android.location.modes.RenderMode$Mode',
      $p,
      _$invokePointer,
      [],
    );
    final $a = $p.sendPort.nativePort;
    _$impls[$a] = $impl;
  }

  factory RenderMode$Mode.implement(
    $RenderMode$Mode $impl,
  ) {
    final $i = jni$_.JImplementer();
    implementIn($i, $impl);
    return RenderMode$Mode.fromReference(
      $i.implementReference(),
    );
  }
}

abstract base mixin class $RenderMode$Mode {
  factory $RenderMode$Mode() = _$RenderMode$Mode;
}

final class _$RenderMode$Mode with $RenderMode$Mode {
  _$RenderMode$Mode();
}

final class $RenderMode$Mode$NullableType
    extends jni$_.JObjType<RenderMode$Mode?> {
  @jni$_.internal
  const $RenderMode$Mode$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/modes/RenderMode$Mode;';

  @jni$_.internal
  @core$_.override
  RenderMode$Mode? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : RenderMode$Mode.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RenderMode$Mode?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($RenderMode$Mode$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RenderMode$Mode$NullableType) &&
        other is $RenderMode$Mode$NullableType;
  }
}

final class $RenderMode$Mode$Type extends jni$_.JObjType<RenderMode$Mode> {
  @jni$_.internal
  const $RenderMode$Mode$Type();

  @jni$_.internal
  @core$_.override
  String get signature =>
      r'Lorg/maplibre/android/location/modes/RenderMode$Mode;';

  @jni$_.internal
  @core$_.override
  RenderMode$Mode fromReference(jni$_.JReference reference) =>
      RenderMode$Mode.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RenderMode$Mode?> get nullableType =>
      const $RenderMode$Mode$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($RenderMode$Mode$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RenderMode$Mode$Type) &&
        other is $RenderMode$Mode$Type;
  }
}

/// from: `org.maplibre.android.location.modes.RenderMode`
class RenderMode extends jni$_.JObject {
  @jni$_.internal
  @core$_.override
  final jni$_.JObjType<RenderMode> $type;

  @jni$_.internal
  RenderMode.fromReference(
    jni$_.JReference reference,
  )   : $type = type,
        super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'org/maplibre/android/location/modes/RenderMode');

  /// The type which includes information such as the signature of this class.
  static const nullableType = $RenderMode$NullableType();
  static const type = $RenderMode$Type();

  /// from: `static public final int NORMAL`
  static const NORMAL = 18;

  /// from: `static public final int COMPASS`
  static const COMPASS = 4;

  /// from: `static public final int GPS`
  static const GPS = 8;
}

final class $RenderMode$NullableType extends jni$_.JObjType<RenderMode?> {
  @jni$_.internal
  const $RenderMode$NullableType();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/modes/RenderMode;';

  @jni$_.internal
  @core$_.override
  RenderMode? fromReference(jni$_.JReference reference) => reference.isNull
      ? null
      : RenderMode.fromReference(
          reference,
        );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RenderMode?> get nullableType => this;

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($RenderMode$NullableType).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RenderMode$NullableType) &&
        other is $RenderMode$NullableType;
  }
}

final class $RenderMode$Type extends jni$_.JObjType<RenderMode> {
  @jni$_.internal
  const $RenderMode$Type();

  @jni$_.internal
  @core$_.override
  String get signature => r'Lorg/maplibre/android/location/modes/RenderMode;';

  @jni$_.internal
  @core$_.override
  RenderMode fromReference(jni$_.JReference reference) =>
      RenderMode.fromReference(
        reference,
      );
  @jni$_.internal
  @core$_.override
  jni$_.JObjType get superType => const jni$_.JObjectNullableType();

  @jni$_.internal
  @core$_.override
  jni$_.JObjType<RenderMode?> get nullableType =>
      const $RenderMode$NullableType();

  @jni$_.internal
  @core$_.override
  final superCount = 1;

  @core$_.override
  int get hashCode => ($RenderMode$Type).hashCode;

  @core$_.override
  bool operator ==(Object other) {
    return other.runtimeType == ($RenderMode$Type) && other is $RenderMode$Type;
  }
}

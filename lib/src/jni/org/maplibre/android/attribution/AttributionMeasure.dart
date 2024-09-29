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

import 'AttributionLayout.dart' as attributionlayout_;

/// from: `org.maplibre.android.attribution.AttributionMeasure$Builder`
class AttributionMeasure_Builder extends jni.JObject {
  @override
  late final jni.JObjType<AttributionMeasure_Builder> $type = type;

  AttributionMeasure_Builder.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/attribution/AttributionMeasure$Builder');

  /// The type which includes information such as the signature of this class.
  static const type = $AttributionMeasure_BuilderType();
  static final _id_new0 = _class.constructorId(
    r'()V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  /// The returned object must be released after use, by calling the [release] method.
  factory AttributionMeasure_Builder() {
    return AttributionMeasure_Builder.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_setSnapshot = _class.instanceMethodId(
    r'setSnapshot',
    r'(Landroid/graphics/Bitmap;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setSnapshot = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setSnapshot(android.graphics.Bitmap bitmap)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure_Builder setSnapshot(
    jni.JObject bitmap,
  ) {
    return _setSnapshot(reference.pointer, _id_setSnapshot as jni.JMethodIDPtr,
            bitmap.reference.pointer)
        .object(const $AttributionMeasure_BuilderType());
  }

  static final _id_setLogo = _class.instanceMethodId(
    r'setLogo',
    r'(Landroid/graphics/Bitmap;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setLogo = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setLogo(android.graphics.Bitmap bitmap)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure_Builder setLogo(
    jni.JObject bitmap,
  ) {
    return _setLogo(reference.pointer, _id_setLogo as jni.JMethodIDPtr,
            bitmap.reference.pointer)
        .object(const $AttributionMeasure_BuilderType());
  }

  static final _id_setLogoSmall = _class.instanceMethodId(
    r'setLogoSmall',
    r'(Landroid/graphics/Bitmap;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setLogoSmall = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setLogoSmall(android.graphics.Bitmap bitmap)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure_Builder setLogoSmall(
    jni.JObject bitmap,
  ) {
    return _setLogoSmall(reference.pointer,
            _id_setLogoSmall as jni.JMethodIDPtr, bitmap.reference.pointer)
        .object(const $AttributionMeasure_BuilderType());
  }

  static final _id_setTextView = _class.instanceMethodId(
    r'setTextView',
    r'(Landroid/widget/TextView;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setTextView = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setTextView(android.widget.TextView textView)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure_Builder setTextView(
    jni.JObject textView,
  ) {
    return _setTextView(reference.pointer, _id_setTextView as jni.JMethodIDPtr,
            textView.reference.pointer)
        .object(const $AttributionMeasure_BuilderType());
  }

  static final _id_setTextViewShort = _class.instanceMethodId(
    r'setTextViewShort',
    r'(Landroid/widget/TextView;)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setTextViewShort = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setTextViewShort(android.widget.TextView textView)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure_Builder setTextViewShort(
    jni.JObject textView,
  ) {
    return _setTextViewShort(
            reference.pointer,
            _id_setTextViewShort as jni.JMethodIDPtr,
            textView.reference.pointer)
        .object(const $AttributionMeasure_BuilderType());
  }

  static final _id_setMarginPadding = _class.instanceMethodId(
    r'setMarginPadding',
    r'(F)Lorg/maplibre/android/attribution/AttributionMeasure$Builder;',
  );

  static final _setMarginPadding = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Double,)>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double)>();

  /// from: `public org.maplibre.android.attribution.AttributionMeasure$Builder setMarginPadding(float f)`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure_Builder setMarginPadding(
    double f,
  ) {
    return _setMarginPadding(
            reference.pointer, _id_setMarginPadding as jni.JMethodIDPtr, f)
        .object(const $AttributionMeasure_BuilderType());
  }

  static final _id_build = _class.instanceMethodId(
    r'build',
    r'()Lorg/maplibre/android/attribution/AttributionMeasure;',
  );

  static final _build = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.attribution.AttributionMeasure build()`
  /// The returned object must be released after use, by calling the [release] method.
  AttributionMeasure build() {
    return _build(reference.pointer, _id_build as jni.JMethodIDPtr)
        .object(const $AttributionMeasureType());
  }
}

final class $AttributionMeasure_BuilderType
    extends jni.JObjType<AttributionMeasure_Builder> {
  const $AttributionMeasure_BuilderType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure$Builder;';

  @override
  AttributionMeasure_Builder fromReference(jni.JReference reference) =>
      AttributionMeasure_Builder.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($AttributionMeasure_BuilderType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure_BuilderType) &&
        other is $AttributionMeasure_BuilderType;
  }
}

/// from: `org.maplibre.android.attribution.AttributionMeasure$Command`
class AttributionMeasure_Command extends jni.JObject {
  @override
  late final jni.JObjType<AttributionMeasure_Command> $type = type;

  AttributionMeasure_Command.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/attribution/AttributionMeasure$Command');

  /// The type which includes information such as the signature of this class.
  static const type = $AttributionMeasure_CommandType();
  static final _id_execute = _class.instanceMethodId(
    r'execute',
    r'(Lorg/maplibre/android/attribution/AttributionMeasure;)Lorg/maplibre/android/attribution/AttributionLayout;',
  );

  static final _execute = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract org.maplibre.android.attribution.AttributionLayout execute(org.maplibre.android.attribution.AttributionMeasure attributionMeasure)`
  /// The returned object must be released after use, by calling the [release] method.
  attributionlayout_.AttributionLayout execute(
    AttributionMeasure attributionMeasure,
  ) {
    return _execute(reference.pointer, _id_execute as jni.JMethodIDPtr,
            attributionMeasure.reference.pointer)
        .object(const attributionlayout_.$AttributionLayoutType());
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $AttributionMeasure_CommandImpl> _$impls = {};
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
      if ($d ==
          r'execute(Lorg/maplibre/android/attribution/AttributionMeasure;)Lorg/maplibre/android/attribution/AttributionLayout;') {
        final $r = _$impls[$p]!.execute(
          $a[0].castTo(const $AttributionMeasureType(), releaseOriginal: true),
        );
        return ($r as jni.JObject)
            .castTo(const jni.JObjectType())
            .reference
            .toPointer();
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory AttributionMeasure_Command.implement(
    $AttributionMeasure_CommandImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = AttributionMeasure_Command.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.attribution.AttributionMeasure$Command',
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

abstract interface class $AttributionMeasure_CommandImpl {
  factory $AttributionMeasure_CommandImpl({
    required attributionlayout_.AttributionLayout Function(
            AttributionMeasure attributionMeasure)
        execute,
  }) = _$AttributionMeasure_CommandImpl;

  attributionlayout_.AttributionLayout execute(
      AttributionMeasure attributionMeasure);
}

class _$AttributionMeasure_CommandImpl
    implements $AttributionMeasure_CommandImpl {
  _$AttributionMeasure_CommandImpl({
    required attributionlayout_.AttributionLayout Function(
            AttributionMeasure attributionMeasure)
        execute,
  }) : _execute = execute;

  final attributionlayout_.AttributionLayout Function(
      AttributionMeasure attributionMeasure) _execute;

  attributionlayout_.AttributionLayout execute(
      AttributionMeasure attributionMeasure) {
    return _execute(attributionMeasure);
  }
}

final class $AttributionMeasure_CommandType
    extends jni.JObjType<AttributionMeasure_Command> {
  const $AttributionMeasure_CommandType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure$Command;';

  @override
  AttributionMeasure_Command fromReference(jni.JReference reference) =>
      AttributionMeasure_Command.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($AttributionMeasure_CommandType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasure_CommandType) &&
        other is $AttributionMeasure_CommandType;
  }
}

/// from: `org.maplibre.android.attribution.AttributionMeasure`
class AttributionMeasure extends jni.JObject {
  @override
  late final jni.JObjType<AttributionMeasure> $type = type;

  AttributionMeasure.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/attribution/AttributionMeasure');

  /// The type which includes information such as the signature of this class.
  static const type = $AttributionMeasureType();
  static final _id_measure = _class.instanceMethodId(
    r'measure',
    r'()Lorg/maplibre/android/attribution/AttributionLayout;',
  );

  static final _measure = ProtectedJniExtensions.lookup<
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

  /// from: `public org.maplibre.android.attribution.AttributionLayout measure()`
  /// The returned object must be released after use, by calling the [release] method.
  attributionlayout_.AttributionLayout measure() {
    return _measure(reference.pointer, _id_measure as jni.JMethodIDPtr)
        .object(const attributionlayout_.$AttributionLayoutType());
  }

  static final _id_getTextView = _class.instanceMethodId(
    r'getTextView',
    r'()Landroid/widget/TextView;',
  );

  static final _getTextView = ProtectedJniExtensions.lookup<
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

  /// from: `public android.widget.TextView getTextView()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getTextView() {
    return _getTextView(reference.pointer, _id_getTextView as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }
}

final class $AttributionMeasureType extends jni.JObjType<AttributionMeasure> {
  const $AttributionMeasureType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/attribution/AttributionMeasure;';

  @override
  AttributionMeasure fromReference(jni.JReference reference) =>
      AttributionMeasure.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($AttributionMeasureType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($AttributionMeasureType) &&
        other is $AttributionMeasureType;
  }
}

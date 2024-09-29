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

/// from: `android.graphics.PointF`
class PointF extends jni.JObject {
  @override
  late final jni.JObjType<PointF> $type = type;

  PointF.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(r'android/graphics/PointF');

  /// The type which includes information such as the signature of this class.
  static const type = $PointFType();
  static final _id_CREATOR = _class.staticFieldId(
    r'CREATOR',
    r'Landroid/os/Parcelable$Creator;',
  );

  /// from: `static public final android.os.Parcelable$Creator CREATOR`
  /// The returned object must be released after use, by calling the [release] method.
  static jni.JObject get CREATOR =>
      _id_CREATOR.get(_class, const jni.JObjectType());

  static final _id_x = _class.instanceFieldId(
    r'x',
    r'F',
  );

  /// from: `public float x`
  double get x => _id_x.get(this, const jni.jfloatType());

  /// from: `public float x`
  set x(double value) => _id_x.set(this, const jni.jfloatType(), value);

  static final _id_y = _class.instanceFieldId(
    r'y',
    r'F',
  );

  /// from: `public float y`
  double get y => _id_y.get(this, const jni.jfloatType());

  /// from: `public float y`
  set y(double value) => _id_y.set(this, const jni.jfloatType(), value);

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
  factory PointF() {
    return PointF.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_new1 = _class.constructorId(
    r'(FF)V',
  );

  static final _new1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double, double)>();

  /// from: `public void <init>(float f, float f1)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PointF.new1(
    double f,
    double f1,
  ) {
    return PointF.fromReference(
        _new1(_class.reference.pointer, _id_new1 as jni.JMethodIDPtr, f, f1)
            .reference);
  }

  static final _id_new2 = _class.constructorId(
    r'(Landroid/graphics/Point;)V',
  );

  static final _new2 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(android.graphics.Point point)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PointF.new2(
    jni.JObject point,
  ) {
    return PointF.fromReference(_new2(_class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr, point.reference.pointer)
        .reference);
  }

  static final _id_new3 = _class.constructorId(
    r'(Landroid/graphics/PointF;)V',
  );

  static final _new3 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void <init>(android.graphics.PointF pointF)`
  /// The returned object must be released after use, by calling the [release] method.
  factory PointF.new3(
    PointF pointF,
  ) {
    return PointF.fromReference(_new3(_class.reference.pointer,
            _id_new3 as jni.JMethodIDPtr, pointF.reference.pointer)
        .reference);
  }

  static final _id_set0 = _class.instanceMethodId(
    r'set',
    r'(FF)V',
  );

  static final _set0 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double, double)>();

  /// from: `public final void set(float f, float f1)`
  void set0(
    double f,
    double f1,
  ) {
    _set0(reference.pointer, _id_set0 as jni.JMethodIDPtr, f, f1).check();
  }

  static final _id_set1 = _class.instanceMethodId(
    r'set',
    r'(Landroid/graphics/PointF;)V',
  );

  static final _set1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void set(android.graphics.PointF pointF)`
  void set1(
    PointF pointF,
  ) {
    _set1(reference.pointer, _id_set1 as jni.JMethodIDPtr,
            pointF.reference.pointer)
        .check();
  }

  static final _id_negate = _class.instanceMethodId(
    r'negate',
    r'()V',
  );

  static final _negate = ProtectedJniExtensions.lookup<
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

  /// from: `public final void negate()`
  void negate() {
    _negate(reference.pointer, _id_negate as jni.JMethodIDPtr).check();
  }

  static final _id_offset = _class.instanceMethodId(
    r'offset',
    r'(FF)V',
  );

  static final _offset = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double, double)>();

  /// from: `public final void offset(float f, float f1)`
  void offset(
    double f,
    double f1,
  ) {
    _offset(reference.pointer, _id_offset as jni.JMethodIDPtr, f, f1).check();
  }

  static final _id_equals = _class.instanceMethodId(
    r'equals',
    r'(FF)Z',
  );

  static final _equals = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double, double)>();

  /// from: `public final boolean equals(float f, float f1)`
  bool equals(
    double f,
    double f1,
  ) {
    return _equals(reference.pointer, _id_equals as jni.JMethodIDPtr, f, f1)
        .boolean;
  }

  static final _id_equals1 = _class.instanceMethodId(
    r'equals',
    r'(Ljava/lang/Object;)Z',
  );

  static final _equals1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallBooleanMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public boolean equals(java.lang.Object object)`
  bool equals1(
    jni.JObject object,
  ) {
    return _equals1(reference.pointer, _id_equals1 as jni.JMethodIDPtr,
            object.reference.pointer)
        .boolean;
  }

  static final _id_hashCode1 = _class.instanceMethodId(
    r'hashCode',
    r'()I',
  );

  static final _hashCode1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public int hashCode()`
  int hashCode1() {
    return _hashCode1(reference.pointer, _id_hashCode1 as jni.JMethodIDPtr)
        .integer;
  }

  static final _id_toString1 = _class.instanceMethodId(
    r'toString',
    r'()Ljava/lang/String;',
  );

  static final _toString1 = ProtectedJniExtensions.lookup<
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

  /// from: `public java.lang.String toString()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString toString1() {
    return _toString1(reference.pointer, _id_toString1 as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_length = _class.instanceMethodId(
    r'length',
    r'()F',
  );

  static final _length = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallFloatMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public final float length()`
  double length() {
    return _length(reference.pointer, _id_length as jni.JMethodIDPtr).float;
  }

  static final _id_length1 = _class.staticMethodId(
    r'length',
    r'(FF)F',
  );

  static final _length1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Double, ffi.Double)>)>>(
          'globalEnv_CallStaticFloatMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, double, double)>();

  /// from: `static public float length(float f, float f1)`
  static double length1(
    double f,
    double f1,
  ) {
    return _length1(
            _class.reference.pointer, _id_length1 as jni.JMethodIDPtr, f, f1)
        .float;
  }

  static final _id_describeContents = _class.instanceMethodId(
    r'describeContents',
    r'()I',
  );

  static final _describeContents = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `public int describeContents()`
  int describeContents() {
    return _describeContents(
            reference.pointer, _id_describeContents as jni.JMethodIDPtr)
        .integer;
  }

  static final _id_writeToParcel = _class.instanceMethodId(
    r'writeToParcel',
    r'(Landroid/os/Parcel;I)V',
  );

  static final _writeToParcel = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>, $Int32)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, int)>();

  /// from: `public void writeToParcel(android.os.Parcel parcel, int i)`
  void writeToParcel(
    jni.JObject parcel,
    int i,
  ) {
    _writeToParcel(reference.pointer, _id_writeToParcel as jni.JMethodIDPtr,
            parcel.reference.pointer, i)
        .check();
  }

  static final _id_readFromParcel = _class.instanceMethodId(
    r'readFromParcel',
    r'(Landroid/os/Parcel;)V',
  );

  static final _readFromParcel = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void readFromParcel(android.os.Parcel parcel)`
  void readFromParcel(
    jni.JObject parcel,
  ) {
    _readFromParcel(reference.pointer, _id_readFromParcel as jni.JMethodIDPtr,
            parcel.reference.pointer)
        .check();
  }
}

final class $PointFType extends jni.JObjType<PointF> {
  const $PointFType();

  @override
  String get signature => r'Landroid/graphics/PointF;';

  @override
  PointF fromReference(jni.JReference reference) =>
      PointF.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($PointFType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($PointFType) && other is $PointFType;
  }
}
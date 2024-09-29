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

import '../../geometry/LatLngQuad.dart' as latlngquad_;

import 'Source.dart' as source_;

/// from: `org.maplibre.android.style.sources.ImageSource`
class ImageSource extends source_.Source {
  @override
  late final jni.JObjType<ImageSource> $type = type;

  ImageSource.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/style/sources/ImageSource');

  /// The type which includes information such as the signature of this class.
  static const type = $ImageSourceType();
  static final _id_new0 = _class.constructorId(
    r'(J)V',
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
                  ffi.VarArgs<(ffi.Int64,)>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public void <init>(long j)`
  /// The returned object must be released after use, by calling the [release] method.
  factory ImageSource(
    int j,
  ) {
    return ImageSource.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr, j)
            .reference);
  }

  static final _id_new2 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/geometry/LatLngQuad;Ljava/net/URL;)V',
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.geometry.LatLngQuad latLngQuad, java.net.URL uRL)`
  /// The returned object must be released after use, by calling the [release] method.
  factory ImageSource.new2(
    jni.JString string,
    latlngquad_.LatLngQuad latLngQuad,
    jni.JObject uRL,
  ) {
    return ImageSource.fromReference(_new2(
            _class.reference.pointer,
            _id_new2 as jni.JMethodIDPtr,
            string.reference.pointer,
            latLngQuad.reference.pointer,
            uRL.reference.pointer)
        .reference);
  }

  static final _id_new3 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/geometry/LatLngQuad;Ljava/net/URI;)V',
  );

  static final _new3 = ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.geometry.LatLngQuad latLngQuad, java.net.URI uRI)`
  /// The returned object must be released after use, by calling the [release] method.
  factory ImageSource.new3(
    jni.JString string,
    latlngquad_.LatLngQuad latLngQuad,
    jni.JObject uRI,
  ) {
    return ImageSource.fromReference(_new3(
            _class.reference.pointer,
            _id_new3 as jni.JMethodIDPtr,
            string.reference.pointer,
            latLngQuad.reference.pointer,
            uRI.reference.pointer)
        .reference);
  }

  static final _id_new4 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/geometry/LatLngQuad;Landroid/graphics/Bitmap;)V',
  );

  static final _new4 = ProtectedJniExtensions.lookup<
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

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.geometry.LatLngQuad latLngQuad, android.graphics.Bitmap bitmap)`
  /// The returned object must be released after use, by calling the [release] method.
  factory ImageSource.new4(
    jni.JString string,
    latlngquad_.LatLngQuad latLngQuad,
    jni.JObject bitmap,
  ) {
    return ImageSource.fromReference(_new4(
            _class.reference.pointer,
            _id_new4 as jni.JMethodIDPtr,
            string.reference.pointer,
            latLngQuad.reference.pointer,
            bitmap.reference.pointer)
        .reference);
  }

  static final _id_new5 = _class.constructorId(
    r'(Ljava/lang/String;Lorg/maplibre/android/geometry/LatLngQuad;I)V',
  );

  static final _new5 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        $Int32
                      )>)>>('globalEnv_NewObject')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>, int)>();

  /// from: `public void <init>(java.lang.String string, org.maplibre.android.geometry.LatLngQuad latLngQuad, int i)`
  /// The returned object must be released after use, by calling the [release] method.
  factory ImageSource.new5(
    jni.JString string,
    latlngquad_.LatLngQuad latLngQuad,
    int i,
  ) {
    return ImageSource.fromReference(_new5(
            _class.reference.pointer,
            _id_new5 as jni.JMethodIDPtr,
            string.reference.pointer,
            latLngQuad.reference.pointer,
            i)
        .reference);
  }

  static final _id_setUrl = _class.instanceMethodId(
    r'setUrl',
    r'(Ljava/net/URL;)V',
  );

  static final _setUrl = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setUrl(java.net.URL uRL)`
  void setUrl(
    jni.JObject uRL,
  ) {
    _setUrl(reference.pointer, _id_setUrl as jni.JMethodIDPtr,
            uRL.reference.pointer)
        .check();
  }

  static final _id_setUrl1 = _class.instanceMethodId(
    r'setUrl',
    r'(Ljava/lang/String;)V',
  );

  static final _setUrl1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setUrl(java.lang.String string)`
  void setUrl1(
    jni.JString string,
  ) {
    _setUrl1(reference.pointer, _id_setUrl1 as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_setUri = _class.instanceMethodId(
    r'setUri',
    r'(Ljava/net/URI;)V',
  );

  static final _setUri = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setUri(java.net.URI uRI)`
  void setUri(
    jni.JObject uRI,
  ) {
    _setUri(reference.pointer, _id_setUri as jni.JMethodIDPtr,
            uRI.reference.pointer)
        .check();
  }

  static final _id_setUri1 = _class.instanceMethodId(
    r'setUri',
    r'(Ljava/lang/String;)V',
  );

  static final _setUri1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setUri(java.lang.String string)`
  void setUri1(
    jni.JString string,
  ) {
    _setUri1(reference.pointer, _id_setUri1 as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_setImage = _class.instanceMethodId(
    r'setImage',
    r'(Landroid/graphics/Bitmap;)V',
  );

  static final _setImage = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setImage(android.graphics.Bitmap bitmap)`
  void setImage(
    jni.JObject bitmap,
  ) {
    _setImage(reference.pointer, _id_setImage as jni.JMethodIDPtr,
            bitmap.reference.pointer)
        .check();
  }

  static final _id_setImage1 = _class.instanceMethodId(
    r'setImage',
    r'(I)V',
  );

  static final _setImage1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<($Int32,)>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>, jni.JMethodIDPtr, int)>();

  /// from: `public final void setImage(int i)`
  void setImage1(
    int i,
  ) {
    _setImage1(reference.pointer, _id_setImage1 as jni.JMethodIDPtr, i).check();
  }

  static final _id_getUrl = _class.instanceMethodId(
    r'getUrl',
    r'()Ljava/lang/String;',
  );

  static final _getUrl = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getUrl() {
    return _getUrl(reference.pointer, _id_getUrl as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_getUri = _class.instanceMethodId(
    r'getUri',
    r'()Ljava/lang/String;',
  );

  static final _getUri = ProtectedJniExtensions.lookup<
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

  /// from: `public final java.lang.String getUri()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString getUri() {
    return _getUri(reference.pointer, _id_getUri as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_setCoordinates = _class.instanceMethodId(
    r'setCoordinates',
    r'(Lorg/maplibre/android/geometry/LatLngQuad;)V',
  );

  static final _setCoordinates = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public final void setCoordinates(org.maplibre.android.geometry.LatLngQuad latLngQuad)`
  void setCoordinates(
    latlngquad_.LatLngQuad latLngQuad,
  ) {
    _setCoordinates(reference.pointer, _id_setCoordinates as jni.JMethodIDPtr,
            latLngQuad.reference.pointer)
        .check();
  }

  static final _id_initialize = _class.instanceMethodId(
    r'initialize',
    r'(Ljava/lang/String;Lorg/maplibre/android/geometry/LatLngQuad;)V',
  );

  static final _initialize = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: `protected native final void initialize(java.lang.String string, org.maplibre.android.geometry.LatLngQuad latLngQuad)`
  void initialize(
    jni.JString string,
    latlngquad_.LatLngQuad latLngQuad,
  ) {
    _initialize(reference.pointer, _id_initialize as jni.JMethodIDPtr,
            string.reference.pointer, latLngQuad.reference.pointer)
        .check();
  }

  static final _id_nativeSetUrl = _class.instanceMethodId(
    r'nativeSetUrl',
    r'(Ljava/lang/String;)V',
  );

  static final _nativeSetUrl = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `protected native final void nativeSetUrl(java.lang.String string)`
  void nativeSetUrl(
    jni.JString string,
  ) {
    _nativeSetUrl(reference.pointer, _id_nativeSetUrl as jni.JMethodIDPtr,
            string.reference.pointer)
        .check();
  }

  static final _id_nativeGetUrl = _class.instanceMethodId(
    r'nativeGetUrl',
    r'()Ljava/lang/String;',
  );

  static final _nativeGetUrl = ProtectedJniExtensions.lookup<
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

  /// from: `protected native final java.lang.String nativeGetUrl()`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString nativeGetUrl() {
    return _nativeGetUrl(
            reference.pointer, _id_nativeGetUrl as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_nativeSetImage = _class.instanceMethodId(
    r'nativeSetImage',
    r'(Landroid/graphics/Bitmap;)V',
  );

  static final _nativeSetImage = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `protected native final void nativeSetImage(android.graphics.Bitmap bitmap)`
  void nativeSetImage(
    jni.JObject bitmap,
  ) {
    _nativeSetImage(reference.pointer, _id_nativeSetImage as jni.JMethodIDPtr,
            bitmap.reference.pointer)
        .check();
  }

  static final _id_nativeSetCoordinates = _class.instanceMethodId(
    r'nativeSetCoordinates',
    r'(Lorg/maplibre/android/geometry/LatLngQuad;)V',
  );

  static final _nativeSetCoordinates = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `protected native final void nativeSetCoordinates(org.maplibre.android.geometry.LatLngQuad latLngQuad)`
  void nativeSetCoordinates(
    latlngquad_.LatLngQuad latLngQuad,
  ) {
    _nativeSetCoordinates(
            reference.pointer,
            _id_nativeSetCoordinates as jni.JMethodIDPtr,
            latLngQuad.reference.pointer)
        .check();
  }

  static final _id_finalize = _class.instanceMethodId(
    r'finalize',
    r'()V',
  );

  static final _finalize = ProtectedJniExtensions.lookup<
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

  /// from: `protected native final void finalize()`
  void finalize() {
    _finalize(reference.pointer, _id_finalize as jni.JMethodIDPtr).check();
  }
}

final class $ImageSourceType extends jni.JObjType<ImageSource> {
  const $ImageSourceType();

  @override
  String get signature => r'Lorg/maplibre/android/style/sources/ImageSource;';

  @override
  ImageSource fromReference(jni.JReference reference) =>
      ImageSource.fromReference(reference);

  @override
  jni.JObjType get superType => const source_.$SourceType();

  @override
  final superCount = 2;

  @override
  int get hashCode => ($ImageSourceType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($ImageSourceType) && other is $ImageSourceType;
  }
}

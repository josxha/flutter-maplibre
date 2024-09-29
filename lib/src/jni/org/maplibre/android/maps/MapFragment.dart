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

import 'MapLibreMap.dart' as maplibremap_;

import 'MapLibreMapOptions.dart' as maplibremapoptions_;

import 'MapView.dart' as mapview_;

import 'OnMapReadyCallback.dart' as onmapreadycallback_;

/// from: `org.maplibre.android.maps.MapFragment$OnMapViewReadyCallback`
class MapFragment_OnMapViewReadyCallback extends jni.JObject {
  @override
  late final jni.JObjType<MapFragment_OnMapViewReadyCallback> $type = type;

  MapFragment_OnMapViewReadyCallback.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class = jni.JClass.forName(
      r'org/maplibre/android/maps/MapFragment$OnMapViewReadyCallback');

  /// The type which includes information such as the signature of this class.
  static const type = $MapFragment_OnMapViewReadyCallbackType();
  static final _id_onMapViewReady = _class.instanceMethodId(
    r'onMapViewReady',
    r'(Lorg/maplibre/android/maps/MapView;)V',
  );

  static final _onMapViewReady = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public abstract void onMapViewReady(org.maplibre.android.maps.MapView mapView)`
  void onMapViewReady(
    mapview_.MapView mapView,
  ) {
    _onMapViewReady(reference.pointer, _id_onMapViewReady as jni.JMethodIDPtr,
            mapView.reference.pointer)
        .check();
  }

  /// Maps a specific port to the implemented interface.
  static final Map<int, $MapFragment_OnMapViewReadyCallbackImpl> _$impls = {};
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
      if ($d == r'onMapViewReady(Lorg/maplibre/android/maps/MapView;)V') {
        _$impls[$p]!.onMapViewReady(
          $a[0].castTo(const mapview_.$MapViewType(), releaseOriginal: true),
        );
        return jni.nullptr;
      }
    } catch (e) {
      return ProtectedJniExtensions.newDartException(e);
    }
    return jni.nullptr;
  }

  factory MapFragment_OnMapViewReadyCallback.implement(
    $MapFragment_OnMapViewReadyCallbackImpl $impl,
  ) {
    final $p = ReceivePort();
    final $x = MapFragment_OnMapViewReadyCallback.fromReference(
      ProtectedJniExtensions.newPortProxy(
        r'org.maplibre.android.maps.MapFragment$OnMapViewReadyCallback',
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

abstract interface class $MapFragment_OnMapViewReadyCallbackImpl {
  factory $MapFragment_OnMapViewReadyCallbackImpl({
    required void Function(mapview_.MapView mapView) onMapViewReady,
  }) = _$MapFragment_OnMapViewReadyCallbackImpl;

  void onMapViewReady(mapview_.MapView mapView);
}

class _$MapFragment_OnMapViewReadyCallbackImpl
    implements $MapFragment_OnMapViewReadyCallbackImpl {
  _$MapFragment_OnMapViewReadyCallbackImpl({
    required void Function(mapview_.MapView mapView) onMapViewReady,
  }) : _onMapViewReady = onMapViewReady;

  final void Function(mapview_.MapView mapView) _onMapViewReady;

  void onMapViewReady(mapview_.MapView mapView) {
    return _onMapViewReady(mapView);
  }
}

final class $MapFragment_OnMapViewReadyCallbackType
    extends jni.JObjType<MapFragment_OnMapViewReadyCallback> {
  const $MapFragment_OnMapViewReadyCallbackType();

  @override
  String get signature =>
      r'Lorg/maplibre/android/maps/MapFragment$OnMapViewReadyCallback;';

  @override
  MapFragment_OnMapViewReadyCallback fromReference(jni.JReference reference) =>
      MapFragment_OnMapViewReadyCallback.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapFragment_OnMapViewReadyCallbackType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapFragment_OnMapViewReadyCallbackType) &&
        other is $MapFragment_OnMapViewReadyCallbackType;
  }
}

/// from: `org.maplibre.android.maps.MapFragment`
class MapFragment extends jni.JObject {
  @override
  late final jni.JObjType<MapFragment> $type = type;

  MapFragment.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r'org/maplibre/android/maps/MapFragment');

  /// The type which includes information such as the signature of this class.
  static const type = $MapFragmentType();
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
  factory MapFragment() {
    return MapFragment.fromReference(
        _new0(_class.reference.pointer, _id_new0 as jni.JMethodIDPtr)
            .reference);
  }

  static final _id_newInstance = _class.staticMethodId(
    r'newInstance',
    r'()Lorg/maplibre/android/maps/MapFragment;',
  );

  static final _newInstance = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>('globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: `static public org.maplibre.android.maps.MapFragment newInstance()`
  /// The returned object must be released after use, by calling the [release] method.
  static MapFragment newInstance() {
    return _newInstance(
            _class.reference.pointer, _id_newInstance as jni.JMethodIDPtr)
        .object(const $MapFragmentType());
  }

  static final _id_newInstance1 = _class.staticMethodId(
    r'newInstance',
    r'(Lorg/maplibre/android/maps/MapLibreMapOptions;)Lorg/maplibre/android/maps/MapFragment;',
  );

  static final _newInstance1 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallStaticObjectMethod')
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `static public org.maplibre.android.maps.MapFragment newInstance(org.maplibre.android.maps.MapLibreMapOptions mapLibreMapOptions)`
  /// The returned object must be released after use, by calling the [release] method.
  static MapFragment newInstance1(
    maplibremapoptions_.MapLibreMapOptions mapLibreMapOptions,
  ) {
    return _newInstance1(
            _class.reference.pointer,
            _id_newInstance1 as jni.JMethodIDPtr,
            mapLibreMapOptions.reference.pointer)
        .object(const $MapFragmentType());
  }

  static final _id_onInflate = _class.instanceMethodId(
    r'onInflate',
    r'(Landroid/content/Context;Landroid/util/AttributeSet;Landroid/os/Bundle;)V',
  );

  static final _onInflate = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void onInflate(android.content.Context context, android.util.AttributeSet attributeSet, android.os.Bundle bundle)`
  void onInflate(
    jni.JObject context,
    jni.JObject attributeSet,
    jni.JObject bundle,
  ) {
    _onInflate(
            reference.pointer,
            _id_onInflate as jni.JMethodIDPtr,
            context.reference.pointer,
            attributeSet.reference.pointer,
            bundle.reference.pointer)
        .check();
  }

  static final _id_onAttach = _class.instanceMethodId(
    r'onAttach',
    r'(Landroid/content/Context;)V',
  );

  static final _onAttach = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void onAttach(android.content.Context context)`
  void onAttach(
    jni.JObject context,
  ) {
    _onAttach(reference.pointer, _id_onAttach as jni.JMethodIDPtr,
            context.reference.pointer)
        .check();
  }

  static final _id_onCreateView = _class.instanceMethodId(
    r'onCreateView',
    r'(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;',
  );

  static final _onCreateView = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>('globalEnv_CallObjectMethod')
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public android.view.View onCreateView(android.view.LayoutInflater layoutInflater, android.view.ViewGroup viewGroup, android.os.Bundle bundle)`
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject onCreateView(
    jni.JObject layoutInflater,
    jni.JObject viewGroup,
    jni.JObject bundle,
  ) {
    return _onCreateView(
            reference.pointer,
            _id_onCreateView as jni.JMethodIDPtr,
            layoutInflater.reference.pointer,
            viewGroup.reference.pointer,
            bundle.reference.pointer)
        .object(const jni.JObjectType());
  }

  static final _id_onViewCreated = _class.instanceMethodId(
    r'onViewCreated',
    r'(Landroid/view/View;Landroid/os/Bundle;)V',
  );

  static final _onViewCreated = ProtectedJniExtensions.lookup<
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

  /// from: `public void onViewCreated(android.view.View view, android.os.Bundle bundle)`
  void onViewCreated(
    jni.JObject view,
    jni.JObject bundle,
  ) {
    _onViewCreated(reference.pointer, _id_onViewCreated as jni.JMethodIDPtr,
            view.reference.pointer, bundle.reference.pointer)
        .check();
  }

  static final _id_onMapReady = _class.instanceMethodId(
    r'onMapReady',
    r'(Lorg/maplibre/android/maps/MapLibreMap;)V',
  );

  static final _onMapReady = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void onMapReady(org.maplibre.android.maps.MapLibreMap mapLibreMap)`
  void onMapReady(
    maplibremap_.MapLibreMap mapLibreMap,
  ) {
    _onMapReady(reference.pointer, _id_onMapReady as jni.JMethodIDPtr,
            mapLibreMap.reference.pointer)
        .check();
  }

  static final _id_onStart = _class.instanceMethodId(
    r'onStart',
    r'()V',
  );

  static final _onStart = ProtectedJniExtensions.lookup<
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

  /// from: `public void onStart()`
  void onStart() {
    _onStart(reference.pointer, _id_onStart as jni.JMethodIDPtr).check();
  }

  static final _id_onResume = _class.instanceMethodId(
    r'onResume',
    r'()V',
  );

  static final _onResume = ProtectedJniExtensions.lookup<
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

  /// from: `public void onResume()`
  void onResume() {
    _onResume(reference.pointer, _id_onResume as jni.JMethodIDPtr).check();
  }

  static final _id_onPause = _class.instanceMethodId(
    r'onPause',
    r'()V',
  );

  static final _onPause = ProtectedJniExtensions.lookup<
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

  /// from: `public void onPause()`
  void onPause() {
    _onPause(reference.pointer, _id_onPause as jni.JMethodIDPtr).check();
  }

  static final _id_onSaveInstanceState = _class.instanceMethodId(
    r'onSaveInstanceState',
    r'(Landroid/os/Bundle;)V',
  );

  static final _onSaveInstanceState = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void onSaveInstanceState(android.os.Bundle bundle)`
  void onSaveInstanceState(
    jni.JObject bundle,
  ) {
    _onSaveInstanceState(
            reference.pointer,
            _id_onSaveInstanceState as jni.JMethodIDPtr,
            bundle.reference.pointer)
        .check();
  }

  static final _id_onStop = _class.instanceMethodId(
    r'onStop',
    r'()V',
  );

  static final _onStop = ProtectedJniExtensions.lookup<
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

  /// from: `public void onStop()`
  void onStop() {
    _onStop(reference.pointer, _id_onStop as jni.JMethodIDPtr).check();
  }

  static final _id_onLowMemory = _class.instanceMethodId(
    r'onLowMemory',
    r'()V',
  );

  static final _onLowMemory = ProtectedJniExtensions.lookup<
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

  /// from: `public void onLowMemory()`
  void onLowMemory() {
    _onLowMemory(reference.pointer, _id_onLowMemory as jni.JMethodIDPtr)
        .check();
  }

  static final _id_onDestroyView = _class.instanceMethodId(
    r'onDestroyView',
    r'()V',
  );

  static final _onDestroyView = ProtectedJniExtensions.lookup<
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

  /// from: `public void onDestroyView()`
  void onDestroyView() {
    _onDestroyView(reference.pointer, _id_onDestroyView as jni.JMethodIDPtr)
        .check();
  }

  static final _id_onDestroy = _class.instanceMethodId(
    r'onDestroy',
    r'()V',
  );

  static final _onDestroy = ProtectedJniExtensions.lookup<
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

  /// from: `public void onDestroy()`
  void onDestroy() {
    _onDestroy(reference.pointer, _id_onDestroy as jni.JMethodIDPtr).check();
  }

  static final _id_getMapAsync = _class.instanceMethodId(
    r'getMapAsync',
    r'(Lorg/maplibre/android/maps/OnMapReadyCallback;)V',
  );

  static final _getMapAsync = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: `public void getMapAsync(org.maplibre.android.maps.OnMapReadyCallback onMapReadyCallback)`
  void getMapAsync(
    onmapreadycallback_.OnMapReadyCallback onMapReadyCallback,
  ) {
    _getMapAsync(reference.pointer, _id_getMapAsync as jni.JMethodIDPtr,
            onMapReadyCallback.reference.pointer)
        .check();
  }
}

final class $MapFragmentType extends jni.JObjType<MapFragment> {
  const $MapFragmentType();

  @override
  String get signature => r'Lorg/maplibre/android/maps/MapFragment;';

  @override
  MapFragment fromReference(jni.JReference reference) =>
      MapFragment.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($MapFragmentType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($MapFragmentType) && other is $MapFragmentType;
  }
}
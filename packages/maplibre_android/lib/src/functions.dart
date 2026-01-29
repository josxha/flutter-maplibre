import 'dart:ui';

import 'package:jni/jni.dart';
import 'package:maplibre_android/src/jni.g.dart';

/// Get the Android [Context].
Context getJContext() => Jni.androidApplicationContext.as(Context.type);

/// Get the Android [Activity].
Activity getJActivity() =>
    Jni.androidActivity(_engineId)?.as(Activity.type) ??
    (throw Exception(
      'No Android Activity is attached to the Flutter engine with id $_engineId. '
      'This usually means that the Flutter engine is running in a '
      'background context without an associated Activity.',
    ));

int get _engineId =>
    PlatformDispatcher.instance.engineId ??
    (throw Exception(
      'PlatformDispatcher.instance.engineId is null. '
      'This usually means that the code is being executed outside of a '
      'Flutter engine context.',
    ));

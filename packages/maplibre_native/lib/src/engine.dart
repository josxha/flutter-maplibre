import 'dart:ui';

/// The id of the Flutter engine that runs this isolate, which every plugin
/// call passes.
///
/// Each engine of the process, such as a second one of a background service,
/// registers a plugin of its own with its own texture registry, and the
/// plugin serves a call with the textures of the caller's engine.
int get engineId =>
    PlatformDispatcher.instance.engineId ??
    (throw StateError('Flutter reports no engine for this isolate.'));

#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

// Registers the maplibre_native Linux plugin. Dart reaches it through the C
// API in desktop/include/maplibre_native/maplibre_native_api.h, never through
// a channel.
FLUTTER_PLUGIN_EXPORT void maplibre_native_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_

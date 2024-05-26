//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <maplibre/maplibre_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) maplibre_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MaplibrePlugin");
  maplibre_plugin_register_with_registrar(maplibre_registrar);
}

#include "include/maplibre_native/maplibre_native_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "maplibre_native_plugin.h"

void MaplibreNativePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  maplibre_native::MaplibreNativePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

#include "include/maplibre/maplibre_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "maplibre_plugin.h"

void MaplibrePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  maplibre::MaplibrePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

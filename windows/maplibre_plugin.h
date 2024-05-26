#ifndef FLUTTER_PLUGIN_MAPLIBRE_PLUGIN_H_
#define FLUTTER_PLUGIN_MAPLIBRE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace maplibre {

class MaplibrePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MaplibrePlugin();

  virtual ~MaplibrePlugin();

  // Disallow copy and assign.
  MaplibrePlugin(const MaplibrePlugin&) = delete;
  MaplibrePlugin& operator=(const MaplibrePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace maplibre

#endif  // FLUTTER_PLUGIN_MAPLIBRE_PLUGIN_H_

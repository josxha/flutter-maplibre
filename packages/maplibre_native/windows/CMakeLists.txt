cmake_minimum_required(VERSION 3.14)

set(PROJECT_NAME "maplibre_native")
project(${PROJECT_NAME} LANGUAGES CXX)

cmake_policy(VERSION 3.14...3.25)

# This value is used when generating builds using this plugin, so it must
# not be changed.
set(PLUGIN_NAME "maplibre_native_plugin")

add_library(${PLUGIN_NAME} SHARED
  "include/maplibre_native/maplibre_native_plugin_c_api.h"
  "maplibre_native_plugin_c_api.cpp"
  "maplibre_native_plugin.cpp"
  "maplibre_native_plugin.h"
)

apply_standard_settings(${PLUGIN_NAME})

set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin)

# maplibre-native-c.dll reaches the application as a Dart code asset declared
# by the maplibre_native_ffi build hook, which Flutter bundles beside the
# executable, so nothing is listed here.
set(maplibre_native_bundled_libraries
  ""
  PARENT_SCOPE
)

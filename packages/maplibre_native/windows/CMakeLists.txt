cmake_minimum_required(VERSION 3.14)

set(PROJECT_NAME "maplibre_native")
project(${PROJECT_NAME} LANGUAGES CXX)

cmake_policy(VERSION 3.14...3.25)

# This value is used when generating builds using this plugin, so it must
# not be changed.
set(PLUGIN_NAME "maplibre_native_plugin")

# Vulkan headers, for the device that render sessions borrow and for the
# D3D11 interop of zero-copy textures. The loader is opened at runtime, so no
# Vulkan SDK is needed. The headers come from a pinned release rather than the
# vendored submodule, whose path through Flutter's plugin symlinks passes
# MAX_PATH.
include(FetchContent)
FetchContent_Declare(
  mln_vulkan_headers
  URL https://github.com/KhronosGroup/Vulkan-Headers/archive/refs/tags/v1.3.296.tar.gz
  URL_HASH SHA256=e204e0b3c19f622d197df945737f5db913d6621830999b8578d34e80a7c90585
)
FetchContent_GetProperties(mln_vulkan_headers)
if(NOT mln_vulkan_headers_POPULATED)
  FetchContent_Populate(mln_vulkan_headers)
endif()
set(MLN_VULKAN_HEADERS_DIR "${mln_vulkan_headers_SOURCE_DIR}/include")

add_library(${PLUGIN_NAME} SHARED
  "include/maplibre_native/maplibre_native_plugin_c_api.h"
  "maplibre_native_plugin_c_api.cpp"
  "maplibre_native_plugin.cpp"
  "maplibre_native_plugin.h"
  "gpu_texture.cpp"
  "gpu_texture.h"
  "vulkan_device.cpp"
  "vulkan_device.h"
)

apply_standard_settings(${PLUGIN_NAME})

set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL NOMINMAX)

target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_include_directories(${PLUGIN_NAME} PRIVATE "${MLN_VULKAN_HEADERS_DIR}")
target_link_libraries(${PLUGIN_NAME} PRIVATE
  flutter flutter_wrapper_plugin d3d11 dxgi)

# maplibre-native-c.dll reaches the application as a Dart code asset declared
# by the maplibre_native_ffi build hook, which Flutter bundles beside the
# executable, so nothing is listed here.
set(maplibre_native_bundled_libraries
  ""
  PARENT_SCOPE
)

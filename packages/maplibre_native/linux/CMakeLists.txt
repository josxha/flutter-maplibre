cmake_minimum_required(VERSION 3.10)

set(PROJECT_NAME "maplibre_native")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed.
set(PLUGIN_NAME "maplibre_native_plugin")

# The Vulkan device and the C API, shared with the Windows plugin.
set(MLN_DESKTOP_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../desktop")
include("${MLN_DESKTOP_DIR}/vulkan_headers.cmake")

# OpenGL, through the libepoxy that GTK and Flutter already load, imports the
# Vulkan memory of zero-copy textures.
find_package(PkgConfig REQUIRED)
pkg_check_modules(EPOXY REQUIRED IMPORTED_TARGET epoxy)

add_library(${PLUGIN_NAME} SHARED
  "include/maplibre_native/maplibre_native_plugin.h"
  "maplibre_native_plugin.cc"
  "gl_texture.cc"
  "gl_texture.h"
  "pixel_texture.cc"
  "pixel_texture.h"
  "${MLN_DESKTOP_DIR}/desktop_plugin.h"
  "${MLN_DESKTOP_DIR}/maplibre_native_api.cpp"
  "${MLN_DESKTOP_DIR}/vulkan_device.cpp"
  "${MLN_DESKTOP_DIR}/vulkan_device.h"
)

apply_standard_settings(${PLUGIN_NAME})
target_compile_features(${PLUGIN_NAME} PRIVATE cxx_std_17)

set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_include_directories(${PLUGIN_NAME} PRIVATE
  "${MLN_DESKTOP_DIR}" "${MLN_DESKTOP_DIR}/include" "${MLN_VULKAN_HEADERS_DIR}")
target_link_libraries(${PLUGIN_NAME} PRIVATE
  flutter PkgConfig::GTK PkgConfig::EPOXY ${CMAKE_DL_LIBS})

# libmaplibre-native-c.so reaches the application as a Dart code asset
# declared by the maplibre_native_ffi build hook, which Flutter bundles in
# lib/, so nothing is listed here.
set(maplibre_native_bundled_libraries
  ""
  PARENT_SCOPE
)

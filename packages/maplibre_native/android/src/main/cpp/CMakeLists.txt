cmake_minimum_required(VERSION 3.13)  # target_link_options

project(maplibre_native_jni LANGUAGES CXX)

add_library(maplibre_native_jni SHARED maplibre_native_jni.cpp)

target_compile_features(maplibre_native_jni PRIVATE cxx_std_17)
target_link_libraries(maplibre_native_jni PRIVATE android log dl EGL vulkan)

# Android 15 and later run on devices with 16 KB memory pages, and Google
# Play requires every shared library of an app that targets them to align
# its LOAD segments to that size. The NDK's CMake toolchain still links at
# 4 KB, so ask the linker for 16 KB.
target_link_options(maplibre_native_jni PRIVATE "-Wl,-z,max-page-size=16384")

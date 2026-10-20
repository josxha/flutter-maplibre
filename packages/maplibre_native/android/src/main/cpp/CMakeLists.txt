cmake_minimum_required(VERSION 3.10)

project(maplibre_native_jni LANGUAGES CXX)

add_library(maplibre_native_jni SHARED maplibre_native_jni.cpp)

target_compile_features(maplibre_native_jni PRIVATE cxx_std_17)
target_link_libraries(maplibre_native_jni PRIVATE android log dl EGL vulkan)

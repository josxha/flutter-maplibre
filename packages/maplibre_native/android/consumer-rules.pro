# The MapLibre Native C library calls the TLS certificate verifier over JNI.
-keep, includedescriptorclasses class org.maplibre.nativeffi.internal.rustlsplatformverifier.** { *; }
# The JNI shim binds these native methods by name.
-keep class com.github.josxha.maplibre_native.NativeBridge { *; }
# Dart calls the API and implements the listener through jnigen bindings.
-keep class com.github.josxha.maplibre_native.MaplibreNativeApi { *; }
-keep interface com.github.josxha.maplibre_native.SurfaceListener { *; }

-keep class com.google.gson.** { *; }
-keep class org.maplibre.** { *; }

-keepclasseswithmembernames class * {
    native <methods>;
}
-keepclasseswithmembers class * {
    native <methods>;
}

-keep class io.flutter.plugin.platform.** { *; }
-keep class io.flutter.plugin.common.** { *; }
-keep class io.flutter.embedding.engine.plugins.** { *; }
-keep class android.app.Application$ActivityLifecycleCallbacks { *; }

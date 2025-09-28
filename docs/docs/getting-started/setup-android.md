---
sidebar_position: 20
---

# Setup Android

## Use a compatible Kotlin version

Ensure that you are using Kotlin version
**1.9.0** or newer. You can check the most recent Kotlin version on
[kotlinlang.org](https://kotlinlang.org/docs/releases.html#release-details).

### (new) Gradle with a declarative plugins block

Open `android/settings.gradle` and set the Kotlin version like this:

```gradle title="android/settings.gradle"
plugins {
    // ...
    // highlight-next-line
    id "org.jetbrains.kotlin.android" version "1.9.0" apply false
}
```

In case you can't find the `plugins {}` block your app still uses the old apply
script method.

### (old) In a legacy apply script gradle file

Open `android/app/build.gradle` and set the Kotlin version like this:

```gradle title="android/app/build.gradle"
buildscript {
    // highlight-next-line
    ext.kotlin_version = '1.9.0'
    // ...
}
```

## Adjust the minSdk version of Android

The `maplibre` package on Flutter
uses [platform views](https://docs.flutter.dev/platform-integration/android/platform-views)
to display the native map. This requires an Android SDK version of at least 23
(Android 6.0).

:::tip

The app compiles with a minSdk version of down to 21. However, the MapLibre map
won't be visible on these Android versions. You can check for the SDK version
with [device_info_plus](https://pub.dev/packages/device_info_plus)
and render an alternative map as a workaround or limit the supported Android
versions to Android 6.0 and onwards like demonstrated here.

:::

Open your `android/app/build.gradle` file and ensure that it is set to 23 or
higher.

```gradle title="android/app/build.gradle"
android {
    defaultConfig {
        // ...
        // highlight-next-line
        minSdk = 23 // previously flutter.minSdkVersion
        // ...
    }
}
```

## Set the permissions

If you want to show the user's location on the map you need to add
the permissions in the application
manifest`android/app/src/main/AndroidManifest.xml`.

```xml title="android/app/src/main/AndroidManifest.xml"

<manifest>
    // highlight-start
    <!-- Always include this permission -->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    <!-- Include only if your app benefits from precise location access. -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    // highlight-end
</manifest>
```

Starting from Android API level 23 you also need to request it at runtime.
You can use the `PermissionManager` for it (only available with version 0.1.2 or
later).
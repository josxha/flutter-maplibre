dart run jnigen --config jnigen.yaml

# https://github.com/dart-lang/native/issues/2493
# Read whole file as single string
$content = Get-Content -Path "lib/src/platform/android/jni/org/maplibre/android/camera/CameraUpdateFactory.dart" -Raw
# Remove abstract base mixin class block
$content = $content -replace '(?s)abstract base mixin class \$CameraUpdateFactory\$ZoomUpdate\$Type\s*\{.*?\}\s*', ''
# Remove final class block
$content = $content -replace '(?s)final class _\$CameraUpdateFactory\$ZoomUpdate\$Type.*?\{.*?\}\s*', ''
# Remove trailing newline (and only keep one final newline if desired)
$content = $content.TrimEnd("`r", "`n")
# Write file back
Set-Content -Path "lib/src/platform/android/jni/org/maplibre/android/camera/CameraUpdateFactory.dart" -Value $content
#!/bin/bash
# Builds and runs gl_texture_test.cc, which checks the zero-copy path of the
# Linux plugin without Flutter: the GPU IDs from an EGL context like Flutter's
# on a real GTK window's display, a Vulkan device on that GPU, and exported
# Vulkan images that populate imports in an EGL context of its own, as
# Flutter's.
#
# Needs an X display (XWayland in a Wayland session, or xvfb-run),
# libgtk-3-dev, libepoxy-dev, a Vulkan driver, and Flutter's Linux engine
# headers, which `flutter precache --linux` puts in the Flutter SDK. On a
# machine without a GPU, Mesa's lavapipe and llvmpipe share memory with each
# other:
#
#   LIBGL_ALWAYS_SOFTWARE=1 VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/lvp_icd.json \
#     packages/maplibre_native/linux/test/run_gl_texture_test.sh
#
# Vulkan headers come from VULKAN_INCLUDE, else from the system, else from the
# copy that a Linux build of the example app fetched
# (examples/build/linux/x64/*/_deps/mln_vulkan_headers-src/include).
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
package="$here/../.."
if [ -z "${VULKAN_INCLUDE:-}" ] &&
  ! echo '#include <vulkan/vulkan.h>' | ${CXX:-g++} -E -x c++ - >/dev/null 2>&1; then
  for dir in "$package"/../../examples/build/linux/x64/*/_deps/mln_vulkan_headers-src/include; do
    if [ -f "$dir/vulkan/vulkan.h" ]; then VULKAN_INCLUDE="$dir"; break; fi
  done
  if [ -z "${VULKAN_INCLUDE:-}" ]; then
    echo "No Vulkan headers: install them, set VULKAN_INCLUDE, or build the example app for Linux first." >&2
    exit 1
  fi
fi
flutter_root="${FLUTTER_ROOT:-$(dirname "$(dirname "$(readlink -f "$(command -v flutter)")")")}"
engine="$flutter_root/bin/cache/artifacts/engine/linux-x64"
out="$(mktemp -d)"
trap 'rm -rf "$out"' EXIT
${CXX:-g++} -std=c++17 -O1 -g -Wall -Werror -DFLUTTER_LINUX_COMPILATION \
  -I"$engine" -I"$package/linux" -I"$package/desktop" \
  -I"$package/desktop/include" ${VULKAN_INCLUDE:+-I"$VULKAN_INCLUDE"} \
  $(pkg-config --cflags gtk+-3.0 epoxy) \
  "$here/gl_texture_test.cc" "$package/linux/gl_texture.cc" \
  "$package/linux/vulkan_device.cc" \
  $(pkg-config --libs gtk+-3.0 epoxy) -ldl -o "$out/gl_texture_test"
"$out/gl_texture_test"

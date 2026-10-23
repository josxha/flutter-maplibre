# Vulkan headers, for the device that render sessions borrow and for the
# memory that zero-copy textures share. The loader is opened at runtime, so no
# Vulkan SDK is needed. The headers come from a pinned release. Sets
# MLN_VULKAN_HEADERS_DIR.
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

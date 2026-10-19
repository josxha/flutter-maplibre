#include "maplibre_native_plugin.h"

#include <flutter/plugin_registrar_windows.h>

#include <algorithm>
#include <cstring>
#include <memory>

#include "include/maplibre_native/maplibre_native_api.h"

namespace maplibre_native {

using Microsoft::WRL::ComPtr;

namespace {

std::mutex g_mutex;
MaplibreNativePlugin* g_plugin = nullptr;

}  // namespace

PixelTexture::PixelTexture(flutter::TextureRegistrar* registrar)
    : registrar_(registrar) {
  texture_ = std::make_unique<flutter::TextureVariant>(
      flutter::PixelBufferTexture([this](size_t width, size_t height) {
        return CopyPixelBuffer(width, height);
      }));
  id_ = registrar_->RegisterTexture(texture_.get());
}

// static
void PixelTexture::Dispose(std::unique_ptr<PixelTexture> texture) {
  PixelTexture* raw = texture.release();
  // Flutter may copy the buffer until unregistration completes.
  raw->registrar_->UnregisterTexture(raw->id_, [raw] { delete raw; });
}

void PixelTexture::Update(size_t width, size_t height, const uint8_t* pixels,
                          size_t stride) {
  {
    std::lock_guard<std::mutex> lock(mutex_);
    const size_t row_bytes = width * 4;
    pixels_.resize(row_bytes * height);
    if (stride == row_bytes) {
      std::memcpy(pixels_.data(), pixels, pixels_.size());
    } else {
      for (size_t row = 0; row < height; ++row) {
        std::memcpy(pixels_.data() + row * row_bytes, pixels + row * stride,
                    row_bytes);
      }
    }
    buffer_.width = width;
    buffer_.height = height;
  }
  registrar_->MarkTextureFrameAvailable(id_);
}

// Runs on the raster thread. The mutex stays held until Flutter calls
// release_callback, so Update cannot replace the bytes during the upload.
const FlutterDesktopPixelBuffer* PixelTexture::CopyPixelBuffer(size_t width,
                                                               size_t height) {
  mutex_.lock();
  if (pixels_.empty()) {
    mutex_.unlock();
    return nullptr;
  }
  buffer_.buffer = pixels_.data();
  buffer_.release_context = &mutex_;
  buffer_.release_callback = [](void* context) {
    static_cast<std::mutex*>(context)->unlock();
  };
  return &buffer_;
}

// static
void MaplibreNativePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar) {
  registrar->AddPlugin(std::make_unique<MaplibreNativePlugin>(registrar));
}

// static
MaplibreNativePlugin* MaplibreNativePlugin::Instance() { return g_plugin; }

// static
std::unique_lock<std::mutex> MaplibreNativePlugin::Lock() {
  return std::unique_lock<std::mutex>(g_mutex);
}

MaplibreNativePlugin::MaplibreNativePlugin(
    flutter::PluginRegistrarWindows* registrar)
    : textures_(registrar->texture_registrar()) {
  if (registrar->GetGraphicsAdapter(&adapter_) && adapter_) {
    DXGI_ADAPTER_DESC desc{};
    if (SUCCEEDED(adapter_->GetDesc(&desc))) {
      adapter_luid_ = desc.AdapterLuid;
      has_adapter_luid_ = true;
    }
  }
  std::lock_guard<std::mutex> lock(g_mutex);
  g_plugin = this;
}

MaplibreNativePlugin::~MaplibreNativePlugin() {
  std::lock_guard<std::mutex> lock(g_mutex);
  if (g_plugin == this) g_plugin = nullptr;
  for (auto& [id, texture] : pixel_textures_) {
    PixelTexture::Dispose(std::move(texture));
  }
  for (auto& [id, texture] : gpu_textures_) {
    GpuTexture::Dispose(std::move(texture));
  }
}

VulkanDevice* MaplibreNativePlugin::GetVulkan(std::string* error) {
  return VulkanDevice::Get(has_adapter_luid_ ? &adapter_luid_ : nullptr, error);
}

ID3D11Device* MaplibreNativePlugin::GetD3D11(std::string* error) {
  if (d3d_) return d3d_.Get();
  if (!adapter_) {
    *error = "Flutter does not render through a DXGI adapter.";
    return nullptr;
  }
  const D3D_FEATURE_LEVEL levels[] = {D3D_FEATURE_LEVEL_11_1,
                                      D3D_FEATURE_LEVEL_11_0};
  HRESULT result = D3D11CreateDevice(
      adapter_.Get(), D3D_DRIVER_TYPE_UNKNOWN, nullptr, 0, levels,
      static_cast<UINT>(std::size(levels)), D3D11_SDK_VERSION, &d3d_, nullptr,
      nullptr);
  if (FAILED(result)) {
    *error = "D3D11CreateDevice failed.";
    return nullptr;
  }
  return d3d_.Get();
}

int64_t MaplibreNativePlugin::CreatePixelTexture() {
  auto texture = std::make_unique<PixelTexture>(textures_);
  const int64_t id = texture->id();
  pixel_textures_.emplace(id, std::move(texture));
  return id;
}

bool MaplibreNativePlugin::UpdatePixelTexture(int64_t id, size_t width,
                                              size_t height, size_t stride,
                                              const uint8_t* pixels,
                                              size_t length,
                                              std::string* error) {
  const auto texture = pixel_textures_.find(id);
  if (texture == pixel_textures_.end()) {
    *error = "No pixel buffer texture with this id.";
    return false;
  }
  if (pixels == nullptr || width == 0 || height == 0 || stride < width * 4 ||
      length < stride * (height - 1) + width * 4) {
    *error = "Pixel data does not match its size.";
    return false;
  }
  texture->second->Update(width, height, pixels, stride);
  return true;
}

GpuTexture* MaplibreNativePlugin::CreateGpuTexture(uint32_t width,
                                                   uint32_t height,
                                                   uint32_t slot_count,
                                                   std::string* error) {
  // Lets the CPU readback path be tested on hardware that shares textures.
  char disable[2] = {};
  if (GetEnvironmentVariableA("MAPLIBRE_NATIVE_DISABLE_ZERO_COPY", disable,
                              sizeof(disable)) > 0) {
    *error = "MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set.";
    return nullptr;
  }
  VulkanDevice* vulkan = GetVulkan(error);
  ID3D11Device* d3d = vulkan == nullptr ? nullptr : GetD3D11(error);
  if (d3d == nullptr) return nullptr;
  auto texture = GpuTexture::Create(textures_, vulkan, d3d, width, height,
                                    slot_count, error);
  if (!texture) return nullptr;
  GpuTexture* raw = texture.get();
  gpu_textures_.emplace(raw->id(), std::move(texture));
  return raw;
}

GpuTexture* MaplibreNativePlugin::FindGpuTexture(int64_t id) {
  const auto texture = gpu_textures_.find(id);
  return texture == gpu_textures_.end() ? nullptr : texture->second.get();
}

void MaplibreNativePlugin::DisposeTexture(int64_t id) {
  if (const auto gpu = gpu_textures_.find(id); gpu != gpu_textures_.end()) {
    GpuTexture::Dispose(std::move(gpu->second));
    gpu_textures_.erase(gpu);
  } else if (const auto pixel = pixel_textures_.find(id);
             pixel != pixel_textures_.end()) {
    PixelTexture::Dispose(std::move(pixel->second));
    pixel_textures_.erase(pixel);
  }
}

}  // namespace maplibre_native

// C API

using maplibre_native::GpuTexture;
using maplibre_native::MaplibreNativePlugin;
using maplibre_native::SharedSlot;

namespace {

void WriteError(const std::string& message, char* error, size_t error_size) {
  if (error == nullptr || error_size == 0) return;
  const size_t length = std::min(message.size(), error_size - 1);
  std::memcpy(error, message.data(), length);
  error[length] = '\0';
}

uint64_t Bits(const void* handle) {
  return static_cast<uint64_t>(reinterpret_cast<uintptr_t>(handle));
}

void WriteSlots(const std::vector<SharedSlot>& slots,
                MaplibreNativeGpuSlot* out_slots, uint32_t slot_capacity) {
  const size_t count = std::min<size_t>(slots.size(), slot_capacity);
  for (size_t i = 0; i < count; ++i) {
    out_slots[i].image = reinterpret_cast<uint64_t>(slots[i].image);
    out_slots[i].view = reinterpret_cast<uint64_t>(slots[i].view);
  }
}

// Finds a GPU texture of the registered plugin; the caller holds the lock.
GpuTexture* FindGpuTexture(int64_t texture_id, char* error,
                           size_t error_size) {
  MaplibreNativePlugin* plugin = MaplibreNativePlugin::Instance();
  GpuTexture* texture =
      plugin == nullptr ? nullptr : plugin->FindGpuTexture(texture_id);
  if (texture == nullptr) {
    WriteError("No GPU texture with this id.", error, error_size);
  }
  return texture;
}

constexpr const char* kNotRegistered =
    "The maplibre_native Windows plugin is not registered.";

}  // namespace

bool maplibre_native_vulkan_context(MaplibreNativeVulkanContext* out_context,
                                    char* error, size_t error_size) {
  auto lock = MaplibreNativePlugin::Lock();
  MaplibreNativePlugin* plugin = MaplibreNativePlugin::Instance();
  if (plugin == nullptr) {
    WriteError(kNotRegistered, error, error_size);
    return false;
  }
  std::string message;
  maplibre_native::VulkanDevice* vulkan = plugin->GetVulkan(&message);
  if (vulkan == nullptr) {
    WriteError(message, error, error_size);
    return false;
  }
  *out_context = MaplibreNativeVulkanContext{
      Bits(vulkan->instance()),
      Bits(vulkan->physical_device()),
      Bits(vulkan->device()),
      Bits(vulkan->queue()),
      vulkan->queue_family_index(),
      Bits(reinterpret_cast<void*>(vulkan->get_instance_proc_addr())),
      Bits(reinterpret_cast<void*>(vulkan->get_device_proc_addr())),
  };
  return true;
}

int64_t maplibre_native_create_pixel_texture(void) {
  auto lock = MaplibreNativePlugin::Lock();
  MaplibreNativePlugin* plugin = MaplibreNativePlugin::Instance();
  return plugin == nullptr ? -1 : plugin->CreatePixelTexture();
}

bool maplibre_native_update_pixel_texture(int64_t texture_id, uint32_t width,
                                          uint32_t height, uint32_t stride,
                                          const uint8_t* pixels, size_t length,
                                          char* error, size_t error_size) {
  auto lock = MaplibreNativePlugin::Lock();
  MaplibreNativePlugin* plugin = MaplibreNativePlugin::Instance();
  if (plugin == nullptr) {
    WriteError(kNotRegistered, error, error_size);
    return false;
  }
  std::string message;
  if (!plugin->UpdatePixelTexture(texture_id, width, height, stride, pixels,
                                  length, &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  return true;
}

int64_t maplibre_native_create_gpu_texture(uint32_t width, uint32_t height,
                                           uint32_t slot_count,
                                           uint32_t* out_format,
                                           MaplibreNativeGpuSlot* out_slots,
                                           uint32_t slot_capacity, char* error,
                                           size_t error_size) {
  auto lock = MaplibreNativePlugin::Lock();
  MaplibreNativePlugin* plugin = MaplibreNativePlugin::Instance();
  if (plugin == nullptr) {
    WriteError(kNotRegistered, error, error_size);
    return -1;
  }
  std::string message;
  GpuTexture* texture =
      plugin->CreateGpuTexture(width, height, slot_count, &message);
  if (texture == nullptr) {
    WriteError(message, error, error_size);
    return -1;
  }
  *out_format = static_cast<uint32_t>(GpuTexture::kVulkanFormat);
  WriteSlots(texture->slots(), out_slots, slot_capacity);
  return texture->id();
}

bool maplibre_native_resize_gpu_texture(int64_t texture_id, uint32_t width,
                                        uint32_t height,
                                        MaplibreNativeGpuSlot* out_slots,
                                        uint32_t slot_capacity, char* error,
                                        size_t error_size) {
  auto lock = MaplibreNativePlugin::Lock();
  GpuTexture* texture = FindGpuTexture(texture_id, error, error_size);
  if (texture == nullptr) return false;
  std::string message;
  if (!texture->Resize(width, height, &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  WriteSlots(texture->slots(), out_slots, slot_capacity);
  return true;
}

void maplibre_native_release_retired_slots(int64_t texture_id) {
  auto lock = MaplibreNativePlugin::Lock();
  if (GpuTexture* texture = FindGpuTexture(texture_id, nullptr, 0)) {
    texture->ReleaseRetiredSlots();
  }
}

bool maplibre_native_present_gpu_texture(int64_t texture_id, uint32_t slot,
                                         char* error, size_t error_size) {
  auto lock = MaplibreNativePlugin::Lock();
  GpuTexture* texture = FindGpuTexture(texture_id, error, error_size);
  if (texture == nullptr) return false;
  std::string message;
  if (!texture->Present(slot, &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  return true;
}

void maplibre_native_dispose_texture(int64_t texture_id) {
  auto lock = MaplibreNativePlugin::Lock();
  if (MaplibreNativePlugin* plugin = MaplibreNativePlugin::Instance()) {
    plugin->DisposeTexture(texture_id);
  }
}

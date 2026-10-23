#include "maplibre_native_plugin.h"

#include <flutter/plugin_registrar_windows.h>

#include <cstring>
#include <memory>

namespace maplibre_native {

using Microsoft::WRL::ComPtr;

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

MaplibreNativePlugin::MaplibreNativePlugin(
    flutter::PluginRegistrarWindows* registrar)
    : textures_(registrar->texture_registrar()) {
  if (registrar->GetGraphicsAdapter(&adapter_) && adapter_) {
    DXGI_ADAPTER_DESC desc{};
    if (SUCCEEDED(adapter_->GetDesc(&desc))) {
      static_assert(sizeof(desc.AdapterLuid) == VK_LUID_SIZE);
      std::memcpy(adapter_luid_.bytes, &desc.AdapterLuid, VK_LUID_SIZE);
      adapter_luid_.size = VK_LUID_SIZE;
    }
  }
}

MaplibreNativePlugin::~MaplibreNativePlugin() {
  auto lock = Lock();
  Unregister();
  for (auto& [id, texture] : pixel_textures_) {
    PixelTexture::Dispose(std::move(texture));
  }
  for (auto& [id, texture] : gpu_textures_) {
    D3D11Texture::Dispose(std::move(texture));
  }
}

VulkanDevice* MaplibreNativePlugin::GetVulkan(std::string* error) {
  return VulkanDevice::Get(&adapter_luid_, error);
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
                                              const uint8_t* pixels) {
  const auto texture = pixel_textures_.find(id);
  if (texture == pixel_textures_.end()) return false;
  texture->second->Update(width, height, pixels, stride);
  return true;
}

GpuTexture* MaplibreNativePlugin::CreateGpuTexture(uint32_t width,
                                                   uint32_t height,
                                                   uint32_t slot_count,
                                                   std::string* error) {
  if (ZeroCopyDisabled()) {
    *error = "MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set.";
    return nullptr;
  }
  VulkanDevice* vulkan = GetVulkan(error);
  ID3D11Device* d3d = vulkan == nullptr ? nullptr : GetD3D11(error);
  if (d3d == nullptr) return nullptr;
  auto texture = D3D11Texture::Create(textures_, vulkan, d3d, width, height,
                                      slot_count, error);
  if (!texture) return nullptr;
  D3D11Texture* raw = texture.get();
  gpu_textures_.emplace(raw->id(), std::move(texture));
  return raw;
}

GpuTexture* MaplibreNativePlugin::FindGpuTexture(int64_t id) {
  const auto texture = gpu_textures_.find(id);
  return texture == gpu_textures_.end() ? nullptr : texture->second.get();
}

void MaplibreNativePlugin::DisposeTexture(int64_t id) {
  if (const auto gpu = gpu_textures_.find(id); gpu != gpu_textures_.end()) {
    D3D11Texture::Dispose(std::move(gpu->second));
    gpu_textures_.erase(gpu);
  } else if (const auto pixel = pixel_textures_.find(id);
             pixel != pixel_textures_.end()) {
    PixelTexture::Dispose(std::move(pixel->second));
    pixel_textures_.erase(pixel);
  }
}

}  // namespace maplibre_native

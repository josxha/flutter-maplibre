#include "maplibre_native_plugin.h"

#include <flutter/plugin_registrar_windows.h>
#include <maplibre_native/maplibre_native_api.h>

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
      static_assert(sizeof(desc.AdapterLuid) == 8);
      std::memcpy(adapter_luid_.bytes, &desc.AdapterLuid, 8);
      adapter_luid_.size = 8;
    }
  }
}

MaplibreNativePlugin::~MaplibreNativePlugin() {
  auto lock = Lock();
  Unregister();
  for (auto& [id, texture] : pixel_textures_) {
    PixelTexture::Dispose(std::move(texture));
  }
  for (auto& [id, texture] : shared_textures_) {
    SharedTexture::Dispose(std::move(texture));
  }
}

bool MaplibreNativePlugin::GetGpuId(GpuId* id, std::string* error) {
  // The library opens a D3D11 device on the adapter too, to allocate its
  // shared textures there.
  if (GetD3D11(error) == nullptr) return false;
  *id = adapter_luid_;
  return true;
}

ID3D11Device1* MaplibreNativePlugin::GetD3D11(std::string* error) {
  if (d3d_) return d3d_.Get();
  if (!adapter_) {
    *error = "Flutter does not render through a DXGI adapter.";
    return nullptr;
  }
  if (adapter_luid_.size == 0) {
    *error = "Flutter's DXGI adapter has no LUID.";
    return nullptr;
  }
  const D3D_FEATURE_LEVEL levels[] = {D3D_FEATURE_LEVEL_11_1,
                                      D3D_FEATURE_LEVEL_11_0};
  ComPtr<ID3D11Device> device;
  HRESULT result = D3D11CreateDevice(
      adapter_.Get(), D3D_DRIVER_TYPE_UNKNOWN, nullptr, 0, levels,
      static_cast<UINT>(std::size(levels)), D3D11_SDK_VERSION, &device,
      nullptr, nullptr);
  if (FAILED(result)) {
    *error = "D3D11CreateDevice failed.";
    return nullptr;
  }
  // OpenSharedResource1 opens the NT handles of the library's textures.
  if (FAILED(device.As(&d3d_))) {
    *error = "D3D11 lacks ID3D11Device1, which opens NT shared handles.";
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

int64_t MaplibreNativePlugin::CreateSharedTexture(std::string* error) {
  ID3D11Device1* d3d = GetD3D11(error);
  if (d3d == nullptr) return -1;
  auto texture = std::make_unique<SharedTexture>(textures_, d3d);
  const int64_t id = texture->id();
  shared_textures_.emplace(id, std::move(texture));
  return id;
}

SharedTexture* MaplibreNativePlugin::FindSharedTexture(int64_t id) {
  const auto texture = shared_textures_.find(id);
  return texture == shared_textures_.end() ? nullptr : texture->second.get();
}

void MaplibreNativePlugin::DisposeTexture(int64_t id) {
  if (const auto shared = shared_textures_.find(id);
      shared != shared_textures_.end()) {
    SharedTexture::Dispose(std::move(shared->second));
    shared_textures_.erase(shared);
  } else if (const auto pixel = pixel_textures_.find(id);
             pixel != pixel_textures_.end()) {
    PixelTexture::Dispose(std::move(pixel->second));
    pixel_textures_.erase(pixel);
  }
}

}  // namespace maplibre_native

// The functions of the C API that only Windows has.

using maplibre_native::DesktopPlugin;
using maplibre_native::MaplibreNativePlugin;
using maplibre_native::SharedTexture;
using maplibre_native::WriteError;

int64_t maplibre_native_create_shared_texture(char* error, size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  auto* plugin = static_cast<MaplibreNativePlugin*>(DesktopPlugin::Instance());
  if (plugin == nullptr) {
    WriteError("The maplibre_native plugin is not registered.", error,
               error_size);
    return -1;
  }
  std::string message;
  const int64_t id = plugin->CreateSharedTexture(&message);
  if (id < 0) WriteError(message, error, error_size);
  return id;
}

bool maplibre_native_present_shared_texture(int64_t texture_id, uint32_t ring,
                                            uint32_t slot, uint64_t handle,
                                            char* error, size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  auto* plugin = static_cast<MaplibreNativePlugin*>(DesktopPlugin::Instance());
  SharedTexture* texture =
      plugin == nullptr ? nullptr : plugin->FindSharedTexture(texture_id);
  if (texture == nullptr) {
    WriteError("No shared texture with this id.", error, error_size);
    return false;
  }
  std::string message;
  if (!texture->Present(ring, slot,
                        reinterpret_cast<HANDLE>(static_cast<uintptr_t>(handle)),
                        &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  return true;
}

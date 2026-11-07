#include "shared_texture.h"

#include <cstdio>
#include <utility>

namespace maplibre_native {

using Microsoft::WRL::ComPtr;

namespace {

std::string HResultError(const char* what, HRESULT result) {
  char buffer[64];
  snprintf(buffer, sizeof(buffer), " failed with HRESULT 0x%08lx.",
           static_cast<unsigned long>(result));
  return std::string(what) + buffer;
}

}  // namespace

SharedTexture::SharedTexture(flutter::TextureRegistrar* registrar,
                             ID3D11Device1* d3d)
    : registrar_(registrar), d3d_(d3d) {
  d3d_->GetImmediateContext(&context_);
  D3D11_QUERY_DESC query_desc{D3D11_QUERY_EVENT, 0};
  d3d_->CreateQuery(&query_desc, &query_);
  descriptor_.struct_size = sizeof(FlutterDesktopGpuSurfaceDescriptor);
  descriptor_.format = kFlutterDesktopPixelFormatBGRA8888;
  texture_ =
      std::make_unique<flutter::TextureVariant>(flutter::GpuSurfaceTexture(
          kFlutterDesktopGpuSurfaceTypeDxgiSharedHandle,
          [this](size_t width, size_t height) {
            return Descriptor(width, height);
          }));
  id_ = registrar_->RegisterTexture(texture_.get());
}

// static
void SharedTexture::Dispose(std::unique_ptr<SharedTexture> texture) {
  SharedTexture* raw = texture.release();
  // Flutter may call Descriptor until unregistration completes, so the
  // texture lives until then. Present textures hold legacy shared handles,
  // which are not closed.
  raw->registrar_->UnregisterTexture(raw->id_, [raw] { delete raw; });
}

ID3D11Texture2D* SharedTexture::Open(uint32_t ring, uint32_t slot,
                                     HANDLE handle, std::string* error) {
  if (ring != ring_) {
    // The library replaced its textures, and closed the old handles.
    ring_ = ring;
    opened_.clear();
  }
  if (slot >= opened_.size()) opened_.resize(slot + 1);
  if (!opened_[slot]) {
    HRESULT result = d3d_->OpenSharedResource1(
        handle, IID_PPV_ARGS(opened_[slot].GetAddressOf()));
    if (FAILED(result)) {
      *error = HResultError("ID3D11Device1::OpenSharedResource1", result);
      return nullptr;
    }
  }
  return opened_[slot].Get();
}

bool SharedTexture::CreatePresentTextures(uint32_t width, uint32_t height,
                                          PresentTexture* created,
                                          std::string* error) {
  for (int i = 0; i < kPresentCount; ++i) {
    PresentTexture& present = created[i];
    D3D11_TEXTURE2D_DESC desc{};
    desc.Width = width;
    desc.Height = height;
    desc.MipLevels = 1;
    desc.ArraySize = 1;
    desc.Format = kFormat;
    desc.SampleDesc.Count = 1;
    desc.Usage = D3D11_USAGE_DEFAULT;
    desc.BindFlags = D3D11_BIND_RENDER_TARGET | D3D11_BIND_SHADER_RESOURCE;
    // Flutter opens the texture through ANGLE, which takes a legacy shared
    // handle.
    desc.MiscFlags = D3D11_RESOURCE_MISC_SHARED;
    HRESULT result = d3d_->CreateTexture2D(&desc, nullptr, &present.texture);
    ComPtr<IDXGIResource> resource;
    if (SUCCEEDED(result)) result = present.texture.As(&resource);
    if (SUCCEEDED(result)) result = resource->GetSharedHandle(&present.handle);
    if (FAILED(result)) {
      *error = HResultError("Creating the Flutter texture", result);
      return false;
    }
  }
  return true;
}

bool SharedTexture::Present(uint32_t ring, uint32_t slot, HANDLE handle,
                            std::string* error) {
  if (!query_) {
    *error = "ID3D11Device::CreateQuery failed.";
    return false;
  }
  ID3D11Texture2D* source = Open(ring, slot, handle, error);
  if (source == nullptr) return false;
  D3D11_TEXTURE2D_DESC desc{};
  source->GetDesc(&desc);
  // On a new size, Flutter keeps showing the old textures until a frame was
  // copied into the new ones.
  const bool resized = desc.Width != width_ || desc.Height != height_;
  PresentTexture created[kPresentCount];
  if (resized &&
      !CreatePresentTextures(desc.Width, desc.Height, created, error)) {
    return false;
  }
  int back = 0;
  ID3D11Texture2D* target;
  if (resized) {
    target = created[back].texture.Get();
  } else {
    std::lock_guard<std::mutex> lock(mutex_);
    while (back == front_ || back == fetched_) ++back;
    target = present_[back].texture.Get();
  }
  context_->CopyResource(target, source);
  context_->End(query_.Get());
  context_->Flush();
  // Flutter's device reads the texture without a keyed mutex, so the copy
  // completes before the frame is offered, and before the library renders
  // into its texture again.
  BOOL done = FALSE;
  while (context_->GetData(query_.Get(), &done, sizeof(done), 0) == S_FALSE) {
    SwitchToThread();
  }
  {
    std::lock_guard<std::mutex> lock(mutex_);
    // Two presents after a resize, Flutter shows the new textures.
    for (auto& retired : retired_present_) retired.first++;
    while (!retired_present_.empty() && retired_present_.front().first > 2) {
      retired_present_.pop_front();
    }
    if (resized) {
      for (int i = 0; i < kPresentCount; ++i) {
        if (present_[i].texture) {
          retired_present_.emplace_back(0, std::move(present_[i]));
        }
        present_[i] = std::move(created[i]);
      }
      fetched_ = -1;
      width_ = desc.Width;
      height_ = desc.Height;
    }
    front_ = back;
  }
  registrar_->MarkTextureFrameAvailable(id_);
  return true;
}

const FlutterDesktopGpuSurfaceDescriptor* SharedTexture::Descriptor(
    size_t width, size_t height) {
  std::lock_guard<std::mutex> lock(mutex_);
  if (front_ < 0) return nullptr;
  fetched_ = front_;
  D3D11_TEXTURE2D_DESC desc{};
  present_[front_].texture->GetDesc(&desc);
  descriptor_.handle = present_[front_].handle;
  descriptor_.width = descriptor_.visible_width = desc.Width;
  descriptor_.height = descriptor_.visible_height = desc.Height;
  descriptor_.release_callback = nullptr;
  descriptor_.release_context = nullptr;
  return &descriptor_;
}

}  // namespace maplibre_native

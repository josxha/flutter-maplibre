#import "MaplibreNativePlugin.h"

#import <CoreVideo/CoreVideo.h>
#import <IOSurface/IOSurfaceRef.h>
#import <os/lock.h>

#include <string.h>

/// The deepest ring the C library allocates.
enum { kMaxSlots = 8 };

/// Writes |message| into the caller's |error| buffer, when there is one.
static void WriteError(NSString *message, char *error, size_t error_size) {
  if (error == NULL || error_size == 0) return;
  strlcpy(error, message.UTF8String ?: "unknown error", error_size);
}

/// Runs |block| on the main thread and waits for it. Dart's UI thread is the
/// main thread when the platform and UI threads are merged, and then this runs
/// inline.
static void RunOnMain(dispatch_block_t block) {
  if (NSThread.isMainThread) {
    block();
  } else {
    dispatch_sync(dispatch_get_main_queue(), block);
  }
}

/// A Flutter texture that shows the frames of a ring of IOSurfaces, which the
/// C library allocates and renders into through Metal. Flutter samples the
/// surface of the presented frame directly, without a copy: Dart keeps that
/// frame acquired, so MapLibre renders into the other surfaces, and releases
/// a frame it replaced once -isSlotInUse: reports that Flutter no longer
/// samples its slot.
@interface MLNGpuTexture : NSObject <FlutterTexture>

/// Makes the finished frame in |surface|, at |slot| of the ring |ring|, the
/// one Flutter shows next.
- (BOOL)presentRing:(uint32_t)ring
               slot:(uint32_t)slot
            surface:(IOSurfaceRef)surface
              error:(NSString *_Nullable *_Nonnull)error;

/// Whether Flutter may still sample |slot|: it is the presented slot, or one
/// of the last two that Flutter took.
- (BOOL)isSlotInUse:(uint32_t)slot;

@end

@implementation MLNGpuTexture {
  /// The pixel buffers of the current ring's surfaces, by slot, which retain
  /// the surfaces.
  uint32_t _ring;
  CVPixelBufferRef _buffers[kMaxSlots];
  /// Guard the fields below, which Flutter's raster thread reads.
  os_unfair_lock _lock;
  /// The buffer of the presented frame, retained, and its slot, or -1.
  CVPixelBufferRef _latest;
  int64_t _latestSlot;
  /// The slot that Flutter took last, whose buffer it holds until it takes
  /// the next one, and the slot it took before, which a frame still on the
  /// GPU may read. Neither IOSurfaceIsInUse nor the use count see Flutter's
  /// reads: the ring's buffers keep every surface in use, and Flutter's
  /// texture adds nothing.
  int64_t _takenSlot;
  int64_t _previousTakenSlot;
}

- (instancetype)init {
  if ((self = [super init])) {
    _lock = OS_UNFAIR_LOCK_INIT;
    _latestSlot = -1;
    _takenSlot = -1;
    _previousTakenSlot = -1;
  }
  return self;
}

- (void)dealloc {
  [self releaseBuffers];
  if (_latest != NULL) CVPixelBufferRelease(_latest);
}

- (void)releaseBuffers {
  for (uint32_t i = 0; i < kMaxSlots; i++) {
    if (_buffers[i] != NULL) CVPixelBufferRelease(_buffers[i]);
    _buffers[i] = NULL;
  }
}

- (BOOL)presentRing:(uint32_t)ring
               slot:(uint32_t)slot
            surface:(IOSurfaceRef)surface
              error:(NSString *_Nullable *_Nonnull)error {
  if (slot >= kMaxSlots) {
    *error = [NSString stringWithFormat:@"Slot %u is beyond the ring", slot];
    return NO;
  }
  if (ring != _ring) {
    // The library replaced its surfaces. Flutter keeps showing the old
    // ring's buffer, which it retains, until a frame of the new ring is
    // presented, and samples none of the new slots yet.
    [self releaseBuffers];
    _ring = ring;
    os_unfair_lock_lock(&_lock);
    _latestSlot = -1;
    _takenSlot = -1;
    _previousTakenSlot = -1;
    os_unfair_lock_unlock(&_lock);
  }
  if (_buffers[slot] == NULL) {
    // BGRA8 is the layout of the surfaces and of Flutter's pixel buffer
    // textures, so Flutter samples the frames as MapLibre rendered them.
    CVReturn status = CVPixelBufferCreateWithIOSurface(kCFAllocatorDefault, surface, NULL,
                                                       &_buffers[slot]);
    if (status != kCVReturnSuccess) {
      _buffers[slot] = NULL;
      *error = [NSString stringWithFormat:@"CVPixelBufferCreateWithIOSurface failed (%d)", status];
      return NO;
    }
  }
  // The frame's GPU writes completed before it became acquirable.
  CVPixelBufferRef buffer = CVPixelBufferRetain(_buffers[slot]);
  os_unfair_lock_lock(&_lock);
  CVPixelBufferRef previous = _latest;
  _latest = buffer;
  _latestSlot = slot;
  os_unfair_lock_unlock(&_lock);
  if (previous != NULL) CVPixelBufferRelease(previous);
  return YES;
}

- (BOOL)isSlotInUse:(uint32_t)slot {
  os_unfair_lock_lock(&_lock);
  const BOOL held = slot == _latestSlot || slot == _takenSlot || slot == _previousTakenSlot;
  os_unfair_lock_unlock(&_lock);
  return held;
}

// Runs on Flutter's raster thread. Flutter keeps the buffer it gets until it
// takes the next one.
- (CVPixelBufferRef _Nullable)copyPixelBuffer {
  os_unfair_lock_lock(&_lock);
  CVPixelBufferRef buffer = _latest;
  if (buffer != NULL) CVPixelBufferRetain(buffer);
  if (_latestSlot != _takenSlot) {
    _previousTakenSlot = _takenSlot;
    _takenSlot = _latestSlot;
  }
  os_unfair_lock_unlock(&_lock);
  return buffer;
}

@end

// State shared by the C API, guarded by gLock. Dart calls the API on its UI
// thread, and the plugin registers on the main thread.
static NSLock *gLock;
static __weak NSObject<FlutterTextureRegistry> *gRegistry;
static NSMutableDictionary<NSNumber *, MLNGpuTexture *> *gTextures;

static MLNGpuTexture *_Nullable FindTexture(int64_t texture_id, char *error, size_t error_size) {
  MLNGpuTexture *texture = gTextures[@(texture_id)];
  if (texture == nil) {
    WriteError([NSString stringWithFormat:@"No texture %lld", (long long)texture_id], error,
               error_size);
  }
  return texture;
}

int64_t maplibre_native_create_gpu_texture(char *error, size_t error_size) {
  [gLock lock];
  NSObject<FlutterTextureRegistry> *registry = gRegistry;
  [gLock unlock];
  if (registry == nil) {
    WriteError(@"The maplibre_native plugin is not registered.", error, error_size);
    return -1;
  }
  MLNGpuTexture *texture = [[MLNGpuTexture alloc] init];
  // Outside the lock, which the main thread may wait for.
  __block int64_t texture_id = -1;
  RunOnMain(^{
    texture_id = [registry registerTexture:texture];
  });
  [gLock lock];
  gTextures[@(texture_id)] = texture;
  [gLock unlock];
  return texture_id;
}

bool maplibre_native_present_gpu_texture(int64_t texture_id, uint32_t ring, uint32_t slot,
                                         void *surface, char *error, size_t error_size) {
  [gLock lock];
  MLNGpuTexture *texture = FindTexture(texture_id, error, error_size);
  NSString *message = nil;
  const BOOL presented = texture != nil && [texture presentRing:ring
                                                           slot:slot
                                                        surface:(IOSurfaceRef)surface
                                                          error:&message];
  NSObject<FlutterTextureRegistry> *registry = gRegistry;
  [gLock unlock];
  if (!presented) {
    if (message != nil) WriteError(message, error, error_size);
    return false;
  }
  // The engine only marks the texture dirty and schedules a frame, which is
  // safe from any thread.
  [registry textureFrameAvailable:texture_id];
  return true;
}

bool maplibre_native_gpu_texture_slot_in_use(int64_t texture_id, uint32_t slot) {
  [gLock lock];
  MLNGpuTexture *texture = gTextures[@(texture_id)];
  const BOOL inUse = texture != nil && [texture isSlotInUse:slot];
  [gLock unlock];
  return inUse;
}

void maplibre_native_dispose_texture(int64_t texture_id) {
  [gLock lock];
  MLNGpuTexture *texture = gTextures[@(texture_id)];
  [gTextures removeObjectForKey:@(texture_id)];
  NSObject<FlutterTextureRegistry> *registry = gRegistry;
  [gLock unlock];
  if (texture == nil) return;
  // The registry keeps the texture alive while Flutter may still copy it.
  RunOnMain(^{
    [registry unregisterTexture:texture_id];
  });
}

static const MaplibreNativeSymbol kSymbols[] = {
    {"maplibre_native_create_gpu_texture", (void *)&maplibre_native_create_gpu_texture},
    {"maplibre_native_present_gpu_texture", (void *)&maplibre_native_present_gpu_texture},
    {"maplibre_native_gpu_texture_slot_in_use",
     (void *)&maplibre_native_gpu_texture_slot_in_use},
    {"maplibre_native_dispose_texture", (void *)&maplibre_native_dispose_texture},
    {NULL, NULL},
};

@implementation MaplibreNativePlugin

+ (void)initialize {
  if (self == [MaplibreNativePlugin class]) {
    gLock = [[NSLock alloc] init];
    gTextures = [NSMutableDictionary dictionary];
  }
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  [gLock lock];
  gRegistry = [registrar textures];
  [gLock unlock];
}

+ (const MaplibreNativeSymbol *)symbols {
  return kSymbols;
}

@end

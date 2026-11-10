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

/// The key under which every engine publishes its plugin instance, the
/// plugin's name in the generated registrant.
static NSString *const kPluginKey = @"MaplibreNativePlugin";

static const MaplibreNativeSymbol kSymbols[] = {
    {"maplibre_native_create_gpu_texture", (void *)&maplibre_native_create_gpu_texture},
    {"maplibre_native_present_gpu_texture", (void *)&maplibre_native_present_gpu_texture},
    {"maplibre_native_gpu_texture_slot_in_use",
     (void *)&maplibre_native_gpu_texture_slot_in_use},
    {"maplibre_native_dispose_texture", (void *)&maplibre_native_dispose_texture},
    {NULL, NULL},
};

@interface MaplibreNativePlugin ()

- (instancetype)initWithRegistry:(NSObject<FlutterTextureRegistry> *)registry;

/// The texture registry of the plugin's engine, and the textures registered
/// there by id. Guarded by gLock.
@property(nonatomic, weak, readonly, nullable) NSObject<FlutterTextureRegistry> *registry;
@property(nonatomic, readonly) NSMutableDictionary<NSNumber *, MLNGpuTexture *> *textures;

@end

// State shared by the C API, guarded by gLock. Dart calls the API on its UI
// thread, and the plugins register on the main thread.
static NSLock *gLock;
/// The plugins that the C API found so far, by engine id. A plugin lives as
/// long as its engine publishes it, so an engine id that a later engine
/// reuses finds no stale plugin.
static NSMapTable<NSNumber *, MaplibreNativePlugin *> *gPlugins;

/// The plugin that the engine |engine_id|, `PlatformDispatcher.instance.engineId`
/// of the calling isolate, published at registration. The id is the
/// engine's pointer, which is alive while that isolate calls. Called without
/// gLock, which the main thread may wait for.
static MaplibreNativePlugin *_Nullable FindPlugin(int64_t engine_id, char *error,
                                                  size_t error_size) {
  NSNumber *key = @(engine_id);
  [gLock lock];
  MaplibreNativePlugin *plugin = [gPlugins objectForKey:key];
  [gLock unlock];
  if (plugin != nil) return plugin;
  __block NSObject *published = nil;
  RunOnMain(^{
    FlutterEngine *engine = (__bridge FlutterEngine *)(void *)(intptr_t)engine_id;
    published = [engine valuePublishedByPlugin:kPluginKey];
  });
  // An engine that shuts down publishes NSNull.
  if (![published isKindOfClass:[MaplibreNativePlugin class]]) {
    WriteError(@"The maplibre_native plugin is not registered.", error, error_size);
    return nil;
  }
  plugin = (MaplibreNativePlugin *)published;
  [gLock lock];
  [gPlugins setObject:plugin forKey:key];
  [gLock unlock];
  return plugin;
}

@implementation MaplibreNativePlugin

+ (void)initialize {
  if (self == [MaplibreNativePlugin class]) {
    gLock = [[NSLock alloc] init];
    gPlugins = [NSMapTable strongToWeakObjectsMapTable];
  }
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  // The engine keeps the instance it publishes, and Dart finds it there.
  [registrar publish:[[MaplibreNativePlugin alloc] initWithRegistry:[registrar textures]]];
}

+ (const MaplibreNativeSymbol *)symbols {
  return kSymbols;
}

- (instancetype)initWithRegistry:(NSObject<FlutterTextureRegistry> *)registry {
  if ((self = [super init])) {
    _registry = registry;
    _textures = [NSMutableDictionary dictionary];
  }
  return self;
}

- (MLNGpuTexture *_Nullable)findTexture:(int64_t)textureId
                                  error:(char *)error
                              errorSize:(size_t)errorSize {
  MLNGpuTexture *texture = _textures[@(textureId)];
  if (texture == nil) {
    WriteError([NSString stringWithFormat:@"No texture %lld", (long long)textureId], error,
               errorSize);
  }
  return texture;
}

@end

int64_t maplibre_native_create_gpu_texture(int64_t engine_id, char *error, size_t error_size) {
  MaplibreNativePlugin *plugin = FindPlugin(engine_id, error, error_size);
  if (plugin == nil) return -1;
  [gLock lock];
  NSObject<FlutterTextureRegistry> *registry = plugin.registry;
  [gLock unlock];
  if (registry == nil) {
    WriteError(@"The engine of the maplibre_native plugin is gone.", error, error_size);
    return -1;
  }
  MLNGpuTexture *texture = [[MLNGpuTexture alloc] init];
  // Outside the lock, which the main thread may wait for.
  __block int64_t texture_id = -1;
  RunOnMain(^{
    texture_id = [registry registerTexture:texture];
  });
  [gLock lock];
  plugin.textures[@(texture_id)] = texture;
  [gLock unlock];
  return texture_id;
}

bool maplibre_native_present_gpu_texture(int64_t engine_id, int64_t texture_id, uint32_t ring,
                                         uint32_t slot, void *surface, char *error,
                                         size_t error_size) {
  MaplibreNativePlugin *plugin = FindPlugin(engine_id, error, error_size);
  if (plugin == nil) return false;
  [gLock lock];
  MLNGpuTexture *texture = [plugin findTexture:texture_id error:error errorSize:error_size];
  NSString *message = nil;
  const BOOL presented = texture != nil && [texture presentRing:ring
                                                           slot:slot
                                                        surface:(IOSurfaceRef)surface
                                                          error:&message];
  NSObject<FlutterTextureRegistry> *registry = plugin.registry;
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

bool maplibre_native_gpu_texture_slot_in_use(int64_t engine_id, int64_t texture_id,
                                             uint32_t slot) {
  MaplibreNativePlugin *plugin = FindPlugin(engine_id, NULL, 0);
  if (plugin == nil) return false;
  [gLock lock];
  MLNGpuTexture *texture = plugin.textures[@(texture_id)];
  const BOOL inUse = texture != nil && [texture isSlotInUse:slot];
  [gLock unlock];
  return inUse;
}

void maplibre_native_dispose_texture(int64_t engine_id, int64_t texture_id) {
  MaplibreNativePlugin *plugin = FindPlugin(engine_id, NULL, 0);
  if (plugin == nil) return;
  [gLock lock];
  MLNGpuTexture *texture = plugin.textures[@(texture_id)];
  [plugin.textures removeObjectForKey:@(texture_id)];
  NSObject<FlutterTextureRegistry> *registry = plugin.registry;
  [gLock unlock];
  if (texture == nil) return;
  // The registry keeps the texture alive while Flutter may still copy it.
  RunOnMain(^{
    [registry unregisterTexture:texture_id];
  });
}

#include <stdint.h>
#import <Foundation/Foundation.h>
#import "../ios/maplibre_ios/Sources/maplibre_ios/MapLibreRegistry.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNMapView.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNMapProjection.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNStyle.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNSource.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNVectorTileSource.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNComputedShapeSource.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNImageSource.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNRasterTileSource.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNRasterDEMSource.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNBackgroundStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNCircleStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNFillExtrusionStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNFillStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNHeatmapStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNHillshadeStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNLineStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNRasterStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNSymbolStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNVectorStyleLayer.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNAttributionInfo.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/NSExpression+MLNAdditions.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNOfflineStorage.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNOfflinePack.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNOfflineRegion.h"
#import "../../../../../Library/Caches/CocoaPods/Pods/Release/MapLibre/6.11.0-9ff4b/MapLibre.xcframework/ios-arm64_x86_64-simulator/MapLibre.framework/Headers/MLNTilePyramidOfflineRegion.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

id objc_retainBlock(id);

typedef void  (^_ListenerTrampoline)();
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _MapLibreFFi_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _MapLibreFFi_wrapBlockingBlock_1pl9qdv(
    _BlockingTrampoline block, _BlockingTrampoline listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void() {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil);
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter);
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline1)(id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline1 _MapLibreFFi_wrapListenerBlock_1a22wz(_ListenerTrampoline1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline1)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline1 _MapLibreFFi_wrapBlockingBlock_1a22wz(
    _BlockingTrampoline1 block, _BlockingTrampoline1 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline2)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline2 _MapLibreFFi_wrapListenerBlock_18v1jvf(_ListenerTrampoline2 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline2)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline2 _MapLibreFFi_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline2 block, _BlockingTrampoline2 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(void * arg0, id arg1) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline3)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline3 _MapLibreFFi_wrapListenerBlock_pfv6jd(_ListenerTrampoline3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline3)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline3 _MapLibreFFi_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline3 block, _BlockingTrampoline3 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0, id arg1) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline4)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline4 _MapLibreFFi_wrapListenerBlock_xtuoz7(_ListenerTrampoline4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline4)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline4 _MapLibreFFi_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline4 block, _BlockingTrampoline4 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline5)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline5 _MapLibreFFi_wrapListenerBlock_r8gdi7(_ListenerTrampoline5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline5)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline5 _MapLibreFFi_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline5 block, _BlockingTrampoline5 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(id arg0, id arg1, id arg2) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
      awaitWaiter(waiter);
    }
  };
}

typedef void  (^_ListenerTrampoline6)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline6 _MapLibreFFi_wrapListenerBlock_10lndml(_ListenerTrampoline6 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline6)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline6 _MapLibreFFi_wrapBlockingBlock_10lndml(
    _BlockingTrampoline6 block, _BlockingTrampoline6 listenerBlock,
    void* (*newWaiter)(), void (*awaitWaiter)(void*)) NS_RETURNS_RETAINED {
  NSThread *targetThread = [NSThread currentThread];
  return ^void(void * arg0, BOOL arg1) {
    if ([NSThread currentThread] == targetThread) {
      objc_retainBlock(block);
      block(nil, arg0, arg1);
    } else {
      void* waiter = newWaiter();
      objc_retainBlock(listenerBlock);
      listenerBlock(waiter, arg0, arg1);
      awaitWaiter(waiter);
    }
  };
}

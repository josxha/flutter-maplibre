#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "../../ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h"
#import "MapLibre.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

typedef struct {
  int64_t version;
  void* (*newWaiter)(void);
  void (*awaitWaiter)(void*);
  void* (*currentIsolate)(void);
  void (*enterIsolate)(void*);
  void (*exitIsolate)(void);
  int64_t (*getMainPortId)(void);
  bool (*getCurrentThreadOwnsIsolate)(int64_t);
  void (*invokeListenerPortBlock)(int64_t port, void*);
  void (*invokeBlockingPortBlock)(int64_t port, void*, void*);
} DOBJC_Context;

id objc_retainBlock(id);

#define BLOCKING_BLOCK_IMPL(ctx, TYPE, SIG, INVOKE_DIRECT, INVOKE_LISTENER)    \
  assert(ctx->version >= 1);                                                   \
  void* targetIsolate = ctx->currentIsolate();                                 \
  int64_t targetPort = ctx->getMainPortId == NULL ? 0 : ctx->getMainPortId();  \
  __block __weak TYPE weakSelfBlock = nil;                                     \
  TYPE strongSelfBlock = [SIG {                                                \
    void* currentIsolate = ctx->currentIsolate();                              \
    bool mayEnterIsolate =                                                     \
        currentIsolate == NULL &&                                              \
        ctx->getCurrentThreadOwnsIsolate != NULL &&                            \
        ctx->getCurrentThreadOwnsIsolate(targetPort);                          \
    if (currentIsolate == targetIsolate || mayEnterIsolate) {                  \
      if (mayEnterIsolate) {                                                   \
        ctx->enterIsolate(targetIsolate);                                      \
      }                                                                        \
      INVOKE_DIRECT;                                                           \
      if (mayEnterIsolate) {                                                   \
        ctx->exitIsolate();                                                    \
      }                                                                        \
    } else {                                                                   \
      void* waiter = ctx->newWaiter();                                         \
      TYPE selfRetain = [weakSelfBlock copy];                                  \
      INVOKE_LISTENER;                                                         \
      ctx->awaitWaiter(waiter);                                                \
      (void)selfRetain;                                                        \
    }                                                                          \
  } copy];                                                                     \
  weakSelfBlock = strongSelfBlock;                                             \
  return strongSelfBlock;


__attribute__((visibility("default"))) __attribute__((used))
Protocol* _6admjt_FlutterApi(void) { return @protocol(FlutterApi); }

__attribute__((visibility("default"))) __attribute__((used))
Protocol* _6admjt_MLNFeature(void) { return @protocol(MLNFeature); }

__attribute__((visibility("default"))) __attribute__((used))
Protocol* _6admjt_MLNMapViewDelegate(void) { return @protocol(MLNMapViewDelegate); }

typedef double  (^_ProtocolTrampoline)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _6admjt_protocolTrampoline_1kspct0(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_1)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _6admjt_protocolTrampoline_1hsw88y(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CLLocationCoordinate2D  (^_ProtocolTrampoline_2)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CLLocationCoordinate2D  _6admjt_protocolTrampoline_neuenc(id target, void * sel) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_3)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6admjt_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_4)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6admjt_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_5)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _6admjt_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_6)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6admjt_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_7)(void * sel, id arg1, id arg2, id arg3, MLNCameraChangeReason arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6admjt_protocolTrampoline_1wu22tl(id target, void * sel, id arg1, id arg2, id arg3, MLNCameraChangeReason arg4) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_8)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6admjt_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1pl9qdv : NSObject
@property (copy) id block;

@end
@implementation _6admjt_BlockArgs_1pl9qdv
@end

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _6admjt_wrapListenerBlock_1pl9qdv(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline weakSelfBlock = nil;
  _ListenerTrampoline strongSelfBlock = [^void() {
    @autoreleasepool {
      _6admjt_BlockArgs_1pl9qdv* args = [[_6admjt_BlockArgs_1pl9qdv alloc] init];
      args.block = weakSelfBlock;
      
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _6admjt_wrapBlockingBlock_1pl9qdv(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline, ^void(), {
    @autoreleasepool {
      _6admjt_BlockArgs_1pl9qdv* args = [[_6admjt_BlockArgs_1pl9qdv alloc] init];
      args.block = weakSelfBlock;
      
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1pl9qdv* args = [[_6admjt_BlockArgs_1pl9qdv alloc] init];
      args.block = weakSelfBlock;
      
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_pfv6jd : NSObject
@property (copy) id block;
@property (strong) id arg0;
@property (strong) id arg1;
@end
@implementation _6admjt_BlockArgs_pfv6jd
@end

typedef void  (^_ListenerTrampoline_1)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _6admjt_wrapListenerBlock_pfv6jd(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_1 weakSelfBlock = nil;
  _ListenerTrampoline_1 strongSelfBlock = [^void(id arg0, id arg1) {
    @autoreleasepool {
      _6admjt_BlockArgs_pfv6jd* args = [[_6admjt_BlockArgs_pfv6jd alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _6admjt_wrapBlockingBlock_pfv6jd(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_1, ^void(id arg0, id arg1), {
    @autoreleasepool {
      _6admjt_BlockArgs_pfv6jd* args = [[_6admjt_BlockArgs_pfv6jd alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_pfv6jd* args = [[_6admjt_BlockArgs_pfv6jd alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_xtuoz7 : NSObject
@property (copy) id block;
@property (strong) id arg0;
@end
@implementation _6admjt_BlockArgs_xtuoz7
@end

typedef void  (^_ListenerTrampoline_2)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _6admjt_wrapListenerBlock_xtuoz7(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_2 weakSelfBlock = nil;
  _ListenerTrampoline_2 strongSelfBlock = [^void(id arg0) {
    @autoreleasepool {
      _6admjt_BlockArgs_xtuoz7* args = [[_6admjt_BlockArgs_xtuoz7 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _6admjt_wrapBlockingBlock_xtuoz7(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_2, ^void(id arg0), {
    @autoreleasepool {
      _6admjt_BlockArgs_xtuoz7* args = [[_6admjt_BlockArgs_xtuoz7 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_xtuoz7* args = [[_6admjt_BlockArgs_xtuoz7 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_r8gdi7 : NSObject
@property (copy) id block;
@property (strong) id arg0;
@property (strong) id arg1;
@property (strong) id arg2;
@end
@implementation _6admjt_BlockArgs_r8gdi7
@end

typedef void  (^_ListenerTrampoline_3)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _6admjt_wrapListenerBlock_r8gdi7(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_3 weakSelfBlock = nil;
  _ListenerTrampoline_3 strongSelfBlock = [^void(id arg0, id arg1, id arg2) {
    @autoreleasepool {
      _6admjt_BlockArgs_r8gdi7* args = [[_6admjt_BlockArgs_r8gdi7 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _6admjt_wrapBlockingBlock_r8gdi7(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_3, ^void(id arg0, id arg1, id arg2), {
    @autoreleasepool {
      _6admjt_BlockArgs_r8gdi7* args = [[_6admjt_BlockArgs_r8gdi7 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_r8gdi7* args = [[_6admjt_BlockArgs_r8gdi7 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1bktu2 : NSObject
@property (copy) id block;
@property void * arg0;
@property struct CGPoint arg1;
@end
@implementation _6admjt_BlockArgs_1bktu2
@end

typedef void  (^_ListenerTrampoline_4)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _6admjt_wrapListenerBlock_1bktu2(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_4 weakSelfBlock = nil;
  _ListenerTrampoline_4 strongSelfBlock = [^void(void * arg0, struct CGPoint arg1) {
    @autoreleasepool {
      _6admjt_BlockArgs_1bktu2* args = [[_6admjt_BlockArgs_1bktu2 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _6admjt_wrapBlockingBlock_1bktu2(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_4, ^void(void * arg0, struct CGPoint arg1), {
    @autoreleasepool {
      _6admjt_BlockArgs_1bktu2* args = [[_6admjt_BlockArgs_1bktu2 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1bktu2* args = [[_6admjt_BlockArgs_1bktu2 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_9)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_18v1jvf : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@end
@implementation _6admjt_BlockArgs_18v1jvf
@end

typedef void  (^_ListenerTrampoline_5)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _6admjt_wrapListenerBlock_18v1jvf(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_5 weakSelfBlock = nil;
  _ListenerTrampoline_5 strongSelfBlock = [^void(void * arg0, id arg1) {
    @autoreleasepool {
      _6admjt_BlockArgs_18v1jvf* args = [[_6admjt_BlockArgs_18v1jvf alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _6admjt_wrapBlockingBlock_18v1jvf(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_5, ^void(void * arg0, id arg1), {
    @autoreleasepool {
      _6admjt_BlockArgs_18v1jvf* args = [[_6admjt_BlockArgs_18v1jvf alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_18v1jvf* args = [[_6admjt_BlockArgs_18v1jvf alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_10)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_fjrv01 : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property (strong) id arg2;
@end
@implementation _6admjt_BlockArgs_fjrv01
@end

typedef void  (^_ListenerTrampoline_6)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _6admjt_wrapListenerBlock_fjrv01(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_6 weakSelfBlock = nil;
  _ListenerTrampoline_6 strongSelfBlock = [^void(void * arg0, id arg1, id arg2) {
    @autoreleasepool {
      _6admjt_BlockArgs_fjrv01* args = [[_6admjt_BlockArgs_fjrv01 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _6admjt_wrapBlockingBlock_fjrv01(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_6, ^void(void * arg0, id arg1, id arg2), {
    @autoreleasepool {
      _6admjt_BlockArgs_fjrv01* args = [[_6admjt_BlockArgs_fjrv01 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_fjrv01* args = [[_6admjt_BlockArgs_fjrv01 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_11)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1yu368z : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property MLNCameraChangeReason arg2;
@end
@implementation _6admjt_BlockArgs_1yu368z
@end

typedef void  (^_ListenerTrampoline_7)(void * arg0, id arg1, MLNCameraChangeReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _6admjt_wrapListenerBlock_1yu368z(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_7 weakSelfBlock = nil;
  _ListenerTrampoline_7 strongSelfBlock = [^void(void * arg0, id arg1, MLNCameraChangeReason arg2) {
    @autoreleasepool {
      _6admjt_BlockArgs_1yu368z* args = [[_6admjt_BlockArgs_1yu368z alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0, id arg1, MLNCameraChangeReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _6admjt_wrapBlockingBlock_1yu368z(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_7, ^void(void * arg0, id arg1, MLNCameraChangeReason arg2), {
    @autoreleasepool {
      _6admjt_BlockArgs_1yu368z* args = [[_6admjt_BlockArgs_1yu368z alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1yu368z* args = [[_6admjt_BlockArgs_1yu368z alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_12)(void * sel, id arg1, MLNCameraChangeReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1yu368z(id target, void * sel, id arg1, MLNCameraChangeReason arg2) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1f1ebb3 : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property MLNCameraChangeReason arg2;
@property BOOL arg3;
@end
@implementation _6admjt_BlockArgs_1f1ebb3
@end

typedef void  (^_ListenerTrampoline_8)(void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _6admjt_wrapListenerBlock_1f1ebb3(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_8 weakSelfBlock = nil;
  _ListenerTrampoline_8 strongSelfBlock = [^void(void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3) {
    @autoreleasepool {
      _6admjt_BlockArgs_1f1ebb3* args = [[_6admjt_BlockArgs_1f1ebb3 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _6admjt_wrapBlockingBlock_1f1ebb3(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_8, ^void(void * arg0, id arg1, MLNCameraChangeReason arg2, BOOL arg3), {
    @autoreleasepool {
      _6admjt_BlockArgs_1f1ebb3* args = [[_6admjt_BlockArgs_1f1ebb3 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1f1ebb3* args = [[_6admjt_BlockArgs_1f1ebb3 alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_13)(void * sel, id arg1, MLNCameraChangeReason arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1f1ebb3(id target, void * sel, id arg1, MLNCameraChangeReason arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_epgd2t : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property MLNTileOperation arg2;
@property long arg3;
@property long arg4;
@property long arg5;
@property long arg6;
@property long arg7;
@property (strong) id arg8;
@end
@implementation _6admjt_BlockArgs_epgd2t
@end

typedef void  (^_ListenerTrampoline_9)(void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _6admjt_wrapListenerBlock_epgd2t(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_9 weakSelfBlock = nil;
  _ListenerTrampoline_9 strongSelfBlock = [^void(void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8) {
    @autoreleasepool {
      _6admjt_BlockArgs_epgd2t* args = [[_6admjt_BlockArgs_epgd2t alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      args.arg5 = arg5;
      args.arg6 = arg6;
      args.arg7 = arg7;
      args.arg8 = arg8;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _6admjt_wrapBlockingBlock_epgd2t(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_9, ^void(void * arg0, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8), {
    @autoreleasepool {
      _6admjt_BlockArgs_epgd2t* args = [[_6admjt_BlockArgs_epgd2t alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      args.arg5 = arg5;
      args.arg6 = arg6;
      args.arg7 = arg7;
      args.arg8 = arg8;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_epgd2t* args = [[_6admjt_BlockArgs_epgd2t alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      args.arg5 = arg5;
      args.arg6 = arg6;
      args.arg7 = arg7;
      args.arg8 = arg8;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_14)(void * sel, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_epgd2t(id target, void * sel, id arg1, MLNTileOperation arg2, long arg3, long arg4, long arg5, long arg6, long arg7, id arg8) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_gl3jxl : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property MLNUserTrackingMode arg2;
@property BOOL arg3;
@end
@implementation _6admjt_BlockArgs_gl3jxl
@end

typedef void  (^_ListenerTrampoline_10)(void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _6admjt_wrapListenerBlock_gl3jxl(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_10 weakSelfBlock = nil;
  _ListenerTrampoline_10 strongSelfBlock = [^void(void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3) {
    @autoreleasepool {
      _6admjt_BlockArgs_gl3jxl* args = [[_6admjt_BlockArgs_gl3jxl alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _6admjt_wrapBlockingBlock_gl3jxl(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_10, ^void(void * arg0, id arg1, MLNUserTrackingMode arg2, BOOL arg3), {
    @autoreleasepool {
      _6admjt_BlockArgs_gl3jxl* args = [[_6admjt_BlockArgs_gl3jxl alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_gl3jxl* args = [[_6admjt_BlockArgs_gl3jxl alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_15)(void * sel, id arg1, MLNUserTrackingMode arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_gl3jxl(id target, void * sel, id arg1, MLNUserTrackingMode arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_rgxx3r : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property (strong) id arg2;
@property struct _NSRange arg3;
@end
@implementation _6admjt_BlockArgs_rgxx3r
@end

typedef void  (^_ListenerTrampoline_11)(void * arg0, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _6admjt_wrapListenerBlock_rgxx3r(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_11 weakSelfBlock = nil;
  _ListenerTrampoline_11 strongSelfBlock = [^void(void * arg0, id arg1, id arg2, struct _NSRange arg3) {
    @autoreleasepool {
      _6admjt_BlockArgs_rgxx3r* args = [[_6admjt_BlockArgs_rgxx3r alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, void * arg0, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _6admjt_wrapBlockingBlock_rgxx3r(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_11, ^void(void * arg0, id arg1, id arg2, struct _NSRange arg3), {
    @autoreleasepool {
      _6admjt_BlockArgs_rgxx3r* args = [[_6admjt_BlockArgs_rgxx3r alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_rgxx3r* args = [[_6admjt_BlockArgs_rgxx3r alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_16)(void * sel, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_rgxx3r(id target, void * sel, id arg1, id arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_g6us7l : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property long arg2;
@property long arg3;
@property (strong) id arg4;
@end
@implementation _6admjt_BlockArgs_g6us7l
@end

typedef void  (^_ListenerTrampoline_12)(void * arg0, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _6admjt_wrapListenerBlock_g6us7l(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_12 weakSelfBlock = nil;
  _ListenerTrampoline_12 strongSelfBlock = [^void(void * arg0, id arg1, long arg2, long arg3, id arg4) {
    @autoreleasepool {
      _6admjt_BlockArgs_g6us7l* args = [[_6admjt_BlockArgs_g6us7l alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, void * arg0, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _6admjt_wrapBlockingBlock_g6us7l(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_12, ^void(void * arg0, id arg1, long arg2, long arg3, id arg4), {
    @autoreleasepool {
      _6admjt_BlockArgs_g6us7l* args = [[_6admjt_BlockArgs_g6us7l alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_g6us7l* args = [[_6admjt_BlockArgs_g6us7l alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_17)(void * sel, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_g6us7l(id target, void * sel, id arg1, long arg2, long arg3, id arg4) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1tz5yf : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property (strong) id arg2;
@property (strong) id arg3;
@end
@implementation _6admjt_BlockArgs_1tz5yf
@end

typedef void  (^_ListenerTrampoline_13)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _6admjt_wrapListenerBlock_1tz5yf(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_13 weakSelfBlock = nil;
  _ListenerTrampoline_13 strongSelfBlock = [^void(void * arg0, id arg1, id arg2, id arg3) {
    @autoreleasepool {
      _6admjt_BlockArgs_1tz5yf* args = [[_6admjt_BlockArgs_1tz5yf alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _6admjt_wrapBlockingBlock_1tz5yf(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_13, ^void(void * arg0, id arg1, id arg2, id arg3), {
    @autoreleasepool {
      _6admjt_BlockArgs_1tz5yf* args = [[_6admjt_BlockArgs_1tz5yf alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1tz5yf* args = [[_6admjt_BlockArgs_1tz5yf alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_18)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_wy9lus : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property unsigned long arg2;
@end
@implementation _6admjt_BlockArgs_wy9lus
@end

typedef void  (^_ListenerTrampoline_14)(void * arg0, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _6admjt_wrapListenerBlock_wy9lus(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_14 weakSelfBlock = nil;
  _ListenerTrampoline_14 strongSelfBlock = [^void(void * arg0, id arg1, unsigned long arg2) {
    @autoreleasepool {
      _6admjt_BlockArgs_wy9lus* args = [[_6admjt_BlockArgs_wy9lus alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _6admjt_wrapBlockingBlock_wy9lus(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_14, ^void(void * arg0, id arg1, unsigned long arg2), {
    @autoreleasepool {
      _6admjt_BlockArgs_wy9lus* args = [[_6admjt_BlockArgs_wy9lus alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_wy9lus* args = [[_6admjt_BlockArgs_wy9lus alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_19)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_wy9lus(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1nyrrbs : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property unsigned long arg2;
@property BOOL arg3;
@end
@implementation _6admjt_BlockArgs_1nyrrbs
@end

typedef void  (^_ListenerTrampoline_15)(void * arg0, id arg1, unsigned long arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _6admjt_wrapListenerBlock_1nyrrbs(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_15 weakSelfBlock = nil;
  _ListenerTrampoline_15 strongSelfBlock = [^void(void * arg0, id arg1, unsigned long arg2, BOOL arg3) {
    @autoreleasepool {
      _6admjt_BlockArgs_1nyrrbs* args = [[_6admjt_BlockArgs_1nyrrbs alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, void * arg0, id arg1, unsigned long arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _6admjt_wrapBlockingBlock_1nyrrbs(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_15, ^void(void * arg0, id arg1, unsigned long arg2, BOOL arg3), {
    @autoreleasepool {
      _6admjt_BlockArgs_1nyrrbs* args = [[_6admjt_BlockArgs_1nyrrbs alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1nyrrbs* args = [[_6admjt_BlockArgs_1nyrrbs alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_20)(void * sel, id arg1, unsigned long arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1nyrrbs(id target, void * sel, id arg1, unsigned long arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_zzthnb : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property BOOL arg2;
@end
@implementation _6admjt_BlockArgs_zzthnb
@end

typedef void  (^_ListenerTrampoline_16)(void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _6admjt_wrapListenerBlock_zzthnb(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_16 weakSelfBlock = nil;
  _ListenerTrampoline_16 strongSelfBlock = [^void(void * arg0, id arg1, BOOL arg2) {
    @autoreleasepool {
      _6admjt_BlockArgs_zzthnb* args = [[_6admjt_BlockArgs_zzthnb alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _6admjt_wrapBlockingBlock_zzthnb(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_16, ^void(void * arg0, id arg1, BOOL arg2), {
    @autoreleasepool {
      _6admjt_BlockArgs_zzthnb* args = [[_6admjt_BlockArgs_zzthnb alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_zzthnb* args = [[_6admjt_BlockArgs_zzthnb alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_21)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_zzthnb(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1llhjbh : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property BOOL arg2;
@property (strong) id arg3;
@end
@implementation _6admjt_BlockArgs_1llhjbh
@end

typedef void  (^_ListenerTrampoline_17)(void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _6admjt_wrapListenerBlock_1llhjbh(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_17 weakSelfBlock = nil;
  _ListenerTrampoline_17 strongSelfBlock = [^void(void * arg0, id arg1, BOOL arg2, id arg3) {
    @autoreleasepool {
      _6admjt_BlockArgs_1llhjbh* args = [[_6admjt_BlockArgs_1llhjbh alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _6admjt_wrapBlockingBlock_1llhjbh(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_17, ^void(void * arg0, id arg1, BOOL arg2, id arg3), {
    @autoreleasepool {
      _6admjt_BlockArgs_1llhjbh* args = [[_6admjt_BlockArgs_1llhjbh alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1llhjbh* args = [[_6admjt_BlockArgs_1llhjbh alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_22)(void * sel, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1llhjbh(id target, void * sel, id arg1, BOOL arg2, id arg3) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

__attribute__((visibility("default")))
@interface _6admjt_BlockArgs_1v8di4v : NSObject
@property (copy) id block;
@property void * arg0;
@property (strong) id arg1;
@property BOOL arg2;
@property double arg3;
@property double arg4;
@end
@implementation _6admjt_BlockArgs_1v8di4v
@end

typedef void  (^_ListenerTrampoline_18)(void * arg0, id arg1, BOOL arg2, double arg3, double arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _6admjt_wrapListenerBlock_1v8di4v(
    int64_t port, DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  __block __weak _ListenerTrampoline_18 weakSelfBlock = nil;
  _ListenerTrampoline_18 strongSelfBlock = [^void(void * arg0, id arg1, BOOL arg2, double arg3, double arg4) {
    @autoreleasepool {
      _6admjt_BlockArgs_1v8di4v* args = [[_6admjt_BlockArgs_1v8di4v alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      ctx->invokeListenerPortBlock(port, (__bridge_retained void*)args);
    }
  } copy];
  weakSelfBlock = strongSelfBlock;
  return strongSelfBlock;
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, void * arg0, id arg1, BOOL arg2, double arg3, double arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _6admjt_wrapBlockingBlock_1v8di4v(int64_t port, DOBJC_Context* ctx,
    void (*directInvoke)(void*)) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, _ListenerTrampoline_18, ^void(void * arg0, id arg1, BOOL arg2, double arg3, double arg4), {
    @autoreleasepool {
      _6admjt_BlockArgs_1v8di4v* args = [[_6admjt_BlockArgs_1v8di4v alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      directInvoke((__bridge_retained void*)args);
    }
  }, {
    @autoreleasepool {
      _6admjt_BlockArgs_1v8di4v* args = [[_6admjt_BlockArgs_1v8di4v alloc] init];
      args.block = weakSelfBlock;
      args.arg0 = arg0;
      args.arg1 = arg1;
      args.arg2 = arg2;
      args.arg3 = arg3;
      args.arg4 = arg4;
      ctx->invokeBlockingPortBlock(port, (__bridge_retained void*)args, waiter);
    }
  });
}

typedef void  (^_ProtocolTrampoline_23)(void * sel, id arg1, BOOL arg2, double arg3, double arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6admjt_protocolTrampoline_1v8di4v(id target, void * sel, id arg1, BOOL arg2, double arg3, double arg4) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

__attribute__((visibility("default"))) __attribute__((used))
Protocol* _6admjt_OfflinePackProgressCallbacks(void) { return @protocol(OfflinePackProgressCallbacks); }
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop

#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "../ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h"
#import "../MapLibre.h"

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
} DOBJC_Context;

id objc_retainBlock(id);

#define BLOCKING_BLOCK_IMPL(ctx, BLOCK_SIG, INVOKE_DIRECT, INVOKE_LISTENER)    \
  assert(ctx->version >= 1);                                                   \
  void* targetIsolate = ctx->currentIsolate();                                 \
  int64_t targetPort = ctx->getMainPortId == NULL ? 0 : ctx->getMainPortId();  \
  return BLOCK_SIG {                                                           \
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
      INVOKE_LISTENER;                                                         \
      ctx->awaitWaiter(waiter);                                                \
    }                                                                          \
  };


typedef id  (^ProtocolTrampoline)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^ProtocolTrampoline_1)(void * sel, id arg1, id arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_10z9f5k(id target, void * sel, id arg1, id arg2, id * arg3) {
  return ((ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSItemProviderRepresentationVisibility  (^ProtocolTrampoline_2)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSItemProviderRepresentationVisibility  _MapLibreFFi_protocolTrampoline_1ldqghh(id target, void * sel, id arg1) {
  return ((ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^ListenerTrampoline)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline _MapLibreFFi_wrapListenerBlock_pfv6jd(ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^BlockingTrampoline)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline _MapLibreFFi_wrapBlockingBlock_pfv6jd(
    BlockingTrampoline block, BlockingTrampoline listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef id  (^ProtocolTrampoline_3)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_1q0i84(id target, void * sel, id arg1, id arg2) {
  return ((ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_NSProgressReporting(void) { return @protocol(NSProgressReporting); }

typedef void  (^ListenerTrampoline_1)(id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_1 _MapLibreFFi_wrapListenerBlock_1a22wz(ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^BlockingTrampoline_1)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_1 _MapLibreFFi_wrapBlockingBlock_1a22wz(
    BlockingTrampoline_1 block, BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef BOOL  (^ProtocolTrampoline_4)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^ListenerTrampoline_2)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_2 _MapLibreFFi_wrapListenerBlock_18v1jvf(ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^BlockingTrampoline_2)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_2 _MapLibreFFi_wrapBlockingBlock_18v1jvf(
    BlockingTrampoline_2 block, BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^ProtocolTrampoline_5)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^ProtocolTrampoline_6)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^ListenerTrampoline_3)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_3 _MapLibreFFi_wrapListenerBlock_lmc3p5(ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^BlockingTrampoline_3)(void * waiter, id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_3 _MapLibreFFi_wrapBlockingBlock_lmc3p5(
    BlockingTrampoline_3 block, BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  });
}

Protocol* _MapLibreFFi_UIItemProviderPresentationSizeProviding(void) { return @protocol(UIItemProviderPresentationSizeProviding); }

Protocol* _MapLibreFFi_NSTextAttachmentLayout(void) { return @protocol(NSTextAttachmentLayout); }

typedef struct CGSize  (^ProtocolTrampoline_7)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _MapLibreFFi_protocolTrampoline_1j20mp(id target, void * sel) {
  return ((ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_UIAccessibilityIdentification(void) { return @protocol(UIAccessibilityIdentification); }

typedef void  (^ListenerTrampoline_4)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_4 _MapLibreFFi_wrapListenerBlock_xtuoz7(ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^BlockingTrampoline_4)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_4 _MapLibreFFi_wrapBlockingBlock_xtuoz7(
    BlockingTrampoline_4 block, BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

Protocol* _MapLibreFFi_CAMediaTiming(void) { return @protocol(CAMediaTiming); }

Protocol* _MapLibreFFi_CAAction(void) { return @protocol(CAAction); }

Protocol* _MapLibreFFi_CALayerDelegate(void) { return @protocol(CALayerDelegate); }

Protocol* _MapLibreFFi_UIMenuLeaf(void) { return @protocol(UIMenuLeaf); }

Protocol* _MapLibreFFi_UIPasteConfigurationSupporting(void) { return @protocol(UIPasteConfigurationSupporting); }

Protocol* _MapLibreFFi_UIUserActivityRestoring(void) { return @protocol(UIUserActivityRestoring); }

Protocol* _MapLibreFFi_UIResponderStandardEditActions(void) { return @protocol(UIResponderStandardEditActions); }

Protocol* _MapLibreFFi_UIAppearance(void) { return @protocol(UIAppearance); }

Protocol* _MapLibreFFi_UIAppearanceContainer(void) { return @protocol(UIAppearanceContainer); }

Protocol* _MapLibreFFi_UIDynamicItem(void) { return @protocol(UIDynamicItem); }

Protocol* _MapLibreFFi_UITraitEnvironment(void) { return @protocol(UITraitEnvironment); }

Protocol* _MapLibreFFi_UICoordinateSpace(void) { return @protocol(UICoordinateSpace); }

Protocol* _MapLibreFFi_UIFocusItem(void) { return @protocol(UIFocusItem); }

Protocol* _MapLibreFFi_UIFocusItemContainer(void) { return @protocol(UIFocusItemContainer); }

typedef void  (^ListenerTrampoline_5)();
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_5 _MapLibreFFi_wrapListenerBlock_1pl9qdv(ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^BlockingTrampoline_5)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_5 _MapLibreFFi_wrapBlockingBlock_1pl9qdv(
    BlockingTrampoline_5 block, BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(), {
    objc_retainBlock(block);
    block(nil);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter);
  });
}

typedef void  (^ListenerTrampoline_6)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_6 _MapLibreFFi_wrapListenerBlock_1s56lr9(ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^BlockingTrampoline_6)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_6 _MapLibreFFi_wrapBlockingBlock_1s56lr9(
    BlockingTrampoline_6 block, BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

Protocol* _MapLibreFFi_UITraitChangeObservable(void) { return @protocol(UITraitChangeObservable); }

Protocol* _MapLibreFFi_UIInteraction(void) { return @protocol(UIInteraction); }

Protocol* _MapLibreFFi_UILargeContentViewerItem(void) { return @protocol(UILargeContentViewerItem); }

typedef struct UIEdgeInsets  (^ProtocolTrampoline_8)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct UIEdgeInsets  _MapLibreFFi_protocolTrampoline_1rtilx3(id target, void * sel) {
  return ((ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_UIHoverEffect(void) { return @protocol(UIHoverEffect); }

Protocol* _MapLibreFFi_UIPopoverPresentationControllerSourceItem(void) { return @protocol(UIPopoverPresentationControllerSourceItem); }

typedef struct CGRect  (^ProtocolTrampoline_9)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _MapLibreFFi_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^ProtocolTrampoline_10)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^ProtocolTrampoline_11)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _MapLibreFFi_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^ListenerTrampoline_7)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_7 _MapLibreFFi_wrapListenerBlock_1bktu2(ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^BlockingTrampoline_7)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_7 _MapLibreFFi_wrapBlockingBlock_1bktu2(
    BlockingTrampoline_7 block, BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^ProtocolTrampoline_12)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^ProtocolTrampoline_13)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _MapLibreFFi_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGAffineTransform  (^ProtocolTrampoline_14)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _MapLibreFFi_protocolTrampoline_8o6he9(id target, void * sel) {
  return ((ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^ListenerTrampoline_8)(void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_8 _MapLibreFFi_wrapListenerBlock_1lznlw3(ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGAffineTransform arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^BlockingTrampoline_8)(void * waiter, void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_8 _MapLibreFFi_wrapBlockingBlock_1lznlw3(
    BlockingTrampoline_8 block, BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGAffineTransform arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^ProtocolTrampoline_15)(void * sel, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1lznlw3(id target, void * sel, struct CGAffineTransform arg1) {
  return ((ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIDynamicItemCollisionBoundsType  (^ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDynamicItemCollisionBoundsType  _MapLibreFFi_protocolTrampoline_ku69ws(id target, void * sel) {
  return ((ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGPoint  (^ProtocolTrampoline_17)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _MapLibreFFi_protocolTrampoline_17ipln5(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^ProtocolTrampoline_18)(void * sel, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _MapLibreFFi_protocolTrampoline_1sh7l9z(id target, void * sel, struct CGRect arg1, id arg2) {
  return ((ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIFocusItemDeferralMode  (^ProtocolTrampoline_19)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIFocusItemDeferralMode  _MapLibreFFi_protocolTrampoline_1qeotwu(id target, void * sel) {
  return ((ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_UIFocusEnvironment(void) { return @protocol(UIFocusEnvironment); }

typedef void  (^ListenerTrampoline_9)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_9 _MapLibreFFi_wrapListenerBlock_ovsamd(ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^BlockingTrampoline_9)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_9 _MapLibreFFi_wrapBlockingBlock_ovsamd(
    BlockingTrampoline_9 block, BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^ProtocolTrampoline_20)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^ProtocolTrampoline_21)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^ListenerTrampoline_10)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_10 _MapLibreFFi_wrapListenerBlock_fjrv01(ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^BlockingTrampoline_10)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_10 _MapLibreFFi_wrapBlockingBlock_fjrv01(
    BlockingTrampoline_10 block, BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^ProtocolTrampoline_22)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^ProtocolTrampoline_23)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_12thpau(id target, void * sel, struct CGRect arg1) {
  return ((ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^ListenerTrampoline_11)(void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_11 _MapLibreFFi_wrapListenerBlock_qvcerx(ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGContext * arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^BlockingTrampoline_11)(void * waiter, void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_11 _MapLibreFFi_wrapBlockingBlock_qvcerx(
    BlockingTrampoline_11 block, BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGContext * arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^ProtocolTrampoline_24)(void * sel, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_qvcerx(id target, void * sel, id arg1, struct CGContext * arg2) {
  return ((ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_UITraitOverrides(void) { return @protocol(UITraitOverrides); }

Protocol* _MapLibreFFi_UITraitChangeRegistration(void) { return @protocol(UITraitChangeRegistration); }

typedef id  (^ProtocolTrampoline_25)(void * sel, id arg1, id arg2, struct objc_selector * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_g285me(id target, void * sel, id arg1, id arg2, struct objc_selector * arg3) {
  return ((ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^ProtocolTrampoline_26)(void * sel, id arg1, struct objc_selector * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_wyrm70(id target, void * sel, id arg1, struct objc_selector * arg2) {
  return ((ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_UIActivityItemsConfigurationProviding(void) { return @protocol(UIActivityItemsConfigurationProviding); }

Protocol* _MapLibreFFi_UIActivityItemsConfigurationReading(void) { return @protocol(UIActivityItemsConfigurationReading); }

Protocol* _MapLibreFFi_UIMenuBuilder(void) { return @protocol(UIMenuBuilder); }

typedef void  (^ListenerTrampoline_12)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_12 _MapLibreFFi_wrapListenerBlock_1l4hxwm(ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^BlockingTrampoline_12)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_12 _MapLibreFFi_wrapBlockingBlock_1l4hxwm(
    BlockingTrampoline_12 block, BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^ProtocolTrampoline_27)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_UIMutableTraits(void) { return @protocol(UIMutableTraits); }

typedef UIMenuElementAttributes  (^ProtocolTrampoline_28)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIMenuElementAttributes  _MapLibreFFi_protocolTrampoline_1tmn9mr(id target, void * sel) {
  return ((ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^ListenerTrampoline_13)(void * arg0, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_13 _MapLibreFFi_wrapListenerBlock_1lmpkp(ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIMenuElementAttributes arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^BlockingTrampoline_13)(void * waiter, void * arg0, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_13 _MapLibreFFi_wrapBlockingBlock_1lmpkp(
    BlockingTrampoline_13 block, BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIMenuElementAttributes arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^ProtocolTrampoline_29)(void * sel, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1lmpkp(id target, void * sel, UIMenuElementAttributes arg1) {
  return ((ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIMenuElementState  (^ProtocolTrampoline_30)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIMenuElementState  _MapLibreFFi_protocolTrampoline_gvl1rz(id target, void * sel) {
  return ((ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^ListenerTrampoline_14)(void * arg0, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_14 _MapLibreFFi_wrapListenerBlock_1mm4s9d(ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIMenuElementState arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^BlockingTrampoline_14)(void * waiter, void * arg0, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_14 _MapLibreFFi_wrapBlockingBlock_1mm4s9d(
    BlockingTrampoline_14 block, BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIMenuElementState arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^ProtocolTrampoline_31)(void * sel, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_1mm4s9d(id target, void * sel, UIMenuElementState arg1) {
  return ((ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_UITextInputDelegate(void) { return @protocol(UITextInputDelegate); }

Protocol* _MapLibreFFi_UIContentSizeCategoryAdjusting(void) { return @protocol(UIContentSizeCategoryAdjusting); }

Protocol* _MapLibreFFi_UILetterformAwareAdjusting(void) { return @protocol(UILetterformAwareAdjusting); }

Protocol* _MapLibreFFi_UIContentContainer(void) { return @protocol(UIContentContainer); }

Protocol* _MapLibreFFi_UIAccessibilityContentSizeCategoryImageAdjusting(void) { return @protocol(UIAccessibilityContentSizeCategoryImageAdjusting); }

typedef void  (^ListenerTrampoline_15)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_15 _MapLibreFFi_wrapListenerBlock_10lndml(ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^BlockingTrampoline_15)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_15 _MapLibreFFi_wrapBlockingBlock_10lndml(
    BlockingTrampoline_15 block, BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^ProtocolTrampoline_32)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _MapLibreFFi_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_UIGestureRecognizerDelegate(void) { return @protocol(UIGestureRecognizerDelegate); }

Protocol* _MapLibreFFi_UIConfigurationState(void) { return @protocol(UIConfigurationState); }

Protocol* _MapLibreFFi_UIContentConfiguration(void) { return @protocol(UIContentConfiguration); }

typedef BOOL  (^ProtocolTrampoline_33)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_UIShapeProvider(void) { return @protocol(UIShapeProvider); }

Protocol* _MapLibreFFi_CTAdaptiveImageProviding(void) { return @protocol(CTAdaptiveImageProviding); }

typedef void  (^ListenerTrampoline_16)(id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_16 _MapLibreFFi_wrapListenerBlock_6p7ndb(ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^BlockingTrampoline_16)(void * waiter, id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_16 _MapLibreFFi_wrapBlockingBlock_6p7ndb(
    BlockingTrampoline_16 block, BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^ListenerTrampoline_17)(id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_17 _MapLibreFFi_wrapListenerBlock_13x5jor(ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^BlockingTrampoline_17)(void * waiter, id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_17 _MapLibreFFi_wrapBlockingBlock_13x5jor(
    BlockingTrampoline_17 block, BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

Protocol* _MapLibreFFi_MLNStylable(void) { return @protocol(MLNStylable); }

Protocol* _MapLibreFFi_MLNMapViewDelegate(void) { return @protocol(MLNMapViewDelegate); }

Protocol* _MapLibreFFi_MLNLocationManager(void) { return @protocol(MLNLocationManager); }

typedef struct CLLocationCoordinate2D  (^ProtocolTrampoline_34)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CLLocationCoordinate2D  _MapLibreFFi_protocolTrampoline_neuenc(id target, void * sel) {
  return ((ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_MLNAnnotation(void) { return @protocol(MLNAnnotation); }

typedef struct MLNCoordinateBounds  (^ProtocolTrampoline_35)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct MLNCoordinateBounds  _MapLibreFFi_protocolTrampoline_1fkc0ji(id target, void * sel) {
  return ((ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^ProtocolTrampoline_36)(void * sel, struct MLNCoordinateBounds arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _MapLibreFFi_protocolTrampoline_krbldm(id target, void * sel, struct MLNCoordinateBounds arg1) {
  return ((ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

Protocol* _MapLibreFFi_MLNOverlay(void) { return @protocol(MLNOverlay); }

Protocol* _MapLibreFFi_MLNFeature(void) { return @protocol(MLNFeature); }

typedef unsigned long  (^ProtocolTrampoline_37)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _MapLibreFFi_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

Protocol* _MapLibreFFi_MLNCluster(void) { return @protocol(MLNCluster); }

typedef id  (^ProtocolTrampoline_38)(void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_fclj7c(id target, void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3) {
  return ((ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^ProtocolTrampoline_39)(void * sel, struct MLNCoordinateBounds arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_129i16p(id target, void * sel, struct MLNCoordinateBounds arg1, unsigned long arg2) {
  return ((ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

Protocol* _MapLibreFFi_MLNComputedShapeSourceDataSource(void) { return @protocol(MLNComputedShapeSourceDataSource); }

Protocol* _MapLibreFFi_MLNOfflineRegion(void) { return @protocol(MLNOfflineRegion); }

typedef void  (^ListenerTrampoline_18)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_18 _MapLibreFFi_wrapListenerBlock_r8gdi7(ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^BlockingTrampoline_18)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
ListenerTrampoline_18 _MapLibreFFi_wrapBlockingBlock_r8gdi7(
    BlockingTrampoline_18 block, BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef id  (^ProtocolTrampoline_40)(void * sel, id arg1, MLNResourceKind arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _MapLibreFFi_protocolTrampoline_1fy0zqa(id target, void * sel, id arg1, MLNResourceKind arg2, id arg3) {
  return ((ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

Protocol* _MapLibreFFi_MLNOfflineStorageDelegate(void) { return @protocol(MLNOfflineStorageDelegate); }
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop

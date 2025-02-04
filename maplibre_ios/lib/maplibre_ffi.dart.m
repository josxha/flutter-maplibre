#include <stdint.h>
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

id objc_retain(id);
id objc_retainBlock(id);

typedef void  (^_ListenerTrampoline)();
_ListenerTrampoline _MapLibreFFi_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_ListenerTrampoline1)(void * arg0, id arg1);
_ListenerTrampoline1 _MapLibreFFi_wrapListenerBlock_wjovn7(_ListenerTrampoline1 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retain(arg1));
  };
}

typedef void  (^_ListenerTrampoline2)(id arg0, id arg1);
_ListenerTrampoline2 _MapLibreFFi_wrapListenerBlock_wjvic9(_ListenerTrampoline2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void  (^_ListenerTrampoline3)(id arg0);
_ListenerTrampoline3 _MapLibreFFi_wrapListenerBlock_1jdvcbf(_ListenerTrampoline3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retain(arg0));
  };
}

typedef void  (^_ListenerTrampoline4)(id arg0, id arg1, id arg2);
_ListenerTrampoline4 _MapLibreFFi_wrapListenerBlock_1hcfngn(_ListenerTrampoline4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

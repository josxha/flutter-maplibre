#import <TargetConditionals.h>

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#import "maplibre_native_api.h"

NS_ASSUME_NONNULL_BEGIN

/// The maplibre_native plugin on iOS and macOS. It holds the texture registry
/// of the engine that registered it last, and serves the C API in
/// maplibre_native_api.h.
@interface MaplibreNativePlugin : NSObject <FlutterPlugin>

/// The functions of the C API, ending with an entry whose name is NULL. Dart
/// calls this through the Objective-C runtime, which finds the class by name
/// even where the linker or strip dropped the C symbols.
+ (const MaplibreNativeSymbol *)symbols;

@end

NS_ASSUME_NONNULL_END

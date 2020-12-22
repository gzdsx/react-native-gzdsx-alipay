//
//  Created by songdewei on 2020/12/23.
//

#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#if __has_include("AlipaySDK.h")
#import "AlipaySDK.h"
#else
#import <AlipaySDK/AlipaySDK.h>
#endif

@interface RNAlipay : NSObject <RCTBridgeModule>

@property (nonatomic, copy) RCTPromiseResolveBlock payOrderResolve;

@end
  

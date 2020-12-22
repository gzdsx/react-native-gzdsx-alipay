//
//  Created by songdewei on 2020/12/23.
//

#import "RNAlipay.h"
#import <objc/runtime.h>

static RCTPromiseResolveBlock _resolve;
static RCTPromiseRejectBlock _reject;

@implementation RNAlipay

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOpenURL:) name:@"RCTOpenURLNotification" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(auth:(NSString *)infoStr
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    _resolve = resolve;
    _reject = reject;
    [AlipaySDK.defaultService auth_V2WithInfo:infoStr fromScheme:self.appScheme callback:^(NSDictionary *resultDic) {
        [RNAlipay handleResult:resultDic];
    }];
}

RCT_EXPORT_METHOD(pay:(NSString *)orderInfo
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    _resolve = resolve;
    _reject = reject;
    [AlipaySDK.defaultService payOrder:orderInfo fromScheme:self.appScheme callback:^(NSDictionary *resultDic) {
        [RNAlipay handleResult:resultDic];
    }];
}

RCT_EXPORT_METHOD(payInterceptorWithUrl:(NSString *)urlStr
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    _resolve = resolve;
    _reject = reject;
    [AlipaySDK.defaultService payInterceptorWithUrl:urlStr fromScheme:self.appScheme callback:^(NSDictionary *resultDic) {
        [RNAlipay handleResult:resultDic];
    }];
}

RCT_EXPORT_METHOD(getVersion:(RCTPromiseResolveBlock)resolve) {
    resolve(AlipaySDK.defaultService.currentVersion);
}

- (NSString *)appScheme {
    NSArray *urlTypes = NSBundle.mainBundle.infoDictionary[@"CFBundleURLTypes"];
    for (NSDictionary *urlType in urlTypes) {
        NSString *urlName = urlType[@"CFBundleURLName"];
        if ([urlName hasPrefix:@"alipay"]) {
            NSArray *schemes = urlType[@"CFBundleURLSchemes"];
            return schemes.firstObject;
        }
    }
    return nil;
}

- (void)handleOpenURL:(NSNotification *)notification {
    NSString *urlString = notification.userInfo[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    if ([url.host isEqualToString:@"safepay"]) {
        //__weak __typeof__(self) weakSelf = self;
        [AlipaySDK.defaultService processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"processOrderWithPaymentResult = %@", resultDic);
            [RNAlipay handleResult:resultDic];
        }];
        
        [AlipaySDK.defaultService processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"processAuth_V2Result = %@", resultDic);
            [RNAlipay handleResult:resultDic];
        }];
    }
}

+(void) handleResult:(NSDictionary *)resultDic
{
    NSString *status = resultDic[@"resultStatus"];
    if ([status integerValue] >= 8000) {
        _resolve(resultDic);
    } else {
        _reject(status, resultDic[@"memo"], [NSError errorWithDomain:resultDic[@"memo"] code:[status integerValue] userInfo:NULL]);
    }
}

@end
  

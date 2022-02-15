#import "EXAdSettingsManager.h"
#import "EXUnversioned.h"

//#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <React/RCTUtils.h>
#import <React/RCTConvert.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@implementation RCTConvert (EXNativeAdView)

RCT_ENUM_CONVERTER(FBAdLogLevel, (@{
  @"none": @(FBAdLogLevelNone),
  @"debug": @(FBAdLogLevelDebug),
  @"verbose": @(FBAdLogLevelVerbose),
  @"warning": @(FBAdLogLevelWarning),
  @"notification": @(FBAdLogLevelNotification),
  @"error": @(FBAdLogLevelError),
}), FBAdLogLevelLog, integerValue)

@end

@interface EXAdSettingsManager ()

@property (nonatomic) BOOL isChildDirected;
@property (nonatomic, strong) NSString *mediationService;
@property (nonatomic, strong) NSString *urlPrefix;
@property (nonatomic) FBAdLogLevel logLevel;
@property (nonatomic, strong) NSMutableArray<NSString*> *testDevices;

@end

@implementation EXAdSettingsManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(CTKAdSettingsManager)

- (instancetype)init {
  if (self = [super init]) {
    _testDevices = [NSMutableArray new];
    _urlPrefix = @"";
    _mediationService = @"";
  }
  return self;
}

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (void)setBridge:(RCTBridge *)bridge
{
  _bridge = bridge;

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(bridgeDidForeground:)
                                               name:EX_UNVERSIONED(@"EXKernelBridgeDidForegroundNotification")
                                             object:self.bridge];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(bridgeDidBackground:)
                                               name:EX_UNVERSIONED(@"EXKernelBridgeDidBackgroundNotification")
                                             object:self.bridge];
}

RCT_EXPORT_METHOD(addTestDevice:(NSString *)deviceHash)
{
  [FBAdSettings addTestDevice:deviceHash];
  [_testDevices addObject:deviceHash];
}

RCT_EXPORT_METHOD(clearTestDevices)
{
  [FBAdSettings clearTestDevices];
  [_testDevices removeAllObjects];
}

RCT_EXPORT_METHOD(setLogLevel:(FBAdLogLevel)logLevel)
{
  [FBAdSettings setLogLevel:logLevel];
  _logLevel = logLevel;
}

RCT_EXPORT_METHOD(setIsChildDirected:(BOOL)isDirected)
{
  [FBAdSettings setMixedAudience:isDirected];
  _isChildDirected = isDirected;
}

RCT_EXPORT_METHOD(setMediationService:(NSString *)mediationService)
{
  [FBAdSettings setMediationService:mediationService];
  _mediationService = mediationService;
}

RCT_EXPORT_METHOD(setUrlPrefix:(NSString *)urlPrefix)
{
  [FBAdSettings setUrlPrefix:urlPrefix];
  _urlPrefix = urlPrefix;
}


RCT_EXPORT_METHOD(getTrackingStatus:(RCTPromiseResolveBlock)resolve rejector:(RCTPromiseRejectBlock)reject)
{
    if (@available(iOS 14, *)) {
        resolve([EXAdSettingsManager convertTrackingStatusToString:[ATTrackingManager trackingAuthorizationStatus]]);
    } else {
        resolve(@"unavailable");
    }
}

RCT_EXPORT_METHOD(requestTrackingPermission:(RCTPromiseResolveBlock)resolve rejector:(RCTPromiseRejectBlock)reject)
{
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            resolve([EXAdSettingsManager convertTrackingStatusToString:status]);
        }];
    } else {
        resolve(@"unavailable");
    }
}

RCT_EXPORT_METHOD(setAdvertiserIDCollectionEnabled:(BOOL)enabled)
{
    [FBAdSettings setAdvertiserTrackingEnabled:enabled];
}


RCT_EXPORT_METHOD(setAdvertiserTrackingEnabled:(BOOL)enabled)
{
    [FBAdSettings setAdvertiserTrackingEnabled:enabled];
}


- (void)bridgeDidForeground:(NSNotification *)notification
{
  [FBAdSettings setMixedAudience:_isChildDirected];
  [FBAdSettings setMediationService:_mediationService];
  [FBAdSettings setUrlPrefix:_urlPrefix];
  [FBAdSettings setLogLevel:_logLevel];
  [FBAdSettings addTestDevices:_testDevices];
}

- (void)bridgeDidBackground:(NSNotification *)notification
{
  [FBAdSettings setMixedAudience:NO];
  [FBAdSettings setMediationService:@""];
  [FBAdSettings setUrlPrefix:@""];
  [FBAdSettings setLogLevel:FBAdLogLevelLog];
  [FBAdSettings clearTestDevices];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSDictionary *)constantsToExport
{
  return @{ @"currentDeviceHash": [FBAdSettings testDeviceHash] };
}

+ (NSString *) convertTrackingStatusToString:(ATTrackingManagerAuthorizationStatus) status API_AVAILABLE(ios(14)) {
    switch (status) {
        case ATTrackingManagerAuthorizationStatusDenied:
            return @"denied";
        case ATTrackingManagerAuthorizationStatusAuthorized:
            return @"authorized";
        case ATTrackingManagerAuthorizationStatusRestricted:
            return @"restricted";
        case ATTrackingManagerAuthorizationStatusNotDetermined:
            return @"not-determined";
    }
}

@end

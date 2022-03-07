#import <React/RCTViewManager.h>


#ifdef FB_AUDIENCE_ENABLED
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface EXNativeAdManager : RCTViewManager

- (FBNativeAdsManager *) getFBAdsManager:(NSString *)placementId;

@end

#endif
#import <React/RCTViewManager.h>
#import <UIKit/UIKit.h>

#ifdef FB_AUDIENCE_ENABLED
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface EXNativeMediaViewManager : RCTViewManager
@end

#endif
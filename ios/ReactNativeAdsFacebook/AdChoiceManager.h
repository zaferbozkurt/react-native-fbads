//
//  AdChoiceManager.h
//  ReactNativeAdsFacebook
//
//  Created by Suraj Tiwari  on 14/08/18.
//  Copyright © 2018 Suraj Tiwari . All rights reserved.
//

#import <React/RCTViewManager.h>
#import <UIKit/UIKit.h>

#ifdef FB_AUDIENCE_ENABLED
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface AdChoiceManager : RCTViewManager
@end

#endif

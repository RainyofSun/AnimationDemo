//
//  WeatherAnimationBaseLayer.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WeatherAnimationHeader.h"

NS_ASSUME_NONNULL_BEGIN
#define kMaxWhiteCloudCount  11
#define kRotationAnimationTimes  80
#define kOffsetXAnimationTimes  100
#define kOffsetXScreenCount  3

@interface WeatherAnimationBaseLayer : CALayer

/// override 
- (void)startAnimation;
- (void)stopAnimation;

/// cloud animation
- (void)addCloud:(BOOL)isRain rainCount:(NSInteger)rainCount onLayer:(CALayer *)layer;
- (void)freeCloud;

@end

NS_ASSUME_NONNULL_END

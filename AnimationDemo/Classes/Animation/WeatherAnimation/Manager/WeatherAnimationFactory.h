//
//  WeatherAnimationFactory.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherAnimationHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherAnimationFactory : NSObject

- (instancetype)initWithWeatherAnimationView:(UIView *)animationView;
- (void)addWeatherAnimationFactoryWithType:(WeatherAnimationType)weatherType;
- (void)removeAllAnimation;

@end

NS_ASSUME_NONNULL_END

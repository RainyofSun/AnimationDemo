//
//  WeatherAnimationHeader.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#ifndef WeatherAnimationHeader_h
#define WeatherAnimationHeader_h

/**
 * 天气类型
 */
typedef enum : NSUInteger {
    WeatherAnimationType_Sun,
    WeatherAnimationType_Cloud,
    WeatherAnimationType_Rain,
    WeatherAnimationType_RainLighting,
    WeatherAnimationType_Snow,
    WeatherAnimationType_Other
} WeatherAnimationType;

/**
 * 天气背景
 */
typedef enum : NSUInteger {
    WeatherAnimationBackType_SunDay,
    WeatherAnimationBackType_SunNight,
    WeatherAnimationBackType_RainDay,
    WeatherAnimationBackType_RainNight
} WeatherAnimationBackType;

/**
 * 颜色宏
 */

#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b)    UIColorFromRGBA(r,g,b,1.0)

#define kSunDayTopColor         UIColorFromRGB(41, 145, 197)
#define kSunDayBottomColor      UIColorFromRGB(63, 159, 204)

#define kSunNightTopColor       UIColorFromRGB(11, 13, 30)
#define kSunNightDayBottomColor UIColorFromRGB(28, 33, 52)

#define kRainDayTopColor        UIColorFromRGB(73, 115, 146)
#define kRainDayBottomColor     UIColorFromRGB(61, 96, 123)

#define kRainNightTopColor      UIColorFromRGB(13, 13, 18)
#define kRainNightBottomColor   UIColorFromRGB(25, 27, 36)

#define kWeatherChangeAnimationDuration 1.0

#endif /* WeatherAnimationHeader_h */

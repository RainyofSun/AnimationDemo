//
//  WeatherAnimationFactory.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherAnimationFactory.h"
#import "WeatherSunAnimationLayer.h"
#import "WeatherCloudAnimationLayer.h"
#import "WeatherRainAnimationLayer.h"
#import "WeatherSnowAnimationLayer.h"

@interface WeatherAnimationFactory ()

/** weatherBackLayer */
@property (nonatomic,strong) CALayer *weatherBackLayer;
/** animationQueue */
@property (nonatomic,strong) NSMutableArray <NSNumber *>*animationQueue;
/** animationView */
@property (nonatomic,strong) UIView *animationView;
/** displayLayer */
@property (nonatomic,strong) WeatherAnimationBaseLayer *displayLayer;
/** willDisplayLayer */
@property (nonatomic,strong) WeatherAnimationBaseLayer *willDisplayLayer;

@end

@implementation WeatherAnimationFactory

#pragma mark - public methods
- (instancetype)initWithWeatherAnimationView:(UIView *)animationView {
    if (self = [super init]) {
        self.animationView = animationView;
        [self.animationView.layer addSublayer:self.weatherBackLayer];
        self.weatherBackLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.animationView.bounds), CGRectGetHeight(self.animationView.bounds));
    }
    return self;
}

- (void)dealloc {
    self.animationView = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)addWeatherAnimationFactoryWithType:(WeatherAnimationType)weatherType {
    [self addOrRemoveAnimation:NO animationType:weatherType];
}

- (void)removeAllAnimation {
    if (self.displayLayer) {
        [self.displayLayer stopAnimation];
        [self.displayLayer removeFromSuperlayer];
        self.displayLayer = nil;
    }
    [self.animationQueue removeAllObjects];
}

#pragma mark - private methods
- (void)addOrRemoveAnimation:(BOOL)isRemove animationType:(WeatherAnimationType)animationType {
    if (isRemove) {
        if (self.animationQueue.count) {
            [self.animationQueue removeObjectAtIndex:0];
            self.animationQueue.count > 0 ? [self startAnimation] : nil;
        }
    } else {
        if (self.animationQueue.count == 0) {
            [self.animationQueue addObject:[NSNumber numberWithInteger:animationType]];
            [self startAnimation];
        } else {
            [self.animationQueue addObject:[NSNumber numberWithInteger:animationType]];
        }
    }
}

- (void)startAnimation {
    if (!_animationQueue || !self.animationQueue.count) {
        return;
    }
    
    WeatherAnimationType animationType = [self.animationQueue.firstObject integerValue];
    if (animationType == WeatherAnimationType_Sun || animationType == WeatherAnimationType_Other) {
        WeatherSunAnimationLayer *sunLayer = [[WeatherSunAnimationLayer alloc] init];
        sunLayer.frame = self.animationView.frame;
        [self.animationView.layer addSublayer:sunLayer];
        self.willDisplayLayer = sunLayer;
    } else if (animationType == WeatherAnimationType_Cloud) {
        WeatherCloudAnimationLayer *cloudLayer = [[WeatherCloudAnimationLayer alloc] init];
        cloudLayer.frame = self.animationView.frame;
        [self.animationView.layer addSublayer:cloudLayer];
        self.willDisplayLayer = cloudLayer;
    } else if (animationType == WeatherAnimationType_Rain) {
        WeatherRainAnimationLayer *rainLayer = [[WeatherRainAnimationLayer alloc] init];
        rainLayer.frame = self.animationView.frame;
        [self.animationView.layer addSublayer:rainLayer];
        self.willDisplayLayer = rainLayer;
    } else if (animationType == WeatherAnimationType_RainLighting) {
        WeatherRainAnimationLayer *thrunderLayer = [[WeatherRainAnimationLayer alloc] init];
        thrunderLayer.isThrunder = YES;
        thrunderLayer.frame = self.animationView.frame;
        [self.animationView.layer addSublayer:thrunderLayer];
        self.willDisplayLayer = thrunderLayer;
    } else if (animationType == WeatherAnimationType_Snow) {
        WeatherSnowAnimationLayer *snowLayer = [[WeatherSnowAnimationLayer alloc] init];
        snowLayer.frame = self.animationView.frame;
        [self.animationView.layer addSublayer:snowLayer];
        self.willDisplayLayer = snowLayer;
    }
    
    WeatherAnimationBackType animationBackType = [self getWeatherBackViewType:animationType];
    UIImage *backImg;
    
    if (animationBackType == WeatherAnimationBackType_SunDay) {
        backImg = [self getGradientImage:kSunDayTopColor andColor:kSunDayBottomColor];
    } else if (animationBackType == WeatherAnimationBackType_SunNight) {
        backImg = [self getGradientImage:kSunNightTopColor andColor:kSunNightDayBottomColor];
    } else if (animationBackType == WeatherAnimationBackType_RainDay) {
        backImg = [self getGradientImage:kRainDayTopColor andColor:kRainDayBottomColor];
    } else if (animationBackType == WeatherAnimationBackType_RainNight) {
        backImg = [self getGradientImage:kRainNightTopColor andColor:kRainNightBottomColor];
    }
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:kWeatherChangeAnimationDuration];
    [CATransaction setCompletionBlock:^{
        [self.displayLayer removeFromSuperlayer];
        self.displayLayer = nil;
        self.displayLayer = self.willDisplayLayer;
        [self addOrRemoveAnimation:YES animationType:WeatherAnimationType_Sun];
    }];

    if (backImg) {
        self.weatherBackLayer.contents = (__bridge id)backImg.CGImage;
    }
    if (self.willDisplayLayer) {
        [self.willDisplayLayer startAnimation];
    }
    if (self.displayLayer) {
        [self.displayLayer stopAnimation];
    }

    [CATransaction commit];
}

- (WeatherAnimationBackType)getWeatherBackViewType:(WeatherAnimationType)animationType {
    BOOL isRain = NO;
    
    if (animationType >= 0 && animationType < 4) {
        // 晴天
        isRain = NO;
    } else if (animationType >= 4 && animationType < 10) {
        // 多云
        isRain = NO;
    } else if (animationType >= 10 && animationType < 20) {
        // 雨
        isRain = YES;
    } else if (animationType >= 20 && animationType < 26) {
        // 雪
        isRain = NO;
    } else {
        isRain = YES;
    }
    
    if ([self isNowDayTime]) {
        if (isRain) {
            return WeatherAnimationBackType_RainDay;
        } else {
            return WeatherAnimationBackType_SunDay;
        }
    } else {
        if (isRain) {
            return WeatherAnimationBackType_RainNight;
        } else {
            return WeatherAnimationBackType_SunNight;
        }
    }
}

#pragma mark - tools
- (BOOL)isNowDayTime {
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitHour fromDate:date];
    if ([components hour] >= 19 || [components hour] < 6) {
        return NO;
    }else{
        return YES;
    }
}

- (UIImage *)getGradientImage:(UIColor *)color1 andColor:(UIColor *)color2 {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)color1.CGColor,
                            (__bridge id)color2.CGColor];
    
    gradientLayer.locations = @[@(0.f),@(1.f)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    gradientLayer.frame = CGRectMake(0, 0, 100, 100);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, NO, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return gradientImage;
}

#pragma mark - lazy
- (NSMutableArray<NSNumber *> *)animationQueue {
    if (!_animationQueue) {
        _animationQueue = [NSMutableArray array];
    }
    return _animationQueue;
}

- (CALayer *)weatherBackLayer {
    if (!_weatherBackLayer) {
        _weatherBackLayer = [CALayer layer];
        _weatherBackLayer.masksToBounds = YES;
    }
    return _weatherBackLayer;
}

@end

//
//  WeatherSunAnimationLayer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherSunAnimationLayer.h"

@interface WeatherSunAnimationLayer ()

/** sunImageLayer */
@property (nonatomic,strong) CALayer *sunImageLayer;
/** sunShineImageLayer */
@property (nonatomic,strong) CALayer *sunShineImageLayer;

@end

@implementation WeatherSunAnimationLayer

- (instancetype)init {
    if (self = [super init]) {
        [self initSunAnimation];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - override
- (void)startAnimation {
    [super startAnimation];
    self.speed = 1.0;
}

- (void)stopAnimation {
    [super stopAnimation];
}

#pragma mark - private methods
- (void)initSunAnimation {
    [self addSublayer:self.sunImageLayer];
    [self addSublayer:self.sunShineImageLayer];
    
    self.sunImageLayer.contents = (__bridge id)[UIImage imageNamed:@"ele_sunnySun"].CGImage;
    self.sunImageLayer.contentsGravity = kCAGravityResizeAspectFill;
    self.sunImageLayer.frame = CGRectMake(0, 0, 200, 200*579/612.0);
    self.sunImageLayer.center = CGPointMake([UIScreen mainScreen].bounds.size.height * 0.1, [UIScreen mainScreen].bounds.size.height * 0.1);
    [self.sunImageLayer addAnimation:[self sunAnimationWithDuration:kRotationAnimationTimes] forKey:nil];
    
    self.sunShineImageLayer.contents = (__bridge id)[UIImage imageNamed:@"ele_sunnySunshine"].CGImage;
    self.sunShineImageLayer.frame = CGRectMake(0, 0, 600, 600);
    self.sunShineImageLayer.contentsGravity = kCAGravityResizeAspectFill;
    self.sunShineImageLayer.center = CGPointMake([UIScreen mainScreen].bounds.size.height * 0.1, [UIScreen mainScreen].bounds.size.height * 0.1);
    [self.sunShineImageLayer addAnimation:[self sunAnimationWithDuration:kRotationAnimationTimes] forKey:nil];
    
    [self addCloud:NO rainCount:3 + arc4random()%3 onLayer:self];
    
    self.speed = 0.0;
}

#pragma mark - animation
- (CABasicAnimation *)sunAnimationWithDuration:(CGFloat)duration {
    CGFloat fromFloat = 0;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:fromFloat * M_PI];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(fromFloat + 2.0) * M_PI];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    
    return rotationAnimation;
}

#pragma mark - lazy
- (CALayer *)sunImageLayer {
    if (!_sunImageLayer) {
        _sunImageLayer = [CALayer layer];
    }
    return _sunImageLayer;
}

- (CALayer *)sunShineImageLayer {
    if (!_sunShineImageLayer) {
        _sunShineImageLayer = [CALayer layer];
    }
    return _sunShineImageLayer;
}

@end

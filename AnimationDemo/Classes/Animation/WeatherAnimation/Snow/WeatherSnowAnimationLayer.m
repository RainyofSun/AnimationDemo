//
//  WeatherSnowAnimationLayer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherSnowAnimationLayer.h"

@implementation WeatherSnowAnimationLayer

- (instancetype)init {
    if (self = [super init]) {
        [self initSnowAnimation];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - override
- (void)startAnimation {
    [super startAnimation];
    self.speed = 1.f;
}

- (void)stopAnimation {
    [super stopAnimation];
}

#pragma mark - private methods
- (void)initSnowAnimation {
    CGFloat widthPix = [UIScreen mainScreen].bounds.size.width/320;
    
    for (NSInteger i = 0; i < 45; i ++) {
        CALayer *snowLayer = [CALayer layer];
        snowLayer.contents = (__bridge id)[UIImage imageNamed:@"ele_snow"].CGImage;
        snowLayer.frame = CGRectMake(arc4random()%300 * widthPix, arc4random()%400, arc4random()%7 + 3, arc4random()%7 + 3);
        [self addSublayer:snowLayer];
        
        [snowLayer addAnimation:[self snowAnimationWithDuration:5 + i%5] forKey:nil];
        [snowLayer addAnimation:[self snowAlphaAnimationWithDuration:5 + i%5] forKey:nil];
        [snowLayer addAnimation:[self snowZAnimationWithDuration:5] forKey:nil];
    }
    
    self.speed = 0.f;
}

#pragma mark - Animation
- (CABasicAnimation *)snowAnimationWithDuration:(CGFloat)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-170, -620, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation([UIScreen mainScreen].bounds.size.height/2.0 * 34/124.0, [UIScreen mainScreen].bounds.size.height/2, 0)];
    return animation;
}

- (CABasicAnimation *)snowAlphaAnimationWithDuration:(CGFloat)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.f];
    animation.toValue = [NSNumber numberWithFloat:0.f];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = NO;
    
    return animation;
}

- (CABasicAnimation *)snowZAnimationWithDuration:(CGFloat)duration {
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

@end

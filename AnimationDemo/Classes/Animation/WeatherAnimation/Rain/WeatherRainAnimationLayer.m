//
//  WeatherRainAnimationLayer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherRainAnimationLayer.h"
#import "WeatherThrunderAnimationLayer.h"

@interface WeatherRainAnimationLayer ()

/** thrunderLayer */
@property (nonatomic,strong) WeatherThrunderAnimationLayer *thrunderLayer;

@end

@implementation WeatherRainAnimationLayer

- (instancetype)init {
    if (self = [super init]) {
        self.isThrunder = NO;
        [self initRainAnimation];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - override
- (void)startAnimation {
    [super startAnimation];
    if (self.isThrunder) {
        [self.thrunderLayer startAnimation];
    }
    self.speed = 1.f;
}

- (void)stopAnimation {
    [super stopAnimation];
    if (self.isThrunder) {
        [self.thrunderLayer stopAnimation];
    }
}

#pragma mark - private methods
- (void)initRainAnimation {
    
    CGFloat widthPix = [UIScreen mainScreen].bounds.size.width/320;
    
    for (NSInteger i = 0; i < 45; i ++) {
        NSInteger randomInteger = arc4random()%3 + 1;
        CALayer *rainLayer = [CALayer layer];
        rainLayer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"ele_rainLine%ld",randomInteger]].CGImage;
        if (randomInteger == 1) {
            rainLayer.frame = CGRectMake(arc4random() % 300 * widthPix, arc4random()%400, 60, 210);
        } else if (randomInteger == 2) {
            rainLayer.frame = CGRectMake(arc4random() % 300 * widthPix, arc4random()%400, 33, 118);
        } else {
            rainLayer.frame = CGRectMake(arc4random() % 300 * widthPix, arc4random()%400, 33, 118);
        }
        [self addSublayer:rainLayer];
        
        [rainLayer addAnimation:[self rainAnimationWithDuration:2 + i%5] forKey:nil];
        [rainLayer addAnimation:[self rainAlphaAnimationWithDuration:2 + i%5] forKey:nil];
    }
    
    [self addCloud:YES rainCount:kMaxWhiteCloudCount onLayer:self];
    
    self.speed = 0.0;
}

#pragma mark - Animation
- (CABasicAnimation *)rainAnimationWithDuration:(CGFloat)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-170, -620, 0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation([UIScreen mainScreen].bounds.size.height/2.0 * 34/124.0, [UIScreen mainScreen].bounds.size.height/2, 0)];
    return animation;
}

- (CABasicAnimation *)rainAlphaAnimationWithDuration:(CGFloat)duration {
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

#pragma mark - set
- (void)setIsThrunder:(BOOL)isThrunder {
    _isThrunder = isThrunder;
    if (isThrunder) {
        [self insertSublayer:self.thrunderLayer atIndex:0];
    }
}

#pragma mark - lazy
- (WeatherThrunderAnimationLayer *)thrunderLayer {
    if (!_thrunderLayer) {
        _thrunderLayer = [[WeatherThrunderAnimationLayer alloc] init];
    }
    return _thrunderLayer;
}

@end

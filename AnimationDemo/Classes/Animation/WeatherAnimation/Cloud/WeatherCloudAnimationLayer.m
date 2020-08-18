//
//  WeatherCloudAnimationLayer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherCloudAnimationLayer.h"

@interface WeatherCloudAnimationLayer ()

/** birdImageLayer */
@property (nonatomic,strong) CALayer *birdImageLayer;
/** birdRefImageLayer */
@property (nonatomic,strong) CALayer *birdRefImageLayer;
/** cloudImageLayer */
@property (nonatomic,strong) CALayer *cloudImageLayer0;
/** cloudImageLayer */
@property (nonatomic,strong) CALayer *cloudImageLayer1;
/** birdsImageArray */
@property (nonatomic,strong) NSMutableArray *birdImageArray;

@end

@implementation WeatherCloudAnimationLayer

- (instancetype)init {
    if (self = [super init]) {
        [self addBirdsImage];
        [self initCloudAnimation];
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
    [self.birdImageArray removeAllObjects];
}

#pragma mark - private methods
- (void)initCloudAnimation {
    [self addSublayer:self.birdImageLayer];
    [self addSublayer:self.birdRefImageLayer];
    [self addSublayer:self.cloudImageLayer0];
    [self addSublayer:self.cloudImageLayer1];
    
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_h = [UIScreen mainScreen].bounds.size.height;
    
    // 鸟 本体
    self.birdImageLayer.contents = (__bridge id)[UIImage imageNamed:@"ele_sunnyBird1"].CGImage;
    self.birdImageLayer.frame = CGRectMake(-30, screen_h * 0.3, 70, 50);
    [self.birdImageLayer addAnimation:[self birdsAnimation] forKey:@"birds"];
    [self.birdImageLayer addAnimation:[self birdFlyAnimationToValue:@(screen_w + 30) duration:10 autoreverses:NO] forKey:nil];
    
    // 鸟 倒影
    self.birdRefImageLayer.contents = (__bridge id)[UIImage imageNamed:@"ele_sunnyBird1"].CGImage;
    self.birdRefImageLayer.frame = CGRectMake(-30, screen_h * 0.9, 70, 50);
    self.birdRefImageLayer.opacity = .4f;
    [self.birdRefImageLayer addAnimation:[self birdsAnimation] forKey:@"birdsRef"];
    [self.birdRefImageLayer addAnimation:[self birdFlyAnimationToValue:@(screen_w + 30) duration:10 autoreverses:NO] forKey:nil];
    
    // 云朵效果
    self.cloudImageLayer0.frame = CGRectMake(0, 0, screen_h * .7f, screen_w * .5f);
    self.cloudImageLayer0.center = CGPointMake(screen_w * 0.25, screen_h * 0.8);
    self.cloudImageLayer0.contents = (__bridge id)[UIImage imageNamed:@"ele_white_cloud_12"].CGImage;
    [self.cloudImageLayer0 addAnimation:[self birdFlyAnimationToValue:@(screen_w + 30) duration:70 autoreverses:YES] forKey:nil];
    
    self.cloudImageLayer1.frame = self.cloudImageLayer0.frame;
    self.cloudImageLayer1.center = CGPointMake(screen_w * 0.05, screen_h * 0.8);
    [self.cloudImageLayer1 addAnimation:[self birdFlyAnimationToValue:@(screen_w + 30) duration:70 autoreverses:YES] forKey:nil];
    
    self.speed = 0.0;
}

#pragma mark - Animation
- (CAKeyframeAnimation *)birdsAnimation {
    CAKeyframeAnimation *birdAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    birdAnimation.values = self.birdImageArray;
    birdAnimation.removedOnCompletion = NO;
    birdAnimation.fillMode = kCAFillModeForwards;
    birdAnimation.repeatCount = MAXFLOAT;
    birdAnimation.duration = 1;
    return birdAnimation;
}

- (CABasicAnimation *)birdFlyAnimationToValue:(NSNumber *)toValue duration:(CGFloat)duration autoreverses:(BOOL)autoreverse {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = toValue;
    animation.duration = duration;
    animation.autoreverses = autoreverse;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (void)addBirdsImage {
    for (NSInteger i = 1; i < 9; i ++) {
        UIImage *birdsImage = [UIImage imageNamed:[NSString stringWithFormat:@"ele_sunnyBird%ld",i]];
        CGImageRef cgImage = birdsImage.CGImage;
        [self.birdImageArray addObject:(__bridge UIImage *)cgImage];
    }
}

#pragma mark - lazy
- (CALayer *)birdImageLayer {
    if (!_birdImageLayer) {
        _birdImageLayer = [CALayer layer];
    }
    return _birdImageLayer;
}

- (CALayer *)birdRefImageLayer {
    if (!_birdRefImageLayer) {
        _birdRefImageLayer = [CALayer layer];
    }
    return _birdRefImageLayer;
}

- (CALayer *)cloudImageLayer0 {
    if (!_cloudImageLayer0) {
        _cloudImageLayer0 = [CALayer layer];
    }
    return _cloudImageLayer0;
}

- (CALayer *)cloudImageLayer1 {
    if (!_cloudImageLayer1) {
        _cloudImageLayer1 = [CALayer layer];
    }
    return _cloudImageLayer1;
}

- (NSMutableArray *)birdImageArray {
    if (!_birdImageArray) {
        _birdImageArray = [NSMutableArray array];
    }
    return _birdImageArray;
}

@end

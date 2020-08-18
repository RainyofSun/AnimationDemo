//
//  WeatherAnimationBaseLayer.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "WeatherAnimationBaseLayer.h"

@interface WeatherAnimationBaseLayer ()

/** cloudArray */
@property (nonatomic,strong) NSMutableArray <CALayer *>*cloudArray;

@end

@implementation WeatherAnimationBaseLayer

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)startAnimation {
    self.opacity = 1.0;
}

- (void)stopAnimation {
    [self freeCloud];
    self.opacity = 0.f;
}

- (void)freeCloud {
    for (CALayer *cloudLayer in self.cloudArray) {
        [cloudLayer removeFromSuperlayer];
    }
    [self.cloudArray removeAllObjects];
}

- (void)addCloud:(BOOL)isRain rainCount:(NSInteger)rainCount onLayer:(CALayer *)layer {
    NSMutableArray *tempArray = [NSMutableArray array];
    
    if (rainCount == kMaxWhiteCloudCount) {
        for (NSInteger i = 0; i < rainCount; i ++) {
            [tempArray addObject:@(i)];
        }
        [tempArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if (arc4random()%2) {
                return [obj1 compare:obj2];
            } else {
                return [obj2 compare:obj1];
            }
        }];
    } else {
        for (NSInteger i = 0; i < rainCount; i ++) {
            while (1) {
                NSInteger indexRow = arc4random()%kMaxWhiteCloudCount;
                if (![tempArray containsObject:@(indexRow)]) {
                    [tempArray addObject:@(indexRow)];
                    break;
                }
            }
        }
    }
    
    for (NSInteger i = 0; i < tempArray.count; i ++) {
        NSNumber *number = tempArray[i];
        UIImage *cloudImg;
        if (isRain) {
            cloudImg = [self imageNamed:[NSString stringWithFormat:@"ele_white_cloud_%@",number] withTintColor:UIColorFromRGB(0, 51, 86)];
        } else {
            cloudImg = [UIImage imageNamed:[NSString stringWithFormat:@"ele_white_cloud_%@",number]];
        }
        
        CGFloat offsetX = i * kOffsetXScreenCount / rainCount * [UIScreen mainScreen].bounds.size.width - (kOffsetXScreenCount - 1) / 2.0 * [UIScreen mainScreen].bounds.size.width;
        
        CALayer *cloudLayer = [CALayer layer];
        cloudLayer.contents = (__bridge id)cloudImg.CGImage;
        cloudLayer.contentsGravity = kCAGravityResizeAspect;
        cloudLayer.frame = CGRectMake(0, 0, 200 * cloudImg.size.width/cloudImg.size.height, 200);
        cloudLayer.center = CGPointMake(offsetX, [UIScreen mainScreen].bounds.size.height * 0.05);
        [layer addSublayer:cloudLayer];
        [self.cloudArray addObject:cloudLayer];
        // 云动画
        [cloudLayer addAnimation:[self cloudAnimationFromValue:@(offsetX) toValue:@(kOffsetXScreenCount) duration:kOffsetXAnimationTimes] forKey:nil];
    }
}

#pragma mark - private methods
- (CAAnimationGroup *)cloudAnimationFromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue duration:(CGFloat)duration {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    NSMutableArray *temp = [NSMutableArray array];
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    for (NSInteger i = 0; i < 40; i ++) {
        CGFloat offseX = i / 40.0 * toValue.floatValue * screen_w;
        if (offseX + fromValue.floatValue < ((kOffsetXScreenCount - 1) / 2.0 * screen_w + screen_w)) {
            [temp addObject:@(offseX)];
        } else {
            while (offseX + fromValue.floatValue > (kOffsetXScreenCount - 1) / 2.0 * screen_w + screen_w) {
                offseX = offseX - kOffsetXScreenCount * screen_w;
            }
            [temp addObject:@(offseX)];
        }
    }
    [temp addObject:@(0.0)];
    keyAnimation.values = [NSArray arrayWithArray:temp];
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    NSMutableArray *opacityTemp = [NSMutableArray array];
    for (NSNumber *num in temp) {
        if (num.floatValue + fromValue.floatValue < -(kOffsetXScreenCount - 1) / 4.0 * screen_w ||
            num.floatValue + fromValue.floatValue > (kOffsetXScreenCount - 1) / 4.0 * screen_w + screen_w) {
            [opacityTemp addObject:@(0.0)];
        } else {
            [opacityTemp addObject:@(1.0)];
        }
    }
    
    opacityAnimation.values = opacityTemp;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = duration;
    groupAnimation.animations = @[keyAnimation,opacityAnimation];
    groupAnimation.autoreverses = NO;
    groupAnimation.repeatCount = MAXFLOAT;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    
    return groupAnimation;
}

#pragma mark - Tools
- (UIImage *)imageNamed:(NSString *)name withTintColor:(UIColor *)color {
    UIImage *img = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    [color set];
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - lazy
- (NSMutableArray<CALayer *> *)cloudArray {
    if (!_cloudArray) {
        _cloudArray = [NSMutableArray array];
    }
    return _cloudArray;
}

@end

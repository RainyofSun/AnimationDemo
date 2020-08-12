//
//  AnimationBaseView.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AnimationBaseView.h"

@interface AnimationBaseView ()<CAAnimationDelegate>

@end

@implementation AnimationBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc {
    for (NSInteger i = 0; i < self.layer.sublayers.count; i ++) {
        [self.layer.sublayers[i] removeFromSuperlayer];
        i --;
    }
    
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        [self.subviews[i] removeFromSuperview];
        i --;
    }
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 公共接口
- (void)animationStart {
    [self layoutSubviews];
}

- (void)animationDuration:(CGFloat)duration {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.beginTime = CACurrentMediaTime();
    animation.duration = duration;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"stop"];
}

#pragma mark - private methods
- (void)animationFinish {
    self.animationFinishBlock();
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self animationFinish];
}

@end

//
//  UIView+Animation.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)show:(AnimationDirection)direction {
    CGFloat offset = 0;
    CGAffineTransform transform;
    switch (direction) {
        case AnimationDirection_Top:
            offset = [UIScreen mainScreen].bounds.size.height;
            break;
        case AnimationDirection_Bottom:
            offset = -CGRectGetHeight(self.bounds);
            break;
        case AnimationDirection_Left:
            offset = -[UIScreen mainScreen].bounds.size.width;
            break;
        case AnimationDirection_Right:
            offset = [UIScreen mainScreen].bounds.size.width;
            break;
        default:
            break;
    }
    if (direction == AnimationDirection_Left || direction == AnimationDirection_Right) {
        transform = CGAffineTransformMakeTranslation(offset, 0);
    } else {
        transform = CGAffineTransformMakeTranslation(0, offset);
    }
    [UIView animateWithDuration:0.6 animations:^{
        self.transform = transform;
    }];
}

- (void)hide:(void (^)(void))animationCompletion {
    [UIView animateWithDuration:0.6 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (animationCompletion) {
            animationCompletion();
        }
    }];
}

@end

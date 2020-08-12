//
//  UIView+Animation.h
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AnimationDirection_Left,
    AnimationDirection_Right,
    AnimationDirection_Top,
    AnimationDirection_Bottom
} AnimationDirection;

@interface UIView (Animation)

- (void)show:(AnimationDirection)direction;
- (void)hide:(void(^)(void))animationCompletion;

@end

NS_ASSUME_NONNULL_END

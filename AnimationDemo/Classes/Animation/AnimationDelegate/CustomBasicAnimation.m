//
//  CustomBasicAnimation.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "CustomBasicAnimation.h"

@implementation CustomBasicAnimation

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.animationDelegate != nil && [self.animationDelegate respondsToSelector:@selector(animationDidStop:)]) {
        [self.animationDelegate animationDidStop:anim];
    }
}

- (void)setAnimationDelegate:(id<CustomAnimationDelegate>)animationDelegate {
    _animationDelegate = animationDelegate;
    self.delegate = self;
}

@end

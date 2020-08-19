//
//  BubbleTransitionAnimation.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/8/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "BubbleTransitionAnimation.h"

@interface BubbleTransitionAnimation ()

/** bubble */
@property (nonatomic,strong) UIView *bubble;

@end

@implementation BubbleTransitionAnimation

- (instancetype)init {
    if (self = [super init]) {
        self.startPoint = CGPointZero;
        self.duration = 0.5f;
        self.transitionModel = BubbleTransitionModel_Present;
        self.bubbleColor = [UIColor redColor];
        self.animationType = TransitionAnimationType_Bubble;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    
    if (self.transitionModel == BubbleTransitionModel_Present) {
        UIView *presentedControllerView = nil;
        if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
            presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
        } else {
            presentedControllerView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        }
        
        CGPoint originalCenter = presentedControllerView.center;
        CGSize originalSize = presentedControllerView.frame.size;
        CGFloat lengthX = fmax(self.startPoint.x, originalSize.width - self.startPoint.x);
        CGFloat lengthY = fmax(self.startPoint.y, originalSize.height - self.startPoint.y);
        CGFloat offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
        CGSize size = CGSizeMake(offset, offset);
        
        self.bubble = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        self.bubble.backgroundColor = [UIColor redColor];
        self.bubble.layer.cornerRadius = size.height/2.f;
        self.bubble.center = self.startPoint;
        if (self.animationType == TransitionAnimationType_Bubble) {
            self.bubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        } else if (self.animationType == TransitionAnimationType_Roll) {
            self.bubble.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, [UIScreen mainScreen].bounds.size.height);
        }
        containerView.maskView = self.bubble;
        
        presentedControllerView.center = originalCenter;
        [containerView addSubview:presentedControllerView];
        
        [UIView animateWithDuration:self.duration animations:^{
            self.bubble.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    } else if (self.transitionModel == BubbleTransitionModel_Dismiss) {
        UIView *returningControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:self.duration animations:^{
            if (self.animationType == TransitionAnimationType_Bubble) {
                self.bubble.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
            } else if (self.animationType == TransitionAnimationType_Roll) {
                self.bubble.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, [UIScreen mainScreen].bounds.size.height);
            }
        } completion:^(BOOL finished) {
            [returningControllerView removeFromSuperview];
            [self.bubble removeFromSuperview];
            [transitionContext completeTransition:finished];
        }];
    }
}

@end

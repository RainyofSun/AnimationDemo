//
//  BookAnimationObject.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "BookAnimationObject.h"

@interface BookAnimationObject () <UINavigationControllerDelegate>

/** bookCoverView */
@property (nonatomic,strong) __kindof UIView *bookCoverView;
/** operation */
@property (nonatomic,assign) UINavigationControllerOperation operation;

@end

@implementation BookAnimationObject

+ (id<UIViewControllerAnimatedTransitioning>)objectWithBookCoverView:(__kindof UIView *)bookCoverView animationControllerForOperation:(UINavigationControllerOperation)operation {
    BookAnimationObject *object = [[BookAnimationObject alloc] init];
    object.bookCoverView = bookCoverView;
    object.operation = operation;
    return (id<UIViewControllerAnimatedTransitioning>)object;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    [containerView.layer setSublayerTransform:transform];
    
    switch (self.operation) {
        case UINavigationControllerOperationPush:
            [self pushAnimation:transitionContext containerView:containerView];
            break;
        case UINavigationControllerOperationPop:
            [self popAnimation:transitionContext containerView:containerView];
            break;
        default:
            break;
    }
}

- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext containerView:(UIView *)containView {
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    UIView *currentView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *toView = [currentView snapshotViewAfterScreenUpdates:YES];
    UIView *fromView = [self.bookCoverView snapshotViewAfterScreenUpdates:NO];
    
    [containView addSubview:toView];
    [containView addSubview:fromView];
    
    CGRect toViewFrame = toView.frame;
    CGRect fromViewFrame = self.bookCoverView.frame;
    
    fromView.layer.anchorPoint = CGPointMake(0, .5);
    fromView.frame = fromViewFrame;
    toView.frame = fromViewFrame;
    
    [UIView animateWithDuration:duration delay:0 options:0 animations:^{
        fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        toView.frame = toViewFrame;
        fromView.frame = toViewFrame;
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
        [toView removeFromSuperview];
        [containView addSubview:currentView];
        [containView.layer setSublayerTransform:CATransform3DIdentity];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext containerView:(UIView *)containView {
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *currentFromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [self.bookCoverView snapshotViewAfterScreenUpdates:YES];
    UIView *fromView = [currentFromView snapshotViewAfterScreenUpdates:NO];
    
    [containView addSubview:fromView];
    [containView addSubview:toView];
    [containView insertSubview:toVC.view atIndex:0];
    fromVC.view.hidden = YES;
    
    CGRect toViewFrame = self.bookCoverView.frame;
    CGRect fromViewFrame = fromView.frame;
    
    toView.layer.anchorPoint = CGPointMake(0, .5);
    fromView.frame = fromViewFrame;
    toView.frame = fromViewFrame;
    toView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    
    [UIView animateWithDuration:duration delay:0 options:0 animations:^{
        toView.layer.transform = CATransform3DIdentity;
        fromView.frame = toViewFrame;
        toView.frame = toViewFrame;
    } completion:^(BOOL finished) {
        [fromView removeFromSuperview];
        [toView removeFromSuperview];
        [containView.layer setSublayerTransform:CATransform3DIdentity];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.hidden = NO;
            [toVC.view removeFromSuperview];
        }
    }];
}

@end

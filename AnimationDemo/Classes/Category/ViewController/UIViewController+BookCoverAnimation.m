//
//  UIViewController+BookCoverAnimation.m
//  AnimationDemo
//
//  Created by EGLS_BMAC on 2020/7/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIViewController+BookCoverAnimation.h"
#import "BookAnimationObject.h"
#import <objc/runtime.h>

@interface UIViewController () <UINavigationControllerDelegate>

/** percentInteractiveTransition */
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *percentInteractiveTransition;
/** direction */
@property (nonatomic,assign) UIRectEdge direction;

@end

@implementation UIViewController (BookCoverAnimation)

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:self.targetClass] && self.transitionOperation == operation) {
        if (operation == UINavigationControllerOperationPush) {
            toVC.bookCoverView = self.bookCoverView;
        }
        return [BookAnimationObject objectWithBookCoverView:self.bookCoverView animationControllerForOperation:operation];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[BookAnimationObject class]]) {
        return self.percentInteractiveTransition;
    } else {
        return nil;
    }
}

#pragma mark - setter / getter
- (__kindof UIView *)bookCoverView {
    return objc_getAssociatedObject(self, @selector(bookCoverView));
}

- (void)setBookCoverView:(__kindof UIView *)bookCoverView {
    objc_setAssociatedObject(self, @selector(bookCoverView), bookCoverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
